FROM fedora:latest
MAINTAINER https://github.com/SatelliteQE

RUN dnf -y update; dnf clean all
RUN dnf groupinstall -y "Development Tools"
RUN dnf install -y which git python-pip
RUN dnf install -y redhat-rpm-config-36 python-devel

# Upgrade pip itself
RUN pip install --upgrade pip

ENV HOME /root
WORKDIR /root

# Clone Robottelo
RUN git clone https://github.com/SatelliteQE/robottelo.git

# Install Python deps
RUN cd /root/robottelo && pip install -r requirements.txt
RUN cd /root/robottelo && pip install -r requirements-optional.txt

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

# Add phantomjs
RUN dnf install -y gcc gcc-c++ make flex bison gperf ruby \
  openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel \
  libpng-devel libjpeg-devel

RUN git clone git://github.com/ariya/phantomjs.git
RUN cd /root/phantomjs && git checkout 2.0
RUN cd /root/phantomjs && ./build.sh --confirm --silent --jobs 2

# Move the binary
RUN cp /root/phantomjs/bin/phantomjs /usr/bin/.

# Clean up
RUN rm -rf /root/robottelo
RUN rm -rf /root/phantomjs

# runtime
EXPOSE 22

CMD /tmp/startup.sh
