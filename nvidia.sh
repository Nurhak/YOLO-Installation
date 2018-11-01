#!/bin/bash

#Bu script NVIDIA GTX 950M ve CUDA-8.0 için yazılmıştır.  İşletim sistemi Ubuntu 16.04 LTS'dir.
#Nurhak ALTIN tarafından yazılmıştır.Ticari kullanımlar için geçerli değildir. Kullanılması halinde nurhakaltin@gmail.com adresine bildirilmesi beklenir.Bu scripti çalıştırmadan önce ctl+alt+f1 ile tty1 ekranına geçilip giriş yapıldıktan sonra çalıştırılmalıdır.

#grafik arayüzü kapat
sudo service lightdm stop

#Xorg sistemi kapat
sudo killall Xorg

#nvidia dosyalarını temizle
sudo apt-get remove --purge nvidia-*

#linux headerları yükle
sudo apt-get install linux-headers-$(uname -r)

#nouveau kerneli durdur
sudo echo blacklist nouveau>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist lbm-nouveau>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist amd76x_edac>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist vga16fb>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist rivatv>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist rivafb>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidiafb>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidia-173>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidia-96>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidia-current>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidia-173-updates>>/etc/modprobe.d/blacklist.conf
sudo echo blacklist nvidia-96-updates>>/etc/modprobe.d/blacklist.conf
sudo echo alias nvidia nvidia_current_updates>>/etc/modprobe.d/blacklist.conf
sudo echo alias nouveau off>>/etc/modprobe.d/blacklist.conf
sudo echo alias lbm-nouveau off>>/etc/modprobe.d/blacklist.conf

#parametreleri günceller
sudo update-initramfs -u

#gerekli kütüphane ve dosyaları indir ve kur
sudo apt-get install freeglut3 freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev linux-headers-generic linux-source
sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so


#en son driver ı nvidia.com'dan girip size uygun olanını indirin.Bu GTX950M içindir
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.39/NVIDIA-Linux-x86_64-375.39.run

#Default ayarlar kullanılmalı. DKMS yes. opengl ile çalıştırırsan login loopa girer
sudo chmod +x NVIDIA-Linux-x86_64-375.39.run
./NVIDIA-Linux-x86_64-375.39.run --no-opengl-files


#nvidia modprobe edilmeli
sudo modprobe nvidia-uvm

#nvidia kontrol
echo "Nvidia driverları kurulum kontrolü komutu çalıştırılacak!!!"
echo "Ekranda Gpu Processlerinin Gösteren Bir Kutu Gelmeli Yoksa Yüklemede oluşan Bir Hata Vardır"
sleep 2
nvidia-smi

#xserver yeniden yükleniyor
sudo apt-get install --reinstall xserver-xorg-core  xserver-xorg-video-intel

#cuda için gerekli dosyalar indiriliyor. Cuda 8.0
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
sudo chmod +x cuda_8.0.61_375.26_linux-run
mkdir nvidia_installers

#cuda kurulum
sudo ./cuda_8.0.61_375.26_linux-run -extract=nvidia_installers;

sudo ./cuda-linux64-rel-8.0.61-21551265.run

sudo ./cuda-samples-linux-8.0.61-21551265.run

#İndirilen Dosyaları Sil
sudo rm NVIDIA-Linux-x86_64-375.39.run
sudo rm cuda_8.0.61_375.26_linux-run
sudo rm -rf nvidia_installers

#Örnek dosyalarını derle ve test et
cd /usr/local/cuda/samples

sudo chown -R nurhak:root .
cd 1_Utilities/deviceQuery
make .
./deviceQuery 


#bashrc yollar yazılıyor
sudo echo "export CUDA_HOME=/usr/local/cuda-8.0">>~/.bashrc 
sudo echo "export LD_LIBRARY_PATH=${CUDA_HOME}/lib64">>~/.bashrc 

sudo echo "PATH=${CUDA_HOME}/bin:${PATH}">>~/.bashrc  
sudo echo "export PATH">>~/.bashrc 

#bashrc güncelle
sudo source ~/.bashrc










