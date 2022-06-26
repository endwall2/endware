#!/bin/sh
####################################################################################
#                        HEADER AND INSTRUCTIONS
####################################################################################
# Program: endlists_nft.sh
# Type: Bourne shell script
# Creation Date: February 14, 2016
# Current Version: 1.28  June 25, 2022
# Stable Version:  1.25, August 30, 2017
# Author: The Endware Development Team
# Copyright: The Endware Development Team 2016
#
####################################################################################
# Description:  Traditional iptables list based blacklisting 
#
# Changes:  - Add --version --help + buf fix $insert variables   
#           - Loop over interfaces + abstract rule insertion point $insert, $insert6
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
# $ cp endlists_nft.sh ~/endwall/endlists_nft.sh
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
# $ nano endlists_nft.sh   # go to the section below labeled SAVE RULES (line 336)
#                      # comment out save rules for distributions you don't use line 336
# $ chmod u+rwx endlists_nft.sh         # change permisions to allow script execution 
# $ su                              # become root
# # ./endwall_nft.sh                    # execute script/install the basic firewall rules
# # ./endlists_nft.sh               # execute script / install blacklists
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
# $ chmod u+wrx endwall_nft.sh
# $ chmod u+wrx endlists_nft.sh
# $ su                     
# # ./endwall_nft.sh   # run the endwall firewall script 
# # ./endlists_nft.sh  # run the blacklist/whitelist script endlists.sh
################################################################################################################################################
#                Enable iptables and ip6tables if using systemd
###############################################################################################################################################
# systemctl enable  nftables
# systemctl start nftables
#
############################################################################################################################################################################
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

##########################################################  BEGINNING OF PROGRAM   ########################################################################################################

#################################################################################################################
#                           GLOBAL VARIABLES
################################################################################################
# version information
version="1.26"
branch="gnu/linux nft"
rev_date="23/06/2022"

##  get input list from shell argument 
for arg in $@
do 

if [ "$arg" = "--help" ]
 then
 echo "ENDLISTS: traditional iptables based text list blacklisting and whitlisting"
 echo " "
 echo "USAGE:  ./endlists.sh --option " 
 echo "./endlists --help    ## print usage information"
 echo "./endlists --version ## print version information"
 echo "./endlists    ## default mode downloads videos in list.txt"
 echo " "
 shift 
 exit 0
 elif [ "$arg" = "--version" ]
 then
 echo "ENDLISTS: version "$version", branch: "$branch", revision date: "$rev_date" "
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
nft="/sbin/nft"

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

# rule insertion is before the rule with the handle nubmber
# use the following command to see the handle numbers 
# nft -a -p list table inet filter

## remove  " position "$insert_out" ", from rules to default to 1st rule insertion

#### Insertion points for IPv4 rules
insert_in=10
insert_fwd=803
insert_out=14

#### Insertion points for IPv6 rules
insert6_in=10
insert6_fwd=803
insert6_out=14

### insertion points for iptables rules for matching
insertIPT_in=1
insertIPT_out=1
insertIPT_fwd=1

## NOTE:
### but puts it in the correct place
#  position "$insert_out" 
#  position "$insert_in"

#########################################################        FUNCTIONS        ##########################################################################################


############ IPv4 Log Drop for a specific interface, protocol, internal Lan IP, per blackout IPv4 IP. 
log_drop()
{
proto=$1
ports=$2
tag=$3

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter output position "$insert_out"  oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop

#nft insert rule inet filter forward position "$insert_fwd" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" drop
#nft insert rule inet filter forward position "$insert_fwd" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" drop
}

############ IPv4 Log Drop for a specific interface, protocol, internal Lan IP, per blackout IPv4 IP. Only input traffic is banned.
log_drop_in()
{
proto=$1
ports=$2
tag=$3

nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
}

############ IPv4 Log Drop for a specific interface, protocol, internal Lan IP, per blackout IPv4 IP. Only output traffic is banned.
log_drop_out()
{
proto=$1
ports=$2
tag=$3

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
}


############## IPv4 Whitelisting by IPv4 IP for a specific interface, prptocol, and specific ports
white()
{

proto=$1
ports=$2
tag=$3

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" accept
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" accept
nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" accept
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" accept

#nft insert rule inet filter forward position "$insert_fwd" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" accept
#nft insert rule inet filter forward position "$insert_fwd" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ip saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" accept
}


############ IPv6 Log Drop for a specific interface, protocol, internal Lan IP, per blackout IPv6 IP. 
log_drop6()
{

proto=$1
ports=$2
tag=$3

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip6 saddr "$int_ip" "$proto" sport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip6 daddr "$int_ip" "$proto" dport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip6 saddr "$int_ip"  "$proto" dport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip6 daddr "$int_ip" "$proto" sport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop

#nft insert rule inet filter forward position "$insert_fwd" oifname "$int_if" ip6 saddr "$int_ip" "$proto" sport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" drop
#nft insert rule inet filter forward position "$insert_fwd" iifname "$int_if" ip6 daddr "$int_ip" "$proto" dport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" drop

}


