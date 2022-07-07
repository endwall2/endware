#!/bin/sh
###############################################################################################################################################################
#                        HEADER AND INSTRUCTIONS
###############################################################################################################################################################
# Program: endwall_nft_wifi.sh
# Type: Bourne shell script
# Creation Date: Jan 1  2013
# Branch: nft_wifi
# Current Version: 1.45
# Revision Date: July 7 2022
# Previous Version: 1.45, June 23, 2022
# Author: THE ENDWARE DEVELOPMENT TEAM
# Copyright: THE ENDWARE DEVELOPMENT TEAM, 2016
#
# Changes:     - Translate endwall.sh from iptables to nftables 
#              - Update EULA, fix typo in if statement to loop over interfaces, add client_out_internal() function 
#              - fixed unfinished call to --open in code (bug fix)
#              - Added --version flag, updated acknowledgements
#              - Loop over interfaces check that ip is picked up
#
# Instructions: make directory,copy the file and change name to endwall.sh
#               make whitelists,blacklist text files, edit the endwall.sh file
#               change permisions to make endwall.sh executable, run the file.    
#
# Notes:    - uncomment the macchanger lines if you want random mac address.
#           - requires macchanger (optional)
#           - comment out lines starting at 1335 for alternate distributions you don't use
#
# $ mkdir ~/endwall
# $ cp endwall_v1xx.sh endwall.sh
# $ nano endwall.sh   # go to the section below labeled GLOBAL VARIABLES
#                       edit the variables client1_ip,client1_mac,client1_ip,client2_mac 
#                       so that they match your needs and save. ^X  
#                     # uncomment the macchanger lines to use machanger
#                     # comment out save rules on line 1335 for distributions not used
# $ chmod u+rwx endwall_nft.sh          # changer permisions to allow script execution
# $ su                              # become root
# # ./endwall_nft.sh                    # execute/run the file
#
#  If the firewall fails (bad interface pickup or bad ipv4 pickup) then run ./endwall_nft.sh --open to return to open policies
# $ ./endwall_nft.sh --open 
# Then manually set the interface ipv4 for ip1 and ip2 or play with the assignments of the internal variables (Switch 1 to 2 and retry etc)
# ######## THERE ARE 4 models slectable from the commandline
#  $ ./endwall_nft_raspi --open
#  $ ./endwall_nft_raspi --default
#  $ ./endwall_nft_raspi --test
#  $ ./endwall_nft_raspi --closed
#  $ ./endwall_nft_raspi   # this selects the closed model settings 
############################################################################################################################################################################
# Note that ip6tables is not enabled by default on some distributions
# for systemd enable and start nftables as follows:
# # systemctl enable nftables
# # systemctl start nftables
#
######################################################################### 
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
#  VERSION: 1.18
#  VERSION DATE: JUNE 28, 2018
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
#        in the air, in an airplane, dirigible, blimp, or balloon, in a car, bus, motor vehicle, armored transport vehicle, and at any distance from the surface of the planet Earth, including in orbit about the Earth or the Moon,
#        on a satellite orbiting about the Earth, the Moon, about any Solar System planet and its moons, on any space transport vehicle, and anywhere in the Solar System including the Moon, Mars, and all other Solar System planets not listed.  
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
#  WHO GRANTS THESE FREEDOMS ?
#  12) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team" by "Endwall", as well as ancillary contributors, and user modifiers and developers of the software. 
#  13) The aforementioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  14)  This software is distributed "AS IS" without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  15)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programmers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution, compensation, or payment for any such loss real or imagined.
#  16)  If a user makes a significant improvement to this software, and if this improvement is included in a release, the user agrees not to seek remuneration or payment 
#       from the creators of this software or from Endwall or from the Endware Development Team, for any such work contribution performed, and the user understands 
#       that there will be no such remuneration or payment rendered to them for any such contribution. 
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADDITIONAL NOTES:
#  17)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  18)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) i) are presented to clarify 1 a) and to enforce non-discrimination and non-exclusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################

################################################      BEGINNING OF PROGRAM        ##################################################################################
####################################################################################################
#                          INPUT ARGUMENTS
###################################################################################################
version="1.45"
branch="gnu/linux,nft,wifi"
rev_date="07/07/2022"
state="closed"

for arg in "$@"
do

 if [ "$arg" = "--help" ]
 then
 echo "USAGE: ./endwall --help ## displays usage statements"
 echo "USAGE: ./endwall --version  ## displays version statements"
 echo "USAGE: ./endwall --open ## opens firewall to default open policies"
 echo "USAGE: ./endwall  ## enable endwall firewall system"
 echo "USAGE: ./endwall --default ## default settings"
 echo "USAGE: ./endwall --closed  ## closed settings"
 echo "USAGE: ./endwall --test test settings"
 echo "USAGE: ./endwall  ## enable endwall firewall system with closed settings"
 
 shift
 exit 0
 elif  [ "$arg" = "--version" ]
 then
 echo "ENDWALL version:"$version", branch:"$branch", revision date:"$rev_date" "
 echo "Copyright: THE ENDWARE DEVELOPMENT TEAM, 2016"
 shift
 exit 0 
 elif  [ "$arg" = "--open" ]
 then
 state="open"
 shift
 elif  [ "$arg" = "--default" ]
 then
 state="default"
 shift
 elif  [ "$arg" = "--test" ]
 then
 state="test"
 shift 
 elif  [ "$arg" = "--closed" ]
 then
 state="closed"
 shift 
 else
 # default state is closed not default
 state="closed"  
 fi
done

############################  CLIENTS  ################################################
# change these values but dont leave them blank
# add more clients as you need them use $ arp or $ nmap -sS client_ip to determine values 

#client1_mac=00:00:00:00:00:00  # change to be the mac address of client 1
#client2_mac=00:00:00:00:00:00  # change to be the mac address of client 2

#client1_ip=192.168.0.161   # change to be the static ip of your first internal client
#client2_ip=192.168.0.162   # change to be the static ip of your second internal client

###########################  SERVERS ###################################################
#host1_mac=00:00:00:00:00:00  # change to be the mac address of internal server host1
#host1_ip=192.168.0.16   # change to be the static ip of your internal server host1

#host2_mac=00:00:00:00:00:00  # change to be the mac address of internal server host1
#host2_ip=192.168.0.17   # change to be the static ip of your internal server host1

#########################################################################################


####################################################################################################
#                           GLOBAL VARIABLES
####################################################################################################
### variable for the nft command location
nft="/sbin/nft"

# Grab interface name from ip link and parse 
int_if1="$(ip link | grep -a "state " | awk -F: '{ if (FNR==2) print $2}')"
int_if2="$(ip link | grep -a "state " | awk -F: '{ if (FNR==3) print $2}')"

# Grab Gateway Information
gateway_ip1="$(ip route | awk '/via/ {print $3}' | head -n 1 )"
gateway_ip2="$(ip route | awk '/via/ {print $3}' | tail -n 1 )"

#gateway_mac=$( arp | awk '/gateway/ {print $3}')
gateway_mac1="$( nmap -sS "$gateway_ip1" -p 53| grep -a "MAC Address:" | awk '{print $3}')"
gateway_mac2="$( nmap -sS "$gateway_ip2" -p 53| grep -a "MAC Address:" | awk '{print $3}')"

# RUN MAC CHANGER on INTERFACES
#macchanger -A $int_if
#macchanger -A "$int_if2"

# grab host mac addresses from ip link  
host_mac1="$(ip link | grep -a "ether" | awk ' {if (FNR==1) print $2}')"
host_mac2="$(ip link | grep -a "ether" | awk ' {if (FNR==2) print $2}')"

