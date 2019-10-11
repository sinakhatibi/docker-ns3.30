FROM ubuntu:latest
MAINTAINER Sina Khatibi <info@sinakhatibi.com>
LABEL Description="Docker image for NS-3 Network Simulator"

ENV TZ=Europe/Berlin
ENV BAKE_HOME=`pwd`/bake 
ENV PATH="${BAKE_HOME}:${PATH}"
ENV PYTHONPATH="${PYTHONPATH}:${BAKE_HOME}"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# General dependencies
RUN apt-get install -y \
gcc \
g++ \
python \
python3 \
python3-dev


#minimal requirements for Python (development)
RUN  apt-get install -y \ 
python3-setuptools \
git \
mercurial

# QT5 components
RUN apt-get install -y qt5-default 

RUN apt-get install -y \ 
gir1.2-goocanvas-2.0 \
python-gi \
python-gi-cairo \
python-pygraphviz \
python3-gi \
python3-gi-cairo \
python3-pygraphviz \
gir1.2-gtk-3.0 \
ipython \
ipython3  

#Support for MPI-based distributed emulation
RUN apt-get install -y \
openmpi-bin \
openmpi-common \
openmpi-doc \
libopenmpi-dev

#Support for bake build tool:
RUN apt-get install -y \
autoconf \
cvs \
bzr \
unrar

#Debugging
RUN apt-get install -y \
gdb \
valgrind 

RUN apt-get install -y uncrustify

# Doxygen
RUN apt-get install -y \
doxygen \
graphviz \
imagemagick

#RUN apt-get install -y \
#texlive \
#texlive-extra-utils \
#texlive-latex-extra \
#texlive-font-utils \
#texlive-lang-portuguese \
#dvipng \
#latexmk

#GNU
RUN apt-get install -y \
gsl-bin \
libgsl-dev \
libgsl23 \
libgslcblas0

#PCAP
RUN apt-get install -y \
tcpdump \
sqlite \
sqlite3 \
libsqlite3-dev \
libxml2 \
libxml2-dev

RUN apt-get update



RUN apt-get install -y \
python3-sphinx \
dia 

#Support for generating modified python bindings
RUN apt-get install -y \
cmake \
libc6-dev \
libc6-dev-i386 \
libclang-6.0-dev \
llvm-6.0-dev automake 

RUN apt-get install -y python3-pip

RUN python3 -m pip install --user cxxfilt

#RUN pip3 install --upgrade pip setuptools

RUN apt-get install -y libgtk2.0-0 libgtk2.0-dev

RUN apt-get install -y vtun lxc

RUN apt-get install -y libboost-signals-dev libboost-filesystem-dev


# NS-3

# Create working directory
RUN mkdir -p /usr/ns3
WORKDIR /usr/ns3

RUN cd /usr/ns3
RUN git clone https://gitlab.com/nsnam/bake
WORKDIR /usr/ns3/bake

RUN python bake.py check
RUN python bake.py configure -e ns-3.30
RUN python bake.py deploy



