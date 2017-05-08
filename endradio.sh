#! /bin/sh
######################################################################
# Title: endradio.sh
# Description:  Anonymous Tor streaming of internet radio streams using mplayer, torsocks, firejail
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: May 7, 2017
# Version: 0.01
# Revision Date: May 7, 2017
#
# Recent Changes: - forked from endstream 0.26
#                 - Channel menu stays on previous selection + English Channel Rearrange
#####################################################################
# Dependencies: mpv, ffmpeg, read , firejail, curl, torsocks
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endstream.sh ~/bin/endstream
# $ cd ~/bin
# $ chmod u+wrx endstream
# $ export PATH=~/bin:"$PATH"
#
# Run ENDSTREAM
# $ endstream
#
####################################################################
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
#  VERSION: 1.14
#  VERSION DATE: FEBRUARY 11, 2017
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2017
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, posses, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, government official, sovereign, monarch, head of state,
#        dignitary, ambassador, legislator, senator, noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any sex or gender, including men, women, and any other gender not mentioned.       
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
######################################## BEGINNING OF PROGRAM    ##########################################################

###############  VERSION INFORMATION  ##############
version="0.01"
rev_date="07/05/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDRADIO "$version"   =================================================================================="
   echo "||        NEWS         ||      COLUMN 2       ||      COLUMN 3       ||     COLUMN 4    ||   COLUMN 5        ||     COLUMN 6   ||      COLUMN 7      ||"
   echo "==========================================================================================================================================================================="
   echo "1) BBC World Service   41) ---------------  80) ---------------   119) --------------- 159) ---------------  198) ---------------   236) ---------------"    
   echo "2) NPR                 42) ---------------  81) ---------------   120) --------------- 160) ---------------  199) ---------------   237) ---------------" 
   echo "3) MPR News            43) ---------------  82) ---------------   121) --------------- 161) ---------------  200) ---------------   238) --------------- "  
   echo "4) WKSU News           44) ---------------  83) ---------------   122) --------------- 162) ---------------  201) ---------------   239) --------------- "             
   echo "5) Infowars            45) ---------------  84) ---------------   123) --------------- 163) ---------------  202) ---------------   240) --------------- "  
   echo "6) BBC Radio 1         46) ---------------  85) ---------------   124) --------------- 164) ---------------  203) ---------------   241) --------------- "  
   echo "7) BBC Radio 2         47) ---------------  86) ---------------   125) --------------- 165) ---------------  204) ---------------   242) --------------- "
   echo "8) BBC Radio 3         48) ---------------  87) ---------------   126) --------------- 166) ---------------  205) ---------------   243) ---------------"
   echo "9) BBC Radio 4         49) ---------------  88) ---------------   127) --------------- 167) ---------------  206) ---------------   244) ---------------"
   echo "10) BBC Radio 5        50) ---------------  89) ---------------   128) --------------- 168) ---------------  207) ---------------   245) ---------------"
   echo "11) BBC Radio 6        51) ---------------  90) ---------------   129) --------------- 169) ---------------  208) ---------------   246) ---------------"
   echo "12) BBC Radio 1 Extra  52) ---------------  91) ---------------   130) --------------- 170) ---------------  209) ---------------   247) --------------- "
   echo "13) BBC Radio 4 Extra  53) ---------------  92) ---------------   131) --------------- 171) ---------------  209) ---------------   248) ---------------"
   echo "14) BBC Radio Sports   54) ---------------  93) ---------------   132) --------------- 172) ---------------  210) ---------------   249) ---------------"
   echo "15) BBC Radio Asian    55) ---------------  94) ---------------   133) --------------- 173) ---------------  211) ---------------   250) ---------------"  
   echo "16) BBC World Service  56) ---------------  95) ---------------   134) --------------- 174) ---------------  212) ---------------   251) ---------------"
   echo "17) Lounge Radio       57) ---------------  96) ---------------   135) --------------- 175) ---------------  213) ---------------   252) ---------------  "
   echo "18) ---------------    58) ---------------  97) ---------------   136) --------------- 176)---------------   214) ---------------   253) --------------- "	
   echo "19) ---------------    59) ---------------  98) ---------------   137) --------------- 177) ---------------  215) ---------------   254) --------------- "
   echo "20) ---------------    60) ---------------  99) ---------------   138) --------------- 178) ---------------  216) ---------------   255) ---------------"  
   echo "21) ---------------    61) ---------------  100) ---------------  139) --------------- 179) ---------------  217) ---------------   256) --------------- "
   echo "22) ---------------    62) ---------------  101) ---------------  140) --------------- 180) ---------------  219) ---------------   257) ---------------"       
   echo "23) ---------------    63) ---------------  102) ---------------  141) --------------- 180) ---------------  218) ---------------   258) ---------------"  
   echo "24) ---------------    64) ---------------  103) ---------------  142) --------------- 181) ---------------  219) ---------------   259) --------------- "
   echo "25) ---------------    65) ---------------  104) ---------------  143) --------------- 182) ---------------  220) ---------------   260) --------------- " 
   echo "26) ---------------    66) ---------------  105) ---------------  144) --------------- 183) ---------------  221) ---------------   261) ---------------"
   echo "27) ---------------    68) ---------------  105) ---------------  145) --------------- 184) ---------------  222) ---------------   262) --------------- "
   echo "28) ---------------    67) ---------------  106) ---------------  146) --------------- 185) ---------------  223) ---------------   263) ---------------"
   echo "29) ---------------    68) ---------------  107) ---------------  147) --------------- 186) ---------------  224) ---------------   264) --------------- "
   echo "30) ---------------    69) ---------------  108) ---------------  148) --------------- 187) ---------------  225) ---------------   265) ---------------  "    
   echo "31) ---------------    70) ---------------  109) ---------------  149) --------------- 188) ---------------  226) ---------------   266) --------------- "
   echo "32) ---------------    71) ---------------  110) ---------------  150) --------------- 189) ---------------  227) ---------------   267) ---------------"
   echo "33) ---------------    72) ---------------  111) ---------------  151) --------------- 190) ---------------  228) ---------------   268) --------------- " 
   echo "34) ---------------    73) ---------------  112) ---------------  152) --------------- 191) ---------------  229) ---------------   269) --------------- "  
   echo "35) ---------------    74) ---------------  113) ---------------  153) --------------- 192) ---------------  230) ---------------   270) --------------- "
   echo "36) ---------------    75) ---------------  114) ---------------  154) --------------- 193) ---------------  231) ---------------   271) ---------------  "
   echo "37) ---------------    76) ---------------  115) ---------------  155) --------------- 194) ---------------  232) ---------------   272) --------------- "
   echo "38) ---------------    77) ---------------  116) ---------------  156) --------------- 195) ---------------  233) ---------------   273) ---------------"	
   echo "39) ---------------    78) ---------------  117) ---------------  157) --------------- 196) ---------------  234) ---------------   274) --------------- "
   echo "40) ---------------    79) ---------------  118) ---------------  158)---------------  197) ---------------  235) ---------------   275) --------------- "
   echo "========================================================================================================================================================================"
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      ENDRADIO  "$version"   =================================================================================="
   echo "||      LOCATIONS         ||      SUPER         ||         DUPER        ||       MEGA        ||       ULTRA        ||        SAIAJIN        ||      GOD MODE     ||"
   echo "============================================================================================================================================================================"
   echo "276) ---------------      316) -------------   356) ---------------      396) -----------     436) -----------       476) -------------      516) --------------"    
   echo "277) ---------------      317) -------------   357) ---------------      397) -----------     437) -----------       477) -------------      517) --------------" 
   echo "278) ---------------      318) -------------   358) ---------------      398) -----------     438) -----------       478) -------------      518) --------------"  
   echo "279) ---------------      319) -------------   359) ---------------      399) -----------     439) -----------       479) -------------      519) --------------"             
   echo "280) ---------------      320) -------------   360) ---------------      400) -----------     440) -----------       480) -------------      520) --------------"  
   echo "281) ---------------      321) -------------   361) ---------------      401) -----------     441) -----------       481) -------------      521) --------------"  
   echo "282) ---------------      322) -------------   362) ---------------      402) -----------     442) -----------       482) -------------      522) --------------"
   echo "283) ---------------      323) -------------   363) ---------------      403) -----------     443) -----------       483) -------------      523) --------------"
   echo "284) ---------------      324) -------------   364) ---------------      404) -----------     444) -----------       484) ------------       524) --------------"
   echo "285) ---------------      325) -------------   365) ---------------      405) -----------     445) -----------       485) ------------       525) --------------"
   echo "286) ---------------      326) -------------   366) ---------------      406) -----------     446) -----------       486) ------------       526) --------------"
   echo "287) ---------------      327) -------------   367) ---------------      407) -----------     447) -----------       487) ------------       527) --------------"
   echo "288) ---------------      328) -------------   368) ---------------      408) -----------     448) -----------       488) ------------       528) --------------"
   echo "289) ---------------      329) -------------   369) ---------------      409) -----------     449) -----------       489) ------------       529) --------------"
   echo "290) ---------------      330) -------------   370) ---------------      410) -----------     450) -----------       490) ------------       530) --------------"  
   echo "291) ---------------      331) -------------   371) ---------------      411) -----------     451) -----------       491) ------------       531) --------------"
   echo "292) ---------------      332) -------------   372) ---------------      412) -----------     452) -----------       492) -------------      532) --------------"
   echo "293) ---------------      333) -------------   373) ---------------      413) -----------     453) -----------       493) -------------      533) --------------"	
   echo "294) ---------------      334) -------------   374) ---------------      414) -----------     454) -----------       494) -------------      534) --------------"
   echo "295) ---------------      335) -------------   375) ---------------      415) -----------     455) -----------       495) -------------      535) --------------"  
   echo "296) ---------------      336) -------------   376) ---------------      416) -----------     456) -----------       496) -------------      536) --------------"
   echo "297) ---------------      337) -------------   377) ---------------      417) -----------     457) -----------       497) -------------      537) --------------"       
   echo "298) ---------------      338) -------------   378) ---------------      418) -----------     458) -----------       498) -------------      538) --------------"  
   echo "299) ---------------      339) -------------   379) ---------------      419) -----------     459) -----------       499) -------------      540) --------------"
   echo "300) ---------------      340) -------------   380) ---------------      420) -----------     460) -----------       500) -------------      541) --------------"  
   echo "301) ---------------      341) -------------   381) ---------------      421) -----------     461) -----------       501) -------------      542) --------------"
   echo "302) ---------------      342) -------------   382) ---------------      422) -----------     462) ------------      502) -------------      543) --------------"
   echo "303) ---------------      343) -------------   383) ---------------      423) -----------     463) ------------      503) -------------      544) --------------"
   echo "304) ---------------      344) --------------  384) ---------------      424) -----------     464) ------------      504) -------------      545) --------------"
   echo "305) ---------------      345) --------------  385) ---------------      425) -----------     465) ------------      505) -------------      546) --------------"    
   echo "306) ---------------      346) --------------  386) ---------------      426) -----------     466) ------------      506) -------------      547) --------------"
   echo "307) ---------------      347) --------------  387) ---------------      427) -----------     467) ------------      507) -------------      548) --------------"
   echo "308) ---------------      348) --------------  388) ---------------      428) -----------     468) ------------      508) -------------      549) --------------" 
   echo "309) ---------------      349) --------------  389) ---------------      429) -----------     469) ------------      509) -------------      550) --------------"  
   echo "310) ---------------      350) --------------  390) ---------------      430) -----------     470) ------------      510) -------------      551) --------------"
   echo "311) ---------------      351) --------------  391) ---------------      431) -----------     471) ------------      511) -------------      552) --------------"
   echo "312) ---------------      352) --------------  392) ---------------      432) -----------     472) ------------      512) -------------      553) --------------"
   echo "313) ---------------      353) --------------  393) ---------------      433) -----------     473) ------------      513) -------------      554) --------------"	
   echo "314) ---------------      354) --------------  394) ---------------      434) -----------     474) ------------      514) -------------      555) ------------- "
   echo "315) ---------------      355) --------------  395) ---------------      435) -----------     475) ------------      515) -------------      556) ------------- "
   echo "========================================================================================================================================================================"
