#! /bin/sh
######################################################### 
## Title: endwall_bsd.sh
## Author: The Endware Development Team
## Copyright: 2016-2021, The Endware Development Team
## All Rights Reserved
## Creation Date: August 1, 2021
## Version: 0.0025
## Revision Date: August 5, 2021
##  
## Description: Translation of endwall to PF for OpenBSD
##
######################################################
## Dependencies:  nmap, pfctl,grep,cut,awk
################## INSTRUCTIONS ######################
## $ su
## # mkdir -p /root/sec   # make a directory to hold the rules
## # cp endwall_pf.sh /root/sec
## # cd /root/sec
## # ./endwall_pf.sh      # creates rules and loads them
## 
## # cat /root/sec/pf_rules.conf   # view the rules file
## # pfctl -sr     # show the rule set after loading
##
## Default rules (OpenBSD default PF setting)
## # ./endwall_pf.sh -d
##
## Tables 
## # pfctl -t blacklist -T add "8.8.8.0/24"
## # echo "8.8.8.0/24" >> /etc/blacklist.txt
## # pfctl -t blacklist -T del "8.8.8.8" 
## # 
#######################################################
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

######################################## BEGINNING OF PROGRAM    ##########################################################

###############  VERSION INFORMATION  ##############
version="0.0025"
rev_date="05/08/2021"
branch="OpenBSD"
product="ENDWALL PF/BSD"
##################################################

###############       RULE SET FILE     ###########################

# set the rule file name
rule_file="./pf_rules.conf"
config_file="/etc/pf.conf"
backup_file="/etc/pf.bkp"

blacklist_file="/etc/blacklist.txt"
#blacklist_file="/etc/blacklist"

### replace the previous rule file
echo "" > "$rule_file"
### create or check for backup file
touch "$backup_file"
touch "$config_file"

############### INTERNAL VARIABLES ###########################
### default interface
int_if="$( ifconfig | grep "UP,BROADCAST" | cut -d : -f 1 )"
### internal ip address
int_ip="$( ifconfig | grep "inet" | tail -n 1 | cut -d " " -f 2 )"
### internal mac address
int_mac="$(ifconfig -a | grep "lladdr " | awk '{print $2}')"

## local host interface
lo_if="$( ifconfig | grep "UP,LOOPBACK" | cut -d : -f 1 )"
## local host ip
lo_ip="$( ifconfig | grep "inet " | head -n 1 | cut -d " " -f 2 )"

## Default Gatway 
#gateway_ip="$(route show | grep "default" | cut -d " " -f 13)"
gateway_ip="$( route show | grep "default" | awk '{print $2}' )"

gateway_mac="$( route show | grep "$gateway_ip"" "| tail -n 1 | awk '{print $2}' )"

### Deprecated grab method. Hangs sometimes/ too slow.
#gateway_mac="$( nmap -sS "$gateway_ip" -p 53 | grep -a "MAC Address:" | awk '{print $3}' ) "

################  FLUSH RULES    ##########################
# flush the rules
#pfctl -F rules 	
# flush the states
#pfctl -F states	
# flush the sources
#pfctl -F Sources
# flush the info
#pfctl -F info
# flush the tables
#pfctl -F Tables
# flush the os finger printng 
#pfctl -F osfp
# reset all counters
#pfctl -F Reset

# flush all of the above
pfctl -F all

####################### FUNCTIONS ###################################
#
#####################################################################

### ./endwall_bsd -d  runs this function 
###  default settings from original install
################   DEFAULTS         #########################
## What OpenBSD ships with
default()
{

################  PREAMBLE ##################################
echo "set block-policy return   # default block policy " >> "$rule_file"

################   ORIGINAL RULE SET (USELESS)
#     We will have rules for local host 
#    (letting localhost run free is wrong)
echo "set skip on lo    # no rules for local host " >> "$rule_file"
echo "block return	# block stateless traffic"  >> "$rule_file"
## This just lets everything through that localhost established ( not a good idea)
## The attack might be from software on the inside connecting out and then letting 
## all other connections in...bad idea
echo "pass		# establish keep-state" >> "$rule_file"
#echo "block all # block everything else" >> "$rule_file"
################################################
# load the rules
pfctl -f "$rule_file"
# backup the config file
cp "$config_file" "$backup_file"
# replace the previous config file with the new rules
cp "$rule_file" "$config_file"

echo "DEFAULT RULES RESTORED"

#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY    :      MAC:"$gateway_mac"  IPv4:"$gateway_ip" " 
echo "INTERFACE_1: "$int_if"  MAC:"$int_mac"   IPv4:"$int_ip" "

}

