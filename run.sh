#!/bin/bash


sudo chmod 755 opencv_2.4.13.sh
sudo chmod 755 nvidia.sh
sudo chmod 755 darknet.sh
sudo chmod 755 cudnn_download.sh

./opencv_2.4.13.sh

./nvidia.sh

./cudnn_download.sh

./darknet.sh

sudo service lightdm start