# grab the ip addresses from the interfaces
host_ip1="$(ip addr | grep -a "scope global"| grep $int_if1 | awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')"
host_ip2="$(ip addr | grep -a "scope global"| grep $int_if2 | awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')"
# grab the ipv6 addresses frrom the interfaces
host_ip1v6="$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')"
host_ip2v6="$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==3) print $1}'| awk '{print $2}')"

########################### INTERNAL VARIABLES ################################## 
int_mac1="$host_mac1"         # internal mac address of interface 1
int_mac2="$host_mac2"       # internal mac address of interface 2 
int_ip1="$host_ip1"          # internal ip address of interface 1  
int_ip2="$host_ip2"         # internal ip address of interface 2
int_ip1v6="$host_ip1v6"     # internal ipv6 address of interface 1
int_ip2v6="$host_ip2v6"     # internal ipv6 address of interface 2


#############################     PRINT ADDRESSES    ########################################################################
#echo "GATEWAY_1    :           MAC:"$gateway_mac1"  IPv4:"$gateway_ip1" " 
#echo "GATEWAY_2    :           MAC:"$gateway_mac2"  IPv4:"$gateway_ip2" " 
#echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
#echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "

###################################################################################################################################
#                             LINUX SECURITY BOOLEANS
###################################################################################################################################
echo "LOADING SYSCTL SECURITY BOOLEANS"

###############         KERNEL       #############################################################################################

sysctl -w -q kernel.sysrq=0
sysctl -w -q kernel.core_uses_pid=1
sysctl -w -q kernel.randomize_va_space=1

#sysctl -w -q kernel.pid_max=65536
#sysctl -w -q kernel.exec-shield=1
###############          IPv4        #############################################################################################
sysctl -w -q net.ipv4.tcp_syncookies=1          # enable tcp syn cookies (prevent against the common 'syn flood attack')
sysctl -w -q net.ipv4.ip_forward=0                                  # disable Packet forwarding between interfaces

# Disable Source Routed Packets,Redirect Acceptance, Redirect Sends, Log all Martian IP addresses 

for f in $(ls /proc/sys/net/ipv4/conf/); do
sysctl -w -q net.ipv4.conf.$f.rp_filter=1                  # do source validation by reversed path (Recommended option for single homed hosts)
sysctl -w -q net.ipv4.conf.$f.accept_source_route=0        # Disable source routed packets redirects
sysctl -w -q net.ipv4.conf.$f.accept_redirects=0           # don't accept redirects
sysctl -w -q net.ipv4.conf.$f.send_redirects=0             # don't send redirects
sysctl -w -q net.ipv4.conf.$f.log_martians=1               # log packets with impossible addresses to kernel log
done

sysctl -w -q net.ipv4.icmp_echo_ignore_broadcasts=1                 # ignore all ICMP ECHO and TIMESTAMP requests sent to it via broadcast/multicast
sysctl -w -q net.ipv4.icmp_ignore_bogus_error_responses=1           # disable logging of bogus responses to broadcast frames

##################      IPv6      ##############################################################################################
for f in $(ls /proc/sys/net/ipv6/conf/); do
sysctl -w -q net.ipv6.conf.$f.accept_source_route=0
sysctl -w -q net.ipv6.conf.$f.accept_redirects=0
sysctl -w -q net.ipv6.conf.$f.router_solicitations=0
sysctl -w -q net.ipv6.conf.$f.accept_ra_rtr_pref=0
sysctl -w -q net.ipv6.conf.$f.accept_ra_pinfo=0 
sysctl -w -q net.ipv6.conf.$f.accept_ra_defrtr=0
sysctl -w -q net.ipv6.conf.$f.autoconf=0
sysctl -w -q net.ipv6.conf.$f.dad_transmits=0
sysctl -w -q net.ipv6.conf.$f.max_addresses=1
done
##################### OTHER ##################################################################################################
#setsebool httpd_can_network_connect on   #needed for squirelmail if you are on selinux
#setsebool httpd_can_sendmail on          #needed for squirelmail send if you are on selinux
sysctl -p  # load settings 

echo "SYSCTL SECURITY BOOLEANS LOADED"	
###########################################################################################################################
######################            FLUSH OLD RULES     #####################################################################
## Flush old rules
nft flush ruleset;

##########################################################################################################################

# load the previously saved rules
# DEBIAN
#nft -f /etc/nftables.conf

######################################       FUNCTIONS       ####################################################################

#  RULES
#           {add | insert} rule [family] table chain [handle handle | index index] statement ... [comment comment]
#           replace rule [family] table chain handle handle statement ... [comment comment]
#           delete rule [family] table chain handle handle
# nft add rule filter input ip saddr { 10.0.0.0/8, 192.168.0.0/16 } tcp dport { 22, 443 } accept


########## LOCAL HOST FUNCTIONS
lo_open()
{
proto=$1
ports=$2
#   add rule fam  table  chain statement 
nft add rule inet filter input iifname lo ip protocol "$proto" "$proto" dport { "$ports" } accept
nft add rule inet filter input iifname lo ip protocol "$proto" "$proto" sport { "$ports" } accept
nft add rule inet filter output oifname lo ip protocol "$proto" "$proto" dport { "$ports" } accept
nft add rule inet filter output oifname lo ip protocol "$proto" "$proto" sport { "$ports" } accept
}

## 
lo6_open()
{
proto=$1
ports=$2

nft add rule inet filter input iifname lo ip6 daddr "::1/128" "$proto" dport { "$ports" } accept
nft add rule inet filter input iifname lo ip6 daddr "::1/128" "$proto" sport { "$ports" } accept
nft add rule inet filter output oifname lo ip6 saddr "::1/128" "$proto" dport { "$ports" } accept
nft add rule inet filter output oifname lo ip6 saddr "::1/128" "$proto" sport { "$ports" } accept

}

### ICMP on localhost
lo_icmp()
{
### ICMP Outbound
nft add rule inet filter output oifname lo ip protocol icmp icmp type { echo-reply, echo-request, destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem } counter accept 
### ICMP Inbound
nft add rule inet filter input iifname lo ip protocol icmp icmp type { echo-reply, echo-request, destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem }  counter accept 

}

############ CLIENT OUTBOUND CONNECTIONS ###################


### only allow new and established connections, to or from specified ports  
client_out()
{
proto=$1
ports=$2

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ct state { established } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ct state { established } counter accept
}

###  allow related connections more permisive  
client_out_rel()
{
proto=$1
ports=$2
#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ct state { established, related } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ct state { established, related } counter accept

}
### only allow new and established connections, to or from specified ports  
client6_out()
{
proto=$1
ports=$2

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6" "$proto" sport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6" "$proto" dport { "$ports" } ct state { established } counter accept 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6"  "$proto" dport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6" "$proto" sport { "$ports" } ct state { established } counter accept

}

###  allow related connections more permisive  
client6_out_rel()
{
proto=$1
ports=$2
#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" protocol "$proto" ip6 saddr "$int_ipv6" "$proto" sport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  protocol "$proto" ip6 daddr "$int_ipv6" "$proto" dport { "$ports" } ct state { established, related } counter accept 
nft add rule inet filter output oifname "$int_if" protocol "$proto" ip6 saddr "$int_ipv6"  "$proto" dport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  protocol "$proto" ip6 daddr "$int_ipv6" "$proto" sport { "$ports" } ct state { established, related } counter accept

}



