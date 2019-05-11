# for GPU

## for gpu instance
### one liner

### memo
#### target
* cuda
* zsh
* neovim
* python 3.68
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
# >> zsh neovim python3.6.8 IntelMKL
sudo apt install -y git make
git clone https://github.com/icebee16/dotfiles
cd dotfiles
make init
exit

# >> CUDA Toolkit 10.0.130
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork
curl -OL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.105-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804_10.1.105-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo apt-get update # 必要
sudo apt-get install cuda
echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
echo 'export PATH=/usr/local/cuda/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
sudo reboot
# need reconnection
rm cuda-repo-ubuntu1804_10.1.105-1_amd64.deb
# 補足：CUDAを上記のdeb(network)の方法でinstallするとcuda driversも一緒にinstallされるらしい

# >> cuDNN v7.5.1
# loginの必要があり自分で公式からポチポチ落としてくるしかない。　https://developer.nvidia.com/rdp/cudnn-download
# Runtime, Developer, Code Samplesの三種類
sudo dpkg -i libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb
rm libcudnn7*
```

## post process
```
pip install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp36-cp36m-linux_x86_64.whl
pip install torchvision
pip install pandas
pip install numba
pip install "dask[complete]"
pip install seaborn
pip install librosa
pip install fastprogress
pip install cython
```
