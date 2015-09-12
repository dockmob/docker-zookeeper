FROM dockmob/java
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

RUN apk add --update bash && rm -rf /var/cache/apk/*

ADD ./setup /setup
WORKDIR /setup
RUN ./install.sh
WORKDIR /usr/lib/zookeeper/bin
RUN rm -rf /setup

VOLUME /var/zookeeper

EXPOSE 2181
EXPOSE 2888
EXPOSE 3888

ENTRYPOINT ["./dockmobStart.sh"]