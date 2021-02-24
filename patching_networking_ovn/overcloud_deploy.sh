set -ux

echo `date '+%F_%H%m%S'`

## Capture the time stamp for Deployment activity
echo "OSP16_1-Scale_test_`date '+%F_%H%m%S'`" | tee -a /home/stack/.tripleo/history

## Deployment Command
time openstack overcloud deploy --templates \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/podman.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/docker-ha.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-ha.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/disable-telemetry.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
-e /home/stack/containers-prepare-parameter.yaml \
-e /home/stack/templates/network-environment.yaml \
-e /home/stack/templates/deploy.yaml \
-e /home/stack/templates/ceph.yaml \
-e /home/stack/templates/networking_ovn_hotfix_template.yaml \
-r /home/stack/templates/roles_data.yaml \
--ntp-server clock1.rdu2.redhat.com,clock.redhat.com,clock2.redhat.com \
--validation-warnings-fatal --timeout 960 --config-download-timeout 960 \
--log-file overcloud_install.log &> /home/stack/overcloud_install.log

## Backup log event.
cp /home/stack/overcloud_install.log /home/stack/archive_tripleo_logs/overcloud_`date '+%F_%H%m%S'`.log
