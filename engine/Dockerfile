FROM michchap/heatbase
MAINTAINER "Michael Chapman" <michael@aptira.com>

RUN yum -y install \
    openstack-heat-engine \
    && yum clean all

ADD ./start.sh /start.sh
CMD ["/start.sh"]
