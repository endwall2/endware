#!/bin/sh
##################################################################
# Program: endsets.sh
# Type: Bourne shell script
# Creation Date: February 12, 2016
# Current Version: 1.31
# Revision Date: June 25 2022
# Stable Version: 1.28
# Stable Version Date: July 11 2016
# Author: The Endware Development Team 
# Copyright: The Endware Development Team, 2016
#
# Description: Loads ipsets, blacklists and whitelists into iptables
#              
# Notes:  This script can be modified to not save it's rules 
#         and be ephemeral on reboot by commenting out lines 513-522
#         do not attempt to save the iptables ruleset unless you have enabled
#         the ipset daemon, as this may cause your firewall to fail and reset in 
#         an open policy state (no firewall).
#        
# Change Log: - Loop over interfaces
#             - Updated Acknowledgements
#             - sort -un on tor nodes
#             - Changed hash size and maxelem (I think this might solve return ip after ban bug)
#             - Updated EULA
#             - Annotated Beginning and End of Program
#             - Fixed insertion numbers
#             - Added tor exit node grabber
#             - Updated EULA
#             - Added EULA
#             - moved booleans to endwall using syctl (removed from script)
#             - Added save persistence
#             - Fixed some style issues
#             - Fixed the Logging problem (reverse order of log and drop due to insert)
#             - Use && to execute log and drop rules in parallel (multiprocess)
###################################################################
#                   INSTRUCTIONS
###################################################################
# STEP 1) INSTALL ipset
# $ su
# # pacman -S ipset 
#
# STEP 2) make directory and save file, make blacklists and whitelists
# $ 
# $ mkdir ~/endwall
# $ cp vdyvuh.sh ~/endwall/endwall.sh
# $ cp rshrwh.sh ~/endwall/endset.sh
# $ cd ~/endwall
# $ echo " " >> smtp_whitelist.txt  # whitelist (hotmail,gmail,etc)
# $ echo " " >> http_whitelist.txt  # users of your website  
# $ echo " " >> http_blacklist.txt  # ipv4 addresses to restrict http/https
# $ echo " " >> smtp_blacklist.txt  # ipv4 addresses to restrict smtp access
# $ echo " " >> dns_blacklist.txt   # ipv4 addresses to restrict dns access/ bad dns actors
# $ echo " " >> attackers.txt       # ipv4 blacklist for hack attackers 
# $ echo " " >> blacklist.txt       # ipv4 blacklist of DOD subnets and others 
# $ echo " " >> email_blacklist.txt # strings of email addresses and keywords to block from smtp
# $ echo " " >> html_blacklist.txt  # strings of attack html calls (cgi,php) to block from http 
# $ echo " " >> ipv6_blacklist.txt  # ipv6 blacklist for subnets
# $ ls                              # list the files you just made
# 
# STEP 3) edit endwall.sh and endset.sh to suite your needs
# $ nano endwall.sh   # go to the section below labeled GLOBAL VARIABLES
#                       edit the variables client1_ip,client1_mac,client1_ip,client2_mac 
#                       so that they match your needs and save. ^X  
#                       uncomment the macchanger lines to use machanger
#
# STEP 4) Make files executable and run them
# $ chmod u+rwx endset.sh          # changer permisions to allow script execution
# $ chmod u+rwx endwall.sh         # change permisions to allow script execution 
# $ su                             # become root
# #./endwall.sh                    # First execute endwall to set your firewall and save it 
# # systemctl enable ipset.service # Enable ipset to run as a daemon on reboot
# # systemctl start ipset          # Start the ipset daemon
# #./endsets.sh                    # Next execute/run the file endset.sh to setup blacklists and whitelists
###############################################################################################
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
# $ echo "6.0.0.0/8" >> blacklist.txt
# Example: banning a spammer 
# $ echo "retard_lamer@website.com" >> email_blacklist.txt (read the postfix log for examples)
# Example: banning a hacker diving for files on your webserver (read your httpd log for examples)
# $ echo "/configuration.php" >> html_blacklist.txt
# $ echo "/wordpress/xmlrpc.php" >> html_blacklist.txt
# $ chmod u+wrx endwall.sh
# $ su                     
# # ./endwall.sh   # run the firewall script with the new blacklisted ipv4 addresses
# # ./endlists.sh  # (optional) configure this for /8 bans with big_bans.txt
# # ./endsets.sh   # run endsets
###############################################################################################
#                      BANNING ON THE FLY WITH IPSETS
###############################################################################################
# # ipset add http_blacklist 113.205.0.0/16
# # ipset add smtp_blacklist 113.205.0.0/16 
# # ipset add blacklist 6.0.0.0/8
# # ipset add dns_blacklist 114.50.150.58
# # ipset add attackers 114.58.29.158
#
#  Whitelisting should only be done to singleton ip addresses or at most a  /24 block
#
# # ipset add http_whitelist 198.252.153.0/24
# # ipset add smtp_whitelist 198.252.153.0/24
#
#  Made a mistake and want to remove number from blacklist or whitelist
# # ipset del http_blacklist 152.41.31.158
#
#  List all members of a set and search for a specific block range
#
# # ipset list http_blacklist
# # ipset list http_blacklist | grep 113.205.0.0/16
#
################################################################################################
#                          ENABLE IPTABLES/IP6TABLES 
#################################################################################################
# systemd commands:
# systemctl enable iptables
# systemctl enable ip6tables
# systemctl enable iptables.service
# systemctl enable ip6tables.service
# systemctl restart iptables
# systemctl restart ip6tables
####################################################################################################
#                          ENABLE IPSET 
##################################################################################################
# systemctl enable ipset.service
# systemctl start ipset
# systemctl restart ipset
#############################################################################################################################################################################
#                                         ACKNOWLEDGMENTS
#############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, Balrog and SnakeDude who graciously hosted and promoted this software project. 
#  We would also like to acknowledge the work and efforts of Stephen Lynx, the creator and maintainer of LynxChan.  
#  Without their efforts and their wonderful web site www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, Balrog, SnakeDude, and Stephen Lynx for inspiring this work and for hosting and promoting it. 
#  
#  The Endware Suite including Endwall,Endsets,Endlists,Endtools,Endloads and Endtube are named in honor of Endchan.
#
#  The Endware Suite is available for download at the following locations:
#  https://gitgud.io/Endwall/ , https://github.com/endwall2/, https://www.endchan.xyz/os/, http://42xlyaqlurifvvtq.onion,
#
#  Special thanks to the designer of the current EndWare logo which replaces the previous logo. It looks great!
#  Thank you also to early beta testers including a@a, and to other contributors including Joshua Moon (for user_agents.txt split and other good suggestions) 
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
##############################################################################################################################################################################
#############################################################   BEGINNING OF PROGRAM  ##############################################################################
##############################################################################################################################################################################
#                                                              LICENSE AGREEMENT  
##############################################################################################################################################################################
#  BEGINNING OF LICENSE AGREEMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.19
#  VERSION DATE: JUNE 23, 2022
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2018
#  ALL RIGHTS RESERVED  
#    
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, possess, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, government official, sovereign, monarch, head of state,
#        dignitary, ambassador, legislator,congressional representative, member of parliament, senator, judicial official, judge, prosecutor, lawyer, law enforcement officer, 
#        police constable, noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any sex or gender, including men, women, or any other sex, or gender not mentioned.       
#  1) e) This program may be used by any human being of any affiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any human being of any race, ethnicity, identity, origin, genetic makeup, physical appearance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by all business classes and business entities, including corporations, limited liability companies, sole proprietorships, partnerships, joint venture companies, private companies, publicly owned companies, and any other business class not specifically mentioned. 
#  1) i) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, sub-sea, in a submarine, underground,
#        in the air, in an airplane, dirigible, blimp, or balloon, in a car, bus, motor vehicle, train, armored transport vehicle, and at any distance from the surface of the planet Earth, including in orbit about the Earth, the Moon, or the planet Mars,
#        on a satellite orbiting about the Earth, the Moon, the planet Mars, and about any Solar System planet and its moons, on any space transport vehicle, and anywhere in the Solar System including the Moon, Mars, and all other Solar System planets not listed.  
#  2) b) This program may be used in any residential, commercial, business, and governmental property or location and in all public and private spaces. 
#  2) c) This program may be used anywhere.
#  IN WHAT CONTEXT OR CIRCUMSTANCES MAY A USER USE THIS PROGRAM?
#  3)  This program may be used by any person, human being or sentient individual for any purpose and in any context and in any setting including for personal use, academic use,
#      business use, commercial use, government use, non-governmental organization use, non-profit organization use, military use, civilian use, and generally any other use 
#      not specifically mentioned.
#  WHAT MAY A "USER" DO WITH THIS PROGRAM ?
#  4) Any user of this program is granted the freedom to read and study the code.
#  5) a) Any user of this program is granted the freedom to distribute, publish, and share the code with any recipient of their choice electronically or by any other method of transmission. 
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or saleable goods.
#  6) a) Any user of this program is granted the freedom to modify the code.
#  6) b) When modified, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or saleable goods.
#  6) d) Any modified code shall be sublicensed by the modifier and distributor only under the original terms of the Endware End User License Agreement as presented in this LICENSE AGREEMENT.
#  6) e) Any user of this software agrees that any derivative works produced as a result of user modification will be sublicensed when re-distributed under the original terms of this LICENSE AGREEMENT exactly as presented.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procure a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procure a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intellectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#  11) b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  12) a) Any user of this program is not granted the freedom to remove, replace, alter or modify the LICENSE AGREEMENT, ACKNOWLEDGMENTS, or the Header and Instructions from the file, if being distributed without modification of the program code. 
#         The LICENSE AGREEMENT, ACKKNWLEGEMENTS and Header and Instructions sections must remain attached to the code in their entirety when re-distributed without modification. 
#      b) If the code is moodified, by a user, as permitted and allowed under section 6) a),b),c),d),e) of this LICENSE AGREEMENT, then 
#         the user of this program who made the program code modifications may modify or alter the ACKNKOWLEGEMENTS, or the Header and Instructions sections to document these new modifications and their authorship, and to acknowledge any asistance in doing so, 
#         however, these user modifiers are not granted the freedom to removem, replace, alter or modify the LICENSE AGREEMENT which must remain attached to the code in their entirety when re-distributed without modification.
#  WHO GRANTS THESE FREEDOMS ?
#  13) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team" by "Endwall", as well as ancillary contributors, and user modifiers and developers of the software. 
#  14) The aforementioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  15)  This software is distributed "AS IS" without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  16)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programmers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution, compensation, or payment for any such loss real or imagined.
#  17)  If a user makes a significant improvement to this software, and if this improvement is included in a release, the user agrees not to seek remuneration or payment 
#       from the creators of this software or from Endwall or from the Endware Development Team, for any such work contribution performed, and the user understands 
#       that there will be no such remuneration or payment rendered to them for any such contribution. 
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADDITIONAL NOTES:
#  18)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  19)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) i) are presented to clarify 1 a) and to enforce non-discrimination and non-exclusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################