### ./endwall runs this function
endwall_main()
{
	
################# HEADER ###################################
echo "## Title: endwall_bsd.sh " >> "$rule_file" 
echo "## Author: The Endware Development Team. " >> "$rule_file"
echo "######################################################### " >> "$rule_file"
echo "## Copyright: 2016-2021, The Endware Development Team" >> "$rule_file"
echo "## All Rights Reserved" >> "$rule_file"
echo "## Creation Date: August 1, 2021" >> "$rule_file"
echo "## Version: "$version" " >> "$rule_file"
echo "## Revision Date: "$rev_date" " >> "$rule_file"
echo "## " >> "$rule_file"  
echo "## Description: Translation of endwall.sh from Iptables to PF for OpenBSD" >> "$rule_file"
echo "## " >> "$rule_file"
echo "######################################################" >> "$rule_file"  
echo "## See /etc/examples/pf.conf or man pf.conf(5) for more examples..." >> "$rule_file"
echo "## " >> "$rule_file"
############# PREAMBLE #################################
echo "set block-policy drop   # default block policy " >> "$rule_file"
echo "set debug info    # logging level " >> "$rule_file" 

#############  VARIABLES ################################

###########   TABLES ###################################

##
#### Default blacklist
echo "table <blacklist> persist " >> "$rule_file"
echo "block quick on lo from <blacklist> to any " >> "$rule_file"
echo "block quick on lo from lo to <blacklist> " >> "$rule_file"
echo "block quick on "$int_if" from <blacklist> to any " >> "$rule_file"
echo "block quick on "$int_if" from "$int_ip" to <blacklist> " >> "$rule_file"

################### BLOCK ALL TRAFFIC #####################
## block all
echo "block all ">> "$rule_file" 

## Per interface blocking
echo "block in on "$int_if" all ">> "$rule_file" 
echo "block in on "$lo_if" all ">> "$rule_file"
 
echo "block out on "$int_if" all">> "$rule_file" 
echo "block out on "$lo_if" all">> "$rule_file" 
 
###########  LOCAL HOST RULES   ##################
echo "LOADING LOCALHOST RULES"
############# BOOTP ###############
lo_open udp 67
lo_open udp 68
############# DNS #################
lo_open tcp 53
lo_open udp 53
lo_open tcp 953
lo_open udp 953
############ SSH ###################
lo_open tcp 22
############# Telnet ###############
lo_open tcp 23
############ SMTP #################
lo_open tcp 25
lo_open tcp 587
lo_open tcp 465
############ FTP  #################
lo_open tcp 20
lo_open tcp 21
############ HTTP ################
lo_open tcp 80
lo_open tcp 443
############ GOPHER ###############
lo_open tcp 70

############ IMAP #################
lo_open tcp 143
lo_open tcp 993

############ POP  #################
lo_open tcp 110
lo_open tcp 995

##########  IRC  ##################
lo_open tcp 6667
lo_open tcp 6697

########## XMPP ####################
lo_open tcp 5222
lo_open tcp 5000

lo_open udp 5222
lo_open udp 5000
########## NNTP  ####################
lo_open tcp 119
lo_open tcp 563

lo_open udp 119
lo_open udp 563

########## NTP ##################
lo_open tcp 123

##########  HKP PGP ##################
lo_open tcp 11371

########### TOR ######################
lo_open tcp 9050
lo_open tcp 9051
lo_open tcp 9053
lo_open tcp 9040
lo_open tcp 9001
lo_open tcp 9150
lo_open tcp 9151

lo_open udp 9053
lo_open udp 9153

############  LDAP ################
lo_open tcp 389
lo_open udp 389

############  SQUID ################
lo_open tcp 3128

############ HTTP ALT ###############
lo_open tcp 8080

########### SOCKS ###################
lo_open tcp 1080
lo_open tcp 1081
lo_open tcp 1085

########## NETBIOS #################
#lo_open tcp 135
#lo_open tcp 137
#lo_open tcp 138
#lo_open tcp 139

#lo_open udp 135
#lo_open udp 137
#lo_open udp 138
#lo_open udp 139

###########  SMB  ###################
#lo_open tcp 445

###########  GIT ####################
lo_open tcp 9418

########### SYSLOG ##############
lo_open tcp 514
lo_open udp 514

########### RELP #################
lo_open tcp 2514
lo_open udp 2514

########### RCP ##################
#lo_open udp 111
#lo_open tcp 111

############ RSYNC ###############
lo_open tcp 873
lo_open udp 873

###########  OPENVPN ##############
#lo_open tcp 1194
#lo_open tcp 943

#lo_open udp 1194
#lo_open udp 943

########## MS SQL #################
#lo_open tcp 1433

########## MY SQL ##############
lo_open tcp 3306

########## POSTGRE SQL ############
lo_open tcp 5432

########## BITCOIN ################
lo_open tcp 8332
lo_open tcp 8333
lo_open tcp 8334

########## ZCASH ################
lo_open tcp 8232
lo_open tcp 8233
lo_open tcp 8234

########## LITECOIN ################
lo_open tcp 9332
lo_open tcp 9333
lo_open tcp 9334

######### MONERO ###############
lo_open tcp 18080
lo_open tcp 18081

########## ETHEREUM ############
lo_open tcp 8545
lo_open tcp 8546
lo_open tcp 30303

lo_open udp 30303
lo_open udp 30301

########## MUMBLE ################
lo_open tcp 64738
lo_open udp 64738

#################################################
########## PRIVATE SSH #############
lo_open tcp 22543

###############     ICMP RULES        ###################
### icmp_lo_type icmp-type  

icmp_lo_type "echoreq"
icmp_lo_type 0
icmp_lo_type 3

### Need the correct icmp code for these
# echo "pass in quick on lo inet proto icmp-type 8 code" >> "$rule_file"
# echo "pass out quick on lo inet proto icmp-type 8 code" >> "$rule_file"
# echo "pass in quick on lo inet proto icmp-type 11 code " >> "$rule_file"
# echo "pass out quick on lo inet proto icmp-type 11 code " >> "$rule_file"

###################### BLOCK REMAINING LOCALHOST ################################
echo "block on lo all" >> "$rule_file"
echo "LOCALHOST RULES LOADED"

#################  PUBLIC OUTPUT   #################################
###########    CLIENT OUTBOUND RULES ################

echo "LOADING PUBLIC OUTPUT CLIENTS"
###################  BOOTP CLIENT #################
client_out udp 67
client_out udp 68

################### DNS CLIENT #####################
client_out tcp 53
client_out udp 53
client_out tcp 953
client_out udp 953

################### HTTP CLIENT #######################
client_out tcp 80
client_out tcp 443

#################  HKP PGP ####################
client_out tcp 11371

#################  RSYNC  ######################
client_out tcp 873

#################  GOPHER ####################
client_out tcp 70
client_out udp 70

#################  SQUID #####################
client_out tcp 3128

#################  HTTP ALT #################
client_out tcp 8080
client_out tcp 8000

################  SOCKS ##################
client_out tcp 1080

################  IRC ##################
client_out tcp 6667
client_out tcp 6697

###############  XMPP  #################
client_out tcp 5222 
client_out tcp 5000

###############  FTP #################
client_out tcp 20
client_out tcp 21

############### NNTP #################
client_out tcp 119
client_out tcp 563

############## TELNET ################
client_out tcp 23

############## SSH ###################
client_out tcp 22

############## SMTP ##################
client_out tcp 25

#############  POP  ###################
client_out tcp 110
client_out tcp 995

############ IMAP  #####################
client_out tcp 143
client_out tcp 993

############ NTP  #######################
client_out tcp 123
client_out udp 123

########### BOOTP  ######################
bootp udp 67
bootp udp 68

########### ICMP  #######################
icmp_out_type 0
icmp_out_type 3
icmp_out_type "echoreq"

########### GIT ##########################
client_out tcp 9418

########### TOR  #########################
client_out tcp 9050
client_out tcp 9053
client_out tcp 9040
client_out tcp 9001

client_out tcp 9053
client_out udp 9053

client_out tcp 9150
client_out tcp 9151
client_out tcp 9153
client_out udp 9153


###############  COINS   ##################


################# BITCOIN ##################
client_out tcp 8332
client_out tcp 8333
client_out tcp 8334

################# LITECOIN #################
client_out tcp 9332
client_out tcp 9333
client_out tcp 9334

################# ZCASH ####################
client_out tcp 8232
client_out tcp 8233
client_out tcp 8234

################# MONERO ####################
client_out tcp 18080
client_out tcp 18081

################# ETHEREUM #################
client_out tcp 8545
client_out tcp 8546
client_out tcp 30303

client_out udp 30303
client_out udp 30301

################# INTERNAL OUTPUT #################################

############ SSH INTERNAL
client_out tcp 22543

################   PUBLIC INPUT ####################################
echo "LOADING SERVER INBOUND RULES"
###########    SERVER INBOUND RULES #################

############### SMTP ###################
# server_in tcp 25
# server_in tcp 587
# server_in tcp 465

############## IMAP #####################
# server_in tcp 143
# server_in tcp 993

############## POP ######################
# server_in tcp 110
# server_in tcp 995

##############  HTTP ####################
# server_in tcp 80
# server_in tcp 443

############# DNS  #######################
#server_in udp 53

################ INTERNAL INPUT ####################################

############# DNS SERVER ###############
# server_in_int udp 53 "$client_ip1" 
# server_in_int udp 53 "$client_ip2" 
# server_in_int udp 53 "$client_ip3"

echo "SERVER INBOUND RULES LOADED"
######################################################################

##############  FINAL LOG DROP #####################
# By default, do not permit remote connections to X11
echo "block return in on ! lo0 proto tcp to port 6000:6010" >> "$rule_file"
# Port build user does not need network
echo "block return out log proto {tcp udp} user _pbuild" >> "$rule_file"
################   BLOCK EVERYTHING  ########################
### Drop all remaining traffic
echo "block quick all" >> "$rule_file" 

################### BLOCK ALL TRAFFIC #####################
#echo "block in quick on "$int_if" all ">> "$rule_file" 
#echo "block in quick on "$lo_if" all ">> "$rule_file"
 
#echo "block out quick on "$int_if" all ">> "$rule_file" 
#echo "block out quick on "$lo_if" all ">> "$rule_file" 

##############  LOAD THE FILE  #################
pfctl -f "$rule_file"
## backup previous config file
cp "$config_file" "$backup_file"
## replace config file with new rules
cp "$rule_file" "$config_file"

echo "ENDWALL BSD LOADED"

#############################     PRINT ADDRESSES    ########################################################################
echo "GATEWAY    :      MAC:"$gateway_mac"  IPv4:"$gateway_ip" " 
echo "INTERFACE_1: "$int_if"  MAC:"$int_mac"   IPv4:"$int_ip" "

}

