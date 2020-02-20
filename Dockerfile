# Each instruction in this file generates a new layer that gets pushed to your local image cache
#

#
# Lines preceeded by # are regarded as comments and ignored
#


FROM registry.access.redhat.com/ubi8/ubi
####RUN echo `id`
MAINTAINER Suraj@in.ibm.com \
#### LABEL
LABEL "name"="suraj" \
      "vendor"="IBM" \
      "version"="v9" \
      "release"="A number used to identify the specific build for this image" \
      "summary"="A short overview of the application or component in this image" \
      "description"="A long description of the application or component in this image"

#### Disabling "SU" permision 
RUN usermod -s /sbin/nologin root
RUN echo "auth requisite  pam_deny.so" >> /etc/pam.d/su

#### Install prepare infrastructure
RUN yum -y update && \
  yum -y install wget && \
  yum -y install tar && \
  yum -y install git

#### Creating Directory
RUN mkdir opt/java

####Adding License 
RUN mkdir /licenses
ADD ./licenses.txt /licenses

#### Prepare environment
ENV JAVA_HOME /opt/java
ENV PATH $PATH:$JAVA_HOME/bin

####Changing working directory
WORKDIR /opt/java

####Downlading tar file
###RUN wget https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8_openj9-0.18.0/OpenJDK13U-jdk_x64_linux_openj9_13.0.2_8_openj9-0.18.0.tar.gz
RUN wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08_openj9-0.18.1/OpenJDK8U-jdk_x64_linux_openj9_8u242b08_openj9-0.18.1.tar.gz
# Create java user
RUN groupadd -r java && \
 useradd -g java -d ${JAVA_HOME} -s /sbin/nologin  -c "Java user" java && \
 chown -R java:java ${JAVA_HOME}

#### changing User
USER java

#### Running untar Command a nd moving it to ${JAVA_HOME}
##RUN tar -xvf jdk-13.0.2_linux-x64_bin.tar.gz && \
RUN tar -xvf OpenJDK8U-jdk_x64_linux_openj9_8u242b08_openj9-0.18.1.tar.gz && \ 
   rm Open*.tar.gz && \
    mv jdk*/*  ${JAVA_HOME}









        

