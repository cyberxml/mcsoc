import socket
import time
import smtplib
import sys

'''
mailserver = "mail.example.net" # destination email server
fromaddress = "unittest@example.net" # email address of sender
toaddress = ["user@example.net"] # list of email address of receipients
testprhase = "CLI Test Message"
'''

if (len(sys.argv) == 5):
	mailserver = sys.argv[1]
	fromaddress = sys.argv[2]
	toaddress = [sys.argv[3]]
	testphrase = sys.argv[4]
else:
	print(len(sys.argv))
	for i in sys.argv:
		print(i)
	print("Usage: send_email.py fromaddress toaddress mailserver testphrase")
	exit(1)


# ---------------------------------------------------------
# email object
# ---------------------------------------------------------
class Mailmsg(object):
	'''
	An email object that can send itself
		x_fromaddr: string email address
		x_toaddr: list of string email addresses
		x_subject: string email subject
		x_data: string message
	'''	

	
	def __init__(self, x_fromaddr, x_toaddr, x_subject, x_data):
		self.fromaddr = x_fromaddr
		self.toaddr = x_toaddr
		self.subject = x_subject
		self.data = x_data
		self.message = ""
		self.set_msg()
	
	def set_msg(self):
		self.message = """\
From: %s
To: %s
Subject: %s

%s
""" % (self.fromaddr, ", ".join(self.toaddr), self.subject, self.data)
	
	def set_subject(self, x_subject):
		self.subject = x_subject
		self.set_msg()
	
	def set_data(self, x_data):
		self.data = x_data
		set_msg()
		self.set_msg()
	
	def set_message(self, x_subject, x_data):
		self.subject = x_subject
		self.data = x_data
		self.set_msg()
	
	def quickprint(self):
		print self.message
	
	def send(self, server,dbg=0):
		ret=0
		try:
			server=smtplib.SMTP(server)
			server.set_debuglevel(dbg)	
			server.sendmail(self.fromaddr, self.toaddr, self.message)
			server.quit()
		except:
			ret =1
		return ret	



if __name__ == '__main__':
	thistime = time.strftime("%Y-%m-%d %H:%M:%S")
	testmail = alertmail=Mailmsg(fromaddress,toaddress,testphrase+": "+thistime, testphrase+": "+thistime)
	ret=testmail.send(mailserver,0)
	exit(ret)

