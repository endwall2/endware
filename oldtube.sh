#!/bin/sh
#################################################################################################################################################
# NAME: oldtube.sh
# TYPE: BOURNE SHELL SCRIPT
# DESCRIPTION: Downlods youtube video files from an input video url list
#              and an input proxy url list, by randomizing lists, randomizing timing   
#              and anonymously using youtube-dl, torsocks, and the proxy
#
# AUTHOR:  THE ENDWARE DEVELOPMENT TEAM
# CREATION DATE: APRIL 9, 2016
# VERSION: 0.01
# REVISION DATE: FEBRUARY 04, 2016
# COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016 
#
# CHANGE LOG: 
#              - Forked from endtube.sh return to simplicity for tor (fit in to the crowd) purists
#              - --ua-ranstr random string user agent --ua-rand, --refer-rand, --refer-ranstr, --refer-grab 
#              - turn off automatic rerferer mode if --referer option is called
#              - collect referers from grab process into $REFERERS + update --help
#              - revert to site root as default referer + --grab-refer, --rand-refer, --ranstr-refer options
#              - bug fix rm $proxies 
#              - test -s to check json filesize after download + quotations on variables
#              - bug fix missing "$", + random delay between json download and actual download + bug fix rm json 
#              - While loop to ensure json downloads
#              - Don't pull referer (video upload channel) if --no-refer + check if youtube (multi case switch)  
#              - bug fix for "null" uploader id
#              - referer bug fix for if pull fails ( default to site root) 
#              - referer protocol bug fix
#              - Accept-Charset header added ( not used yet)
#              - fixed referer using json dump for youtube videos 
#              - added referer
#              - --exitnode bug fix + gunzip unpack optimization
########################################################################################################################################
# DEPENDENCIES: torsocks,youtube-dl,od,head,urandom,sleep,curl,geoiplookup,shuf
########################################################################################################################################
# INSTRUCTIONS: Make a bin directory in ~/ add it to the path. Copy this file there and make executable.
#               Make a videos directory in Downloads.  Get some download links, and some proxies place in separte text files.
#               Start the TOR daemon. Execute the script in the ~/Download/videos/ directory.    
#   
#  Do the following at a command prompt
#
#  $  mkdir ~/bin
#  $  chmod u+wrx endtube.sh
#  $  cp endtube.sh ~/bin/endtube
#  $  export PATH=$PATH:~/bin
#  $  cd Downloads
#  $  mkdir videos
#  $  cd videos
#  $  emacs/nano/leafpad etc  ytlinks.txt  
#
#     Populate list of youtube links into the file ytlinks.txt by right click and paste into the file in a column
#     save ytlinks.txt and exit editor.
# 
#  START TOR DAEMON:
#     SYSTEMD:
#  $ sudo systemctl start tor
#  $ sudo systemctl status tor
#     OPENRC:
#  $ sudo rc-update add tor default
#  $ sudo rc-service start tor
#  $ sudo rc-status
#      
#     Run EndTube 
#  $  oldtube --list ytlinks.txt
#  $  oldtube --uarand --list ytlinks.txt
#  $  oldtube --uaranstr --list ytlinks.txt
#  $  oldtube --exitnode --list ytlinks.txt
#  $  oldtube --uarand --exitnode --list ytlinks.txt
#  $  oldtube --exitnode --uarand --list ytlinks.txt
#  $  oldtube --native --list ytlinks.txt
#  $  oldtube --url http://www.youtu.be/aa3gagacJGe
#  $  oldtube http://www.youtu.be/aa3gagacJGe
#  Using with Proxies:
#  $ emacs/nano/leafpad etc proxies.txt    
#     
#     You will require at least 4 fresh https proxies for operation, get as many as possible
#     Populate the list of proxies from a fresh proxy source, save the list and test the proxies using
#     proxies must be in the file in format protocol://ipv4address:port 
#     eg. https://5.3.55.125:8080, can also be just  5.4.55.125:8080
#
#  $  torsocks curl --proxy protocol://ipv4address:port www.google.com
#
#     Run EndTube
#  $  oldtube --list ytlinks.txt
#  $  oldtube --uarand --list ytlinks.txt
#  $  oldtube --uaranstr --list ytlinks.txt
#  $  oldtube --exitnode --list ytlinks.txt
#  $  oldtube --uarand --proxylist proxies.txt --list ytlinks.txt
#  $  oldtube --exitnode --proxylist proxies.txt --list ytinks.txt 
#  $  oldtube --exitnode --uarand --proxylist proxies.txt --list ytinks.txt 
#  $  oldtube --uarand --exitnode --proxylist proxies.txt --list ytinks.txt
#  $  oldtube --proxylist proxies --url http://www.youtu.be/aa3gagacJGe
#  $  oldtube --grab-refer --list ytlinks   # grab the video uploader channel as referer
#  $  oldtube --no-refer --list ytlinks   # no referer string
#  $  oldtube --ranstr-refer --list ytlinks   # website based on random string as referer
#  $  oldtube --rand-refer --list ytlinks   # referer random selected from $REFERERS as referer
#  $  oldtube --help
#  $  oldtube --version 
#
#############################################################################################################################################################################
#                                         ACKNOWLEDGMENTS
#############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, and SnakeDude who graciously hosted and promoted this software project. 
#  We would also like to acknowledge the work and efforts of Stephen Lynx, the creator and maintainer of LynxChan.  
#  Without their efforts and their wonderful web site www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, SnakeDude, and Stephen Lynx for inspiring this work and for hosting and promoting it. 
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
#  VERSION: 1.12 
#  VERSION DATE: AUGUST 11, 2016
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
#        dignitary, ambassador, noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any gender, including men, women, and any other gender not mentioned.       
#  1) e) This program may be used by anyone of any affiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any person of any race, ethnicity, identity, origin, genetic makeup, physical appearance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, sub-sea, in a submarine, underground,
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
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or salable goods.
#  6) a) Any user of this program is granted the freedom to modify and improve the code.
#  6) b) When modified or improved, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or salable goods.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procure a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procure a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intellectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#      b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  WHO GRANTS THESE FREEDOMS ?
#  12) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team", as well as ancillary contributors, and user modifiers and developers of the software. 
#  13) The aforementioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  14)  This software is distributed "as is" without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
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
#  18)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) h) are presented to clarify 1 a) and to enforce non-discrimination and non-exclusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################
#####################################################        BEGINNING OF PROGRAM      #####################################################################################
# version information
version="0.01"
branch="gnu/linux"
rev_date="10/02/2017"

