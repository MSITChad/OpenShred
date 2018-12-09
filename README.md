# OpenShred
OpenShred - released at DEF CON 24 in August 2016

Drag N Drop Windows 10 and Command Line Windows File Shredder using AES 256 using Ruby OpenSSL module

Random IV and Random Encryption Key purged within program memory before exit

File Info:

08/07/2016  08:20 AM OShredAES.exe

SHA1: 2fe1767ecb73f8b970cdb8fee7082fef8d99206a

Source code uploaded, to test: c:\ruby openshred.rb <file>
  
  View OpenShredSnip.JPG ^ to see the program used at the command line -> Click the 'Download' Icon above screen shot to make full size
  
Originally repository status missing/deleted; new upload

Instructions to build the Windows Executable from a Windows command prompt View BuildEXESnip.JPG ^

Simple Windows Instructions from c:\ command prompt in same directory as .rb and .ico:

ruby --version

gem install ocra

ocra openshred.rb --windows --icon shredicon.ico
