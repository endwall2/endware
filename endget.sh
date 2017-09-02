#!/bin/sh
#################################################################################################################################################
# NAME: endget.sh
# TYPE: BOURNE SHELL SCRIPT
# DESCRIPTION: Download file using wget torsocks,and 
#              a random user agent
#
# AUTHOR:  THE ENDWALL DEVELOPMENT TEAM
# CREATION DATE: APRIL 9 2016
# VERSION: 0.17
# REVISION DATE: OCTOBER 23 2016
# COPYRIGHT: THE ENDWALL DEVELOPMENT TEAM, 2016
#
# CHANGE LOG:  - Header bug fix
#              - torsocks -i --isolate on main download 
#              - Rewrite of input checking section, --uarand, --no-header, --no-agent flags
#              - Added USERAGENTS path variable + default to first line of user_agents.txt
#              - Moved user agents to user_agents.txt 
#              - Default to torbrowser UA + -r flag for random UA + torbrowser header
#              - Updated user agents
#              - Forked from endloads
#              - Added extra user-agents
#              - Forked from endtube
#
########################################################################################################################################
# DEPENDENCIES: torsocks,wget,od,head,urandom,sleep
########################################################################################################################################
# INSTRUCTIONS: Make a bin directory in ~/ add it to the path. Copy this file there and make executable.
#               Start the TOR daemon. Execute the script in the ~/Download/videos/ directory.    
#   
#  Do the following at a command prompt
#
#  $  mkdir ~/bin
#  $  chmod u+wrx endtube.sh
#  $  cp endtube.sh ~/bin/endget
#  $  export PATH=$PATH:~/bin
#  $  cd Downloads
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
#     Run EndLoads 
#  $  endget http://www.website.com/coolfile.tar
#  # use random user agent
#  $  endget --uarand http://www.website.com/coolfile.tar 
#  # turn off usr agent
#  $  endget --no-agent http://www.website.com/coolfile.tar  
#  # turn off user header
#  $ endget --no-header http://www.website.com/coolfile.tar  
#  # turn off header, agent, add other wget flags afterwards
#  $ endget --no-header --no-agent http://www.website.com/coolfile.tar  
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
#  BEGINNING OF LICENSE AGREEMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.15
#  VERSION DATE: JULY 05, 2017
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2017
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
#        dignitary, ambassador, legislator,congressional representative, member of parliament, senator, judicial official, judge, prosecutor, lawyer, 
#        noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
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
#####################################################     BEGINNING OF PROGRAM      #####################################################################################

########  VERSION INFORMATION  ###################
version="0.17"
branch="gnu/linux"
rev_date="23/10/2016"
##################################################

#change this to whatever path/file you what to use as your user agents file
USERAGENTS=$HOME/bin/user_agents.txt 

headmode="on"
uamode="on"
state="normal"

##  get input list from shell argument 

nargs=$#

for arg in $@
do 

 if [ "$arg" == "--help" ]
 then
 echo "ENDGET: download files remotely using wget, tor, torsocks, random user-agents"
 echo "endget http://www.website.com/index.html"
 echo "endget --uarand http://www.website.com/index.html ## random user-agent"
 echo "endget --help ## usage statements"
 echo "endget --version ## version information"
 echo "Type: wget --help for more options to add before the link"
 echo "endget --no-header --no-agent www.website.com  ## is equivalent to torsocks curl website.com "
 echo "type wget --help for more options to add before the web link"
 shift
 exit 0
 elif [ "$arg" == "--version" ]
 then
 echo "ENDGET: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
 echo "Copyright: The Endware Development Team, 2016"
 shift
 exit 0
 elif [ "$arg" == "--uarand" ]
 then
 state="rand"
 uamode="on"
 shift
 elif [ "$arg" == "--no-agent" ]
 then
 uamode="off"
 shift 
 elif [ "$arg" == "--no-header" ]
 then
 headmode="off"
 shift  
 fi 

 link="$arg"

done

if [ "$state" == "rand" ]
then
#select random user agent
UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 )  
else 
UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
fi

HEAD="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\Accept-Language: en-US,en;q=0.5\Accept-Encoding: gzip, deflate\Connection: keep-alive"

HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"

echo "$UA"

echo "Downloading "$link""
echo "UAMODE="$uamode" STATE="$state" HEADMODE="$headmode" "

if [ "$uamode" == "on" ]
then 
echo "$UA"
 if [ "$headmode" == "on" ]
 then 
 # initate curl download +tor + random agent
 torsocks -i wget --user-agent="$UA" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" "$@" 
 else
 torsocks -i wget --user-agent="$UA" "$@" 
 fi
else 
 torsocks -i wget "$@"
fi 

exit "$?"
#########################################################        END OF PROGRAM         ######################################################################################
