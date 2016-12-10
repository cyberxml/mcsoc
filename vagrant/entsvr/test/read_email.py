import imaplib
import time

mail = imaplib.IMAP4_SSL('mail.example.net')
mail.login('user@example.net', 'Vagrant!234')

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

# assumes a unit test email was sent in the same hour as current
# does not handle "top of the hour" roll overs
subj = time.strftime("Unit Test Message: %Y-%m-%d %H")

ret = not subj in raw_email
print ret

exit(int(ret))