#########  Use this to lock to a specific internal server (DNS,SMTP,IMAP) by client_ip and client_mac of the host machine
client_out_internal()
{

proto=$1
ports=$2
client_ip=$3
client_mac=$4

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$client_ip" counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ether saddr "$client_mac" ip saddr "$client_ip" ct state { established, related } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ip daddr "$client_ip"  counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ether saddr "$client_mac" ip saddr "$client_ip"  ct state { established, related } counter accept
}


client_out_wifi()
{
proto=$1
ports=$2
int_if="wlan0"

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" "$proto" sport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto"  "$proto" dport { "$ports" } ct state { established } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto"  "$proto" dport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto"  "$proto" sport { "$ports" } ct state { established } counter accept

}


client6_out_wifi()
{
proto=$1
ports=$2
int_if="wlan0"

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6" "$proto" sport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6" "$proto" dport { "$ports" } ct state { established } counter accept 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6" "$proto" dport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6" "$proto" sport { "$ports" } ct state { established } counter accept

}


client_out_rel_wifi()
{
proto=$1
ports=$2
int_if="wlan0"

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" "$proto" sport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto"  "$proto" dport { "$ports" } ct state { established, related } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto"  "$proto" dport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto"  "$proto" sport { "$ports" } ct state { established, related } counter accept

}

client6_out_rel_wifi()
{
proto=$1
ports=$2
int_if="wlan0"

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6" "$proto" sport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6"  "$proto" dport { "$ports" } ct state { established, related } counter accept 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6" "$proto" dport { "$ports" } ct state { new, established, related } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if"  ip6 daddr "$int_ipv6" "$proto" sport { "$ports" } ct state { established, related } counter accept

}


### only allow new and established connections, to or from specified ports to a specific ip and mac address  
client_out_internal()
{
proto=$1
ports=$2
client_ip=$3
client_mac=$4

#   add rule fam  table  chain statement 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" ip daddr "$client_ip" "$proto" sport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" ip saddr "$client_ip"  "$proto" dport { "$ports" } ether saddr "$client_mac"  ct state { established } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  ip daddr "$client_ip" "$proto" dport { "$ports" } ct state { new, established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" ip saddr "$client_ip" "$proto" sport { "$ports" } ether saddr "$client_mac"  ct state { established } counter accept
}



############################ ICMP ###################################
icmp_out()
{
interface=$1

### ICMP Outbound
nft add rule inet filter output oifname "$interface" ip protocol icmp icmp type { echo-reply, echo-request, destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem } counter accept 
### ICMP Inbound
nft add rule inet filter input iifname "$interface" ip protocol icmp icmp type { echo-reply, echo-request, destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem } ct state {established, related } counter accept 

}


#########  SERVER INBOUND CONNECTIONS ############################

## basic inbound rules
server_in()
{
proto=$1
ports=$2

nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } counter log accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ct state { established, related } counter log accept 

}


### extended / more permisive inbound rules
server_in_x()
{
proto=$1
ports=$2

nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } counter log accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ct state { established, related } counter log accept 
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } counter log accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" dport { "$ports" } ct state { established, related } counter log accept 


}

#### extended / permisive but locked to a specifice machine by client_ip and client_mac on your internal network 
#### only allow access to services based on specific ip/mac address combinations 
server_in_internal()
{

proto=$1
ports=$2
client_ip=$3
client_mac=$4

#   add rule fam  table  chain statement 
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ether saddr "$client_mac" ip saddr "$client_ip" ct state { new, established } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" sport { "$ports" } ip daddr "$client_ip" ct state { established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$ports" } ether saddr "$client_mac" ip saddr "$client_ip"  ct state { new, established } counter accept
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" dport { "$ports" } ip daddr "$client_ip"  ct state { established } counter accept # jump PASS
}


## basic inbound rules
server_in_wifi()
{
proto=$1
ports=$2

nft add rule inet filter input iifname "$int_if" ip protocol "$proto"  "$proto" dport { "$ports" } counter log accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" "$proto" sport { "$ports" } ct state { established, related } counter log accept 

}


## basic inbound rules
server6_in_wifi()
{
proto=$1
ports=$2

nft add rule inet filter input iifname "$int_if" ip6 daddr "$int_ipv6"  "$proto" dport { "$ports" } counter log accept 
nft add rule inet filter output oifname "$int_if" ip6 saddr "$int_ipv6"  "$proto" sport { "$ports" } ct state { established, related } counter log accept 

}


server_internal_2p()
{
proto=$1
port1=$2
port2=$3
client_ip=$4
client_mac=$5

#   add rule fam  table  chain statement 
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" sport { "$port1" } dport { "$port2" } ether saddr "$client_mac" ip saddr "$client_ip" ct state { new, established } counter accept 
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip" "$proto" dport { "$port1"} sport { "$port2" } ip daddr "$client_ip" ct state { established } counter accept # jump PASS
nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$sport1" } sport { "$port2" } ether saddr "$client_mac" ip saddr "$client_ip"  ct state { new, established } counter accept
nft add rule inet filter output oifname "$int_if" ip protocol "$proto" ip saddr "$int_ip"  "$proto" sport{ "$port1" } dport { "$port2" } ip daddr "$client_ip"  ct state { established } counter accept # jump PASS

}

server_internal_1way()
{
proto="udp"
ports=$1
client_ip=$2
client_mac=$3

nft add rule inet filter input iifname "$int_if" ip protocol "$proto" ip daddr "$int_ip" "$proto" dport { "$ports" } ether saddr "$client_mac" ip saddr "$client_ip" ct state { new, established } counter accept 

}


############################# NOT FIXED / TRANSLATE THESE LATER ###########################################33 

########### CLIENT OUTBOUND

### limit the burst rate / number of requests per second to stop DDOS 
client_out_lim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4

#iptables -A OUTPUT -o $int_if -s "$int_ip" -p "$proto" -m multiport --dports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
#iptables -A INPUT  -i $int_if -d "$int_ip" -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
#iptables -A OUTPUT -o $int_if -s "$int_ip" -p "$proto" -m multiport --sports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
#iptables -A INPUT  -i $int_if -d "$int_ip" -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS

}

############## SERVER INBOUND

server_in_lim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4


}

##################################### END OF FUNCTIONS #####################################################################################


######## THERE ARE 4 models slectable from the commandline
#  $ ./endwall_nft_raspi --open
#  $ ./endwall_nft_raspi --default
#  $ ./endwall_nft_raspi --test
#  $ ./endwall_nft_raspi --closed
#  $ ./endwall_nft_raspi   # this selects the closed model settings 

# The model settings follow below


####################################### OPEN WALL ########################################################################
# Disable firewall if --open flag 
if [ "$state" = "open" ]
then

################################  DISABLE THE FIREWALL #################################################################

# Policies

############################     DEFUALT POLICY       ####################################################################
# make a new table called filter
nft add table inet filter     #inet does both ip and ip6 
#nft add table ip filter      # ip filter table
#nft add table ip6 filter     # ip6 filter table

# Make some default chains 
nft add chain inet filter input '{ type filter hook input priority 0 ; policy drop ; }'
nft add chain inet filter forward '{ type filter hook forward priority 0 ; policy drop ; }' 
nft add chain inet filter output '{ type filter hook output priority 0 ; policy drop ; }'

nft add rule inet filter input accept
nft add rule inet filter forward accept
nft add rule inet filter output accept

##############################      SAVE RULES         ##############################################################
echo SAVING RULES
#DEBIAN
nft list ruleset > /etc/nftables.conf