######################################################################################################
#                           GLOBAL VARIABLES
#######################################################################################################
# version information
version="1.31"
branch="gnu/linux"
rev_date="25/06/2022"

##  get input list from shell argument 
for arg in $@
do 

if [ "$arg" = "--help" ]
 then
 echo "ENDSETS: traditional iptables based text list blacklisting and whitlisting"
 echo " "
 echo "USAGE:  ./endsets.sh --option " 
 echo "./endsets --help    ## print usage information"
 echo "./endsets --version ## print version information"
 echo "./endsets    ## default mode downloads videos in list.txt"
 echo " "
 shift 
 exit 0
 elif [ "$arg" = "--version" ]
 then
 echo "ENDSETS: version "$version", branch: "$branch", revision date: "$rev_date" "
 echo "Copyright: 2016, THE ENDWARE DEVELOPMENT TEAM" 
 shift
 exit 0
 fi  

arghold="$arg"
 
done

####################################################################################################
#                           GLOBAL VARIABLES
####################################################################################################
### variable for the nft command location
iptables="/sbin/iptables"
ip6tables="/sbin/ip6tables"

# Grab interface name from ip link and parse 
int_if1=$(ip link | grep -a "state " | awk -F: '{ if (FNR==2) print $2}')
int_if2=$(ip link | grep -a "state " | awk -F: '{ if (FNR==3) print $2}')