############## IPv6 Whitelisting by IPv6 IP for a specific interface, prptocol, and specific ports
white6()
{

proto=$1
ports=$2
tag=$3

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip6 saddr "$int_ip" "$proto" sport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" accept
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip6 daddr "$int_ip" "$proto" dport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" accept
nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip6 saddr "$int_ip"  "$proto" dport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" accept
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip6 daddr "$int_ip" "$proto" sport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" accept

#nft insert rule inet filter forward position "$insert_fwd" oifname "$int_if" ip6 saddr "$int_ip" "$proto" sport { "$ports" } ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" accept
#nft insert rule inet filter forward position "$insert_fwd" iifname "$int_if" ip6 daddr "$int_ip" "$proto" dport { "$ports" } ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD] \" accept

}


###=################# IPv4 Log Drop by IP for specific interface and internal lan ip 
log_drop_ip(){
proto=$1
tag=$2

nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter output position "$insert_out" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop

#nft insert rule inet filter forward position "$insert_fwd" oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" ip daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD OUT] \" drop
#nft insert rule inet filter forward position "$insert_fwd" iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" ip saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD IN] \" drop
}

############## IPv4 Log Drop by IP 
log_drop_any(){

tag=$1

nft insert rule inet filter output position "$insert_out" ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter output position "$insert_out" ip daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert_in" ip saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop

#nft insert rule inet filter forward position "$insert_fwd" ip daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD OUT] \" drop
#nft insert rule inet filter forward position "$insert_fwd" ip saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD IN] \" drop
}

###################### IPv6 LOG DROP by IP 
log_drop6_any(){

tag=$1

nft insert rule inet filter output position "$insert6_out" ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert6_in" ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop
nft insert rule inet filter output position "$insert6_out" ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" OUT] \" drop
nft insert rule inet filter input position "$insert6_in" ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" IN] \" drop

#nft insert rule inet filter forward "$insert6_fwd" ip6 daddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD OUT]\" drop
#nft insert rule inet filter forward "$insert6_fwd" ip6 saddr "$blackout" counter log level "info" prefix \"["$tag" FORWARD IN]\" drop
}


################## IPTABLES FUNCTIONS (STRING MATCHING) ##############################################

#################  String matching on packet headers for a single port (bad string gets dropped)
string_match_1p()
{
proto=$1
port=$2
tag=$3

iptables -I INPUT "$insertIPT_in" -p "$proto" --dport "$port"  -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert_out" -p "$proto" --dport "$port" -m string --string "$blackout" --algo bm -j DROP ;
iptables -I INPUT "$insertIPT_in" -p "$proto" --dport "$port"  -m string --string "$blackout" --algo bm -j LOG --log-prefix "$tag" --log-level=info && iptables -I OUTPUT "$insert_out" -p "$proto" --dport "$port" -m string --string "$blackout" --algo bm -j LOG --log-prefix "$tag" --log-level=info ;

#iptables -I FORWARD "$insertIPT_fwd" -p "$proto" --dport "$port"  -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insertIPT_fwd" -p "$proto" --dport "$port"  -m string --string "$blackout" --algo bm -j LOG --log-prefix "$tag" --log-level=info

}

################# String matching on packet headers for multiple ports ( bad string gets dropped) 
string_match_mp()
{
proto=$1
ports=$2
tag=$3

iptables -I INPUT "$insertIPT_in" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j DROP && iptables -I OUTPUT "$insert_out" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j DROP;
iptables -I INPUT "$insertIPT_in" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j LOG --log-prefix \"["$tag"] \" --log-level=info && iptables -I OUTPUT "$insert_out" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j LOG --log-prefix \"["$tag"] \" --log-level=info;

#iptables -I FORWARD "$insertIPT_fwd" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j DROP 
#iptables -I FORWARD "$insertIPT_fwd" -p "$proto" -m multiport --dports "$ports" -m string --string "$blackout" --algo bm -j LOG --log-prefix "$tag" --log-level=info;
}
#######################################################################################################


###############################################################################################################################################################

### loop over interfaces

## initialize index outside loop
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
int_ip="$int_ip2" 
int_mac="$int_mac2" 
int_ipv6="$int_ip2v6"
fi 

## check for empty ip-address pickup
if [ "$int_ip" != "" ]
then 

#################################################################################### 
# IP FILTER BLACK LISTS 
#################################################################################### 
### ports that your server serves to clearnet access
server_ports="21,20,70,80,443,53,25,587,953,993,995,5222,6697,22543,64738"


## block traffic to the multiple ports that you serve to,
## ban ip values in big_bans.txt (use CIDR ranges like 132.0.0.0/8 )
## Good for blocking regions you have no business with (ASIA, AFRICA, MIDDLE EAST etc) 
echo SERVER BLACKLIST LOADING 
for blackout in $(cat big_bans.txt); 
do 
log_drop tcp "$server_ports" "BIG-BANS" 
echo "$blackout" 
done 
echo SERVER BLACKLIST LOADED