echo "ENDWALL NFT DISABLED"
##############################     PRINT RULES       ################################################################
#list the rules
nft list ruleset;
#
#
#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY_1    :           MAC:"$gateway_mac1"  IPv4:"$gateway_ip1" " 
echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "GATEWAY_2    :           MAC:"$gateway_mac2"  IPv4:"$gateway_ip2" " 
echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "
# print the time the script finishes
date
exit 0
fi 



if [ "$state" = "default" ]
then

### This is a compact set of rules for testing 
### This should actually be a better default ruleset rather than all open 
### acces with --test option

############################     DEFUALT POLICY       ####################################################################
# make a new table called filter
nft add table inet filter     #inet does both ip and ip6 
#nft add table ip filter      # ip filter table
#nft add table ip6 filter     # ip6 filter table

# Make some default chains 
nft add chain inet filter input '{ type filter hook input priority 0 ; policy drop ; }'
nft add chain inet filter forward '{ type filter hook forward priority 0 ; policy drop ; }' 
nft add chain inet filter output '{ type filter hook output priority 0 ; policy drop ; }'


### Accept all loopback 
nft add rule inet filter input iifname lo accept 

### Accept all output
nft add rule inet filter output accept


################# wlan0 #########################################################################
## Accept all input from icmp
nft add rule inet filter input iifname wlan0 ip protocol icmp accept

### Accept all input from gateway (will make redundant rules if a gatweay is missing)
nft add rule inet filter input iifname wlan0 ip protocol tcp ip saddr "$gateway_ip1" accept
nft add rule inet filter input iifname wlan0 ip protocol udp ip saddr "$gateway_ip1" accept
nft add rule inet filter input iifname wlan0 ip protocol tcp ip saddr "$gateway_ip2" accept
nft add rule inet filter input iifname wlan0 ip protocol udp ip saddr "$gateway_ip2" accept

## Accept all input from DNS,BOOTP,HTTP,HTTPS
nft add rule inet filter input iifname wlan0 ip protocol tcp tcp sport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname wlan0 ip protocol udp udp sport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname wlan0 ip protocol tcp tcp dport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname wlan0 ip protocol udp udp dport { 53,67,68,80,443 } accept
################ eth0 ###########################################################################
## Accept all input from icmp
nft add rule inet filter input iifname eth0 ip protocol icmp accept

### Accept all input from gateway (will make redundant rules if a gateway is missing)
nft add rule inet filter input iifname eth0 ip protocol tcp ip saddr "$gateway_ip1" accept
nft add rule inet filter input iifname eth0 ip protocol udp ip saddr "$gateway_ip1" accept
nft add rule inet filter input iifname eth0 ip protocol tcp ip saddr "$gateway_ip2" accept
nft add rule inet filter input iifname eth0 ip protocol udp ip saddr "$gateway_ip2" accept

## Accept all input from DNS,BOOTP,HTTP,HTTPS
nft add rule inet filter input iifname eth0 ip protocol tcp tcp sport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname eth0 ip protocol udp udp sport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname eth0 ip protocol tcp tcp dport { 53,67,68,80,443 } accept
nft add rule inet filter input iifname eth0 ip protocol udp udp dport { 53,67,68,80,443 } accept
##################################################################################################


######################## FINAL DROP ################################################################
nft add rule inet filter input drop
nft add rule inet filter forward drop
nft add rule inet filter output drop

##############################      SAVE RULES         ##############################################################
echo SAVING RULES
#DEBIAN
nft list ruleset > /etc/nftables.conf

echo "ENDWALL NFT DISABLED"
##############################     PRINT RULES       ################################################################
#list the rules
nft list ruleset;
#
#
#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY_1    :           MAC:"$gateway_mac1"  IPv4:"$gateway_ip1" " 
echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "GATEWAY_2    :           MAC:"$gateway_mac2"  IPv4:"$gateway_ip2" " 
echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "
# print the time the script finishes
date
exit 0
fi 




if [ "$state" = "test" ]
then

### This is a compact set of rules for testing 
### This should actually be a better default ruleset rather than all open 
### acces with --test option

############################     DEFUALT POLICY       ####################################################################
# make a new table called filter
nft add table inet filter     #inet does both ip and ip6 
#nft add table ip filter      # ip filter table
#nft add table ip6 filter     # ip6 filter table

# Make some default chains 
nft add chain inet filter input '{ type filter hook input priority 0 ; policy drop ; }'
nft add chain inet filter forward '{ type filter hook forward priority 0 ; policy drop ; }' 
nft add chain inet filter output '{ type filter hook output priority 0 ; policy drop ; }'

############################## TEST RULES #############################################################################
# Drop invalid
nft add rule inet filter input ct state invalid drop;
nft add rule inet filter output ct state invalid drop;

### Accept all loopback 
#nft add rule inet filter input iifname lo accept 

lo_open udp 53,67,68,80,443
lo_open tcp 53,67,68,80,443
lo_icmp 

nft add rule inet filter input iifname lo counter log drop
nft add rule inet filter output oifname lo counter log drop

### Accept all output
#nft add rule inet filter output accept

client_out_wifi tcp 53,67,68,80,443
client_out_wifi udp 53,67,68,80,443

### ICMP 

icmp_out "wlan0"
icmp_out "eth0"

## Accept all input from icmp
#nft add rule inet filter input iifname wlan0 ip protocol icmp accept
#nft add rule inet filter input iifname eth0 ip protocol icmp accep

#######################################################################################


######################## FINAL DROP ###################################################
nft add rule inet filter input drop
nft add rule inet filter forward drop
nft add rule inet filter output drop

##############################      SAVE RULES         ##############################################################
echo SAVING RULES
#DEBIAN
nft list ruleset > /etc/nftables.conf

echo "ENDWALL NFT DISABLED"
##############################     PRINT RULES       ################################################################
#list the rules
nft list ruleset;
#
#
#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY_1    :           MAC:"$gateway_mac1"  IPv4:"$gateway_ip1" " 
echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "GATEWAY_2    :           MAC:"$gateway_mac2"  IPv4:"$gateway_ip2" " 
echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "
# print the time the script finishes
date
exit 0
fi 


if [ "$state" = "closed" ]
then 
###OTHERWISE continue with the firewall implementation 
##############################################################################################################################3

############################     DEFUALT POLICY       ####################################################################
# make a new table called filter
nft add table inet filter     #inet does both ip and ip6 
#nft add table ip filter      # ip filter table
#nft add table ip6 filter     # ip6 filter table

# Make some default chains 
nft add chain inet filter input '{ type filter hook input priority 0 ; policy drop ; }'
nft add chain inet filter forward '{ type filter hook forward priority 0 ; policy drop ; }' 
nft add chain inet filter output '{ type filter hook output priority 0 ; policy drop ; }'

############################   DEFINE CUSTOM CHAINS    #####################################################################

#######################################################################################################################
#                   BASIC FIRST LINE SECURITY
#######################################################################################################################
echo "LOADING FIRST LINE SECURITY"
###########################################################################################

#######################################################################################################################
#                     DROP RESTRICTED SPECIAL USE IPv4 NETWORKS / IP SPOOFING
#######################################################################################################################
############################# DROP LINK-LOCAL ADDRESSES ###############################################################
# Drop invalid
nft add rule inet filter input ct state invalid drop;
nft add rule inet filter output ct state invalid drop;
#
nft add rule inet filter input ip saddr 169.254.0.0/16 drop
nft add rule inet filter input ip daddr 169.254.0.0/16 drop

############################### DROP OUTBOUND BROADCAST ###############################################################
# drop broadcast outbound
nft add rule inet filter output ip daddr 255.255.255.255 drop

#####################  DROP PRIVATE LAN INPUT OF WRONG CLASS/TYPE      ################################################ 

