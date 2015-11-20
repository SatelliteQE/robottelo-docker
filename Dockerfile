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
#

# runtime
EXPOSE 22

CMD /tmp/startup.sh
