FROM jenkins
MAINTAINER Michal Bocek <michal.bocek@gmail.com>

USER root

RUN apt-get update && apt-get install -y ruby-full rubygems git-core && rm -rf /var/lib/apt/lists/*
RUN gem install rhc

USER jenkins

