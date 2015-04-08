import boto.ec2
import argparse

REGION = 'us-east-1'

parser = argparse.ArgumentParser(description='Return the public DNS name for an EC2 instance.')
parser.add_argument('-i', '--instance',
                    action='store', dest='instance_name')
args = parser.parse_args()
instance_name = args.instance_name

conn = boto.ec2.connect_to_region(REGION)
reservations = conn.get_all_reservations()

for reservation in reservations:
    for instance in reservation.instances:
        for key, value in instance.tags.iteritems():
            if key == 'Name' and value == instance_name and instance.state == 'running':
                print instance.dns_name
                exit(0)

print 'Instance not found'
exit(1)
