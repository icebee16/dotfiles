local M = {}

--- 指定した .env ファイルを読み込み、環境変数にセットする
--- @param filepath string パス（例: "~/.config/secrets/openai.env"）
function M.load(filepath)
  local expanded = vim.fn.expand(filepath)
  local file = io.open(expanded, "r")
  if not file then return end

  for line in file:lines() do
    local key, value = line:match("([%w_]+)%s*=%s*['\"]?([^'\"]+)['\"]?")
    if key and value and vim.fn.getenv(key) == vim.NIL then
      vim.fn.setenv(key, value)
    end
  end
  file:close()
end

return M