echo " " 
}	

for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo "ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl mpv using"
   echo "Type in the terminal $ endstream "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endstream --help         # usage messages"
   echo "$ endstream --version      # print version information"
   echo "$ endstream --list-matrix  # channel list in matrix format"
   echo "$ endstream --list-all     # channel list in column format"
   echo "$ endstream  55            # use channel number in command line"  
   echo "$ endstream  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDSTREAM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" == "--list-matrix" ]
   then 
   channel_matrix
   exit 0
   elif [ "$arg" == "--list-all" ]
   then
   more "$chan_columns"
   exit 0   
 fi
done


if [ "$1" != "" ]
then
echo "$1"
# take channel input from command line
num="$1" 
elif [ "$1" == "" ]
then
channel_matrix
echo "Please Select a Number corresponding to a YouTube Live Stream:"

read num

if [ "$num" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
elif [ "$num" == "" ]
then
num=1
fi

fi

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    MAIN  ENGLISH  ##################################
# 1) BBC World Service 
1) link=http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-eieuk
use_paylist="no"
chan_name="BBC World Service";;
# 2) NPR National Public Radio
2) link=https://www.npr.org/streams/aac/live1_aac.pls
use_paylist="no"
chan_name="NPR";;
# 3)  MPR News
3) link=http://minnesota.publicradio.org/tools/play/streams/news.pls
use_playlist="no"
chan_name="Minnesota Public Radio News ";;
# 4) WKSU News
4) link=http://66.225.205.8:8020
use_playlist="no"
chan_name="WKSU News";;
# 5) Infowars
5) link=http://50.7.130.118:80
 
