import socket
import time
import smtplib

threshhold = 13 # threshold of diskusage as a percent
fromaddress = "unittest@example.net" # email address of sender
toaddress = ["user@example.net"] # list of email address of receipients
mailserver = "mail.example.net" # destination email server

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
	testmail = alertmail=Mailmsg(fromaddress,toaddress,"Unit Test Message: "+thistime, "Unit Test Message: "+thistime)
	ret=testmail.send(mailserver,0)
	exit(ret)

