#!/bin/sh

cd /root/robottelo

# Update Robottelo code
git pull

# Update dependencies, if needed
pip install -q --upgrade -r requirements.txt
pip install -q --upgrade -r requirements-optional.txt

# Copy the properties file
cp robottelo.properties.sample robottelo.properties
# Tweak it
sed -i "s/^hostname.*/hostname=${SERVER_URL}/" robottelo.properties
sed -i "s/^ssh_key.*/ssh_key=${SSH_KEY}/" robottelo.properties
sed -i "s/^project.*/project=satellite6/" robottelo.properties
sed -i 's/^upstream.*/upstream=false/' robottelo.properties

nosetests -v ${TESTS}
