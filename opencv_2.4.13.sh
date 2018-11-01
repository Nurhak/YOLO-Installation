#NURHAK ALTIN OPENCV 2.4.13 DARKNET KURULUM GEREKLI KUTUPHANE
# install dependencies
sudo apt-get update
sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y libgtk2.0-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y python-numpy python-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev
 
sudo apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2 libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils
 
# download opencv-2.4.13
wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.13/opencv-2.4.13.zip
unzip opencv-2.4.13.zip
cd opencv-2.4.13
mkdir release
cd release
 
# compile and install
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make all -j8 # 8 cores
sudo make install

#cofiguration
sudo echo /usr/local/lib>/etc/ld.so.conf.d/opencv.conf
sudo ldconfig
sudo echo PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig>>/etc/bash.bashrc
sudo echo export PKG_CONFIG_PATH>>/etc/bash.bashrc
