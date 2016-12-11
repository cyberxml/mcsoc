import imaplib
import time
import sys

if (len(sys.argv) == 5):
	mailserver=sys.argv[1]
	maillogin=sys.argv[2]
	mailpasswd=sys.argv[3]
	testphrase=sys.argv[4]
else:
	print("Usage: read_email.py mailserver maillogin mailpasswd testphrase")
	exit(1)

mail = imaplib.IMAP4_SSL(mailserver)
mail.login(maillogin, mailpasswd)

# connect to inbox
mail.select("inbox") 
result, data = mail.search(None, "ALL")

# list of mail ids
ids = data[0] # data is a list.
id_list = ids.split() 

# get the latest email
latest_email_id = id_list[-1] 

# fetch the email body (RFC822) for the given ID
result, data = mail.fetch(latest_email_id, "(RFC822)") 

# body of email 
raw_email = data[0][1] 

# assumes the test message was the last message received
# assumes a unit test email was sent in the same hour as current
# does not handle "top of the hour" roll overs
# example "Unit Test Message: 2016-12-30 11:30:14"
# in this example, the testphrase is "Unit Test Message"
dt = time.strftime("%Y-%m-%d %H")
subj = testphrase+": "+dt

ret = not subj in raw_email
#print ret

exit(int(ret))

