# OpenShred
OpenShred - released at DEF CON 24

Originally repository status missing/deleted; new upload

Drag and Drop Windows File Shredder using AES 256 using Ruby OpenSSL module

Random IV and Random Encryption Key purged within program memory before exit

View OpenShredSnip.JPG ^ to see the program used at the command line -> Click the 'Download' Icon above screen shot to make full size

Instructions to build the Windows Executable from a Windows command prompt View BuildEXESnip.JPG ^

Simple Windows Instructions from c:\ command prompt in same directory as .rb and .ico:

ruby --version

gem install ocra

ocra openshred.rb --windows --icon shredicon.ico
