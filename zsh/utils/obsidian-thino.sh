#!/bin/zsh

function obsidian-thino() {
    local vault_path="${OBSIDIAN_VAULT_PATH}"
    local daily_note_path="daily/$(date '+%Y-%m-%d').md"
    local template_path="templates/daily.md"
    local tags_yaml="${vault_path}/tags.yaml"

    local full_daily="${vault_path}/${daily_note_path}"
    local full_template="${vault_path}/${template_path}"

    local message=""
    local tags_input=""
    local notes_input=""
    local links=""
    local use_fzf_tags=false
    local use_fzf_notes=false
    local dry_run=false

    # --dry-run を先に処理
    if [ "$1" = "--dry-run" ]; then
        dry_run=true
        shift
    fi

    # 引数解析
    while getopts "m:t:n:l:TNh" opt; do
        case "$opt" in
            m) message="$OPTARG" ;;
            t) tags_input="$OPTARG" ;;
            T) use_fzf_tags=true ;;
            n) notes_input="$OPTARG" ;;
            N) use_fzf_notes=true ;;
            l) links="$OPTARG" ;;
            h)
                cat <<EOF
使用方法:
  th [--dry-run] -m "メッセージ" [-t "tag1,tag2"] [-T] [-n "note1,note2"] [-N] [-l "表示名=URL"]

必須:
  -m "メッセージ"       : 記録する本文。空白を含める場合は必ずクォートで囲む。

タグ関連:
  -t "tag1,tag2"       : カンマ区切りでタグ指定。#は不要（例: "log,memo"）
  -T                   : tags.yaml の中から fzf でタグをインタラクティブに選択

ノート関連:
  -n "note1,note2"     : 関連ノート名をカンマ区切りで直接指定（拡張子不要）
  -N                   : fzf + bat によるノートのプレビュー付き選択

リンク関連:
  -l "表示名=URL"      : 1件のみ指定可能。表示名省略可（例: "https://x.com" または "記事=https://x.com"）

その他:
  --dry-run            : ファイルへは書き込まず、記録予定のエントリを標準出力に表示
  -h                   : このヘルプを表示

依存コマンド:
  - yq   : tags.yaml を読み取るために使用
  - fzf  : タグ・ノートの対話選択用
  - bat  : ノート内容のカラー表示（fzfプレビュー）。なければ cat にフォールバック
EOF
                return 0
                ;;
            *) echo "エラー: 不正なオプションです。-h で使い方を確認できます。" ; return 1 ;;
        esac
    done

    if [ -z "$message" ]; then
        echo "エラー: -m オプションでメッセージを指定してください（-h で詳細表示）"
        return 1
    fi

    # 改行を除去（③）
    message=$(echo "$message" | tr '\n' ' ')

    # fzfでタグ選択（表示: tag : 説明、選択結果: tag）
    if $use_fzf_tags; then
        if [[ ! -f "$tags_yaml" ]]; then
            echo "tags.yaml が存在しません: $tags_yaml"
            return 1
        fi

        if ! yq eval '.' "$tags_yaml" >/dev/null 2>&1; then
            echo "tags.yaml の構文が不正です（YAMLエラー）"
            return 1
        fi

        if [ ! -s "$tags_yaml" ]; then
            echo "tags.yaml が空です。タグ選択をスキップします。"
            return 1
        fi

        local selected
        # 最大長の取得（タグ名の幅）
        max_len=$(yq eval 'keys | map(length) | max' "$tags_yaml")

        # fzfで選択（整形表示）
        selected=$(yq eval -r 'to_entries[] | [.key, .value.description] | @tsv' "$tags_yaml" | \
          awk -F'\t' -v width="$max_len" '{printf "%-*s : %s\n", width, $1, $2}' | \
          fzf --multi \
              --prompt="タグを選択: " \
              --header="タグ名 : 説明（複数可）" \
              --with-nth=1 \
              --delimiter="\n" \
              | cut -d':' -f1 | xargs)

        if [[ -n "$selected" ]]; then
            # スペース区切りをカンマ区切りへ
            tags_input=$(echo "$selected" | tr ' ' ',')
        fi
    fi

    # タグバリデーション処理
    local valid_tags=()
    local invalid_tags=()
    if [ -n "$tags_input" ]; then
        # カンマ末尾除去（念のため）
        tags_input="${tags_input%,}"

        if [ -f "$tags_yaml" ]; then
            local allowed_tags
            allowed_tags=$(yq eval 'keys | .[]' "$tags_yaml")

            tag_array=()
            for tag in $(echo "$tags_input" | tr ',' ' '); do
                tag_array+=("$tag")
            done

            for tag in "${tag_array[@]}"; do
                if echo "$allowed_tags" | grep -qx "$tag"; then
                    valid_tags+=("#$tag")
                else
                    invalid_tags+=("$tag")
                fi
            done

            if [ ${#invalid_tags[@]} -gt 0 ]; then
                echo "無効なタグが含まれています: ${invalid_tags[*]}"
            fi
        else
            echo "警告: tags.yaml が存在しないため、タグをすべて無効とみなします"
        fi
    fi

    # fzfでノート選択
    if $use_fzf_notes; then
        local note_candidates
        note_candidates=$(find "$vault_path/" -type f -name '*.md' \
            ! -path "*/templates/*" ! -path "*/attachments/*")
        echo "$note_candidates"
        local selected_paths
        selected_paths=$(echo "$note_candidates" | \
            fzf --multi \
                --prompt="関連ノートを選択: " \
                --preview 'bat --style=plain --color=always {} || cat {}' \
                --preview-window=right:60%:wrap)

        notes_input=$(echo "$selected_paths" | xargs -I{} basename {} .md | tr '\n' ',' | sed 's/,$//')
    fi

    # デイリーノート準備
    if ! $dry_run && [ ! -f "$full_daily" ]; then
        if [ -f "$full_template" ]; then
            echo "デイリーノートが存在しないためテンプレートから作成します..."
            cp "$full_template" "$full_daily"
        else
            echo "テンプレートが存在しないため空のデイリーノートを作成します: $full_daily"
            touch "$full_daily"
        fi
    fi

    # エントリ構築
    local timestamp
    timestamp=$(date '+%H:%M:%S')
    local entry="- ${timestamp} ${message}"

    [ ${#valid_tags[@]} -gt 0 ] && entry+=" ${valid_tags[*]}"

    if [ -n "$notes_input" ]; then
        note_array=()
        for note in $(echo "$notes_input" | tr ',' ' '); do
            note_array+=("$note")
        done

        for note in "${note_array[@]}"; do
            entry+=" [[${note}]]"
        done
    fi

    if [ -n "$links" ]; then
        if [[ "$links" == *=* ]]; then
            local label="${links%%=*}"
            local url="${links#*=}"
            entry+=" [${label}](${url})"
        else
            entry+=" [${links}](${links})"
        fi
    fi

    # 出力または書き込み
    if $dry_run; then
        echo "[DRY-RUN] 記録予定のエントリ:"
        echo "$entry"
    else
        printf "\n%s" "$entry" >> "$full_daily"
    fi
}
alias 'thino'='obsidian-thino'
