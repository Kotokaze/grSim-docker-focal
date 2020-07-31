#Get ubuntu20.04 image
FROM ubuntu:20.04

LABEL maintainer="Kotokaze" \
      description="grSim" \
      version=0.1

#Initialize Focal
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get -y upgrade &&\
    apt -y update && apt -y upgrade

RUN apt-get -y install git \
    build-essential \
    cmake \
    pkg-config \
    qt5-default \
    libqt5opengl5-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libode-dev \
    libboost-dev

RUN apt -y install x11-apps

RUN git clone https://github.com/jpfeltracco/vartypes.git
RUN cd vartypes && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../..

#Install grSim
RUN git clone https://github.com/RoboCup-SSL/grSim.git
RUN cd grSim && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make


ENV DISPLAY host.docker.internal:0.0

#Run grSim
CMD /grSim/bin/grSim