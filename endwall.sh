

#!/bin/sh
###############################################################################################################################################################
#                        HEADER AND INSTRUCTIONS
###############################################################################################################################################################
# Program: endwall.sh
# Type: Bourne shell script
# Creation Date:         Jan 1  2013
# Branch: 1
# Current Version: 1.33  Jul 9 2016
# Stable Version:  1.30, Jun 6 2016
# Author: THE ENDWARE DEVELOPMENT TEAM
# Copyright: THE ENDWARE DEVELOPMENT TEAM, 2016
#
# Changes:     - Updated Acknowledgments
#              - Added 9030 tor in lo,server
#              - Removed duplicate entry for DNS + Added DHCPv6 client output + Aesthetics 
#              - Added functions and rewrote firewall using functions
#              - Surpress output for sysctl to clean up
#              - Updated EULA
#              - Added annotations Beginning/End of Program 
#              - Fixed tor for DNSport 9053
#              - Added gopher lo + client rules
#              - Added a PASS chain
#              - Pass PASS rules through PASS chain 
#              - Updated EULA
#              - Fixed some typos in final log drop 
#              - Updated EULA
#              - Added state RELATED to FTP connections 
#              - Added Acknowledgements section
#              - Added EULA
#              - Fixed linux security booleans with sysctl 
#              - Added DHCPv6 client/server
#           
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
# $ chmod u+rwx endwall.sh          # changer permisions to allow script execution
# $ su                              # become root
# # ./endwall.sh                    # execute/run the file
# OPTIONAL
# # ./endlists.sh                   # Loads traditional blacklists and whitelists into iptables rules
# # ./endsets.sh                    # Requires ipset, loads advanced kernel packet filtering blacklists
#
############################################################################################################################################################################
# Note that ip6tables is not enabled by default on some distributions
# for systemd enable and start iptables/ip6tables as follows:
# # systemctl enable iptables
# # systemctl enable ip6tables 
# # systemctl enable iptables.service
# # systemctl enable ip6tables.service
# # systemctl start iptables
# # systemctl start ip6tables
# # systemctl restart iptables
# # systemctl restart ip6tables
#
######################################################################### 
#############################################################################################################################################################################
#                                         ACKNOWLEDGEMENTS
#############################################################################################################################################################################
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
##############################################################################################################################################################################
##############################################################################################################################################################################
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

################################################      BEGINNING OF PROGRAM        ##################################################################################

####################################################################################################
#                           GLOBAL VARIABLES
####################################################################################################
iptables=/sbin/iptables
ip6tables=/sbin/ip6tables

# Grab interface name from ip link and parse 
int_if=$(ip link | grep -a "state " | awk -F: '{ if (FNR==2) print $2}')
int_if2=$(ip link | grep -a "state " | awk -F: '{ if (FNR==3) print $2}')

# Grab Gateway Information
gateway_ip=$(ip route | awk '/via/ {print $3}')
#gateway_mac=$( arp | awk '/gateway/ {print $3}')
gateway_mac=$( nmap -sS "$gateway_ip" -p 53| grep -a "MAC Address:" | awk '{print $3}')

# RUN MAC CHANGER on INTERFACES
#macchanger -A $int_if
#macchanger -A "$int_if2"

# grab host mac addresses from ip link  
host_mac=$(ip link | grep -a "ether" | awk ' {if (FNR==1) print $2}')
host_mac2=$(ip link | grep -a "ether" | awk ' {if (FNR==2) print $2}')

# grab the ip addresses from the interfaces
host_ip=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==1) print $1}'| awk '{print $2}')
host_ip2=$(ip addr | grep -a "scope global"|awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')
# grab the ipv6 addresses frrom the interfaces
host_ip1v6=$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==2) print $1}'| awk '{print $2}')
host_ip2v6=$(ip addr | grep -a "inet6"| awk 'BEGIN  {FS="/"} {if (FNR==3) print $1}'| awk '{print $2}')
############################  CLIENTS  ################################################
# change these values but dont leave them blank
# add more clients as you need them use $ arp or $ nmap -sS client_ip to determine values 

#client1_mac=00:00:00:00:00:00  # change to be the mac address of client 1
#client2_mac=00:00:00:00:00:00  # change to be the mac address of client 2

