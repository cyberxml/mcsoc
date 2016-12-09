import pytest
import vagrant
import os
import sys

# import from this dir or parent dir
# handles script or shell
try:
	sys.path.append(
		os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir)))
except: 
	sys.path.append(
		os.path.abspath(os.path.join(os.getcwd(), os.path.pardir)))

try:
	from mcsoc_test_config import *
except:
	print "Cannot find 'mcsoc-test-config'"
	exit(1)


# pass a tuple (hostname, zone, ip)
def vagrantStatus(host,zone):
	name = host.split('.')[0]
	try:
		v=vagrant.Vagrant(os.sep.join([PROJDIR,'vagrant',zone]))
		status=v.status(name)[0].state
	except:
		status='unknown'
	return status


@pytest.mark.parametrize("host,zone,ip",hostip)

def test_host_up(host,zone,ip):
	assert vagrantStatus(host,zone) == 'running'