#echo HTTP/HTTPS BLACKLIST LOADING 
#for blackout in $(cat http_blacklist.txt); 
#do 
#log_drop tcp 80,443 HTTP-BL 
#echo "$blackout" 
#done 
#echo HTTP BLACKLIST LOADED

#smtp_blacklist.txt
#echo SMTP BLACKLIST LOADING 
#for blackout in $(cat smtp_blacklist.txt) 
#do 
#log_drop tcp 25,587 SMTP-BL
#echo "$blackout"  
#done 
#echo SMTP BLACKLIST LOADED

#echo DNS BLACKLIST LOADING
#for blackout in $(cat dns_blacklist.txt)
#do 
#log_drop udp 53 DNS-BL
#log_drop tcp 53 DNS-BL
#echo "$blackout" 
#done 
#echo DNS BLACKLIST LOADED

################################### INT_IP BAN ###################################################################

## DROP TRAFFIC TO SERVER for a single interface and LAN IP from IPv4 ips in blacklist.txt
#echo ATTACKER BLACKLIST LOADING
#for blackout in $(cat attackers.txt);
#do 
#log_drop_ip all "ATACKER"
#echo "$blackout" 
#done
#echo ATTACKER BLACKLIST LOADED

################################### TOTAL IPv4 BAN #################################################################

## DROP ALL TRAFFIC TO SERVER from IPv4 ips in blacklist.txt
#echo LOADING BLACKLIST 
#for blackout in $(cat blacklist.txt);
#do 
#log_drop_any "BLACKLIST"
#echo "$blackout"  
#done
#echo BLACKLIST LOADED

################################### Total IPv6 BAN ###################################################################

## DROP ALL TRAFFIC TO SERVER from IPv6 ips in blacklist.txt
#echo LOADING IPv6 BLACKLIST 
#for blackout in $(cat ipv6_blacklist.txt);
#do 
#log_drop6_any "BLACKLIST"
#echo "$blackout"  
#done
#echo IPv6 BLACKLIST LOADED

###################################### STRING MATCHING (USES IPTABLES) ############################################################

### Filter packets on port 25 for ASCII strings that are flagged and block the packet
#echo EMAIL BLACKLIST LOADING
#for blackout in $(cat email_blacklist.txt);
#do 
#string_match_1p tcp 25 [EMAIL SPAM]
#echo $blackout 
#done 
#echo EMAIL BLACKLIST LOADED

### Filter packets on ports 80,443 for ASCII strings that are flagged and block the packet
#echo HTML BLACKLIST LOADING
#for blackout in $(cat html_blacklist.txt);
#do 
#string_match_mp tcp 80,443 [HTML SPAM]
#echo "$blackout"  
#done 
#echo HTML BLACKLIST LOADED

#########################################################

####################################################################################
#                    IP FILTER WHITE LISTS
####################################################################################


### narrow range whitelisting , make the IPv4 values in whitelist.txt single addresses 
# smtp_whitelist.txt
#echo SMTP WHITELIST LOADING
#for whiteout in $(cat smtp_whitelist.txt);
#do 
#white tcp 25,587 SMTP-WL
#echo "$whiteout"  
#done 
#echo SMTP WHITELIST LOADED

### narrow range whitelisting , make the IPv4 values in whitelist.txt single addresses 
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
echo SAVING RULES
#DEBIAN
nft list ruleset > /etc/nftables.conf


## save iptables rules (if you use the string matching section)
#####################################################################################################################
#ARCH/PARABOLA
#iptables-save  > /etc/iptables/iptables.rules
#ip6tables-save > /etc/iptables/ip6tables.rules

#DEBIAN/UBUNTU
#iptables-save  > /etc/iptables/rules.v4
#ip6tables-save > /etc/iptables/rules.v6

# RHEL/CENTOS/FEDORA
#iptables-save  > /etc/iptables/iptables
#ip6tables-save > /etc/iptables/ip6tables

############ RHEL/CENTOS/FEDORA
#iptables-save  > /etc/iptables/iptables
#ip6tables-save > /etc/iptables/ip6tables
#########  DEBIAN/UBUNTU
# iptables-save >  /etc/iptables/rules.v4
# ip6tables-save > /etc/iptables/rules.v6 
######### ARCH/PARABOLA/ARCHBANG/ANTERGOS/MANJARO
# iptables-save >  /etc/iptables/iptables.rules 
# ip6tables-save > /etc/iptables/ip6tables.rules 

# OpenRC (Parabola, Gentoo)
# /etc/init.d/iptables save

echo "ENDLISTS LOADED"
################################  PRINT RULES   ###############################################################
#nft list ruleset 

#############################   PRINT ADDRESSES  ############################################################
echo GATEWAY  :          MAC:$gateway_mac  IP:$gateway_ip  
echo INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" 
echo INTERFACE_2: "$int_if2" MAC:"$int_mac2" IPv4:"$int_ip2" IPv6:"$int_ip2v6"
# print the time the script finishes
date
##########################################################  END OF PROGRAM  ########################################################################################################
