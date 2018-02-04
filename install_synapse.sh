#! /bin/bash

sudo apt-get update
sudo apt-get install -y ufw

sudo ufw allow ssh
sudo ufw logging on
sudo ufw enable
sudo ufw status verbose

sudo apt-get upgrade -y

sudo apt-get install -y build-essential python2.7-dev libffi-dev python-pip python-setuptools sqlite3 libssl-dev python-virtualenv libjpeg-dev libxslt1-dev git nignx postgresql postgresql-contrib

#Setup Postgres for Matrix
sudo -u postgres psql -c "CREATE USER \"janitor\" WITH PASSWORD 'hyfx2lpi'"
sudo -u postgres psql -c "CREATE DATABASE synapse ENCODING 'UTF8' LC_COLLATE='C' LC_CTYPE='C' template=template0 OWNER \"janitor\""
sudo -u postgres psql -c "show data_directory"

#setup Matrix in Python virtual env
virtualenv -p python2.7 ~/.synapse
source ~/.synapse/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
pip install https://github.com/matrix-org/synapse/tarball/master

# Config basic Matrix
cd ~/.synapse
python -m synapse.app.homeserver --server-name $1 --config-path homeserver.yaml --generate-config --report-stats=no
