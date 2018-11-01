#!/bin/bash

tar -zxvf cudnn-8.0-linux-x64-v5.1.tgz

cd cuda

sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/

cd ..

sudo rm -rf cuda