#client1_ip=192.168.0.161   # change to be the static ip of your first internal client
#client2_ip=192.168.0.162   # change to be the static ip of your second internal client
########################### INTERNAL VARIABLES ################################## 
int_mac="$host_mac"         # internal mac address of interface 1
int_mac2="$host_mac2"       # internal mac address of interface 2 
int_ip1="$host_ip"          # internal ip address of interface 1  
int_ip2="$host_ip2"         # internal ip address of interface 2
int_ip1v6="$host_ip1v6"     # internal ipv6 address of interface 1
int_ip2v6="$host_ip2v6"     # internal ipv6 address of interface 2
###################################################################################################################################
#                             LINUX SECURITY BOOLEANS
###################################################################################################################################
echo "LOADING SYSCTL SECURITY BOOLEANS"

###############         KERNEL       #############################################################################################

sysctl -w -q kernel.sysrq=0
sysctl -w -q kernel.core_uses_pid=1
sysctl -w -q kernel.randomize_va_space=1
sysctl -w -q kernel.pid_max=65536

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
iptables -F                   # Flush Rules
iptables -F -t mangle         # Flush table mangle
iptables -X -t mangle         # Delete table mangle from chains
iptables -F -t filter         # Flush table filter
iptables -X -t filter         # Delete table filter from chains
iptables -F -t nat            # Flush table nat 
iptables -X -t nat            # Delete chain table raw 
iptables -F -t raw            # Flush table raw
iptables -X -t raw            # Delete chain table nat 
iptables -F -t security       # Flush table security 
iptables -X -t security       # Delete chain table security 
iptables -X                   # Delete chains 
iptables -Z                   # Reset counter

ip6tables -F                  # Flush Rules
ip6tables -F -t mangle        # Flush table mangle
ip6tables -X -t mangle        # Delete table mangle from chains
ip6tables -F -t filter        # Flush table filter
ip6tables -X -t filter        # Delete table filter from chains
ip6tables -F -t raw           # Flush table raw
ip6tables -X -t raw           # Delete table raw from chains
ip6tables -F -t security      # Flush table security
ip6tables -X -t security      # Delete table security from chains
ip6tables -X                  # Delete Chains
ip6tables -Z                  # Reset Counter

############################     DEFUALT POLICY       ####################################################################
iptables -P INPUT   DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT  DROP

ip6tables -P INPUT   DROP 
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT  DROP
############################   DEFINE CUSTOM CHAINS    #####################################################################
iptables -N LnD			# Define custom DROP chain
iptables -A LnD -p tcp -m limit --limit 1/s -j LOG --log-prefix "[TCP drop] " 
iptables -A LnD -p udp -m limit --limit 1/s -j LOG --log-prefix "[UDP drop] " 
iptables -A LnD -p icmp -m limit --limit 1/s -j LOG --log-prefix "[ICMP drop] " 
iptables -A LnD -f -m limit --limit 1/s -j LOG --log-prefix "[FRAG drop] " 
iptables -A LnD -j DROP

iptables -N LnR			# Define custom REJECT chain
iptables -A LnR -p tcp -m limit --limit 1/s -j LOG --log-prefix "[TCP reject] " 
iptables -A LnR -p udp -m limit --limit 1/s -j LOG --log-prefix "[UDP reject] " 
iptables -A LnR -p icmp -m limit --limit 1/s -j LOG --log-prefix "[ICMP reject] " 
iptables -A LnR -f -m limit --limit 1/s -j LOG --log-prefix "[FRAG reject] " 
iptables -A LnR -j REJECT 

iptables -N PASS		# Define PASS chain
iptables -A PASS -p tcp  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A PASS -p tcp  -m conntrack --ctstate INVALID -j DROP
iptables -A PASS -p udp  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT 
iptables -A PASS -p udp  -m conntrack --ctstate INVALID -j DROP
iptables -A PASS -p icmp -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A PASS -p icmp -m conntrack --ctstate INVALID -j DROP
iptables -A PASS -j DROP

ip6tables -N LnD	        # Define custom DROP chain
ip6tables -A LnD -p tcp  -m limit --limit 1/s -j LOG --log-prefix "[TCP drop] " 
ip6tables -A LnD -p udp  -m limit --limit 1/s -j LOG --log-prefix "[UDP drop] " 
ip6tables -A LnD -p icmp -m limit --limit 1/s -j LOG --log-prefix "[ICMP drop] " 
ip6tables -A LnD -j DROP

