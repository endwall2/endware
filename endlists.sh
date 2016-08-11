#!/bin/sh
####################################################################################
#                        HEADER AND INSTRUCTIONS
####################################################################################
# Program: endlists.sh
# Type: Bourne shell script
# Creation Date: February 14, 2016
# Current Version: 1.23  Aug 11 2016
# Stable Version:  1.22, Jul 9 2016
# Author: The Endware Development Team
# Copyright: The Endware Development Team 2016
#
####################################################################################
# Description:  Traditional iptables list based blacklisting 
#
# Changes:  - Loop over interfaces + abstract rule insertion point $insert, $insert6
#           - Updated Acknowledgements
#           - Rewrite with shell functions
#           - Updated EULA
#           - Fixed insertion numbers
#           - Updated EULA
#           - Fixed a jumped line of code
#           - Added EULA
#           - Removed Linux Security Booleans section.
#           - Fixed some style issues
#           - Fixed the logging bug (reversed the order of drop and log)
#           - Use && to execute log and drop rules in parallel (multiprocess)
#           - changed echo to Endlists Loaded
#
#
# Instructions: make directory,copy the file and change name to endlists.sh
#               make whitelists,blacklist text files, edit the endlists.sh file
#               change permisions to make endlists.sh executable, run the file.  
#                 
#
# Notes:    -  This script is slow to run with more than 1000 blacklist entries.
#           -  Use endsets.sh if your blacklists run over 1000 entries.
#
# $ mkdir ~/endwall
# $ cp endlists.sh ~/endwall/endlists.sh
# $ cd ~/endwall
# $ echo " " >> smtp_whitelist.txt  # whitelist (hotmail,gmail,etc)
# $ echo " " >> http_whitelist.txt  # users of your website  
# $ echo " " >> http_blacklist.txt  # ipv4 addresses to restrict http/https
# $ echo " " >> smtp_blacklist.txt  # ipv4 addresses to restrict smtp access
# $ echo " " >> dns_blacklist.txt   # ipv4 addresses to restrict dns access/ bad dns actors
# $ echo " " >> attackers.txt       # ipv4 blacklist for hack attackers / all ports protocols to your ip 
# $ echo " " >> blacklist.txt       # ipv4 blacklist of DOD subnets and others/ all ports protocols period
# $ echo " " >> email_blacklist.txt # strings of email addresses and keywords to block from smtp
# $ echo " " >> html_blacklist.txt  # strings of attack html calls (cgi,php) to block from http 
# $ echo " " >> ipv6_blacklist.txt  # ipv6 addresses to blacklist all ports and protocols
# $ ls                              # list the files you just made
# $ nano endlists.sh   # go to the section below labeled SAVE RULES (line 336)
#                      # comment out save rules for distributions you don't use line 336
# $ chmod u+rwx endlists.sh         # change permisions to allow script execution 
# $ su                              # become root
# # ./endwall.sh                    # execute script/install the basic firewall rules
# # ./endlists.sh                   # execute script / install blacklists
# # ./endsets.sh                    # execute script / install ipsets based blacklists 
##############################################################################################
#                       ADDING TO BAN LIST EXAMPLES
##############################################################################################
# Next add ip addresses to the whitelists and blacklists
# Example: adding an ip to attackers.txt
# $ echo "116.58.45.115" >> attackers.txt
# Example: banning a subnet from accessing smtp
# $ echo "116.58.0.0/16" >> smtp_blacklist.txt
# Example: banning a larger subnet from accessing http
# $ echo "117.0.0.0/8" >> http_blacklist.txt
# Example: banning a large subnet from accessing anything on your server
# $ echo "118.0.0.0/8" >> blacklist.txt
# Example: banning a spammer 
# $ echo "retard_lamer@website.com" >> email_blacklist.txt (read the postfix log for examples)
# Example: banning a hacker diving for files on your webserver (read your httpd log for examples)
# $ echo "/configuration.php" >> html_blacklist.txt
# $ echo "/wordpress/xmlrpc.php" >> html_blacklist.txt
# Example: Whitelisting 
# $ echo "198.252.153.0/24" >> http_whitelist.txt
# $ echo "198.252.153.0/24" >> smtp_whitelist.txt
# $ chmod u+wrx endwall.sh
# $ chmod u+wrx endlists.sh
# $ su                     
# # ./endwall.sh   # run the endwall firewall script 
# # ./endlists.sh  # run the blacklist/whitelist script endlists.sh
################################################################################################################################################
#                Enable iptables and ip6tables if using systemd
###############################################################################################################################################
# systemctl enable iptables
# systemctl enable ip6tables
# systemctl enable iptables.service
# systemctl enable ip6tables.service
# systemctl restart iptables
# systemctl restart ip6tables
#
############################################################################################################################################################################
############################################################################################################################################################################
#                                         ACKNOWLEDGEMENTS
############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, and SnakeDude who graciously hosted and promoted this software project.  
#  Without their efforts and their wonderful website www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, and to SnakeDude for inspiring this work and for hosting and promoting it. 
#  
#  The Endware Suite including Endwall,Endsets,Endlists,Endtools,Endloads and Endtube are named in honor of Endchan.
#
#  The Endware Suite is available for download at the following locations:
#  https://gitgud.io/Endwall/ , https://github.com/endwall2/, https://www.endchan.xyz/os/, http://42xlyaqlurifvvtq.onion,
#
#  Thank you also to early beta testers including a@a, and to other contributors 
#  as well as to the detractors who helped to critique this work and to ultimately improve it.  
#  
#  We also acknowledge paste.debian.net, ix.io, gitgud and github for their hosting services, 
#  without which distribution would be limited, so thank you.
#
#  https://www.endchan.xyz, http://paste.debian.net, https://gitgud.io, https://github.com, http://ix.io  
#
#  We salute you! 
#  
#  In the end, may it all end well.
#
#  The Endware Development Team
#############################################################################################################################################################################
###############################################################################################################################################################################
#                                                              LICENSE AGREEMENT  
##############################################################################################################################################################################
#  BEGINNING OF LICENSE AGREMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.10 
#  VERSION DATE: JULY 7, 2016
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, posses, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, public official, sovereign, monarch, head of state,
#        dignitary, ambassdor, noble, commoner, clergy, layity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any gender, including men, women, and any other gender not mentioned.       
#  1) e) This program may be used by anyone of any afiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any person of any race, ethnicity, identity, origin, genetic makeup, physical apperance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, subsea, in a submarine, underground,
#        in the air, in an airplane, dirigible, blimp, or balloon, and at any distance from the surface of the planet Earth, including in orbit about the Earth or the Moon,
#        on a satellite orbiting about the Earth, the Moon, about any Solar System planet and its moons, on any space transport vehicle, and anywhere in the Solar System including the Moon, Mars, and all other Solar System planets not listed.  
#  2) b) This program may be used in any residential, commercial, business, and governmental property or location and in all public and private spaces. 
#  2) c) This program may be used anywhere.
#  IN WHAT CONTEXT OR CIRCUMSTANCES MAY A USER USE THIS PROGRAM?
#  3)  This program may be used by any person, human being or sentient individual for any purpose and in any context and in any setting including for personal use, academic use,
#      business use, commercial use, government use, non-governmental organization use, non-profit organization use, military use, civilian use, and generally any other use 
#      not specifically mentioned.
#  WHAT MAY A "USER" DO WITH THIS PROGRAM ?
#  4) Any user of this program is granted the freedom to study the code.
#  5) a) Any user of this program is granted the freedom to distribute, publish, and share the code with any neighbor of their choice electronically or by any other method of transmission. 
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGEMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or saleable goods.
#  6) a) Any user of this program is granted the freedom to modify and improve the code.
#  6) b) When modified or improved, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or saleable goods.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procur a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procur a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intelectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#      b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  WHO GRANTS THESE FREEDOMS ?
#  10) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team", as well as ancillary contributors, and user modifiers and developers of the software. 
#  11) The aformentioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  12)  This software is distributed without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  13)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution or renumeration for any such loss real or imagined.
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADITIONAL NOTES:
#  14)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  15)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) h) are presented to clarify 1 a) and to enforce non-discrimination and non-exlusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################

