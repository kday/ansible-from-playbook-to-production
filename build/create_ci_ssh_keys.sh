#!/bin/bash
set -e

echo $PROD_DEPLOY_KEY > /home/ubuntu/.ssh/prod_deploy_key
chmod 600 /home/ubuntu/.ssh/prod_deploy_key
echo $PROD_DEPLOY_KEY_PUB > /home/ubuntu/.ssh/prod_deploy_key.pub
chmod 644 /home/ubuntu/.ssh/prod_deploy_key.pub