# Grab Gateway Information
gateway_ip=$(ip route | awk '/via/ {print $3}')
#gateway_mac=$( arp | awk '/gateway/ {print $3}')
gateway_mac=$( nmap -sS "$gateway_ip" -p 53| grep -a "MAC Address:" | awk '{print $3}')

# RUN MAC CHANGER on INTERFACES
#macchanger -A $int_if
#macchanger -A "$int_if2"

# grab host mac addresses from ip link  
host_mac1=$(ip link | grep -a "ether" | awk ' {if (FNR==1) print $2}')
host_mac2=$(ip link | grep -a "ether" | awk ' {if (FNR==2) print $2}')

# grab the ip addresses from the interfaces
host_ip1=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')
host_ip2=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')
# grab the ipv6 addresses frrom the interfaces
host_ip1v6=$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')
host_ip2v6=$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==3) print $1}'| awk '{print $2}')

#####################    INTERNAL VARIABLES  #########################################################

int_mac1="$host_mac1"
int_ip1="$host_ip1"   # set the ip of the machine
int_ip1v6="$host_ip1v6"

int_mac2="$host_mac2"
int_ip2="$host_ip2"
int_ip2v6="$host_ip2v6"

insert_in=2
insert_fwd=2
insert_out=2

insert6_in=2
insert6_fwd=2
insert6_out=2

