FROM jenkins
MAINTAINER Michal Bocek <michal.bocek@gmail.com>

USER root

# install rhc 
RUN apt-get update && apt-get install -y ruby-full rubygems git-core && rm -rf /var/lib/apt/lists/*
RUN gem install rhc

USER jenkins
ENV HOME /var/jenkins_home

# install plugins
COPY plugins.txt /tmp/plugins.txt
RUN /usr/local/bin/plugins.sh /tmp/plugins.txt

USER root
# create sonar runner
RUN curl -L http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip -o /opt/sonar-runner-dist-2.4.zip
RUN unzip /opt/sonar-runner-dist-2.4.zip
RUN cat > /opt/sonar-runner-2.4/conf/sonar-runner.properties << 'eof'
sonar.host.url=\${env:SONAR_HOST_URL}
sonar.jdbc.url=\${env:SONAR_JDBC_URL}
sonar.jdbc.username=\${env:SONAR_JDBC_USERNAME}
sonar.jdbc.password=\${env:SONAR_JDBC_PASSWORD}
eof

# clean up
RUN rm /tmp/plugins.txt
RUN rm /opt/sonar-runner-dist-2.4.zip

USER jenkins
