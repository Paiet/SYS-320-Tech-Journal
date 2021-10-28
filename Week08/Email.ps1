# Description: Sening emails and learning variables

# Body of the email

# Creating a variabl

$msg = "Hello there General Kenobi!"

# echoing to screen

write-host -BackgroundColor DarkMagenta -ForegroundColor White $msg

# Email From Address

$email = "connor.merchant@mymail.champlain.edu"

# To address 

$toEmail = "deployer@csi-web"

# Sending the email

Send-MailMessage -From $email -To $toEmail -Subject "A Greeting" -Body $msg -SmtpServer 192.168.6.71 
