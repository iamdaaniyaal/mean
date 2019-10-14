curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install nodejs -y
sudo apt-get install mongodb mongodb-server -y
sudo apt-get install git -y
sudo npm install gulp -y
git clone --depth 1 https://github.com/linnovate/mean.git
cd mean 
npm install
npm install -g @angular/cli -y
