FROM centos:7
MAINTAINER "Michael Chapman" <michael@aptira.com>


RUN yum -y install https://rdo.fedorapeople.org/rdo-release.rpm
RUN yum -y install epel-release
RUN yum update -y && yum clean all
RUN yum -y install crudini git mysql expect

COPY config-heat.sh /config-heat.sh
