FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    devscripts \
    dpkg-dev \
    debhelper \
    dh-python \
    python3-all \
    python3-setuptools \
    python3-pip \
    libusb-1.0-0 \
    python3-dev

COPY . /app

WORKDIR /app


RUN python3 setup.py install --prefix=/debian/usr
RUN dpkg-deb --build debian python3-pyusb.deb

RUN dpkg -i python3-pyusb.deb

ENV PYTHONPATH "${PYTHONPATH}:/debian/usr"

RUN find /debian -type f -exec chmod 644 {} \;
RUN find /debian -type d -exec chmod 755 {} \;


CMD ["/bin/bash"]
