FROM docker.io/tomcat:10

# setting up image
RUN echo building tomcat image
RUN apt-get update && apt-get install -y iputils-ping curl
COPY deployment/SimpleWebApp.war /usr/local/tomcat/webapps/ROOT.war

RUN rm -r /usr/local/tomcat/webapps /usr/local/tomcat/webapps.dist/ROOT
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
COPY deployment/SimpleWebApp.war /usr/local/tomcat/webapps/ROOT.war
RUN chgrp -R 0 /usr/local/tomcat/ && \
    chmod -R g=u,g+w /usr/local/tomcat/
CMD  [ "bash", "-c", "/usr/local/tomcat/bin/catalina.sh run"]

