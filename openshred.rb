#!/usr/bin/env ruby
# puts "#{ARGV[0]}" #file name here =) that is dropped onto exe =)
# (C) OpenShred (c) Chad Martell 2014 to 2016
# Will get SHA1 Hash of unencrypted file (and file size, each step)
# Encrypt with AES
# Get new hash of AES encrypted file, ensure it's different from plaintext Hash
# 6/28/2016 - revision - add all data output to new file based on Desktop *btester complaints of clutter
# 7/6/16 - added SHA1 hash values for each step of file modification

require 'rubygems'
require 'securerandom'
require 'base64'
require 'openssl'
require 'digest/sha1'

#$VERBOSE = nil
exit if Object.const_defined?(:Ocra)

#open file for program output
output = File.open( "OpenShred.txt","a" )

# test if file, if not exit
 if File.file?("#{ARGV[0]}") == true
   puts ">>>> File Verified"
   output << ">>>> File Verified\n"             #6/28/2016
 else
   puts ">>>> File only. Closing."
   output << ">>>> File only. Closing.\n"       #6/28/2016
   output.close                                 #6/28/2016
   exit
 end
## get file size
s = File.stat("#{ARGV[0]}").size
puts ">>>> File Size " "#{s}" " bytes."
output << ">>>> File Size " "#{s}" " bytes.\n"
if s == 0
  puts ">>>> File Size 0.  Closing.\n\n"
  output << ">>>> File Size 0.  Closing.\n\n"
  exit
end
# if s <= 200mb test
if s <= 200000000
  puts ">>>> File Size Accepted limit.\n\n"
  output << ">>>> File Size Accepted limit.\n\n"
 else  
  puts ">>>> File over 200mb, untested.  Exiting Program."
  output << ">>>> File over 200mb, untested.  Exiting Program."
  exit
end
##############################
#Encrypt file with AES-128-CBC
##############################
#Get SHA1 hash
c = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts "Sha1 value    : #{c}\n"
c = nil
#
puts ">>>> Beginning AES Encryption Process."
output << ">>>> Beginning AES Encryption Process."
## read file into variable
file = File.open("#{ARGV[0]}", "rb")
data = file.read
file.close

#encrypt file

cipher = OpenSSL::Cipher.new 'AES-128-CBC'
cipher.encrypt
iv = cipher.random_iv
key = cipher.random_key

puts %(clear plain_text:   "#{data}")
puts %(symmetric key: "#{key.inspect}")
puts %(initialization vector: "#{iv.inspect}")
puts %(cipher alg:   "#{cipher}")

encrypted = cipher.update "#{data}"
encrypted << cipher.final

puts %(encrypted plain_text: #{encrypted.inspect})

output = File.open("#{ARGV[0]}", "wb")
output << encrypted
output.close

file = nil         #reset internals
output = nil       #""
# clear the cipher
cipher.reset
#
c = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts "Sha1 value    : #{c}\n"
c = nil
#############################
#Over-write with random bytes
#############################
puts ">>>> Beginning Over-Write #1 with #{s} Random bytes.\n"
  string3 = SecureRandom.random_bytes(s)
  output = File.open( "#{ARGV[0]}", 'wb')
  output << string3
  output.close
#  enc = Base64.encode64(string3)
  puts ">>>> Over-Write #1 complete.\n"
  
c = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts "Sha1 value    : #{c}\n"
c = nil
  #############################
#Over-write with random bytes No. 2
#############################
puts ">>>> Beginning Over-Write #2 with #{s} Random bytes.\n"
  string4 = SecureRandom.random_bytes(s)
  output2 = File.open( "#{ARGV[0]}", 'wb')
  output2 << string4
  output2.close
#  enc = Base64.encode64(string4)
  puts ">>>> Over-Write #2 complete.\n"

c = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts "Sha1 value    : #{c}\n"
c = nil  
############################
#delete file
############################
 begin
   File.delete("#{ARGV[0]}")
     puts "\n>>>> File deleted."
  rescue Errno::ENOENT
   File.delete(@lf)
 end
 #