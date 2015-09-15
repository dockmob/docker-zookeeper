#!/bin/bash

VERSION=3.4.6

tar -xzf zookeeper-$VERSION.tar.gz
mv zookeeper-$VERSION /usr/lib
ln -s /usr/lib/zookeeper-$VERSION /usr/lib/zookeeper

# Remove unnecessary files
rm -rf /usr/lib/zookeeper/src
rm -rf /usr/lib/zookeeper/dist-maven
rm -rf /usr/lib/zookeeper/docs


mv zoo.cfg /usr/lib/zookeeper/conf
mv dockmobStart.sh /usr/lib/zookeeper/bin

