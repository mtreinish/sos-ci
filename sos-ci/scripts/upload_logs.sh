#!/bin/bash

REF_DATA=$1
cd $REF_DATA

BASE_NAME=`basename $REF_DATA`
mkdir $BASE_NAME
mkdir $BASE_NAME/logs
mkdir $BASE_NAME/logs/etc

PROJECTS="openstack-dev/devstack $PROJECTS"
PROJECTS="openstack/cinder $PROJECTS"
PROJECTS="openstack/glance $PROJECTS"
PROJECTS="openstack/glance_store $PROJECTS"
PROJECTS="openstack/horizon $PROJECTS"
PROJECTS="openstack/keystone $PROJECTS"
PROJECTS="openstack/keystonemiddleware $PROJECTS"
PROJECTS="openstack/nova $PROJECTS"
PROJECTS="openstack/oslo.config $PROJECTS"
PROJECTS="openstack/oslo.db $PROJECTS"
PROJECTS="openstack/oslo.i18n $PROJECTS"
PROJECTS="openstack/oslo.messaging $PROJECTS"
PROJECTS="openstack/oslo.middleware $PROJECTS"
PROJECTS="openstack/oslo.rootwrap $PROJECTS"
PROJECTS="openstack/oslo.serialization $PROJECTS"
PROJECTS="openstack/oslo.vmware $PROJECTS"
PROJECTS="openstack/python-cinderclient $PROJECTS"
PROJECTS="openstack/python-glanceclient $PROJECTS"
PROJECTS="openstack/python-keystoneclient $PROJECTS"
PROJECTS="openstack/python-novaclient $PROJECTS"
PROJECTS="openstack/python-openstackclient $PROJECTS"
PROJECTS="openstack/requirements $PROJECTS"
PROJECTS="openstack/stevedore $PROJECTS"
PROJECTS="openstack/taskflow $PROJECTS"
PROJECTS="openstack/tempest $PROJECTS"
# devstack logs
cd ~/devstack
cp local.conf $REF_DATA/logs/local.conf.txt
cp /tmp/stack.sh.log $REF_DATA/logs/stack.sh.log.txt

# Archive config files
for PROJECT in $PROJECTS; do
    proj=`basename $PROJECT`
    if [ -d /etc/$proj ]; then
        sudo cp -r /etc/$proj $REF_DATA/logs/etc/
    fi
done

# OS Service Logs
cd /opt/stack/screen-logs
for log in `ls -1 /opt/stack/screen-logs | grep "[a-zA-Z].log"`; do
    cp $log $REF_DATA/logs/$log.txt
done

# Tempest logs
cd /opt/stack/tempest
cp console.log.out  $REF_DATA/console.log.out
cp etc/tempest.conf  $REF_DATA/logs/tempest.conf

# Tar it all up
#cd $REF_DATA
cd ~
tar -cvf $BASE_NAME.tar $BASE_NAME
gzip $BASE_NAME.tar