#http://50.7.130.118:80
#http://50.7.130.116:80
#http://50.7.130.117:80
#http://50.7.79.18:80
#http://50.7.79.19:80
#http://50.7.130.114:80
#http://50.7.128.194:80
#http://50.7.128.195:80
#http://50.7.130.115:80
#http://50.7.79.92:80
#http://50.7.79.94:80
#http://50.7.79.93:80
#http://50.7.79.91:80
#http://50.7.79.90:80

use_playlist="no"
chan_name="Infowars";;

# 6)  BBC Radio 1
6) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p
use_playlist="no"
chan_name=" BBC Radio 1";;
# 7)  BBC Radio 2
7) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio2_mf_p
use_playlist="no"
chan_name=" BBC Radio 2";;
# 8)  BBC Radio 3
8) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-aac-lc-a/format/pls/vpid/bbc_radio_three.pls
use_playlist="no"
chan_name=" BBC Radio 3";;
# 9)  BBC Radio 4
9) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio4fm_mf_p
use_playlist="no"
chan_name=" BBC Radio 4";;
# 10)  BBC Radio 5
10) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio5live_mf_p
use_playlist="no"
chan_name=" BBC Radio 5";;
# 11)  BBC Radio 6
11) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p
use_playlist="no"
chan_name=" BBC Radio 1 Extra";;
# 12)  BBC Radio 1 Extra
12) link=http://www.bbc.co.uk/radio/listen/live/r1x_aaclca.pls
use_playlist="no"
chan_name=" BBC Radio 1 Extra";;
# 13)  BBC Radio 4 Extra
13) link=http://www.bbc.co.uk/radio/listen/live/r4x_aaclca.pls
use_playlist="no"
chan_name=" BBC Radio 4 Extra";;
# 14)  BBC Radio 5 Live Sports Extra
14) link=http://www.bbc.co.uk/radio/listen/live/r5lsp_aaclca.pls
use_playlist="no"
chan_name=" BBC Radio 5 Live Sports Extra";;
# 15)  BBC Radio Asian Extra
15) link=http://www.bbc.co.uk/radio/listen/live/ran_aaclca.pls
use_playlist="no"
chan_name=" BBC Radio Asian Extra";;
# 16) BBC World Service Backup
16) link=http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-eieuk_backup
use_paylist="no"
chan_name="BBC World Service";;
# 17)  Lounge Radio
17) link=http://77.235.42.90:80/listen.pls
use_paylist="no"
chan_name="Lounge Radio";;
esac
}

