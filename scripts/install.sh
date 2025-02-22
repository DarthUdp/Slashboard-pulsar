#!/bin/bash

cd "$(dirname "$0")"
echo "Thank you for installing Pulsar-slashboard"
echo "this script will daemonize the node js app and run it."

# install pm2
echo "Setting up pm2..."
sudo apt-get update -y
sudo apt-get upgrade -y

npm install pm2 -g || echo "There seems to be a problem with your node installation, the script failed to install pm2"; sudo apt install nodejs npm -y; npm install pm2 -g

echo "Your server will be given a pairing key,"
echo "you can enter a key of your choice or let the script generate it randomly."

serverKey=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)

echo "Do you want to auto-generate it [Y/n] ?"
read choice
if [ $choice == "Y" -o $choice == "y" ]
then
    echo "Generating random 64-char alphanumeric key."
    sharedSecret=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
else
    echo "Please provide the key of your choice : "
    read sharedSecret
fi
printf "{security: {serverKey: \"$serverKey\", sharedSecret: \"$sharedSecret\", jwtLifetime: 3600}}" > ../config/default.json5
echo "Successfully written to file."
echo "+-------------------------------------------------------------------------------+"
echo "| Your key is : $sharedSecret"
echo "| It can be later found in the configuration file located at config/default.json5"
echo "+-------------------------------------------------------------------------------+"
# cd to the root of the project
cd ..
# install dependencies
npm i

# allow port through firewall
echo "Allowing port 6033 through firewall"
sudo ufw allow 6033
# daemonize the node app
echo "Pulsar is now starting up..."
pm2 start ecosystem.config.js --env production

echo "Do you want pulsar to run on system startup [Y/n] ?"
read choice
if [ $choice == "Y" -o $choice == "y" ]
then
  echo "\e[32m[Pulsar] \e[39mPlease follow the instructions displayed by the pm2 startup manager :"
  pm2 startup
else
  echo Done.
fi