FROM michchap/heatbase:latest
MAINTAINER "Michael Chapman" <michael@aptira.com>

RUN yum -y install \
    openstack-heat-api \
    python-openstackclient \
    && yum clean all

RUN git clone https://github.com/openstack/heat && \
    cd heat && git checkout stable/juno && \
    cd contrib/heat_keystoneclient_v2 && \
    python setup.py install

ADD ./start.sh /start.sh

EXPOSE 8004

CMD ["/start.sh"]
