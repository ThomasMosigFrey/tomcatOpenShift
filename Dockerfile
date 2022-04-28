#FROM docker.io/tomcat@sha256:37557787b2f1b2fc0ecdbbd9281311fbe534587d09df58aa690018172fe840d3

# login to image registry first
FROM image-registry.openshift-image-registry.svc:5000/openshift/jboss-webserver54-openjdk11-tomcat9-openshift-rhel7


# setting up image
RUN echo building coba tomcat image
RUN apt-get update && apt-get install -y iputils-ping curl

COPY deployment/ROOT.war /usr/local/tomcat/webapps/ROOT.war

RUN echo "sleep 60; exit 1" >> /usr/local/tomcat/bin/startup.sh
CMD /usr/local/tomcat/bin/startup.sh

