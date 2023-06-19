#!/bin/bash

source .env
ssh user@server

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc

nvm install 18
nvm alias default 18
nvm use

sudo apt update
sudo apt upgrade -y
sudo apt install -y postgresql postgresql-contrib nginx ufw

sudo ufw enable
sudo ufw default deny incoming
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'

sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
sudo -u postgres psql -c "CREATE USER $USERNAME WITH ENCRYPTED PASSWORD '$PASSWORD';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $USERNAME;"

sudo systemctl enable nginx
sudo systemctl start nginx
