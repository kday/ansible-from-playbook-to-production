import boto.ec2
import argparse
import json

REGION = 'us-east-1'

parser = argparse.ArgumentParser(description="Return the instance IDs for all instances with the Environment tag of 'CI'")

conn = boto.ec2.connect_to_region(REGION)
reservations = conn.get_all_reservations()

instance_ids = []

for reservation in reservations:
    for instance in reservation.instances:
        for key, value in instance.tags.iteritems():
            if key == 'Environment' and value == 'CI' and instance.state != 'terminated':
                instance_ids.append(instance.id)

print json.dumps(instance_ids)
exit(0)