################# LOCAL HOST FUNCTIONS ##########################

lo_open()
{
protocol=$1
lo_port=$2

echo "pass out quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port "$lo_port" to "$lo_ip" port "$lo_port" " >> "$rule_file"
echo "pass out quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port "$lo_port" to "$lo_ip" port !="$lo_port" " >> "$rule_file"
echo "pass out quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port !="$lo_port" to "$lo_ip" port "$lo_port" " >> "$rule_file"

echo "pass in quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port "$lo_port" to "$lo_ip" port "$lo_port" " >> "$rule_file"
echo "pass in quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port "$lo_port" to "$lo_ip" port !="$lo_port" " >> "$rule_file"
echo "pass in quick on "$lo_if" inet proto "$protocol" from "$lo_ip" port !="$lo_port" to "$lo_ip" port "$lo_port" " >> "$rule_file"

}


icmp_lo_type()
{
protocol=icmp
type=$1
echo "pass out quick on "$lo_if" inet proto "$protocol" from "$lo_ip" to any icmp-type "$type" " >> "$rule_file"
echo "pass in quick on "$lo_if" inet proto "$protocol" from any to "$lo_ip" icmp-type  "$type" max-pkt-rate "100/10" " >> "$rule_file"

}


################ CLIENT OUTBOUND FUNCTIONS ######################

