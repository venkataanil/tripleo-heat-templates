#!/bin/bash

openstack overcloud deploy \
--timeout 240 \
--templates /usr/share/openstack-tripleo-heat-templates \
--stack overcloud \
--libvirt-type kvm \
--ntp-server clock1.rdu2.redhat.com \
-e /home/stack/virt/internal.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /home/stack/virt/network/network-environment.yaml \
-e /home/stack/virt/inject-trust-anchor.yaml \
-e /home/stack/virt/hostnames.yml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-ha.yaml \
-e /home/stack/virt/debug.yaml \
-e /home/stack/virt/nodes_data.yaml \
-e ~/containers-prepare-parameter.yaml \
-e /home/stack/virt/docker-images.yaml \
--log-file overcloud_deployment_43.log