############################################################################################################

###################################################################################################
#                       IP SET CREATION 
###################################################################################################
ipset flush
ipset destroy

ipset create -exist server_blacklist hash:net hashsize 8192 maxelem 4294967295
ipset create -exist http_blacklist hash:net hashsize 8192   maxelem 4294967295
ipset create -exist smtp_blacklist hash:net hashsize 8192 maxelem 4294967295
ipset create -exist dns_blacklist hash:net hashsize 8192  maxelem 4294967295
ipset create -exist irc_blacklist hash:net hashsize 8192 maxelem 429467295

ipset create -exist http_whitelist hash:net hashsize 8192 maxelem 4294967295
ipset create -exist smtp_whitelist hash:net hashsize 8192 maxelem 4294967295
ipset create -exist irc_whitelist hash:net hashsize 8192 maxelem 429467295

ipset create -exist tor_list hash:net hashsize 8192 maxelem 4294967295

ipset create -exist attackers hash:net hashsize 8192 maxelem 4294967295
ipset create -exist blacklist hash:net hashsize 8192 maxelem 4294967295
ipset create -exist ipv6_blacklist hash:net family inet6 hashsize 8192 maxelem 4294967295

ipset flush

##########################################          FUNCTIONS             ########################################################### 

log_drop()
{
set=$1
proto=$2
ports=$3
tag=$4

iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --sports "$ports" -j DROP && iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --dports "$ports" -j DROP;
iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info 
iptables -I INPUT  "$insert_in" -p "$proto" -d "$int_ip" -m set --match-set "$set" src -m multiport --dports "$ports" -j DROP && iptables -I INPUT "$insert_in" -p "$proto"-d "$int_ip" -m set --match-set "$set" src -m multiport --sports "$ports" -j DROP;
iptables -I INPUT  "$insert_in" -p "$proto" -d "$int_ip" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info && iptables -I INPUT "$insert_in" -p "$proto" -d "$int_ip" -m set --match-set "$set" src -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" IN] "--log-level=info;

#iptables -I FORWARD "$insert_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j DROP;
#iptables -I FORWARD "$insert_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j DROP;
#iptables -I FORWARD "$insert_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j DROP;

#iptables -I FORWARD "$insert_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 
#iptables -I FORWARD "$insert_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 
}

log_drop6()
{
set=$1
proto=$2
ports=$3
tag=$4

ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j DROP && ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j DROP;
ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info 
ip6tables -I INPUT  "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j DROP && iptables -I INPUT "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j DROP;
ip6tables -I INPUT  "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info && ip6tables -I INPUT "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" IN] "--log-level=info;

#iptables -I FORWARD "$insert6_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j DROP;
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j DROP;
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j DROP;
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j DROP;

#iptables -I FORWARD "$insert6_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --sports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 
#iptables -I FORWARD "$insert6_fwd" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 
}

white()
{
set=$1
proto=$2
ports=$3
tag=$4

iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --dports "$ports" -j ACCEPT && iptables -I INPUT "$insert_in" -p "$proto" -d "$int_ip" -m set --match-set "$set" src -m multiport --dports "$ports" -j ACCEPT;
iptables -I OUTPUT "$insert_out" -p "$proto" -s "$int_ip" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && iptables -I INPUT "$insert_in" -p "$proto" -d "$int_ip" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info 
}


