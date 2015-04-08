#!/bin/bash
set -e

PLAYBOOKS=(flask-web db-manage)
echo 'Playbooks found:'
for playbook in ${PLAYBOOKS[@]}; do
    echo "- $playbook"
done

echo ""

# Syntax check all playbooks first
echo 'Checking syntax:'
for playbook in ${PLAYBOOKS[@]}; do
    echo "- $playbook"
    ansible-playbook machines/$playbook.yml --syntax-check
    if [[ $? -ne 0 ]] ; then
        exit 1
    fi
done

echo 'Execute playbooks:'
for playbook in ${PLAYBOOKS[@]}; do
    echo "EXECUTE $playbook"
    machine="$(echo $playbook|tr '-' '_')" # Ex: mysql_master
    hostname="${machine//_}" # Ex: mysqlmaster

    # Provision test instance
    ansible-playbook build/provision-test-instance.yml -e "instance_name=$machine"

    public_ip="$(python build/get_instance_ip.py --instance test_$machine)"
    dns_name="$(python build/get_instance_dns.py --instance test_$machine)"
    instance_id="$(python build/get_instance_id.py --instance test_$machine)"

    echo "Created test instance:"
    echo " - Public IP: $public_ip"
    echo " - DNS: $dns_name"
    echo " - Instance ID: $instance_id"

    # Run playbook
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/ec2.py machines/$playbook.yml --limit tag_Name_test_$machine -e "hostname=test$hostname"

    # Actually run the tests
    TARGET_HOST=$public_ip rake spec:$machine
done
