FROM jenkins
MAINTAINER Michal Bocek <michal.bocek@gmail.com>

RUN sudo apt-get update && sudo apt-get install -y ruby-full rubygems git-core && sudo rm -rf /var/lib/apt/lists/*
RUN sudo gem install rhc

