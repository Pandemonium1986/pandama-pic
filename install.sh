sudo mkdir -p /docker-data/nexus3
sudo mkdir -p /docker-data/jenkins2
sudo adduser --system --gecos "" --shell "/bin/zsh" --disabled-password --home "/docker-data/nexus3/nexus-data" --uid 200 nexus
sudo adduser --system --gecos "" --shell "/bin/zsh" --disabled-password --home "/docker-data/jenkins2/jenkins_home" --uid 300 jenkins
sudo apt -t stretch-backports install -y groovy
# docker run -d -p 8081:8081 --name nexus -v /docker-data/nexus3/nexus-data:/nexus-data sonatype/nexus3
# cd /vagrant/nexus3/provisionning/ &&  ./provision.sh all
