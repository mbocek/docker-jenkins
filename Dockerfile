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
RUN unzip /opt/sonar-runner-dist-2.4.zip -d /opt
RUN sed -i 's|#sonar.host.url=http://localhost:9000|sonar.host.url=${env:SONAR_URL}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties
RUN sed -i 's|#sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar?useUnicode=true&amp;characterEncoding=utf8|sonar.jdbc.url=${env:SONAR_JDBC_URL}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties
RUN sed -i 's|#sonar.jdbc.username=sonar|sonar.jdbc.username=${env:SONAR_JDBC_USERNAME}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties
RUN sed -i 's|#sonar.jdbc.password=sonar|sonar.jdbc.password=${env:SONAR_JDBC_PASSWORD}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties
RUN sed -i 's|#sonar.login=admin|#sonar.login=${env:SONAR_LOGIN}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties
RUN sed -i 's|#sonar.password=admin|#sonar.password=${env:SONAR_PASSWORD}|g' /opt/sonar-runner-2.4/conf/sonar-runner.properties


# clean up
RUN rm /tmp/plugins.txt
RUN rm /opt/sonar-runner-dist-2.4.zip

USER jenkins
