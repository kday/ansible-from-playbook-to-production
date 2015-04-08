#!/bin/bash

instance_ids="$(python build/get_ci_instance_ids.py)"

echo "Terminating: $instance_ids"

vars="{\"instance_ids\": ${instance_ids}}"
ansible-playbook -i inventory/ec2.py build/destroy-instances.yml --limit tag_Environment_CI -e "$vars"

exit 0