client_out()
{
protocol=$1
port1=$2

echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port "$port1" keep state" >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port !="$port1" keep state" >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port !="$port1" to any port "$port1" keep state" >> "$rule_file"

}

client_out_ks()
{
protocol=$1
port1=$2

echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port "$port1" keep state ( max 100, source-track rule, max-src-nodes 150, max-src-states 20, tcp.established 200, tcp.closing 10 )" >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port !="$port1" keep state ( max 100, source-track rule, max-src-nodes 150, max-src-states 20, tcp.established 200, tcp.closing 10 )" >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port !="$port1" to any port "$port1" keep state ( max 100, source-track rule, max-src-nodes 150, max-src-states 20, tcp.established 200, tcp.closing 10 )" >> "$rule_file"

}

client_out_x()
{
protocol=$1
port1=$2

echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port "$port1" keep state " >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port !="$port1" keep state " >> "$rule_file"

#echo "pass in quick on "$int_if" inet proto "$protocol" from any port !="$port1" to "$int_ip" port "$port1" keep state " >> "$rule_file"
#echo "pass in quick on "$int_if" inet proto "$protocol" from any port "$port1" to "$int_ip" port "$port1" keep state " >> "$rule_file"

}


bootp()
{
protocol=$1
port1=$2

echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port "$port1" keep state" >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" from any port "$port1" to "$int_ip" port "$port1" keep state " >> "$rule_file"

echo "pass in quick on "$int_if" inet proto "$protocol" from any  port "$port1" " to "$int_ip" port "$port1 keep state " >> "$rule_file"
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" port "$port1" to any port "$port1"  keep state " >> "$rule_file"

}

