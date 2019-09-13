FROM jenkins/jenkins:lts

# Install nodejs to fix sonar analysis failure
USER root
RUN apt update && apt install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install nodejs
USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/casc_configs"

COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins settings.xml /var/jenkins_home/.m2/settings.xml

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
