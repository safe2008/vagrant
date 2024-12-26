
```code

sudo systemctl stop splunk
sudo rm -rf /opt/splunk
sudo rm -rf /etc/init.d/splunk
sudo rm -rf /var/log/splunk
sudo find / -name "*splunk*"
sudo userdel splunk

#Check Port 8000 Availability
ps aux | grep splunk
sudo netstat -tuln | grep :8000

#Verify Splunk Configuration
nano /opt/splunk/etc/system/local/web.conf

#Restart Splunk
sudo systemctl restart splunk
sudo tail -f /opt/splunk/var/log/splunk/splunkd.log

sudo dpkg -i splunk-9.4.0-6b4ebe426ca6-linux-amd64.deb

sudo nano /etc/init.d/splunk

sudo systemctl status splunk

"/opt/splunk/bin/splunk" start --no-prompt --answer-yes --accept-license

systemctl daemon-reload
sudo systemctl start splunk


sudo /opt/splunk/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt
sudo /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt

sudo journalctl -u splunk
sudo systemctl status splunk
sudo journalctl -xeu splunk.service

#Check Firewall Settings
sudo ufw allow 8000/tcp

#Docker
sudo usermod -aG docker $USER
newgrp docker
docker ps
groups $USER
docker ps

sudo lsof -i
sudo kill -9 1234

openssl req -x509 -newkey rsa:4096 -passout pass:abcd1234 -keyout /home/key.pem -out /home/cert.pem -days 365 -subj /CN=localhost

docker run -it -d --platform linux/amd64 \
  -p 8000:8000 -p 8191:8191 -p 8089:8089 -p 9997:9997 \
  -e "SPLUNK_HTTP_ENABLESSL=true" \
  -e "SPLUNK_HTTP_ENABLESSL_CERT=/home/cert.pem" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY=/home/key.pem" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY_PASSWORD=abcd1234" \
  -e SPLUNK_START_ARGS="--accept-license --answer-yes --no-prompt" \
  -e SPLUNK_PASSWORD="splunkadmin" \
  --name splunk-server splunk/splunk:latest

docker ps -a
docker logs splunk-server
docker inspect splunk/splunk:latest

Primary Splunk Ports
Port	Description	Default
8000	Splunk Web interface	Yes
8088	HTTP Event Collector (HEC)	Optional
9997	Receiving data from forwarders	Yes
8191	Splunk Daemon Management Port	Yes

Other Ports Used by Splunk
Port	Description	Default
8065	App Key Value Store	Optional
8089	Splunk Management Port (REST API)	Yes
8443	Splunk Cloud Gateway	Optional
9887	Splunk DSP (Data Stream Processor)	Optional

sudo ./setup_splunk.sh


```