white6()
{
set=$1
proto=$2
ports=$3
tag=$4

ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j ACCEPT && ip6tables -I INPUT "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j ACCEPT;
ip6tables -I OUTPUT "$insert6_out" -p "$proto" -s "$int_ipv6" -m set --match-set "$set" dst -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" OUT] " --log-level=info && ip6tables -I INPUT "$insert6_in" -p "$proto" -d "$int_ipv6" -m set --match-set "$set" src -m multiport --dports "$ports" -j LOG --log-prefix "["$tag" IN] " --log-level=info 
}

### on internal interface on lan defined ip
ip_blacklist(){
set=$1
tag=$2

iptables -I OUTPUT "$insert_out" -p all -s "$int_ip" -m set --match-set "$set" dst -j DROP
iptables -I OUTPUT "$insert_out" -p all -s "$int_ip" -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" OUT] " --log-level=info
iptables -I INPUT  "$insert_in"  -p all -d "$int_ip" -m set --match-set "$set" src -j DROP 
iptables -I INPUT  "$insert_in"  -p all -d "$int_ip" -m set --match-set "$set" src -j LOG --log-prefix "["$tag" IN] " --log-level=info 

#iptables -I FORWARD "$insert_fwd" -p all -d "$int_ip"  -m set --match-set "$set" src -j DROP;
#iptables -I FORWARD "$insert_fwd" -p all -s "$int_ip" -m set --match-set "$set" dst -j DROP;
#iptables -I FORWARD "$insert_fwd" -p all -d "$int_ip" -m set --match-set "$set" src -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert_fwd" -p all -s "$int_ip" -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 


}

### on internal interface on lan defined ipv6
ip6_blacklist(){
set=$1
tag=$2

ip6tables -I OUTPUT "$insert6_out" -p all -s "$int_ipv6" -m set --match-set "$set" dst -j DROP ;
ip6tables -I OUTPUT "$insert6_out" -p all -s "$int_ipv6" -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" OUT] " --log-level=info ;
ip6tables -I INPUT  "$insert6_in"  -p all -d "$int_ipv6" -m set --match-set "$set" src -j DROP ;
ip6tables -I INPUT  "$insert6_in"  -p all -d "$int_ipv6" -m set --match-set "$set" src -j LOG --log-prefix "["$tag" IN] " --log-level=info ;

#ip6tables -I FORWARD "$insert6_fwd" -p all-s "$int_ipv6" -m set --match-set "$set" dst -j DROP;
#ip6tables -I FORWARD "$insert6_fwd" -p all -d "$int_ipv6" -m set --match-set "$set" src -j DROP;
#ip6tables -I FORWARD "$insert6_fwd" -p all -d "$int_ipv6" -m set --match-set "$set" src -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#ip6tables -I FORWARD "$insert6_fwd" -p all -s "$int_ipv6" -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 

}

hard_blacklist(){
set=$1
tag=$2

iptables -I OUTPUT "$insert_out" -p all -m set --match-set "$set" dst -j DROP && iptables -I INPUT "$insert_in" -p all -m set --match-set "$set" src -j DROP;
iptables -I OUTPUT "$insert_out" -p all -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" OUT] " --log-level=info && iptables -I INPUT "$insert_in" -p all -m set --match-set "$set" src -j LOG --log-prefix "["$tag" IN] " --log-level=info;

#iptables -I FORWARD "$insert_fwd" -p all -m set --match-set "$set" src -j DROP;
#iptables -I FORWARD "$insert_fwd" -p all -m set --match-set "$set" dst -j DROP;
#iptables -I FORWARD "$insert_fwd" -p all -m set --match-set "$set" src -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#iptables -I FORWARD "$insert_fwd" -p all -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" FORWARD OUT] "  --log-level=info 

}

hard_blacklist6(){
set=$1
tag=$2

ip6tables -I OUTPUT "$insert6_out" -p all -m set --match-set "$set" dst -j DROP && ip6tables -I INPUT "$insert6_in" -p all -m set --match-set "$set" src -j DROP;
ip6tables -I OUTPUT "$insert6_out"  -p all -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" OUT] " --log-level=info && ip6tables -I INPUT "$insert6_in" -p all -m set --match-set "$set" src -j LOG --log-prefix "[$tag IN] "  --log-level=info; 

#ip6tables -I FORWARD "$insert6_fwd" -p all -m set --match-set "$set" src -j DROP && ip6tables -I FORWARD "$insert6_fwd" -p all -m set --match-set "$set" dst -j DROP;
#ip6tables -I FORWARD "$insert6_fwd" -p all -m set --match-set "$set" src -j LOG --log-prefix "["$tag" FORWARD IN] " --log-level=info 
#ip6tables -I FORWARD "$insert6_fwd" -p all -m set --match-set "$set" dst -j LOG --log-prefix "["$tag" FORWARD OUT] " --log-level=info 

}	

