import pytest
import subprocess
import sys
import os

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


def test_vagrant_version():
	vver=subprocess.check_output('vagrant -v', shell=True).replace('\n','')
	assert vver >= PROJVAGRANTVERSION



