import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email import utils

def send_email(sender_email, receiver_email, subject, body, password):
    # Set up the SMTP server
    smtp_server = "smtp.gmail.com"
    smtp_port = 587

    # Create the email
    msg = MIMEMultipart()
    msg['From'] = utils.formataddr(("Unicredit","m45758670@gmail.com"))
    msg['To'] = receiver_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    try:
        # Connect to the server and send the email
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()  # Secure the connection
        server.login(sender_email, password)
        text = msg.as_string()
        server.sendmail(sender_email, receiver_email, text)
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        print(f"Failed to send email. Error: {e}")

# Example usage
sender_email = "gioeleamendola@gmail.com"
receiver_email = "gioeleamendola@gmail.com"
subject = "Test Email"
body = "This is a test email sent from Python."
password = "imavnannxybwdyas "

send_email(sender_email, receiver_email, subject, body, password)