icmp_out_all()
{
protocol=icmp
type=$1
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" to any keep state" >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" from any to "$int_ip" max-pkt-rate "100/10" keep state (max 100, source-track rule, max-src-nodes 75, max-src-states 3, tcp.established 60, tcp.closing 5 ) " >> "$rule_file"
}

icmp_out_type()
{
protocol=icmp
type=$1
echo "pass out quick on "$int_if" inet proto "$protocol" from "$int_ip" to any icmp-type "$type" keep state " >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" from any to "$int_ip" icmp-type "$type" max-pkt-rate "100/10" keep state ( max 100, source-track rule, max-src-nodes 75, max-src-states 3, tcp.established 360, tcp.closing 10 ) " >> "$rule_file"
}

icmp_out_type2(){
protocol=icmp
type=$1
echo "pass out quick on "$int_if" inet proto "$protocol" all icmp-type "$type" " >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" all icmp-type "$type" max-pkt-rate "100/10" keep state ( max 100, source-track rule, max-src-nodes 75, max-src-states 3, tcp.established 360, tcp.closing 10 ) " >> "$rule_file"
}


###############  SERVER INBOUND FUNCTIONS ######################

## For external WAN clients
server_in()
{
protocol=$1
port1=$2

### Same port connection port to same port
## echo "pass in quick on "$int_if" inet proto "$protocol" from any port "$port1" " to "$int_ip" port "$port1" keep state " >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" from any port "$port1" to "$int_ip" port "$port1" max-pkt-rate "100/10" keep state ( max 100, source-track rule, max-src-nodes 75, max-src-states 3, tcp.established 60, tcp.closing 5 ) " >> "$rule_file"

##  Connection to your server port from not same client port 
## echo "pass in quick on "$int_if" inet proto "$protocol" from any port !="$port1" to "$int_ip" port "$port1" keep state " >> "$rule_file"
echo "pass in quick on "$int_if" inet proto "$protocol" from any port !="$port1" to "$int_ip" port "$port1" max-pkt-rate "100/10" keep state ( max 100, source-track rule, max-src-nodes 75, max-src-states 3, tcp.established 60, tcp.closing 5 ) " >> "$rule_file"

}

### for internal LAN clients where you know the connecting IP 
server_in_int()
{
protocol=$1
port1=$2
client_ip=$3

## port to same port connections
echo "pass in quick on "$int_if" inet proto "$protocol" from "$client_ip" port "$port1" to "$int_ip" port "$port1"  " >> "$rule_file"
## port to different port conenctions
echo "pass in quick on "$int_if" inet proto "$protocol" from "$client_ip" port !="$port1" to "$int_ip" port "$port1" " >> "$rule_file"

}

### make a function for mac address binding for LAN clients

######################  END OF FUNCTIONS ######################################


####################### MAIN PROGRAM ######################### 
if [ "$1" = "-d" ]
then 
default
else
endwall_main
fi

date

exit 0

############################### END OF FILE ######################################
