#!/bin/bash
#sudo -s
wget https://github.com/servian/TechChallengeApp/archive/v.0.7.0.zip
sudo apt install unzip -y
unzip v.0.7.0.zip
cd TechChallengeApp-v.0.7.0

wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
sudo mkdir -p /root/go/bin/dep
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
go get -d github.com/Servian/TechChallengeApp
./build.sh

export VTT_DBUSER="postgresadmin@servin-postgressql"
export VTT_DBHOST="servin-postgressql.postgres.database.azure.com"
export VTT_DBPASSWORD="Amrinsulthana16$"
export VTT_DBNAME="servin"
export VTT_LISTENHOST="0.0.0.0"
export VTT_LISTENPORT="80"

cd dist/
./TechChallengeApp updatedb -s
./TechChallengeApp serve