# initialize menu
menu="m"

# Function to check the menu status
menu_status()
{
input=$1
if [ "$input" == "" ]
then
menstat="no"
elif [ "$input" == "q" ]
then
menstat="yes"
menu="q"
elif [ "$input" == "n" ]
then 
menstat="yes"
menu="n"
elif [ "$input" == "m" ]
then
menstat="yes"
menu="m"
else
menstat="no"
fi
}

# function for m,n,q channel matrix display
menu_switch()
{
input=$1
case "$input" in
q) echo "Type endtv to restart program. Bye."
exit "$?" ;;
m) channel_matrix
echo "Please Select a Number corresponding to a YouTube Live Stream, press n for the next menu, or press q to quit:" ;;
n) channel_matrix_2
echo "Please Select a Number corresponding to a YouTube Live Stream, press m for the main menu, or press q to quit:" ;;
esac
}

menu_status $num

# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select $num
 echo "$chan_name"
  if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 torsocks -i mpv --no-resume-playback --cache="$cache_size" --playlist="$link" 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 torsocks -i mpv --no-resume-playback --cache="$cache_size"  "$link" 
  fi
  
 menu_switch "$menu" 
 echo "You were watching "$chan_name" on Channel "$num" "
 read entry
 else 
 menu_switch "$menu"
 read entry
fi

while [ "$entry" != q ]
do
menu_status $entry
if [ "$menstat" == "no" ]
then
channel_select $entry
echo "$chan_name"
  if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 torsocks -i mpv --no-resume-playback --cache="$cache_size" --playlist="$link" 
  # clear the cookie
  echo " " > "$cookie"
  menu_switch "$menu"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 torsocks -i  mpv --no-resume-playback --cache="$cache_size"  "$link" 
  fi
  
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$entry" "  
read entry
else 
menu_switch "$menu"
read entry
fi
done

echo "Type endstream to open a new stream."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

######################     END OF PROGRAM      ####################################################

