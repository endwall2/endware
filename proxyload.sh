#!/bin/sh
#################################################################################################################################################
# NAME: proxyload.sh
# TYPE: BOURNE SHELL SCRIPT
# DESCRIPTION: Fetch fresh ssl and socks5 proxies for use with endtube.
#
# AUTHOR:  ENDWALL DEVELOPEMENT TEAM
# CREATION DATE: JUNE 15 2016
# VERSION: 0.07
# REVISION DATE: JULY 21 2016
# 
# CHANGE LOG:  - Updated user agents
#              - Fixed instructions
#              - Removed unused code and annotated code
#              - Simplified grep chain, abstracted website names to variables 
#              - Added wildcard numbers for grep
#              - Added ssl proxies and socks proxies  
#              - Forked from endcurl
#
########################################################################################################################################
# DEPENDENCIES: tor,torsocks,curl,od,head,urandom,sleep,grep
########################################################################################################################################
# INSTRUCTIONS: Make a bin directory in ~/ add it to the path. Copy this file there and make executable.
#               Start the TOR daemon. Execute the script.    
#   
#  Do the following at a command prompt
#  $  wget http://ix.io/VTZ
#  $  cp VTZ proxyload.sh
#  $  mkdir ~/bin
#  $  chmod u+wrx proxyload.sh
#  $  cp proxyload.sh ~/bin/proxyload
#  $  export PATH=$PATH:/home/$USER/bin
# 
#  START TOR DAEMON:
#     SYSTEMD:
#  $ sudo systemctl start tor
#  $ sudo systemctl status tor
#     OPENRC:
#  $ sudo rc-update add tor default
#  $ sudo rc-service start tor
#  $ sudo rc-status
#    STAND ALONE:
#  $ tor_alpha &
#      
#     Run ProxyLoad 
#  $ proxyload
#  
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
#####################################################        BEGINNING OF PROGRAM      #####################################################################################
##  get input list from shell argument 

nargs="$#"

## proxy list websites
ssl_site="http://sslproxies24.blogspot.com"
socks_site="http://www.vipsocks24.net"

## remove .com .net ending 
ssl_site_rt=$( echo "$ssl_site" | cut -d . -f 1,2 | awk '{print $1}' )
socks_site_rt=$( echo "$socks_site" | cut -d . -f 1,2 | awk '{print $1}' )

## temporary files to store downloads
holder_1=temp_1.txt
holder_2=temp_2.txt
holder_3=temp_3.txt

#select random user agent
 
# pick a random user agent
n=$( expr $(head -c 2 /dev/urandom | od -A n -i) % 126  | awk '{print $1}')
# set the user agent
#echo "$n"

if [ "$n" -le "9" ]
then 
UA="Mozilla/5.0 (Windows NT 6.1; rv:4$n.0) Gecko/20100101 Firefox/4$n.0"
else 
 case $n in 
