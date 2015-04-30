FROM michchap/heatbase:latest
MAINTAINER "Michael Chapman" <michael@aptira.com>

RUN yum -y install \
    openstack-heat-api \
    python-openstackclient \
    && yum clean all


ADD ./start.sh /start.sh

EXPOSE 8004

CMD ["/start.sh"]