# user agents file
USERAGENTS="$HOME/bin/user_agents.txt"
REFERERS="$HOME/bin/referers.txt"

# min delay max delay time between downloads
min_delay=30
max_delay=600

## initial flag switch states
enode="off"
headmode="on"
uamode="off"
refmode="off"
reftype="root"
state="normal"
syntax="check"
listmode="no"
urlmode="no"

##  get input list from shell argument 
for arg in $@
do 

 if [ "$proxypick" == "on" ]
 then 
 Punsort="$arg"
 proxypick="off"
 shift
 elif [ "$listpick" == "on" ]
 then
 Lunsort="$arg"
 listpick="off"
 listmode="yes"
 shift 
 elif [ "$urlpick" == "on" ]
 then
 url="$arg"
 urlpick="off"
 urlmode="yes"
 shift 
 fi 

 if [ "$arg" == "--help" ]
 then
 echo "OLDTUBE: Download videos using tor and youtube-dl, random user-agents and proxies"
 echo " "
 echo "USAGE:  oldtube --option --option --list list.txt" 
 echo "oldtube --help    # print usage information"
 echo "oldtube --version # print version information"
 echo "oldtube --list list.txt # default mode downloads videos in list.txt"
 echo "oldtube --ua-rand --list list.txt  # per video download random user-agent"
 echo "oldtube --ua-ranstr --list list.txt  # per video download random string user-agent"
 echo "oldtube --ua-tor --list list.txt  # per video download tor-browsesr user-agent"
 echo "oldtube --ua-row1 --list list.txt  # per video download user-agent from user_agents.txt row 1"
 echo "oldtube --exitnode --list list.txt # check exit-node pull per download"
 echo "oldtube --proxylist plist.txt --list list.txt  # use random proxies from plist.txt " 
 echo "oldtube --url https://youtu.be/gGHeoahhe   # Download the provided url"
 echo "oldtube https://youtu.be/gGHeoahhe   # Download the url (assume last input is a url)"
 echo " "
 echo "Type: youtube-dl --help for more options to add after the --list list.txt option to pass through to youtube-dl"
 shift 
 exit 0
 elif [ "$arg" == "--version" ]
 then
 echo "OLDTUBE: version "$version", branch: "$branch", revision date: "$rev_date" "
 echo "Copyright: 2017, THE ENDWARE DEVELOPMENT TEAM" 
 shift
 exit 0


 elif [ "$arg" == "--ua-rand" ]
 then
 state="rand"
 uamode="on"
 syntax="good"
 shift
 elif [ "$arg" == "--ua-ranstr" ]
 then
 state="ranstr"
 uamode="on"
 syntax="good"
 shift
 elif [ "$arg" == "--ua-tor" ]
 then
 state="tor"
 uamode="on"
 syntax="good"
 shift
 elif [ "$arg" == "--ua-row1" ]
 then
 state="row1"
 uamode="on"
 syntax="good"
 shift
 elif [ "$arg" == "--referer" ]
 then
 refmode="off"
 syntax="good"
 elif [ "$arg" == "--refer-rand" ]
 then
 refmode="on"
 reftype="rand"
 syntax="good"
 shift 
 elif [ "$arg" == "--refer-ranstr" ]
 then
 refmode="on"
 reftype="ranstr"
 syntax="good"
 shift 
 elif [ "$arg" == "--exitnode" ]
 then
 enode="on"
 syntax="good"
 shift  
 elif [ "$arg" == "--proxylist" ]
 then
 proxies="on"
 proxypick="on"
 syntax="good"
 shift
 elif [ "$arg" == "--list" ]
 then
 listpick="on"
 syntax="good"
 shift
 elif [ "$arg" == "--url" ]
 then
 urlpick="on"
 syntax="good"
 shift
 fi  