# nft add rule filter input ip saddr 10.0.0.0/8  drop;
# nft add rule filter input ip saddr 172.16.0.0/12  drop;
# nft add rule filter input ip saddr 192.168.0.0/16 drop;

# uncomment private lan network classss that are not not applicable to your network to drop them
# use an if statement to check gateway ip against 10,172,192 (not implemented currently)

echo "FIRST LINE SECURITY LOADED"

#####################################################################################################################################################

#####################################################################################################################################################
#                               LOCAL HOST RULES  
#############################################################################################
echo "LOADING LOCALHOST RULES"
#####################################   BOOTP    ############################################
lo_open udp 67,68
#####################################   DHCPv6    ###########################################
lo6_open tcp 546,547
lo6_open udp 546,547
##################################  DNS   ###################################################
lo_open udp 53,953
lo_open tcp 53,953
lo6_open udp 53,953
lo6_open tcp 53,953
########################### TELNET SSH  #####################################################
lo_open tcp 22,23
########################### SMTP ############################################################
lo_open tcp 25,587,465
############################ FTP ############################################################
lo_open tcp 20,21,989,990,2121
lo_open udp 20,21,989,990,2121

# 55536-55663
lo_open tcp 55536-55663
lo_open udp 55536-55663
lo_open tcp 60000-60100
lo_open udp 60000-60100

########################### HTTP,HTTPS ######################################################
lo_open tcp 80,443
lo6_open tcp 80,443
########################### GOPHER ##########################################################
lo_open tcp 70
lo_open udp 70
############################ IMAP,IMAPS #####################################################
lo_open tcp 143,993
################################ POP3,POP3S  ################################################
lo_open tcp 110,995
############################# SPAM ASSASSIN #################################################
# lo_open tcp 783
####################################     IRC         ########################################
lo_open tcp 6667,6668,6669,6697,9999
#################################### XMPP MSN ICQ AOL #######################################
lo_open tcp 1863,5190,5222,5269,5280,5281,5298,5582,8010
lo_open udp 5298,5222
############################### NNTP ########################################################
lo_open tcp 119,563
lo_open udp 119,563
###################################  HKP PGP ################################################
lo_open tcp 11371
####################################  TOR ###################################################
lo_open tcp 9030,9040,9050,9051,9053,9150,9151,9001
lo_open udp 9053
###################################  LDAP  ##################################################
lo_open tcp 389
lo_open udp 389
###################################### BIT TORRENT ##########################################
lo_open tcp 6880,6881,6882,6883,6884,6885,6969,6886,6887,6888,6889,6890
lo_open udp 6880,6881,6882,6883,6884,6885,6969,6886,6887,6888,6889,6890
lo_open tcp 6891,6892,6893,6894,6895,6896,6897,6898,6899,6900,6901
lo_open udp 6891,6892,6893,6894,6895,6896,6897,6898,6899,6900,6901
################################### BIT TORRENT TRACKERS ####################################
lo_open tcp 2710,7000,58846
lo_open udp 3000,4444,6969,1337,2710,80,30301
#################################### SQUID HTTP ALTERNATE ###################################
lo_open tcp 3128,8000,8080,8082,8445,8123,8443
#################################### SOCKS 4/5  #############################################
lo_open tcp 1080,1085
################################## NETBIOS  #################################################
#lo_open tcp 135,137,138,139
#lo_open udp 135,137,138,139
################################### SMB SAMBA ###############################################
#lo_open tcp 445
##############################  PULSE AUDIO SERVER  #########################################
#lo_open tcp 4713
###############################  CUPS #######################################################
lo_open tcp 631
lo_open udp 631
################################### GIT HUB #################################################
lo_open tcp 9418
############################## SYSLOG #######################################################
lo_open tcp 514
lo_open udp 514
############################## RELP LOG #####################################################
#lo_open tcp 2514
#lo_open udp 2514
############################### NTP #########################################################
lo_open tcp 123
lo_open udp 123
################################ RCP   ######################################################
#lo_open tcp 111
#lo_open udp 111
################################ RSYNC   ####################################################
lo_open tcp 873
lo_open udp 873
################################  NFS  ######################################################
#lo_open tcp 2049
#lo_open udp 2049
################################  FREENET  ##################################################
#lo_open tcp 8888
#lo_open udp 12701,29732
################################  GNU NET  ##################################################
#lo_open tcp 2086,2087,2088,2089,2090,2091,2092,2093,2094,2095,2096,2097,4433,5724,7777
#lo_open udp 2086,2087,2088,2089,2090,2091,2092,2093,2094,2095,2096,2097,4433,5724,7777
#lo_open tcp 2053
#lo_open udp 2053
################################  I2P  ######################################################
#lo_open tcp 2827,4444,4445,7652,7653,7654,7656,7657,7658,7659,7660,19648
#lo_open udp 7655,19648
################################ OPEN VPN  ##################################################
lo_open tcp 1194,943
lo_open udp 1194,943
############################### IPsec #######################################################
lo_open udp 500,4500
################################  SIP  ######################################################
#lo_open tcp 5060,5061
#lo_open udp 5060
################################  BITMESSAGE ################################################
#lo_open tcp 8444
############################# RTMP ############################################
lo_open udp 1935
lo_open tcp 1935
lo_open tcp  2222
lo_open udp  2222

################################  BITCOIN ###################################################
lo_open tcp 8332,8333
################################  LITECOIN ##################################################
#lo_open tcp 9332,9333
################################  GOOGLE TALK ###############################################
#lo_open tcp 19294
#lo_open udp 19295,19302
################################  SKYPE #####################################################
#lo_open tcp 23399
#lo_open udp 23399
################################  MYSQL #####################################################
#lo_open tcp 25565
#lo_open udp 25565
################################ INTERNAL SSH ##############################################
lo_open tcp 22543

############################### MUMBLE #####################################################
lo_open tcp 64738
lo_open udp 64738
######################## ICMP ###############################################################
lo_icmp 

############################ LOCAL HOST DROP ############################################## 
# NO FURTHER INPUT/OUTPUT FROM LOCALHOST / SOURCE HOSTS

nft add rule inet filter input ip saddr 127.0.0.0/8 log drop
nft add rule inet filter input ip daddr 127.0.0.0/8 log drop
nft add rule inet filter output ip saddr 127.0.0.0/8 log drop
nft add rule inet filter output ip daddr 127.0.0.0/8 log drop

nft add rule inet filter input ip saddr 0.0.0.0/8 log drop
nft add rule inet filter input ip daddr 0.0.0.0/8 log drop
nft add rule inet filter output ip saddr 0.0.0.0/8 log drop
nft add rule inet filter output ip daddr 0.0.0.0/8 log drop


nft add rule inet filter input iifname lo counter log drop
nft add rule inet filter output oifname lo counter log drop
nft add rule inet filter forward iifname lo counter log drop
nft add rule inet filter forward oifname lo counter log drop


####################################################################################################
echo "LOCALHOST RULES LOADED"
####################################################################################################
####################################################################################################
#                         Router and Internal Network Rules
####################################################################################################
#
#                    REMOVED /ADD YOUR OWN according to your needs  sshd etc
#
####################################################################################################


echo "LOADING WIFI PUBLIC OUTPUT CLIENTS"

######### SET THE VARIABLES FOR wlan0 
int_if="wlan0"
int_mac="$int_mac2"
int_ip="$int_ip2"
int_ipv6="$int_ip2v6"
gateway_ip="$gateway_ip1"
gateway_mac="$gateway_mac1"

#######################################            BOOTP  Client       #######################################################################################
### Change to an internal locked to the gateway ip 
client_out_wifi udp 67,68

