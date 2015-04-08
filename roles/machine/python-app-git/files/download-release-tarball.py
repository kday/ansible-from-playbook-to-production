#!/usr/bin/env python
import os
import subprocess

token = os.environ.get('GITHUB_ACCESS_TOKEN')
tag = os.environ.get('TAG')
repo = os.environ.get('REPO')
org = os.environ.get('ORG')

tmp_dir = '/tmp/deploy-artifacts'

if token == '' or token == None:
    print 'ERROR: Environment variable, GITHUB_ACCESS_TOKEN, is not set.'
    exit(1)

file_write = open('{0}/release-{1}-{2}.tgz'.format(tmp_dir, repo, tag), 'w')
subprocess.Popen(['curl',
                  '-L',
                  '-H', 'Authorization: token {0}'.format(token),
                  '-H', 'Accept: application/vnd.github-blob.raw',
                  'https://api.github.com/repos/{0}/{1}/tarball/{2}'.format(org, repo, tag)],
                 stdout=file_write).wait()
file_write.close()
