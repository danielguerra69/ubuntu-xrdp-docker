FROM danielguerra/ubuntu-xrdp
MAINTAINER Daniel Guerra

# Add packages

RUN apt-get update
RUN apt-get -yy install docker.io python-pip
RUN pip install --upgrade pip 
RUN pip install docker-compose

# Configure

RUN usermod -G docker ubuntu
RUN echo "export DOCKER_HOST='tcp://docker:2375'" >> /etc/profile

# Clean

RUN apt-get -yy clean
RUN rm -rf /tmp/*