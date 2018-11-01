#!/bin/bash

echo "Darknet Yükleniyor!!!"

sudo apt-get install git

git clone https://github.com/pjreddie/darknet.git

cd darknet

sed -ie 's/GPU=0/GPU=1/g' Makefile
sed -ie 's/OPENCV=0/OPENCV=1/g' Makefile
sed -ie 's/CUDNN=0/CUDNN=1/g' Makefile
sed -ie 's/DEBUG=0/DEBUG=1/g' Makefile

sed -ie 's/# ARCH=  -gencode arch=compute_52,code=compute_52/ ARCH=  -gencode arch=compute_35,code=compute_35/g' Makefile

make -j4

wget http://pjreddie.com/media/files/yolo.weights

./darknet detector demo cfg/coco.data cfg/yolo.cfg yolo.weights



