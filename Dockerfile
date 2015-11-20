FROM fedora:latest
MAINTAINER https://github.com/SatelliteQE

RUN dnf -y update; dnf clean all
RUN dnf groupinstall -y "Development Tools"
RUN dnf install -y which git python-pip
RUN dnf install -y redhat-rpm-config-36 python-devel

# Upgrade pip itself
RUN pip install --upgrade pip

ENV HOME /root

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

# Add phantomjs
#

# runtime
EXPOSE 22

CMD ./tmp/startup.sh
