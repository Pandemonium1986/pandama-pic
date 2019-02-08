sudo mkdir -p /docker-data/nexus3
sudo adduser --system --gecos "" --shell "/bin/zsh" --disabled-password --home "/docker-data/nexus3/nexus-data" --uid 200 nexus
sudo apt -t stretch-backports install -y groovy
# docker run -d -p 8081:8081 --name nexus -v /docker-data/nexus3/nexus-data:/nexus-data sonatype/nexus3
# cd /vagrant/nexus3/provisionning/ &&  ./provision.sh all
