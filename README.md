# PushNotifications

You’re going to use the command-line OpenSSL tools for this. Open a Terminal and execute the following steps.
Go to the folder where you downloaded the files, in my case the Desktop:
$ cd ~/Desktop/
Convert the .cer file into a .pem file:
$ openssl x509 -in aps_development.cer -inform der -out PushChatCert.pem
Convert the private key’s .p12 file into a .pem file:
$ openssl pkcs12 -nocerts -out PushChatKey.pem -in PushChatKey.p12
Enter Import Password: 
MAC verified OK
Enter PEM pass phrase: 
Verifying - Enter PEM pass phrase: 
You first need to enter the passphrase for the .p12 file so that openssl can read it. Then you need to enter a new passphrase that will be used to encrypt the PEM file. Again for this tutorial I used “pushchat” as the PEM passphrase. You should choose something more secure.
Note: if you don’t enter a PEM passphrase, openssl will not give an error message but the generated .pem file will not have the private key in it.
Finally, combine the certificate and key into a single .pem file:
$ cat PushChatCert.pem PushChatKey.pem > ck.pem
At this point it’s a good idea to test whether the certificate works. Execute the following command:
$ telnet gateway.sandbox.push.apple.com 2195
Trying 17.172.232.226...
Connected to gateway.sandbox.push-apple.com.akadns.net.
Escape character is '^]'.
This tries to make a regular, unencrypted, connection to the APNS server. If you see the above response, then your Mac can reach APNS. Press Ctrl+C to close the connection. If you get an error message, then make sure your firewall allows outgoing connections on port 2195.
Let’s try connecting again, this time using our SSL certificate and private key to set up a secure connection:
$ openssl s_client -connect gateway.sandbox.push.apple.com:2195 
    -cert PushChatCert.pem -key PushChatKey.pem
Enter pass phrase for PushChatKey.pem: 
You should see a whole bunch of output, which is openssl letting you know what is going on under the hood.
If the connection is successful, you should be able to type a few characters. When you press enter, the server should disconnect. If there was a problem establishing the connection, openssl will give you an error message but you may have to scroll up through the output to find it.
