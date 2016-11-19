import unittest
import vagrant

v=vagrant.Vagrant()

rtrs = ['rtr-ext', 'rtr-dmz', 'rtr-int', 'rtr-dev']
p = 0
f = 0
for r in rtrs:
	try:
		status=v.status(r)
		if (status.state == 'running'):
			print '\t'.join(["[PASS]",r,status.state])
			p=p+1
		else:
			print '\t'.join(["[FAIL]",r,status.state])
			f=f+1
	except:
		print '\t'.join(["[FAIL]",r,'vagrant exception'])
		f=f+1

print '==========================='
print ' '.join([str(p),'of',str(p+f),'pass'])
print ' '.join([str(100.0*p/(p+f)), 'success rate'])