## Firefox Windows NT
 ( 10 ) UA="Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0" ;;
 ( 11 ) UA="Mozilla/5.0 (Windows NT 6.1; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
 ( 12 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0" ;;
 ( 13 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 14 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 15 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 16 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 17 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 18 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 19 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 20 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0" ;; 
 ( 21 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0" ;; 
 ( 22 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 23 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 24 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 25 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 26 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 27 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 28 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 29 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 30 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
 ( 31 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 32 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 33 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 34 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 35 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 36 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 37 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 38 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 39 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
 ( 40 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 41 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 42 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 43 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 44 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 45 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 46 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 47 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 48 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
 ( 49 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 50 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 51 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 52 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 53 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 54 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 55 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 56 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 57 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
 ( 58 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 59 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 60 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 61 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 62 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 63 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 64 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 65 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 66 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
## Firefox Mac
 ( 67 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:41.0) Gecko/20100101 Firefox/41.0" ;;
 ( 68 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:42.0) Gecko/20100101 Firefox/42.0" ;;
 ( 69 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:43.0) Gecko/20100101 Firefox/43.0" ;;
 ( 70 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:44.0) Gecko/20100101 Firefox/44.0" ;;
 ( 71 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0) Gecko/20100101 Firefox/45.0" ;;
 ( 72 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:46.0) Gecko/20100101 Firefox/46.0" ;;
 ( 73 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0" ;;
 ( 74 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:48.0) Gecko/20100101 Firefox/48.0" ;;
 ( 75 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:49.0) Gecko/20100101 Firefox/49.0" ;;
 ( 76 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:50.0) Gecko/20100101 Firefox/50.0" ;;
## Chrome NT
 ( 77 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;
 ( 78 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;
 ( 79 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;
 ( 80 ) UA="Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;
 ( 81 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36" ;;
 ( 82 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36" ;;
 ( 83 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36" ;;
 ( 84 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36" ;;
 ( 85 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36" ;;
 ( 86 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36" ;;
 ( 87 ) UA="Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.75 Safari/537.36" ;; 
 ( 88 ) UA="Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.75 Safari/537.36" ;; 
 ( 89 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.75 Safari/537.36" ;; 
## Chrome Mac
 ( 90 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;          
 ( 91 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36" ;;   
 ( 92 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36" ;;
 ( 93 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36" ;;  
 ( 94 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.75 Safari/537.36" ;;
## Opera 
 ( 95 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41" ;;  
 ( 96 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41" ;;
 ( 97 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41" ;;
 ( 98 ) UA="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36 OPR/38.0.2220.31" ;;  
 ( 99 ) UA="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36 OPR/38.0.2220.31" ;; 
 ( 100 ) UA="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36 OPR/38.0.2220.31" ;;
## Safari Mac
 ( 101 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/601.4.2 (KHTML, like Gecko) Version/9.0.3 Safari/601.4.2" ;;
 ( 102 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/601.4.4 (KHTML, like Gecko) Version/9.0.3 Safari/601.4.4" ;;
 ( 103 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17" ;;
 ( 104 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.14 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.14" ;;
 ( 105 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.1 (KHTML, like Gecko) Version/9.1 Safari/601.5.17" ;;  
 ( 106 ) UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.7 (KHTML, like Gecko) Version/9.1.2 Safari/601.7.7" ;;
## Safari iPhone
 ( 107 ) UA="Mozilla/5.0 (iPhone; CPU iPhone OS 9_2_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13D15 Safari/601.1" ;;
 ( 108 ) UA="Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E237 Safari/601.1" ;;
 ( 109 ) UA="Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E238 Safari/601.1" ;;
 ( 110 ) UA="Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.32 (KHTML, like Gecko) Version/10.0 Mobile/14A5261v Safari/602.1" ;;
 ( 111 ) UA="Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A5297c Safari/602.1" ;;
## Safari iPad
 ( 112 ) UA="Mozilla/5.0 (iPad; CPU OS 9_2 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13C75 Safari/601.1" ;;
 ( 113 ) UA="Mozilla/5.0 (iPad; CPU OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1" ;;
 ( 114 ) UA="Mozilla/5.0 (iPad; CPU OS 9_3_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E238 Safari/601.1" ;;
 ( 115 ) UA="Mozilla/5.0 (iPad; CPU OS 10_0 like Mac OS X) AppleWebKit/602.1.32 (KHTML, like Gecko) Version/10.0 Mobile/14A5261v Safari/602.1" ;;
## MS Edge
 ( 116 ) UA="Mozilla/5.0 (Windows NT 6.4; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36 Edge/12.0" ;; 
 ( 117 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.9600" ;; 
 ( 118 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240" ;; 
 ( 119 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10547" ;;
 ( 120 ) UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64; Xbox; Xbox One) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586" ;;
 ( 121 ) UA="Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; NOKIA; Lumia 735) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Mobile Safari/537.36 Edge/12.0" ;;
## MS IE 9.0
 ( 122 ) UA="Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)" ;;
 ( 123 ) UA="Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)" ;;
 ( 124 ) UA="Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0)" ;;
## Gaming Consoles
 ( 125 ) UA="Mozilla/5.0 (PLAYSTATION 3 4.80) AppleWebKit/531.22.8 (KHTML, like Gecko)" ;; 

 esac
fi
 
echo "$UA"

echo "Downloading SSL Proxies"

cc="com"
torsocks curl -A "$UA" "$ssl_site_rt"."$cc" | grep "Free" | grep "html" | grep -v "title" >> "$holder_1" 

## while loop to pick up country code
cc=" "
while [ "$cc" == " " ];do
cc=$(torsocks curl -A "$UA" "$ssl_site" | grep "The document"  | cut -d / -f 3 | cut -d . -f 3 )
sleep 1
done
echo "Country Code is "$cc" "

## get the URLs hosting the proxy lists and parse

torsocks curl -A "$UA" "$ssl_site_rt"."$cc" | grep "Free" | grep "html" | grep -v "title" >> "$holder_1" 

cut -d '>' -f 1 "$holder_1" | cut -d ':' -f 2 | cut -d '.' -f 3 | sort -u > "$holder_2"

## download the proxies then numeric sort and remove duplicates
for link in $(cat "$holder_2") ; do
torsocks curl -A "$UA" "$ssl_site_rt"."$link".html| grep "[0123456789]:[123456789][0123456789]" >> "$holder_3"
done 

sort -nu "$holder_3" >> ssl_proxies.txt

## remove temporary files
rm "$holder_1"
rm "$holder_2"
rm "$holder_3"

echo "Downloading Socks5 Proxies"

## get the URLs hosting the proxy lists and parse
cc="net"
torsocks curl -A "$UA" "$socks_site_rt"."$cc" | grep "VIP" | grep "html" | grep -v "title" > "$holder_1" 
cut -d '>' -f 1 "$holder_1" | cut -d ':' -f 2 | cut -d '.' -f 3 > "$holder_2"

## Download the proxies then numeric sort and remove duplicates
for link in $(cat "$holder_2") ; do
torsocks curl -A "$UA" "$socks_site_rt"."$link".html| grep -ah "[0123456789]:[123456789][0123456789]" >> "$holder_3"
done 

sort -nu "$holder_3" >> socks_proxies.txt

## remove temporary files
rm "$holder_1"
rm "$holder_2"
rm "$holder_3"

exit 0
#########################################################        END OF PROGRAM         ###################################################################################