arghold="$arg"
 
done

check_tor=check_tor.tmp
json_dump=json.tmp
json_unpack=json.col

# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0"
# define default headers

HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: close"
HEAD5="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"

## Assume final argument is a url and begin download
if [ "$listmode" == "no" ]
then
  

 if [ "$uamode" == "on" ]
 then
   if [ "$state" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$state" == "ranstr" ]
   then 
    # make a random string as the user agent 
    bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
    UA="$( head -c 2 /dev/urandom | base64 -i | cut -d "=" -f 1 | cut -d "+" -f 1 | cut -d "/" -f 1 )"
   elif [ "$state" == "tor" ] 
   then
   UA="$UA_torbrowser" 
   elif [ "$state" == "row1" ] 
   then
   UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
   UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   fi 
 fi


  if [ "$enode" == "on" ] 
  then
    # check tor project ip
    torsocks wget -T 60 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" -O "$check_tor".gz https://check.torproject.org/ 
    torsocks wget -T 30 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" https://check.torproject.org/torcheck/img/tor-on.png 
    torsocks wget -T 30 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" https://check.torproject.org/torcheck/img/tor-on.ico 
    
    gunzip "$check_tor".gz    

    exit_address=$(grep -ah "Your IP" $check_tor | awk 'BEGIN {FS=">"} {print $3}' | awk 'BEGIN {FS="<"} {print $1}' )
    echo "TOR exit node is "$exit_address" "
    geoiplookup "$exit_address" 
    rm $check_tor
    rm tor-on.png
    rm tor-on.ico
    # generate a random number time delay
    delay=$( expr 5 + $(head -c 2 /dev/urandom | od -A n -i) % 30 | awk '{print $1}')
    echo "Delaying download for "$delay" seconds"
    # wait by delay time
    sleep "$delay"
  fi 

  if [ "$urlmode" == "yes" ]
  then
  echo "Downloading "$url""

    site_root=$( echo "$url" | cut -d "/" -f 3 )
    web_proto=$( echo "$url" | cut -d "/" -f 1 )
    
    if [ "$proxies" == "on" ]
    then
     # randomly sort proxies and load the random proxy
     Prxy=$( shuf -n 1 "$Punsort" )
     echo "Random Proxy is" "$Prxy" 
     proxy_ip=$( echo "$Prxy" | cut -d / -f 3 | cut -d : -f 1 )
     geoiplookup "$proxy_ip"
      if [ "$uamode" == "on" ]
      then 
      echo "user-agent=" "$UA"    
      torsocks -i youtube-dl --user-agent "$UA" --proxy "$Prxy" "$url"
      else
      torsocks -i youtube-dl --proxy "$Prxy" "$url"
      fi
    else
      if [ "$uamode" == "on" ]
      then 
         echo "user-agent=" "$UA"    
         youtube-dl --proxy socks5://127.0.0.1:9050 --user-agent "$UA" "$url"  
      else
         youtube-dl --proxy socks5://127.0.0.1:9050 "$url"        
      fi     
    fi
  else

    echo "Downloading "$arghold""
    
    site_root=$( echo "$arghold" | cut -d "/" -f 3 )
    web_proto=$( echo "$arghold" | cut -d "/" -f 1 )
    
   if [ "$proxies" == "on" ]
    then
     # randomly sort proxies and load the random proxy
     Prxy=$( shuf -n 1 "$Punsort" )
     echo "Random Proxy is" "$Prxy" 
     proxy_ip=$( echo "$Prxy" | cut -d / -f 3 | cut -d : -f 1 )
     geoiplookup "$proxy_ip"
      if [ "$uamode" == "on" ]
      then 
      echo "user-agent=" "$UA"    
      torsocks -i youtube-dl --user-agent "$UA" --proxy "$Prxy" "$@"
      else
      torsocks -i youtube-dl --proxy "$Prxy" "$@"
      fi
    else
      if [ "$uamode" == "on" ]
      then 
         echo "user-agent=" "$UA"    
         youtube-dl --proxy socks5://127.0.0.1:9050 --user-agent "$UA" "$@"  
      else
         youtube-dl --proxy socks5://127.0.0.1:9050 "$@"        
      fi     
    fi
  fi

 date

exit "$?"
 
else


# randomly sort the video list
list=tubesort.tmp
shuf $Lunsort > $list

#main loop for list based downloading to select random user agent

for link in $(cat "$list" ); do  

  site_root=$( echo "$link" | cut -d "/" -f 3 )
  web_proto=$( echo "$link" | cut -d "/" -f 1 )

  if [ "$site_root" == "www.youtube.com" ]
  then 
  youtube_site="yes"
  elif [ "$site_root" == "youtube.com" ]
  then 
  youtube_site="yes"
  elif [ "$site_root" == "wwww.youtu.be" ]
  then 
  youtube_site="yes"
  elif [ "$site_root" == "youtu.be" ]
  then 
  youtube_site="yes"
  else 
  youtube_site="no"
  fi   


 if [ "$uamode" == "on" ]
 then
   if [ "$state" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$state" == "ranstr" ]
   then 
    # make a random string as the user agent 
    bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
    UA="$( head -c 2 /dev/urandom | base64 -i | cut -d "=" -f 1 | cut -d "+" -f 1 | cut -d "/" -f 1 )"
   elif [ "$state" == "tor" ]
   then 
   UA="$UA_torbrowser" 
   elif [ "$state" == "row1" ] 
   then
   UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
   UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   fi 
 fi

  # generate a random number time delay
  delay=$( expr "$min_delay" + $(head -c 2 /dev/urandom | od -A n -i ) % $( expr "$max_delay" - "$min_delay" )  | awk '{print $1}')
  echo "Delaying download for "$delay" seconds"
  # wait by delay time
  sleep "$delay"

  if [ "$enode" == "on" ] 
  then
  # check tor project ip
  torsocks wget -T 60 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" -O "$check_tor".gz https://check.torproject.org/ 
  torsocks wget -T 30 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" https://check.torproject.org/torcheck/img/tor-on.png 
  torsocks wget -T 30 --secure-protocol=TLSv1 --user-agent="$UA_torbrowser" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" https://check.torproject.org/torcheck/img/tor-on.ico 

  gunzip "$check_tor".gz

  exit_address=$(grep -ah "Your IP" $check_tor | awk 'BEGIN {FS=">"} {print $3}' | awk 'BEGIN {FS="<"} {print $1}' )
  echo "TOR exit node is "$exit_address" "
  geoiplookup "$exit_address" 
  rm $check_tor
  rm tor-on.png
  rm tor-on.ico
  # generate a random number time delay
  delay=$( expr 5 + $(head -c 2 /dev/urandom | od -A n -i) % 60 | awk '{print $1}')
  echo "Delaying download for "$delay" seconds"
  # wait by delay time
  sleep "$delay"
  fi 

  echo "Downloading "$link""
  # initiate download and change user agent

  if [ "$proxies" == "on" ]
  then
    # randomly sort proxies and load the random proxy
    Prxy=$( shuf -n 1 "$Punsort" )
    echo "Random Proxy is" "$Prxy" 
    proxy_ip=$( echo "$Prxy" | cut -d / -f 3 | cut -d : -f 1 )
    geoiplookup "$proxy_ip"
    
    if [ "$uamode" == "on" ]
    then 
      echo "user-agent=" "$UA"
      torsocks -i youtube-dl --user-agent "$UA" --proxy "$Prxy" "$@" "$link"
    else 
     torsocks -i youtube-dl --proxy "$Prxy" "$@" "$link"
    fi
  else 
    if [ "$uamode" == "on" ]
    then 
      echo "user-agent=" "$UA"
      youtube-dl --user-agent "$UA" --proxy socks5://127.0.0.1:9050 "$@" "$link"
    else
      youtube-dl --proxy socks5://127.0.0.1:9050 "$@" "$link"
    fi 
  fi
date

done
# sometimes the download cuts off so don't delete the file until its all done
mv "$list" "$Lunsort"
fi
exit "$?"
#########################################################        END OF PROGRAM         ######################################################################################