ip6tables -N LnR		# Define custom REJECT chain
ip6tables -A LnR -p tcp  -m limit --limit 1/s -j LOG --log-prefix "[TCP reject] " 
ip6tables -A LnR -p udp  -m limit --limit 1/s -j LOG --log-prefix "[UDP reject] " 
ip6tables -A LnR -p icmp -m limit --limit 1/s -j LOG --log-prefix "[ICMP reject] " 
ip6tables -A LnR -j REJECT 

ip6tables -N PASS		# Define PASS chain
ip6tables -A PASS -p tcp  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
ip6tables -A PASS -p tcp  -m conntrack --ctstate INVALID -j DROP
ip6tables -A PASS -p udp  -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT 
ip6tables -A PASS -p udp  -m conntrack --ctstate INVALID -j DROP
ip6tables -A PASS -p icmp -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
ip6tables -A PASS -p icmp -m conntrack --ctstate INVALID -j DROP
ip6tables -A PASS -j DROP
#######################################################################################################################
#                   BASIC FIRST LINE SECURITY
#######################################################################################################################
echo "LOADING FIRST LINE SECURITY"
################ DROP BAD FLAG COMBINATIONS ###########################################################################
iptables -A INPUT -p tcp -m conntrack --ctstate INVALID -j LnD
iptables -A INPUT -p tcp --tcp-flags ALL FIN,SYN,RST,ACK,SYN -m state --state NEW -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp --tcp-flags ALL SYN,ACK,SYN,ACK -m state --state NEW -j REJECT --reject-with tcp-reset

ip6tables -A INPUT -p tcp -m conntrack --ctstate INVALID -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ALL SYN,ACK,SYN,ACK -m state --state NEW -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p tcp --tcp-flags ALL FIN,SYN,RST,ACK,SYN -m state --state NEW -j REJECT --reject-with tcp-reset
######################       XMAS      ################################################################################
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j LnD
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j LnD
iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j LnD
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j LnD

iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j LnD
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j LnD
iptables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j LnD
iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j LnD
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j LnD
iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j LnD
iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j LnD
iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j LnD
iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j LnD
###############
ip6tables -A INPUT -p tcp --tcp-flags ALL ALL -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ALL NONE -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j LnD

ip6tables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j LnD
ip6tables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j LnD
ip6tables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j LnD
ip6tables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j LnD
ip6tables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j LnD
ip6tables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j LnD
ip6tables -A INPUT -p tcp --tcp-flags ACK,URG URG -j LnD

######################   SYN FLOOD    ########################################################
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p tcp ! --syn -m state --state NEW -j REJECT --reject-with tcp-reset
###################### Prevent DoS attack ####################################################
#iptables -A INPUT -p tcp --dport 25 -m limit --limit 40/minute --limit-burst 80 -j PASS
#ip6tables -A INPUT -p tcp --dport 25 -m limit --limit 40/minute --limit-burst 80 -j PASS
#################     DROP BROADCAST   #######################################################
iptables -A INPUT  -i $int_if -d 255.255.255.255 -j DROP
iptables -A INPUT  -i $int_if -d 192.168.255.255 -j DROP
iptables -A INPUT  -i $int_if -d 192.168.0.255   -j DROP
iptables -A INPUT  -i $int_if -d 153.122.255.255 -j DROP
iptables -A INPUT  -i $int_if -d 153.122.1.255   -j DROP
iptables -A INPUT  -i $int_if -d 172.2.255.255 -j DROP
iptables -A INPUT  -i $int_if -d 172.2.1.255   -j DROP
# comment out if you want to accept broadcast from your router

#################### DROP MULTICAST/BROADCAST ################################################
iptables -A INPUT  -s 224.0.0.0/4    -j LnD
iptables -A OUTPUT -d 224.0.0.0/4    -j LnD
iptables -A INPUT  -s 240.0.0.0/4    -j LnD
iptables -A OUTPUT -d 240.0.0.0/4    -j LnD

# comment out if you want to accept multicast or broadcast
#####################  DROP ASSUMED ATTACKERS   #####################################################
iptables -A INPUT -m recent --rcheck --seconds 60 -m limit --limit 10/second -j LOG --log-prefix "BG "
iptables -A INPUT -m recent --update --seconds 60 -j DROP
ip6tables -A INPUT -m recent --rcheck --seconds 60 -m limit --limit 10/second -j LOG --log-prefix "BG "
ip6tables -A INPUT -m recent --update --seconds 60 -j DROP