#############################################    DNS   Client           ##############################################################################
client_out_wifi udp 53,953
client_out_wifi tcp 53,953

#############################################   HTTP HTTPS Client       ##############################################################################
client_out_rel_wifi tcp 80,443

##########################################    HKP OPEN PGP CLIENT       ##############################################################################
client_out_wifi tcp 11371
##########################################      RSYNC CLIENT            ##############################################################################
client_out_wifi tcp 873
##########################################    GOPHER CLIENT             ##############################################################################
client_out_wifi tcp 70
client_out_wifi udp 70
##########################################       HTTP/HTTPS PROXY       ##############################################################################
client_out_wifi tcp 8000,8080,8081,8443,8445,8090,9090,3128,8123
##########################################   SQUID HTTPS PROXY          ##############################################################################
client_out_wifi tcp 3128
##########################################        SOCK4,SOCK5 Client    ##############################################################################
client_out_wifi tcp 1080,1085
##########################################         IRC Client           ##############################################################################
client_out_wifi tcp 6667,6668,6669,6697,9999
##########################################        XMPP Client           ##############################################################################
client_out_wifi tcp 5190,5222,5223,5269,5280,5281,5298,8010
client_out_wifi udp 5298,5222
##########################################       MSN Client             ##############################################################################
#client_out_wifi tcp 1863
##########################################         FTP Client           ##############################################################################
client_out_wifi tcp 20,21,989,990,2121
client_out_wifi udp 20,21,989,990,2121

# 55536-55663
client_out_wifi tcp 55536-55663
client_out_wifi udp 55536-55663
client_out_wifi tcp 60000-60100
client_out_wifi udp 60000-60100

##########################################         NNTP Client          ##############################################################################
client_out_wifi tcp 119,563
client_out_wifi udp 119,563
##########################################        TELNET  Client        ##############################################################################
client_out_wifi tcp 23
###########################################        SSH  Client          ##############################################################################
client_out_wifi tcp 22
#############################################       SMTP  Client        ##############################################################################
client_out_wifi tcp 25,465,587,2525
#client6_out_wifi tcp 25,465,587,2525
##########################################         POP3  Client         ##############################################################################
client_out_wifi tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out_wifi tcp 114,993
#############################################       SMTP  Client        ##############################################################################
client_out_wifi tcp 25,465,587,2525 5 10
#client6_out_wifi tcp 25,465,587,2525 5 10
##########################################         POP3  Client         ##############################################################################
client_out_wifi tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out_wifi tcp 114,993
##########################################         NTP   Client         ##############################################################################
client_out_wifi udp 123
client_out_wifi tcp 123

#######################################            BOOTP  Client       #######################################################################################
### Change to an internal locked to the gateway ip 
client_out_wifi udp 67,68

###########################################        ICMP         ############################################################################### 
icmp_out "$int_if"

##########################################    SPECIALIZED OUTPUT   ##################################################################################
##########################################        GIT Client        #################################################################################
client_out_wifi tcp 9418
##########################################       TOR  Client        ###############################################################
client_out_wifi tcp 9001
##########################################      BitTorrent  Client     ############################################################
client_out_wifi tcp 2710,6881,6882,6883,6884,6885,6886,6887,6888,6889,6890,6969,7000
client_out_wifi udp 2710,6881,6882,6883,6884,6885,6886,6887,6888,6889,6890,6969,7000
client_out_wifi udp 30301,6969,3000,2710,4444,1337,80
##########################################       NETBIOS  Client   ################################################################
#client_out_wifi tcp 135,137,138,139
#client_out_wifi udp 135,137,138,139
##########################################        SMB   Client      ###############################################################
#client_out_wifi tcp 445
##########################################        CUPS   Client     ###############################################################
client_out_wifi tcp 631
client_out_wifi udp 631
##########################################       PULSE AUDIO  Client ##############################################################
#client_out_wifi tcp 4713
##########################################       LDAP  Client        ##############################################################
#client_out_wifi tcp 389
#client_out_wifi udp 389
##########################################       NFS Client          ##############################################################
#client_out_wifi tcp 2049
#client_out_wifi udp 2049
##########################################       MYSQL Client        ##############################################################
#client_out_wifi tcp 25565
#client_out_wifi udp 25565
##########################################         FREENET  Client   ##############################################################
#client_out_wifi tcp 8888
#client_out_wifi udp 12701,29732
##########################################     GNU NET Client        ##############################################################
#client_out_wifi tcp 2086
#client_out_wifi udp 2086
##########################################        I2P Client         ##############################################################
#client_out_wifi tcp  2827,4444,4445,7652,7653,7655,7654,7656,7657,7658,7659,7660,19648
#client_out_wifi udp  7655,19648
##########################################     OpenSwan IPsec Client ##############################################################
#client_out_wifi udp 500,4500
##########################################       OPEN VPN  Client    ##############################################################
client_out_wifi tcp 1194
client_out_wifi udp 1194
##########################################          SIP              ##############################################################
client_out_wifi tcp 5060,5061
client_out_wifi udp 5060
##########################################      BITCOIN Client       ##############################################################
client_out_wifi tcp 8332,8333
##########################################      BITMESSAGE Client    ##############################################################
client_out_wifi tcp 8444
##########################################      LITECOIN Client      ##############################################################
client_out_wifi tcp 9332,9333
##########################################      GOOGLE TALK Client   ##############################################################
#client_out_wifi tcp 19294
#client_out_wifi udp 19294
##########################################     SKYPE Client          ##############################################################
#client_out_wifi tcp 23399
#client_out_wifi udp 23399
################################################# MUMBLE CLIENT ###############################################################
client_out_wifi tcp 64731
client_out_wifi udp 64731

################################################ INTERNAL SSH ##########################################################3
client_out_wifi tcp 22543

###################################################################################################################################
# echo "LOADING PUBLIC WIFI CLIENT INPUTS"

###################################################### IPV6  ####################################################################
 if [ "$int_ipv6" != "" ]
then 
############################################     DHCPv6  Client         ##############################################################################
client6_out_wifi udp 546,547
client6_out_wifi tcp 546,547
################################################# DNSv6 Client  ###################################################
client6_out_rel_wifi udp 53,953
client6_out_rel_wifi tcp 53,953
############################################## HTTP HTTPS Client #####################################
client6_out_rel_wifi tcp 80,443
fi
############################### SERVER WIFI ################################## 
 
 
#######################################################################################
 
## Loop over interfaces check if ip is defined

for int_if in "$int_if1" "$int_if2"  

do 

if [ "$int_if" = "$int_if1" ]   
then
int_mac="$int_mac1"
int_ip="$int_ip1"
int_ipv6="$int_ip1v6"
gateway_ip="$gateway_ip1"
gateway_mac="$gateway_mac1"
fi

if [ "$int_if" = "$int_if2" ]   
then
int_mac="$int_mac2"
int_ip="$int_ip2"
int_ipv6="$int_ip2v6"
gateway_ip="$gateway_ip2"
gateway_mac="$gateway_mac2"
fi 


if  [ "$int_ip" != "" ]
then 
######################################################################################################################################################
#                      Application and Port Specific Rules for INTERNET 
######################################################################################################################################################
#                                       PUBLIC OUTPUT
######################################################################################################################################################
echo "LOADING PUBLIC OUTPUT CLIENTS"

#######################################            BOOTP  Client       #######################################################################################

if [ "$gateway_ip" != "" ]
then
### Change to an internal locked to the gateway ip 
client_out_internal udp 67,68 "$gateway_ip" "$gateway_mac"
#server_in_internal  udp 67,68 "$gateway_ip" "$gateway_mac"
fi

