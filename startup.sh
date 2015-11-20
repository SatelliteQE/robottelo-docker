#!/bin/sh

cd /root

# Clone Robottelo
git clone https://github.com/SatelliteQE/robottelo.git
cd robottelo

# Install Python deps
pip install -r requirements.txt
pip install -r requirements-optional.txt

# Copy the properties file
cp robottelo.properties.sample robottelo.properties
# Tweak it
sed -i "s/^hostname.*/hostname=${SERVER_URL}/" robottelo.properties
sed -i "s/^ssh_key.*/ssh_key=${SSH_KEY}/" robottelo.properties
sed -i "s/^project.*/project=satellite6/" robottelo.properties
sed -i 's/^upstream.*/upstream=false/' robottelo.properties

nosetests -v ${TESTS}