# this rule places any input source ip making over 10 connections/second into a watch list
# if this ip is still in the watch list after 60 seconds then it is dropped

#######################  DROP INTERNAL HOST IP INPUT SPOOFING    ####################################
#iptables -A INPUT    -i $int_if -s "$int_ip1" -m recent --set -j LnD
#iptables -A FORWARD  -i $int_if -s "$int_ip1" -m recent --set -j LnD
#iptables -A INPUT    -i $int_if -s "$int_ip2" -m recent --set -j LnD
#iptables -A FORWARD  -i $int_if -s "$int_ip2" -m recent --set -j LnD
### this rule may prevent you from seeing your own hosted website from the same computer
### comment these lines out if this affects your ability to see your own website from the host.

######################      DROP OTHER LAN SPOOFING         ############################################
# comment these lines out if they cause a problem

#######################################################################################################################
#                     DROP RESTRICTED SPECIAL USE IPv4 NETWORKS / IP SPOOFING
#######################################################################################################################
############################# DROP LINK-LOCAL ADDRESSES ###############################################################
iptables -A INPUT  -s 169.254.0.0/16  -j LnD
iptables -A INPUT  -d 169.254.0.0/16  -j LnD
############################### DROP OUTBOUND BROADCAST ###############################################################
iptables -A OUTPUT -d 255.255.255.255 -j LnD

#####################  DROP PRIVATE LAN INPUT OF WRONG CLASS/TYPE      ################################################ 
#iptables -A INPUT  -s 10.0.0.0/8     -j LnD
#iptables -A INPUT  -s 172.16.0.0/12  -j LnD
#iptables -A INPUT  -s 192.168.0.0/16 -j LnD
# uncomment private lan network classss that are not not applicable to your network to drop them
# use an if statement to check gateway ip against 10,172,192 (not implemented currently)
#

echo "FIRST LINE SECURITY LOADED"

#################################################################################################################################
######################################       FUNCTIONS       ####################################################################
lo_open()
{
proto=$1
ports=$2
iptables -A INPUT   -i lo  -p "$proto" -m multiport --dports "$ports" -j PASS
iptables -A INPUT   -i lo  -p "$proto" -m multiport --sports "$ports" -j PASS
iptables -A OUTPUT  -o lo  -p "$proto" -m multiport --dports "$ports" -j PASS
iptables -A OUTPUT  -o lo  -p "$proto" -m multiport --sports "$ports" -j PASS
}

lo6_open()
{
proto=$1
ports=$2
ip6tables -A INPUT   -i lo  -p "$proto" -m multiport --dports "$ports" -j PASS
ip6tables -A INPUT   -i lo  -p "$proto" -m multiport --sports "$ports" -j PASS
ip6tables -A OUTPUT  -o lo  -p "$proto" -m multiport --dports "$ports" -j PASS
ip6tables -A OUTPUT  -o lo  -p "$proto" -m multiport --sports "$ports" -j PASS
}

