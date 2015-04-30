FROM centos:7
MAINTAINER "Michael Chapman" <michael@aptira.com>


RUN yum -y install https://rdo.fedorapeople.org/rdo-release.rpm
RUN yum -y install epel-release
RUN yum update -y && yum clean all
RUN yum -y install crudini git mysql expect python-setuptools

RUN git clone https://github.com/openstack/heat && \
    cd heat && git checkout stable/juno && \
    cd contrib/heat_keystoneclient_v2 && \
    python setup.py install

COPY config-heat.sh /config-heat.sh