client_out udp 67,68

#############################################    DNS   Client           ##############################################################################

client_out udp 53,953
client_out tcp 53,953

#server_in udp 53,953
#server_in tcp 53.953

#client_out_internal udp 53 "$gateway_ip" "$gateway_mac"
#server_in_internal  udp 53 "$gateway_ip" "$gateway_mac"
#client_out_internal tcp 53 "$gateway_ip" "$gateway_mac"
#server_in_internal  tcp 53 "$gateway_ip" "$gateway_mac"

#### LAN DNS SERVER 
if [ "$int_if" = "eth0" ]
then 
client_out_internal tcp 53,953 "$host_ip" "$host_mac"
client_out_internal udp 53,953 "$host_ip" "$host_mac"
fi

#############################################   HTTP HTTPS Client       ##############################################################################  
#client_out tcp 80,443
client_out tcp 443
client_out tcp 80 
##########################################    HKP OPEN PGP CLIENT       ##############################################################################
client_out tcp 11371
##########################################      RSYNC CLIENT            ##############################################################################
client_out tcp 873
##########################################    GOPHER CLIENT             ##############################################################################
client_out tcp 70
client_out udp 70
##########################################       HTTP/HTTPS PROXY       ##############################################################################
client_out tcp 8000,8080,8081,8443,8445,8090,9090,3128,8123
##########################################   SQUID HTTPS PROXY          ##############################################################################
client_out tcp 3128
##########################################        SOCK4,SOCK5 Client    ##############################################################################
client_out tcp 1080,1085
##########################################         IRC Client           ##############################################################################
client_out tcp 6667,6668,6669,6697,9999
##########################################        XMPP Client           ##############################################################################
client_out tcp 5190,5222,5223,5269,5280,5281,5298,8010
client_out udp 5298,5222
##########################################       MSN Client             ##############################################################################
#client_out tcp 1863
##########################################         FTP Client           ##############################################################################
client_out tcp 20,21,989,990,2121
client_out udp 20,21,989,990,2121

# 55536-55663
client_out tcp 55536-55663
client_out udp 55536-55663
client_out tcp 60000-60100
client_out udp 60000-60100
##########################################         NNTP Client          ##############################################################################
client_out tcp 119,563
client_out udp 119,563
##########################################        TELNET  Client        ##############################################################################
client_out tcp 23
###########################################        SSH  Client          ##############################################################################
client_out tcp 22
#############################################       SMTP  Client        ##############################################################################
client_out tcp 25,465,587,2525
##########################################         POP3  Client         ##############################################################################
client_out tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out tcp 114,993
#############################################       SMTP  Client        ##############################################################################
client_out tcp 25,465,587,2525
##########################################         POP3  Client         ##############################################################################
client_out tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out tcp 114,993
##########################################         NTP   Client         ##############################################################################
client_out udp 123
client_out tcp 123

###########################################        ICMP         ############################################################################### 
icmp_out "$int_if"


##########################################    SPECIALIZED OUTPUT   ##################################################################################
##########################################        GIT Client        #################################################################################
client_out tcp 9418
##########################################       TOR  Client        ###############################################################
client_out tcp 9001,9050,9053
##########################################      BitTorrent  Client     ############################################################
client_out tcp 2710,6881,6882,6883,6884,6885,6886,6887,6888,6889,6890,6969,7000 
client_out udp 2710,6881,6882,6883,6884,6885,6886,6887,6888,6889,6890,6969,7000 
client_out udp 30301,6969,3000,2710,4444,1337,80 
##########################################       NETBIOS  Client   ################################################################
#client_out tcp 135,137,138,139
#client_out udp 135,137,138,139
##########################################        SMB   Client      ###############################################################
#client_out tcp 445
##########################################        CUPS   Client     ###############################################################
client_out tcp 631
client_out udp 631
##########################################       PULSE AUDIO  Client ##############################################################
#client_out tcp 4713
##########################################       LDAP  Client        ##############################################################
#client_out tcp 389
#client_out udp 389
##########################################       NFS Client          ##############################################################
#client_out tcp 2049
#client_out udp 2049
##########################################       MYSQL Client        ##############################################################
#client_out tcp 25565
#client_out udp 25565
##########################################         FREENET  Client   ##############################################################
#client_out tcp 8888
#client_out udp 12701,29732
##########################################     GNU NET Client        ##############################################################
#client_out tcp 2086
#client_out udp 2086
##########################################        I2P Client         ##############################################################
#client_out tcp  2827,4444,4445,7652,7653,7655,7654,7656,7657,7658,7659,7660,19648 
#client_out udp  7655,19648 
##########################################     OpenSwan IPsec Client ##############################################################
#client_out udp 500,4500
##########################################       OPEN VPN  Client    ##############################################################
client_out tcp 1194
client_out udp 1194
##########################################          SIP              ##############################################################
client_out tcp 5060,5061
client_out udp 5060
############################################# RTMP ##########################################################
client_out tcp 1935
client_out udp 1935
##########################################      BITCOIN Client       ##############################################################
client_out tcp 8332,8333
##########################################      BITMESSAGE Client    ##############################################################
client_out tcp 8444
##########################################      LITECOIN Client      ##############################################################
client_out tcp 9332,9333
##########################################      GOOGLE TALK Client   ##############################################################
client_out tcp 19294
client_out udp 19294
##########################################     SKYPE Client          ##############################################################
client_out tcp 23399
client_out udp 23399
############################################### INTERNAL SSH ######################################################################
client_out tcp 22543

############################################### MUMBLE #############################################################################
client_out tcp 64738
client_out udp 64738


################### IPv6 ######################################################################################
if [ "$int_ipv6" != "" ]
then 
############################################     DHCPv6  Client         ##############################################################################
client6_out udp 546,547
client6_out tcp 546,547
################################################ DNSv6 Client  ###################################################
client6_out udp 53,953
client6_out tcp 53,953
############################################## HTTP HTTPS Client #####################################
client6_out tcp 80,443
fi


###################################################################################################################################
echo "LOADING PUBLIC SERVER INPUTS"
###################################################################################################################################
#                                           PUBLIC  INPUTS
###################################################################################################################################
###################################            NTP SERVER        ################################################################## 
#server_in udp 123
###################################            NNTP SERVER        #################################################################
#server_in udp 119,563
###################################           SMTP SERVER        ##################################################################
#server_in_lim tcp 25,45,587,2525 10 12
###################################         POP3 SERVER          ##################################################################
#server_in_x tcp 110,995
###################################         IMAP4 SERVER         ################################################################## 
#server_in_x tcp 143,993
###################################         TELNET SERVER        ################################################################## 
#server_in tcp 23
##################################           SSH SERVER          ################################################################## 
#server_in tcp 22
###################################          FTP  SERVER         ################################################################## 
#server_in_x tcp 20,21,2121

# 55536-55663
#server_in_x tcp 55536-55663
#server_in_x udp 55536-55663
#server_in_x tcp 60000-60100
#server_in_x udp 60000-60100
##################################          HTTP HTTPS SERVER    ################################################################## 
#server_in_x tcp 80,443
#server6_in_x tcp 80,443
###################################         FREENET  SERVER      ###################################################################
#server_in udp 12701,29732
###################################        BitTorrent  SERVER    ###################################################################
#server_in tcp 6880,6881,6882,6883,6884,6885,6886
#server_in udp 6880,6881,6882,6883,6884,6885,6886
####################################        I2P  SERVER          ####################################################################
#server_in tcp 2827,4444,4445,7652,7653,7654,7655,7656,7657,7658,7659,7660,19648
#server_in udp 7655,19648
####################################            TOR SERVER       ####################################################################
#server_in tcp 9030,9040,9050,9051,9150,9151
#server_in udp 9030,9040,9050,9051,9150,9151,9053  
####################################          TOR RELAY          ####################################################################
#server_in tcp 9001
#server_in udp 9001
####################################       GNUnet SERVER         ####################################################################
#server_in tcp 2086
#server_in udp 2086
echo "LOADING INTERNAL LAN SERVER INPUTS"


