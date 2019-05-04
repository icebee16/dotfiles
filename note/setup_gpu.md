# for GPU

## for gpu instance
### one liner

### memo
#### target
* cuda
* zsh
* neovim
* python 3.65
* IntelMKL

#### make instance
* CPU 4Core
* RAM 16GB
* DISK 80GB
* GPU 1 x NVIDIA Tesla K80
* Intel Broadwell
* ubutun 16.4 LTS

#### setup cuda cuDNN
* CUDA Toolkit 9.2
* cuDNN v7.5.1

#### process
```
# pass init
sudo passwd root
mkdir dotfiles dotfiles/zsh dotfiles/vim dotfiles/vim/rc dotfiles/tmux

# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME

# apt install
sudo apt update && sudo apt upgrade -y
sudo apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# tmux
touch dotfiles/tmux/.tmux.conf
ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/
# .tmux.confをこぴぺ

# zsh
sudo apt install zsh -y
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
sudo chsh $USER -s $(which zsh)
sudo reboot

# >> CUDA Toolkit 9.2
# https://developer.nvidia.com/cuda-92-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
curl -OL http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt update # 必要
sudo apt install -y cuda-9-2
echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
echo 'export PATH=/usr/local/cuda/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
sudo reboot
# need reconnection
rm cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
# 補足：CUDAを上記のdeb(network)の方法でinstallするとcuda driversも一緒にinstallされるらしい

# >> cuDNN v7.5.1
# loginの必要があり自分で公式からポチポチ落としてくるしかない。　https://developer.nvidia.com/rdp/cudnn-download
# Runtime, Developer, Code Samplesの三種類
sudo dpkg -i libcudnn7_7.5.1.10-1+cuda9.2_amd64.deb
sudo dpkg -i libcudnn7-dev_7.5.1.10-1+cuda9.2_amd64.deb
sudo dpkg -i libcudnn7-doc_7.5.1.10-1+cuda9.2_amd64.deb
rm libcudnn7*


```