############################################# END OF FUNCTIONS ####################################################################


#########  FOR LOOP OVER INTERFACES

# initialize index
ind=1

for int_if in "$int_if1" "$int_if2"

do 

if [ "$ind" = "1" ]
then 
int_mac="$int_mac1"
int_ip="$int_ip1"
int_ipv6="$int_ip1v6"

elif [ "$ind" = "2" ]
then 
int_mac="$int_mac2"
int_ip="$int_ip2"
int_ipv6="$int_ip2v6"
fi

## check if int_ip was picked up or empty 
if [ "$int_ip" != "" ]
then 

####################################################################################
#                    IP FILTER BLACK LISTS
####################################################################################

### ports that your server serves to clearnet access
server_ports="21,20,70,80,443,53,25,587,953,993,995,5222,6697,22543,64738"

#echo SERVER BLACKLIST LOADING
log_drop server_blacklist tcp "$server_ports" SERVER-BL
log_drop server_blacklist udp "$server_ports" SERVER-BL
echo SERVER BLACKLIST LOADED

echo HTTP/HTTPS BLACKLIST LOADING
log_drop http_blacklist tcp 80,443 HTTP-BL
echo HTTP BLACKLIST LOADED

echo SMTP BLACKLIST LOADING
log_drop smtp_blacklist tcp 25,587 SMTP-BL
echo SMTP BLACKLIST LOADED

echo IRC BLACKLIST LOADING
log_drop smtp_blacklist tcp 6667,6697 IRC-BL
echo IRC BLACKLIST LOADED

echo DNS BLACKLIST LOADING
log_drop dns_blacklist udp 53,953 DNS-BL
log_drop dns_blacklist tcp 53,953 DNS-BL
echo DNS BLACKLIST LOADED

echo ATTACKER BLACKLIST LOADING
ip_blacklist attackers ATTACKER
echo ATTACKER BLACKLIST LOADED

echo TOR BLACKLIST LOADING
#log_drop tor_list tcp 25,587,80,443 TOR-BL
log_drop tor_list tcp "$server_ports" TOR-BL
echo TOR BLACKLIST LOADED

####################################################################################
#                    IP FILTER WHITE LISTS
####################################################################################

#echo SMTP WHITELIST LOADING
white smtp_whitelist tcp 25,587 SMTP-WL
echo SMTP WHITELIST LOADED

#echo HTTP/HTTPS WHITELIST LOADING
white http_whitelist tcp 80,443 HTTP-WL
echo HTTP/HTTPS WHITELIST LOADED

#echo IRC WHITELIST LOADING
white http_whitelist tcp 6667,6697 HTTP-WL
echo HTTP/HTTPS WHITELIST LOADED

####################################################################################

###################### END OF FOR LOOP OVER INTERFACES

fi 

## increment index to next interface
ind=$( expr "$ind" + 1 )

done

#################### NON INTERFACE SPECIFIC ##########################################
#echo LOADING BLACKLIST 
hard_blacklist blacklist IPv4-BLACKLIST
echo BLACKLIST LOADED

#echo LOADING IPv6 BLACKLIST 
hard_blacklist6 ipv6_blacklist IPv6-BLACKLIST
echo IPv6 BLACKLIST LOADED
######################################################################################


#######################################################################################
#                  STRING MATCHING BLACKLISTS
######################################################################################
#echo EMAIL BLACKLIST LOADING
#for blackout in $(cat email_blacklist.txt);
#do 
#iptables -I INPUT "$insert_in" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert_out" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP; 
#iptables -I INPUT "$insert_in"  -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] "--log-level=info && iptables -I OUTPUT "$insert_out" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] " --log-level=info ;
#iptables -I FORWARD "$insert_fwd" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insert_fwd" -p tcp --dport 25 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[EMAIL SPAM] " --log-level=info 
#echo "$blackout" ; 
#done 
#echo EMAIL BLACKLIST LOADED