###################################################################################################################################################################
#                                 LOCAL / PRIVATE INPUTS  # mac address bind local clients to hosts
##################################          BOOTP SERVER             ################################################################################################### 
#iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp -m multiport --dports 67,68 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS 
#######################################     SYSLOG SERVER        ########################################################################################################### 
#iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp --sport 514 --dport 514 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS
#######################################      RELP LOG SERVER ########################################################################################################### 
#iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp --sport 2514 --dport 2514 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS

### internal 1-way udp make a function

#######################################       DNS SERVER       ######################################################################################################## 
#server_in_internal udp 53 "$int_ip" "$int_mac"
#server_in_internal tcp 53 "$int_ip" "$int_mac"

#server_in_internal udp 53 "$client1_ip" "$client1_mac"
#server_in_internal tcp 53 "$client1_ip" "$client1_mac"

#server_in_internal udp 53 "$client2_ip" "$client2_mac"
#server_in_internal tcp 53 "$client2_ip" "$client2_mac"
###################################         POP3 SERVER       ############################################################################################## 
#server_in_internal tcp 110,995 "$int_ip" "$int_mac"
#server_in_internal tcp 110,995 "$client1_ip" "$client1_mac"
#server_in_internal tcp 110,995 "$client2_ip" "$client2_mac"
###################################         IMAP4 SERVER      ############################################################################################## 
#server_in_internal tcp 143,993 "$int_ip" "$int_mac"
#server_in_internal tcp 143,993 "$client1_ip" "$client1_mac"
#server_in_internal tcp 143,993 "$client2_ip" "$client2_mac"
###################################        SMB SERVER         ##############################################################################################
#server_in_internal_2p tcp 445 445 "$int_ip" "$int_mac"
#server_in_internal_2p tcp 445 445 "$client1_ip" "$client1_mac"
#server_in_internal_2p tcp 445 445 "$client2_ip" "$client2_mac"
###################################        NETBIOS  SERVER    ##############################################################################################
#server_in_internal tcp 135,137,138,139 "$int_ip" "$int_mac" 
#server_in_internal udp 135,137,138,139 "$int_ip" "$int_mac" 

#server_in_internal tcp 135,137,138,139 "$client1_ip" "$client1_mac" 
#server_in_internal udp 135,137,138,139 "$client1_ip" "$client1_mac" 

#server_in_internal tcp 135,137,138,139 "$client2_ip" "$client2_mac" 
#server_in_internal udp 135,137,138,139 "$client2_ip" "$client2_mac" 
###################################        CUPS SERVER        ##############################################################################################
#server_in_internal tcp 631 "$int_ip" "$int_mac" 
#server_in_internal udp 631 "$int_ip" "$int_mac" 

#server_in_internal tcp 631 "$client1_ip" "$client1_mac" 
#server_in_internal udp 631 "$clinet1_ip" "$client1_mac" 

#server_in_internal tcp 631 "$client2_ip" "$client2_mac" 
#server_in_internal udp 631 "$clinet2_ip" "$client2_mac"
###################################    LDAP SERVER            ############################################################################################### 
#server_in_internal tcp 389 "$int_ip" "$int_mac" 
#server_in_internal udp 389 "$int_ip" "$int_mac" 

#server_in_internal tcp 389 "$client1_ip" "$client1_mac" 
#server_in_internal udp 389 "$client1_ip" "$client1_mac" 

#server_in_internal tcp 389 "$client2_ip" "$client2_mac" 
#server_in_internal udp 389 "$client2_ip" "$client2_mac" 
####################################     XMPP SERVER          ############################################################################################### 
#server_in_internal tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$int_ip" "$int_mac" 
#server_in_internal udp 5222,5190,5223,5269,5280,5281,5298,8010 "$int_ip" "$int_mac"

#server_in_internal tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$client1_ip" "$client1_mac" 
#server_in_internal udp 5222,5190,5223,5269,5280,5281,5298,8010 "$client1_ip" "$client1_mac"

#server_in_internal tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$client2_ip" "$client2_mac" 
#server_in_internal udp 5222,5190,5223,5269,5280,5281,5298,8010 "$client2_ip" "$client2_mac"
##############################################################################################################################################################
############################### INTERNAL SSH ##############################
server_in tcp 22543

############################## INTERNAL RTMP ###############################
#server_in tcp 2222
#server_in udp 2222

#server_in tcp 1935
#server_in udp 1935
###################################################################################

#### END OF LOOP OVER INTERFACES/IPs
fi

done  

#######################################################################################################################
#                                          ICMP DROP
#######################################################################################################################
nft add rule inet filter input ip protocol icmp log drop
nft add rule inet filter input ip protocol icmp log drop
nft add rule inet filter output ip protocol icmp log drop
nft add rule inet filter output ip protocol icmp log drop

#nft add rule inet filter input ip6 saddr icmpv6 log drop
#nft add rule inet filter input ip6 saddr icmpv6 log drop
#nft add rule inet filter output ip6 saddr icmpv6 log drop
#nft add rule inet filter output ip6 saddr icmpv6 log drop

########################################################################################################################
#                                          LAN INPUT DROP
########################################################################################################################
# DROP ANY FURTHER PRIVATE LAN INPUT not specified in internal networking or inputs section

nft add rule inet filter input ip saddr 10.0.0.0/8 log drop
nft add rule inet filter input ip daddr 10.0.0.0/8 log drop
nft add rule inet filter output ip saddr 10.0.0.0/8 log drop
nft add rule inet filter output ip daddr 10.0.0.0/8 log drop

nft add rule inet filter input ip saddr 172.16.0.0/12 log drop
nft add rule inet filter input  ip daddr 172.16.0.0/12 log drop
nft add rule inet filter output ip saddr 172.16.0.0/12 log drop
nft add rule inet filter output  ip daddr 172.16.0.0/12 log drop

nft add rule inet filter input ip saddr 192.168.0.0/16 log drop
nft add rule inet filter input  ip daddr 192.168.0.0/16 log drop
nft add rule inet filter output ip saddr 192.168.0.0/16 log drop
nft add rule inet filter output  ip daddr 192.168.0.0/16 log drop

########################################################################################################################
#                                       FINAL LOG DROP  
########################################################################################################################
# log all the rest before dropping

nft add rule inet filter input counter log drop  
nft add rule inet filter output counter log drop  
nft add rule inet filter forward counter log drop  

#############################################################################################################################
#                                 SAVE RULES
#############################################################################################################################
echo SAVING RULES
#DEBIAN
nft list ruleset > /etc/nftables.conf

echo "ENDWALL LOADED"
################################     PRINT RULES      #######################################################################
## list the rules
# nft list ruleset

#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY_1    :           MAC:"$gateway_mac1"  IPv4:"$gateway_ip1" " 
echo "INTERFACE_1: "$int_if1"  MAC:"$int_mac1"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "GATEWAY_2    :           MAC:"$gateway_mac2"  IPv4:"$gateway_ip2" " 
echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "

# print the time the script finishes
date
exit 0
fi
###################################      END OF PROGRAM      ################################################################