client_out()
{
proto=$1
ports=$2
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

client_out_lim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

client_out_rel()
{
proto=$1
ports=$2
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED,RELATED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED,RELATED -j PASS
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED,RELATED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED,RELATED -j PASS
}

client6_out()
{
proto=$1
ports=$2
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS 
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

client6_out_rel()
{
proto=$1
ports=$2
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED,RELATED -j PASS 
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED,RELATED -j PASS
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED,RELATED -j PASS
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED,RELATED -j PASS
}

client6_out_lim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --dports "$ports" -m limit --limit "$limrate"/second --limit-burst "$limburst"  -m state --state NEW,ESTABLISHED -j PASS 
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
ip6tables -A OUTPUT  -o $int_if -p "$proto" -m multiport --sports "$ports" -m limit --limit "$limrate"/second --limit-burst "$limburst"  -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A INPUT   -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

server_in()
{
proto=$1
ports=$2
iptables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
}

server_in_x()
{
proto=$1
ports=$2
iptables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

server_in_xlim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4
iptables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -p "$proto" -m multiport --sports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

server6_in()
{
proto=$1
ports=$2
ip6tables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
}

server6_in_x()
{
proto=$1
ports=$2
ip6tables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
ip6tables -A INPUT  -i $int_if -p "$proto" -m multiport --sports "$ports" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A OUTPUT -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

server6_in_xlim()
{
proto=$1
ports=$2
limrate=$3
limburst=$4
ip6tables -A INPUT  -i $int_if -p "$proto" -m multiport --dports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A OUTPUT -o $int_if -p "$proto" -m multiport --sports "$ports" -m state --state ESTABLISHED -j PASS
ip6tables -A INPUT  -i $int_if -p "$proto" -m multiport --sports "$ports" -m limit --limit "$limrate"/s --limit-burst "$limburst" -m state --state NEW,ESTABLISHED -j PASS
ip6tables -A OUTPUT -o $int_if -p "$proto" -m multiport --dports "$ports" -m state --state ESTABLISHED -j PASS
}

server_internal_1way()
{
ports=$1
client_ip=$2
client_mac=$3
iptables -A INPUT  -i $int_if -p udp -m multiport --dports "$ports" -d "$int_ip1"  -s "$client_ip" -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
}

server_internal_1p()
{
proto=$1
port=$2
client_ip=$3
client_mac=$4
iptables -A INPUT  -i $int_if -p "$proto"  --dport "$port" -d "$int_ip1"   -s "$client_ip" -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  --sport "$port" -s "$int_ip1"   -d "$client_ip" -m state --state ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -p "$proto"  --sport "$port" -s "$client_ip" -d "$int_ip1"   -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  --dport "$port" -d "$client_ip" -s "$int_ip1"   -m state --state ESTABLISHED -j PASS
}

server_internal_mp()
{
proto=$1
ports=$2
client_ip=$3
client_mac=$4
iptables -A INPUT  -i $int_if -p "$proto"  -m multiport --dports "$ports" -d "$int_ip1"   -s "$client_ip" -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  -m multiport --sports "$ports" -s "$int_ip1"   -d "$client_ip" -m state --state ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -p "$proto"  -m multiport --sports "$ports" -s "$client_ip" -d "$int_ip1"   -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  -m multiport --dports "$ports" -d "$client_ip" -s "$int_ip1"   -m state --state ESTABLISHED -j PASS
}

server_internal_2p()
{
proto=$1
port1=$2
port2=$3
client_ip=$4
client_mac=$5
iptables -A INPUT  -i $int_if -p "$proto"  --sport "$port1" --dport "$port2" -d "$int_ip1"   -s "$client_ip" -m mac --mac-source "$client_mac" -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  --dport "$port1" --sport "$port2" -s "$int_ip1"   -d "$client_ip" -m state --state ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -p "$proto"  --dport "$port1" --sport "$port2" -s "$client_ip" -d "$int_ip1" -m mac --mac-source "$client_mac"  -m state --state NEW,ESTABLISHED -j PASS
iptables -A OUTPUT -o $int_if -p "$proto"  --sport "$port1" --dport "$port2" -d "$client_ip" -s "$int_ip1" -m state --state ESTABLISHED -j PASS
}

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
lo6_open tcp 25,587,465
############################ FTP ############################################################
lo_open tcp 20,21,989,990,2121
lo_open udp 20,21,989,990,2121
########################### HTTP,HTTPS ######################################################
lo_open tcp 80,443
lo6_open tcp 80,443
########################### GOPHER ##########################################################
lo_open tcp 70
lo_open udp 70
lo6_open tcp 70
lo6_open udp 70
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
######################## ICMP ###############################################################
iptables -A INPUT  -i lo  -p icmp --icmp-type ping -m limit --limit 1/second -j PASS
iptables -A OUTPUT -o lo  -p icmp --icmp-type ping -m limit --limit 2/second -j PASS

iptables -A INPUT  -i lo  -p icmp --icmp-type 0 -m limit --limit 1/second -j PASS
iptables -A OUTPUT -o lo  -p icmp --icmp-type 0 -m limit --limit 2/second -j PASS
iptables -A INPUT  -i lo  -p icmp --icmp-type 3 -m limit --limit 1/second -j PASS
iptables -A OUTPUT -o lo  -p icmp --icmp-type 3 -m limit --limit 2/second -j PASS
iptables -A INPUT  -i lo  -p icmp --icmp-type 8 -m limit --limit 1/second -j PASS
iptables -A OUTPUT -o lo  -p icmp --icmp-type 8 -m limit --limit 2/second -j PASS
iptables -A INPUT  -i lo  -p icmp --icmp-type 11 -m limit --limit 1/second -j PASS
iptables -A OUTPUT -o lo  -p icmp --icmp-type 11 -m limit --limit 2/second -j PASS

ip6tables -A INPUT  -i lo  -p icmp -m limit --limit 1/second -j PASS
ip6tables -A OUTPUT -o lo  -p icmp -m limit --limit 2/second -j PASS

############################ LOCAL HOST DROP ############################################## 
# NO FURTHER INPUT/OUTPUT FROM LOCALHOST / SOURCE HOSTS
iptables -A INPUT  -s 127.0.0.0/8    -j LnD
iptables -A OUTPUT -d 127.0.0.0/8    -j LnD
iptables -A INPUT  -s 0.0.0.0/8      -j LnD
iptables -A OUTPUT -d 0.0.0.0/8      -j LnD

iptables -A INPUT    -i lo  -j LnD
iptables -A OUTPUT   -o lo  -j LnD
iptables -A FORWARD  -i lo  -j LnD
iptables -A FORWARD  -o lo  -j LnD

ip6tables -A INPUT    -i lo  -j LnD
ip6tables -A OUTPUT   -o lo  -j LnD
ip6tables -A FORWARD  -i lo  -j LnD
ip6tables -A FORWARD  -o lo  -j LnD
###########################################################################################
echo "LOCALHOST RULES LOADED"
###########################################################################################
################################################################################################
#                         Router and Internal Network Rules
###################################################################################################
#
#                    REMOVED /ADD YOUR OWN according to your needs  sshd etc
#
#
######################################################################################################################################################
#                      Application and Port Specific Rules for INTERNET 
######################################################################################################################################################
#                                       PUBLIC OUTPUT
######################################################################################################################################################
echo "LOADING PUBLIC OUTPUT CLIENTS"
#############################################    DNS   Client           ##############################################################################
client_out udp 53,953
client_out tcp 53,953 
client6_out udp 53,953
client6_out tcp 53,953
############################################     DHCPv6  Client         ##############################################################################
client6_out udp 546,547
client6_out tcp 546,547
#############################################   HTTP HTTPS Client       ##############################################################################  
client_out tcp 80,443
client6_out tcp 80,443
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
client_out_rel tcp 20,21,989,990,2121
client_out_rel udp 20,21,989,990,2121
##########################################         NNTP Client          ##############################################################################
client_out tcp 119,563
client_out udp 119,563
##########################################        TELNET  Client        ##############################################################################
client_out tcp 23
###########################################        SSH  Client          ##############################################################################
client_out tcp 22
#############################################       SMTP  Client        ##############################################################################
client_out tcp 25,465,587,2525
client6_out tcp 25,465,587,2525
##########################################         POP3  Client         ##############################################################################
client_out tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out tcp 114,993
#############################################       SMTP  Client        ##############################################################################
client_out_lim tcp 25,465,587,2525 5 10 
client6_out_lim tcp 25,465,587,2525 5 10 
##########################################         POP3  Client         ##############################################################################
client_out tcp 110,995
##########################################         IMAP  Client         ##############################################################################
client_out tcp 114,993
##########################################         NTP   Client         ##############################################################################
client_out udp 123
client_out tcp 123
#######################################            BOOTP  Client       #######################################################################################
iptables -A OUTPUT -o $int_if -s "$int_ip1" -d "$gateway_ip" -p udp -m multiport --dports 67,68 -m state --state NEW,ESTABLISHED -j PASS
iptables -A INPUT  -i $int_if -d "$int_ip1" -s "$gateway_ip" -p udp -m multiport --sports 67,68 -m state --state ESTABLISHED -j PASS
###########################################        ICMP Ping         ###############################################################################
iptables -A OUTPUT -o $int_if -s "$int_ip1" -p icmp --icmp-type ping  -m state --state NEW,ESTABLISHED -j PASS 
iptables -A INPUT  -i $int_if -d "$int_ip1" -p icmp --icmp-type ping  -m state --state ESTABLISHED -j PASS

# echo reply from ping
iptables -A INPUT  -i $int_if -d "$int_ip1" -p icmp --icmp-type 0  -m state --state ESTABLISHED -j PASS
# rejection messages
iptables -A INPUT  -i $int_if -d "$int_ip1" -p icmp --icmp-type 3  -m state --state ESTABLISHED -j PASS
# time out signal
iptables -A INPUT  -i $int_if -d "$int_ip1" -p icmp --icmp-type 11 -m state --state ESTABLISHED -j PASS
# echo request from ping
iptables -A INPUT  -i $int_if -d "$int_ip1" -p icmp --icmp-type 8  -m limit --limit 1/second -m state --state ESTABLISHED -j PASS

## comment out if you wish to block ipv6 icmp (ping etc)
ip6tables -A OUTPUT -o $int_if -p icmp -m state --state NEW,ESTABLISHED -j PASS 
ip6tables -A INPUT  -i $int_if -p icmp -m state --state ESTABLISHED -j PASS
##########################################    SPECIALIZED OUTPUT   ##################################################################################
##########################################        GIT Client        #################################################################################
client_out tcp 9418
##########################################       TOR  Client        ###############################################################
client_out tcp 9001
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
##################################          HTTP HTTPS SERVER    ################################################################## 
#server_in_x tcp 80,443
#server6_in_x tcp 80,443
###################################         FREENET  SERVER      ###################################################################
#server_in udp 12701,29732
###################################        BitTorrent  SERVER    ###################################################################
server_in tcp 6880,6881,6882,6883,6884,6885,6886
server_in udp 6880,6881,6882,6883,6884,6885,6886
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
iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp -m multiport --dports 67,68 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS 
#######################################     SYSLOG SERVER        ########################################################################################################### 
iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp --sport 514 --dport 514 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS
#######################################      RELP LOG SERVER ########################################################################################################### 
#iptables -A INPUT -i $int_if -s "$gateway_ip" -d "$int_ip1" -p udp --sport 2514 --dport 2514 -m mac --mac-source "$gateway_mac" -m state --state NEW,ESTABLISHED -j PASS
#######################################       DNS SERVER       ######################################################################################################## 
server_internal_1p udp 53 "$host_ip" "$host_mac"
server_internal_1p tcp 53 "$host_ip" "$host_mac"

#server_internal_1p udp 53 "$client1_ip" "$client1_mac"
#server_internal_1p tcp 53 "$client1_ip" "$client1_mac"

#server_internal_1p udp 53 "$client2_ip" "$client2_mac"
#server_internal_1p tcp 53 "$client2_ip" "$client2_mac"
###################################         POP3 SERVER       ############################################################################################## 
#server_internal_1p tcp 110,995 "$host_ip" "$host_mac"
#server_internal_1p tcp 110,995 "$client1_ip" "$client1_mac"
#server_internal_1p tcp 110,995 "$client2_ip" "$client2_mac"
###################################         IMAP4 SERVER      ############################################################################################## 
#server_internal_1p tcp 143,993 "$host_ip" "$host_mac"
#server_internal_1p tcp 143,993 "$client1_ip" "$client1_mac"
#server_internal_1p tcp 143,993 "$client2_ip" "$client2_mac"
###################################        SMB SERVER         ##############################################################################################
#server_internal_2p tcp 445 445 "$host_ip" "$host_mac"
#server_internal_2p tcp 445 445 "$client1_ip" "$client1_mac"
#server_internal_2p tcp 445 445 "$client2_ip" "$client2_mac"
###################################        NETBIOS  SERVER    ##############################################################################################
#server_internal_mp tcp 135,137,138,139 "$host_ip" "$host_mac" 
#server_internal_mp udp 135,137,138,139 "$host_ip" "$host_mac" 

#server_internal_mp tcp 135,137,138,139 "$client1_ip" "$client1_mac" 
#server_internal_mp udp 135,137,138,139 "$client1_ip" "$client1_mac" 

#server_internal_mp tcp 135,137,138,139 "$client2_ip" "$client2_mac" 
#server_internal_mp udp 135,137,138,139 "$client2_ip" "$client2_mac" 
###################################        CUPS SERVER        ##############################################################################################
#server_internal_1p tcp 631 "$host_ip" "$host_mac" 
#server_internal_1p udp 631 "$host_ip" "$host_mac" 

#server_internal_1p tcp 631 "$client1_ip" "$client1_mac" 
#server_internal_1p udp 631 "$clinet1_ip" "$client1_mac" 

#server_internal_1p tcp 631 "$client2_ip" "$client2_mac" 
#server_internal_1p udp 631 "$clinet2_ip" "$client2_mac"
###################################    LDAP SERVER            ############################################################################################### 
#server_internal_1p tcp 389 "$host_ip" "$host_mac" 
#server_internal_1p udp 389 "$host_ip" "$host_mac" 

#server_internal_1p tcp 389 "$client1_ip" "$host_mac" 
#server_internal_1p udp 389 "$client1_ip" "$host_mac" 

#server_internal_1p tcp 389 "$client2_ip" "$host_mac" 
#server_internal_1p udp 389 "$client2_ip" "$host_mac" 
####################################     XMPP SERVER          ############################################################################################### 
#server_internal_mp tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$host_ip" "$host_mac" 
#server_internal_mp udp 5222,5190,5223,5269,5280,5281,5298,8010 "$host_ip" "$host_mac"

#server_internal_mp tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$client1_ip" "$client1_mac" 
#server_internal_mp udp 5222,5190,5223,5269,5280,5281,5298,8010 "$client1_ip" "$client1_mac"

#server_internal_mp tcp 5222,5190,5223,5269,5280,5281,5298,8010 "$client2_ip" "$client2_mac" 
#server_internal_mp udp 5222,5190,5223,5269,5280,5281,5298,8010 "$client2_ip" "$client2_mac"
#######################################################################################################################
#                                          ICMP DROP
#######################################################################################################################
iptables -A INPUT -p icmp -j LnD
ip6tables -A INPUT -p icmp -j LnD
########################################################################################################################
#                                          LAN INPUT DROP
########################################################################################################################
# DROP ANY FURTHER PRIVATE LAN INPUT not specified in internal networking or inputs section
iptables -A INPUT  -s 10.0.0.0/8     -j LnD
iptables -A INPUT  -s 172.16.0.0/12  -j LnD
iptables -A INPUT  -s 192.168.0.0/16 -j LnD
########################################################################################################################
#                                       FINAL LOG DROP  
########################################################################################################################
# log all the rest before dropping
iptables -A INPUT   -j LOG --log-prefix "IPTables IN Dropped" --log-level=info;
iptables -A INPUT   -j REJECT --reject-with icmp-host-unreachable
iptables -A OUTPUT  -j LOG --log-prefix "IPTables OUT Dropped" --log-level=info ;
iptables -A OUTPUT  -j REJECT --reject-with icmp-host-unreachable
iptables -A FORWARD -j LOG --log-prefix "IPTables FW Dropped" --log-level=info ;
iptables -A FORWARD -j REJECT --reject-with icmp-host-unreachable

ip6tables -A INPUT   -j LOG --log-prefix "IPTables IN Dropped" --log-level=info ; 
ip6tables -A INPUT   -j REJECT 
ip6tables -A OUTPUT  -j LOG --log-prefix "IPTables OUT Dropped" --log-level=info ;
ip6tables -A OUTPUT  -j REJECT 
ip6tables -A FORWARD -j LOG --log-prefix "IPTables FW Dropped" --log-level=info ;
ip6tables -A FORWARD -j REJECT 
#############################################################################################################################
#                                 SAVE RULES
#############################################################################################################################
echo SAVING RULES
# comment out distribution rules that you are not using
#ARCH/PARABOLA
iptables-save  > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

#DEBIAN/UBUNTU
iptables-save  > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# RHEL/CENTOS/FEDORA
iptables-save  > /etc/iptables/iptables
ip6tables-save > /etc/iptables/ip6tables

echo "ENDWALL LOADED"
################################     PRINT RULES      #######################################################################
#list the rules
#iptables -L -v
#ip6tables -L -v
#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY    :          MAC:"$gateway_mac"  IPv4:"$gateway_ip" " 
echo "INTERFACE_1: "$int_if"  MAC:"$int_mac"  IPv4:"$int_ip1" IPv6:"$int_ip1v6" "
echo "INTERFACE_2: "$int_if2"  MAC:"$int_mac2"  IPv4:"$int_ip2"  IPv6:"$int_ip2v6" "
# print the time the script finishes
date
exit 0
###################################      END OF PROGRAM      ################################################################