##########################################################  BEGINNING OF PROGRAM   ########################################################################################################

#################################################################################################################
#                           GLOBAL VARIABLES
################################################################################################
iptables=/sbin/iptables
ip6tables=/sbin/ip6tables

# Grab interface name from ip link and parse 
int_if1=$(ip link | grep -a "2: " | awk -F: '{ print $2}')
int_if2=$(ip link | grep -a "3: " | awk -F: '{ print $2}')

# Grab Gateway Information
gateway_ip=$(ip route | awk '/via/ {print $3}')
#gateway_mac=$( arp | awk '/gateway/ {print $3}')
gateway_mac=$( nmap -sS $gateway_ip -p 53| grep -a "MAC Address:" | awk '{print $3}')

# grab host mac addresses from ip link  
host_mac1=$(ip link | grep -a "ether" | awk ' {if (FNR==1) print $2}')
host_mac2=$(ip link | grep -a "ether" | awk ' {if (FNR==2) print $2}')

# grab the ip addresses from the interfaces
host_ip1=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')
host_ip2=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')

host_ip1v6=$(ip addr | grep -a "scope link"|awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')
host_ip2v6=$(ip addr | grep -a "scope link"|awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')

########################### INTERNAL VARIABLES ################################## 
int_mac1="$host_mac1"       # internal mac address of interface 1
int_mac2="$host_mac2"       # internal mac address of interface 2 
int_ip1="$host_ip1"         # internal ipv4 address of interface 1  
int_ip2="$host_ip2"         # internal ipv4 address of interface 2
int_ip1v6="$host_ip1v6"     # internal ipv6 address of interface 1  
int_ip2v6="$host_ip2v6"     # internal ipv6 address of interface 2
###################################################################################

### Rule Insertion Points
insert=51
insert6=34

#################################################        FUNCTIONS        ##########################################################################################
log_drop()
{

proto=$1
ports=$2
tag=$3

iptables -I OUTPUT "$insert" -p $proto -s "$int_ip" -d "$blackout" -m multiport --dports $ports -j DROP && iptables -I OUTPUT "$insert" -p $proto -s "$int_ip" -d "$blackout" -m multiport --sports $ports -j DROP;
iptables -I INPUT "$insert" -p $proto -d "$int_ip" -s "$blackout" -m multiport --dports $ports -j DROP && iptables -I INPUT "$insert" -p $proto -d "$int_ip" -s "$blackout" -m multiport --sports $ports -j DROP;

iptables -I OUTPUT "$insert" -p "$proto" -s "$int_ip" -d "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && iptables -I OUTPUT "$insert" -p "$proto" -s "$int_ip" -d "$blackout" -m multiport  --sports "$ports" -j LOG --log-prefix "["$tag" OUT] "  --log-level=info 
iptables -I INPUT "$insert" -p "$proto" -d "$int_ip" -s "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info && iptables -I INPUT "$insert" -p "$proto" -d "$int_ip" -s "$blackout" -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info 

#iptables -I FORWARD "$insert" -p "$proto" -d "$int_ip" -s "$blackout" -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert" -p "$proto" -s "$int_ip" -d "$blackout" -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert" -p "$proto" -d "$int_ip" -s "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] "  --log-level=info;
#iptables -I FORWARD "$insert" -p "$proto" -s "$int_ip" -d "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info;

}


white()
{

proto=$1
ports=$2
tag=$3

iptables -I OUTPUT "$insert" -p "$proto" -s "$int_ip" -d "$whiteout" -m multiport --dports "$ports" -j ACCEPT && iptables -I INPUT "$insert"  -p "$proto" -d "$int_ip" -s "$whiteout" -m multiport --dports "$ports" -j ACCEPT;
iptables -I OUTPUT "$insert" -p "$proto" -s "$int_ip" -d "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && iptables -I INPUT "$insert" -p "$proto" -d "$int_ip" -s "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info;

#iptables -I FORWARD "$insert" -p tcp -d "$int_ip" -s "$whiteout" -m multiport --dports 25,587 -j ACCEPT;
#iptables -I FORWARD "$insert" -p tcp -s "$int_ip" -d "$whiteout" -m multiport --dports 25,587 -j ACCEPT;
#iptables -I FORWARD "$insert" -p tcp -d "$int_ip" -s "$whiteout" -m multiport --dports 25,587 -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info;
#iptables -I FORWARD "$insert" -p tcp -s "$int_ip" -d "$whiteout" -m multiport --dports 25,587 -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info;

}


log_drop6()
{

proto=$1
ports=$2
tag=$3

ip6tables -I OUTPUT "$insert6" -p $proto -s "$int_ipv6" -d "$blackout" -m multiport --dports $ports -j DROP && iptables -I OUTPUT "$insert6" -p $proto -s "$int_ipv6" -d "$blackout" -m multiport --sports $ports -j DROP;
ip6tables -I INPUT "$insert6" -p $proto -d "$int_ipv6" -s "$blackout" -m multiport --dports $ports -j DROP && iptables -I INPUT "$insert6" -p $proto -d "$int_ipv6" -s "$blackout" -m multiport --sports $ports -j DROP;

ip6tables -I OUTPUT "$insert6" -p "$proto" -s "$int_ipv6" -d "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && ip6tables -I OUTPUT "$insert6" -p "$proto" -s "$int_ipv6" -d "$blackout" -m multiport  --sports "$ports" -j LOG --log-prefix "["$tag" OUT] "  --log-level=info 
ip6tables -I INPUT "$insert6" -p "$proto" -d "$int_ipv6" -s "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info && ip6tables -I INPUT "$insert6" -p "$proto" -d "int_ipv6" -s "$blackout" -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info 

#iptables -I FORWARD "$insert6" -p "$proto" -d "$int_ipv6" -s "$blackout" -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert6" -p "$proto" -s "$int_ipv6" -d "$blackout" -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert6" -p "$proto" -d "$int_ipv6" -s "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] "  --log-level=info;
#iptables -I FORWARD "$insert6" -p "$proto" -s "$int_ipv6" -d "$blackout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info;

}

white6()
{

proto=$1
ports=$2
tag=$3

ip6tables -I OUTPUT "$insert6" -p "$proto" -s "$int_ipv6" -d "$whiteout" -m multiport --dports "$ports" -j ACCEPT && ip6tables -I INPUT "$insert6"  -p "$proto" -d "$int_ipv6" -s "$whiteout" -m multiport --dports "$ports" -j ACCEPT;
ip6tables -I OUTPUT "$insert6" -p "$proto" -s "$int_ipv6" -d "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && ip6tables -I INPUT "$insert6" -p "$proto" -d "$int_ipv6" -s "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info;

#ip6tables -I FORWARD "$insert6" -p tcp -d "$int_ipv6" -s "$whiteout" -m multiport --dports "$ports" -j ACCEPT;
#ip6tables -I FORWARD "$insert6" -p tcp -s "$int_ipv6" -d "$whiteout" -m multiport --dports "$ports" -j ACCEPT;
#ip6tables -I FORWARD "$insert6" -p tcp -d "$int_ipv6" -s "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info;
#ip6tables -I FORWARD "$insert6" -p tcp -s "$int_ipv6" -d "$whiteout" -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info;

}

##################################################################################################################################################################

### loop over interfaces

for int_if in "$int_if1" "$int_if2"

do

ind=1

if [ $ind == "1" ] 
then 
int_mac="$int_mac1" 
int_ip="$int_ip1"
int_ipv6="$int_ip1v6"
elif [ $ind == "2" ]
then
int_ip="$int_ip2" 
int_mac="$int_mac2" 
int_ipv6="$int_ip2v6"
fi 

if [ "$int_ip" != " " ]
then 

#################################################################################### 
# IP FILTER BLACK LISTS 
#################################################################################### 

echo HTTP/HTTPS BLACKLIST LOADING 
for blackout in $(cat http_blacklist.txt); 
do 
log_drop tcp 80,443 HTTP-BL 
echo "$blackout" 
done 

echo HTTP BLACKLIST LOADED

#smtp_blacklist.txt
echo SMTP BLACKLIST LOADING 
for blackout in $(cat smtp_blacklist.txt) 
do 
log_drop tcp 25,587 SMTP-BL

echo "$blackout"  
done 
echo SMTP BLACKLIST LOADED

echo DNS BLACKLIST LOADING
for blackout in $(cat dns_blacklist.txt)
do 

log_drop udp 53 DNS-BL
log_drop tcp 53 DNS-BL

echo "$blackout" 
done 
echo DNS BLACKLIST LOADED

echo EMAIL BLACKLIST LOADING
for blackout in $(cat email_blacklist.txt);
do 

iptables -I INPUT "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP ;
iptables -I INPUT "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] " --log-level=info && iptables -I OUTPUT "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] " --log-level=info ;

#iptables -I FORWARD "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insert" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] " --log-level=info

echo $blackout 
done 
echo EMAIL BLACKLIST LOADED

echo HTML BLACKLIST LOADING
for blackout in $(cat html_blacklist.txt);
do 

iptables -I INPUT "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP;
iptables -I INPUT "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info && iptables -I OUTPUT "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info;

#iptables -I FORWARD "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insert" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info;

echo "$blackout"  
done 
echo HTML BLACKLIST LOADED

echo ATTACKER BLACKLIST LOADING
for blackout in $(cat attackers.txt);
do 

iptables -I OUTPUT "$insert" -p all -s "$int_ip" -d "$blackout" -j DROP && iptables -I INPUT "$insert"  -p all -d "$int_ip" -s "$blackout" -j DROP;
iptables -I OUTPUT "$insert" -p all -s "$int_ip" -d "$blackout" -j LOG --log-prefix "[ATTACKER OUT] "  --log-level=info && iptables -I INPUT "$insert"  -p all -d "$int_ip" -s "$blackout" -j LOG --log-prefix "[ATTACKER IN] "  --log-level=info;

#iptables -I FORWARD "$insert" -p all -d "$int_ip" -s "$blackout" -j DROP;
#iptables -I FORWARD "$insert" -p all -s "$int_ip" -d "$blackout" -j DROP;

#iptables -I FORWARD "$insert" -p all -d "$int_ip" -s "$blackout" -j LOG --log-prefix "[ATTACKER FORWARD IN] "  --log-level=info;
#iptables -I FORWARD "$insert" -p all -s "$int_ip" -d "$blackout" -j LOG --log-prefix "[ATTACKER FORWARD OUT] "  --log-level=info;

echo "$blackout" 
done
echo ATTACKER BLACKLIST LOADED

echo LOADING BLACKLIST 
for blackout in $(cat blacklist.txt);
do 


iptables -I OUTPUT "$insert" -p all -d "$blackout" -j DROP && iptables -I INPUT "$insert"  -p all -s "$blackout" -j DROP;
iptables -I OUTPUT "$insert" -p all -d "$blackout" -j LOG --log-prefix "[BLACKLIST OUT] " --log-level=info && "iptables" -I INPUT "$insert"  -p all -s "$blackout" -j LOG --log-prefix "[BLACKLIST IN] "  --log-level=info;

#iptables -I FORWARD "$insert" -p all -s "$blackout" -j DROP;
#iptables -I FORWARD "$insert" -p all -d "$blackout" -j DROP;

#iptables -I FORWARD "$insert" -p all -s "$blackout" -j LOG --log-prefix "[BLACKLIST FORWARD IN] "  --log-level=info;
#iptables -I FORWARD "$insert" -p all -d "$blackout" -j LOG --log-prefix "[BLACKLIST FORWARD OUT] "  --log-level=info;

echo "$blackout"  
done
echo BLACKLIST LOADED

echo LOADING IPv6 BLACKLIST 
for blackout in $(cat ipv6_blacklist.txt);
do 

ip6tables -I OUTPUT "$insert6" -p all -d "$blackout" -j DROP && ip6tables -I INPUT "$insert6"  -p all -s "$blackout" -j DROP;
ip6tables -I OUTPUT "$insert6" -p all -d "$blackout" -j LOG --log-prefix "[IPv6 BLACKLIST OUT] " --log-level=info && ip6tables -I INPUT "$insert6" -p all -s "$blackout" -j LOG --log-prefix "[IPv6 BLACKLIST IN] "  --log-level=info ;

#ip6tables -I FORWARD "$insert6" -p all  -s "$blackout" -j DROP;
#ip6tables -I FORWARD "$insert6" -p all  -d "$blackout" -j DROP;
#ip6tables -I FORWARD "$insert6" -p all  -s "$blackout" -j LOG --log-prefix "[IPv6 BLACKLIST FORWARD IN] "  --log-level=info;
#ip6tables -I FORWARD "$insert6" -p all  -d "$blackout" -j LOG --log-prefix "[IPv6 BLACKLIST FORWARD OUT] "  --log-level=info;

echo "$blackout"  
done
echo IPv6 BLACKLIST LOADED

####################################################################################
#                    IP FILTER WHITE LISTS
####################################################################################

# smtp_whitelist.txt
#echo SMTP WHITELIST LOADING
#for whiteout in $(cat smtp_whitelist.txt);
#do 

#white tcp 25,587 SMTP-WL

#echo "$whiteout"  
#done 
#echo SMTP WHITELIST LOADED

# http_whitelist.txt
#echo HTTP/HTTPS WHITELIST LOADING
#for whiteout in $(cat http_whitelist.txt);
#do 

#white tcp 80,443 HTTP-WL

#echo "$whiteout"  
#done 
#echo HTTP/HTTPS WHITELIST LOADED

###############
### END OF LOOP OVER INTERFACES

fi

ind=$( expr "$ind" + 1 )

done

##########################################################################################################################
#                                 SAVE RULES
#####################################################################################################################
#ARCH/PARABOLA
iptables-save  > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

#DEBIAN/UBUNTU
iptables-save  > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# RHEL/CENTOS/FEDORA
iptables-save  > /etc/iptables/iptables
ip6tables-save > /etc/iptables/ip6tables

############ RHEL/CENTOS/FEDORA
#iptables-save  > /etc/iptables/iptables
#ip6tables-save > /etc/iptables/ip6tables
#########  DEBIAN/UBUNTU
# iptables-save >  /etc/iptables/rules.v4
# ip6tables-save > /etc/iptables/rules.v6 
######### ARCH/PARABOLA/ARCHBANG/ANTERGOS/MANJARO
# iptables-save >  /etc/iptables/iptables.rules 
# ip6tables-save > /etc/iptables/ip6tables.rules 

echo "ENDLISTS LOADED"
################################  PRINT RULES   ###############################################################
#list the rules
#iptables -L -v
#ip6tables -L -v

#############################   PRINT ADDRESSES  ############################################################
echo GATEWAY  :          MAC:$gateway_mac  IP:$gateway_ip  
echo INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" 
echo INTERFACE_2: "$int_if2" MAC:"$int_mac2" IPv4:"$int_ip2" IPv6:"$int_ip2v6"
# print the time the script finishes
date
##########################################################  END OF PROGRAM  ########################################################################################################