#echo HTML BLACKLIST LOADING
#for blackout in $(cat html_blacklist.txt);
#do 
#iptables -I INPUT "$insert_in" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert_out" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP; 
#iptables -I INPUT "$insert_in" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info && iptables -I OUTPUT "$insert_out" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info ;
#iptables -I FORWARD "$insert_fwd" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insert_fwd" -p tcp -m multiport --dports 80,443 -m string --string "$blackout" --algo bm -j LOG --log-prefix "[HTTP SPAM] " --log-level=info  
#echo "$blackout" ; 
#done 
#echo HTML BLACKLIST LOADED


########################################
#          TOR EXIT NODES
#########################################
curl https://check.torproject.org/exit-addresses | grep -ah "ExitAddress" | awk '{print $2}' | sort -un > tor_exit.txt

## format for cidr
for tor_ip in $( cat tor_exit.txt );
do
echo "Tor Exit Node:" "$tor_ip"  

rt=$(echo "$tor_ip"| cut -d . -f 1,2,3 )
ipset add tor_list "$rt".0/24 

done
echo "TOR EXIT NODES LOADED"

#########################################
#         POPULATE WHITELISTS
#######################################
#echo LOADING HTTP WHITELIST 
#for whiteout in $(cat http_whitelist.txt);
#do 
#ipset add http_whitelist "$whiteout" 
#echo "$whiteout" ; 
#done
#echo HTTP WHITELIST LOADED

#echo LOADING SMTP WHITELIST 
#for whiteout in $(cat smtp_whitelist.txt);
#do 
#ipset add smtp_whitelist "$whiteout" 
#echo "$whiteout" ; 
#done
#echo SMTP WHITELIST LOADED

##################################################
#       POPULATE BLACKLISTS
###################################################
echo LOADING SERVER BLACKLIST 
for blackout in $(cat server_blacklist.txt);
do 
ipset add server_blacklist "$blackout" 
echo "$blackout" ; 
done
echo SERVER BLACKLIST LOADED

#echo LOADING HTTP BLACKLIST 
#for blackout in $(cat http_blacklist.txt);
#do 
#ipset add http_blacklist "$blackout" 
#echo "$blackout" ; 
#done
#echo HTTP BLACKLIST LOADED

#echo LOADING SMTP BLACKLIST 
#for blackout in $(cat smtp_blacklist.txt);
#do 
#ipset add smtp_blacklist "$blackout" 
#echo "$blackout" ; 
#done
#echo SMTP BLACKLIST LOADED

#echo LOADING DNS BLACKLIST 
#for blackout in $(cat dns_blacklist.txt);
#do 
#ipset add dns_blacklist "$blackout" 
#echo "$blackout" ; 
#done
#echo "DNS BLACKLIST LOADED"

echo LOADING ATTACKER BLACKLIST 
for blackout in $(cat attackers.txt);
do 
ipset add attackers "$blackout" 
echo "$blackout" ; 
done
echo ATTACKER BLACKLIST LOADED

echo LOADING BLACKLIST 
for blackout in $(cat blacklist.txt);
do 
ipset add blacklist "$blackout" 
echo "$blackout" ; 
done
echo BLACKLIST LOADED

echo LOADING IPv6 BLACKLIST 
for blackout in $(cat ipv6_blacklist.txt);
do 
ipset add ipv6_blacklist "$blackout" 
echo "$blackout" ; 
done
echo IPv6 BLACKLIST LOADED

#########################################

echo "ENDSETS LOADED"
################################  SAVE RULES    ##############################################################

ipset save > /etc/ipset.conf

## Parabola/Arch systemd
iptables-save > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

## Debian/Ubuntu systemd
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

## Fedora/Centos/RHEL systemd
iptables-save > /etc/iptables/iptables
ip6tables-save > /etc/iptables/ip6tables

## Parabola/Gentoo OpenRC
# /etc/init.d/iptables save

################################  PRINT RULES   ###############################################################
#list the rules
#iptables -L -v
#ip6tables -L -v

#############################   PRINT ADDRESSES  ############################################################
echo "GATEWAY  :          MAC:$gateway_mac  IP:$gateway_ip  "
echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "INTERFACE_2: "$int_if2" MAC:"$int_mac2" IPv4:"$int_ip2" IPv6:"$int_ip2v6" "
# print the time the script finishes
date
#############################################################   END OF PROGRAM  ##############################################################################
