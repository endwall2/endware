#! /bin/sh
######################################################################
# Title: endradio.sh
# Description:  Anonymous Tor streaming of internet radio streams using mplayer, torsocks, firejail
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: May 7, 2017
# Version: 0.02
# Revision Date: May 9, 2017
#
# Recent Changes: - forked from endstream 0.26
#                 - Channel menu stays on previous selection 
#####################################################################
# Dependencies: mpv, ffmpeg, read , firejail, curl, torsocks
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endradio.sh ~/bin/endradio
# $ cd ~/bin
# $ chmod u+wrx endradio
# $ export PATH=~/bin:"$PATH"
#
# Run ENDRADIO
# $ endradio
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
version="0.02"
rev_date="09/05/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/radiostations.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDRADIO "$version"   =================================================================================="
   echo "||        NEWS         ||      CBC Canada     ||                   ||        French     ||       COLUMN 5     ||        MUSIC        ||      Drama      ||"
   echo "==========================================================================================================================================================================="
   echo "1) BBC World Service   41) CBC 1 Kamloops     81) CBC 2 Eastern    119) France Info     159) ---------------  198) Pulse Radio       236) Old Time Radio"    
   echo "2) NPR                 42) CBC 1 Kelowna      82) --------------   120) France Inter    160) ---------------  199) ---------------   237) ---------------" 
   echo "3) MPR News            43) CBC 1 Prnc George  83) ---------------  121) RFI Monde       161) ---------------  200) ---------------   238) --------------- "  
   echo "4) WKSU News           44) CBC 1 Vancouver    84) ---------------  122) RFI Afrique     162) ---------------  201) ---------------   239) --------------- "             
   echo "5) Infowars            45) CBC 1 Victoria     85) ---------------  123) Africa no 1     163) ---------------  202) ---------------   240) --------------- "  
   echo "6) BBC Radio 1         46) CBC 1 Whitehorse   86) --------------   124) Alta Frequenza  164) ---------------  203) ---------------   241) --------------- "  
   echo "7) BBC Radio 2         47) CBC 1 Calgary      87) --------------   125) BFM Paris       165) ---------------  204) ---------------   242) --------------- "
   echo "8) BBC Radio 3         48) CBC 1 Edmonton     88) --------------   126) Europe 1        166) ---------------  205) ---------------   243) ---------------"
   echo "9) BBC Radio 4         49) CBC 1 Regina       89) ---------------  127) Kernews         167) ---------------  206) ---------------   244) ---------------"
   echo "10) BBC Radio 5        50) CBC 1 Saskatoon    90) ---------------  128) Radio Ici       168) ---------------  207) ---------------   245) ---------------"
   echo "11) BBC Radio 6        51) CBC 1 Winnipeg     91) ---------------  129) Première Chaîne 169) ---------------  208) ---------------   246) ---------------"
   echo "12) BBC Radio 1 Extra  52) CBC 1 Iqaluit      92) ---------------  130) Espace Musique  170) ---------------  209) ---------------   247) --------------- "
   echo "13) BBC Radio 4 Extra  53) CBC 1 Kitchener    93) ---------------  131) RDI             171) ---------------  209) ---------------   248) ---------------"
   echo "14) BBC Radio Sports   54) CBC 1 London       94) ---------------  132) --------------- 172) ---------------  210) ---------------   249) ---------------"
   echo "15) BBC Radio Asian    55) CBC 1 Ottawa       95) ---------------  133) --------------- 173) ---------------  211) ---------------   250) ---------------"  
   echo "16) BBC World Service  56) CBC 1 Sudbury      96) --------------   134) --------------- 174) ---------------  212) ---------------   251) ---------------"
   echo "17) RTE Dublin         57) CBC 1 Thunder Bay  97) ---------------  135) --------------- 175) ---------------  213) ---------------   252) ---------------  "
   echo "18) RTE Extra Dublin   58) CBC 1 Toronto      98) ---------------  136) --------------- 176)---------------   214) ---------------   253) --------------- "	
   echo "19) 106-108 Talk Dublin59) CBC 1 Windsor      99) ---------------  137) --------------- 177) ---------------  215) ---------------   254) --------------- "
   echo "20) ---------------    60) CBC 1 Montreal     100) --------------  138) --------------- 178) ---------------  216) ---------------   255) ---------------"  
   echo "21) ---------------    61) CBC 1 Nord Quebec  101) --------------  139) --------------- 179) ---------------  217) ---------------   256) --------------- "
   echo "22) ---------------    62) CBC 1 Quebec City  102) --------------  140) --------------- 180) ---------------  219) ---------------   257) ---------------"       
   echo "23) ---------------    63) CBC 1 Fredericton  103) --------------  141) --------------- 180) ---------------  218) ---------------   258) ---------------"  
   echo "24) ---------------    64) CBC 1 Moncton      104) --------------  142) --------------- 181) ---------------  219) ---------------   259) --------------- "
   echo "25) ---------------    65) CBC 1 Saint John   105) --------------  143) --------------- 182) ---------------  220) ---------------   260) --------------- " 
   echo "26) ---------------    66) CBC 1 Charlottetown106) --------------  144) --------------- 183) ---------------  221) ---------------   261) ---------------"
   echo "27) ---------------    67) CBC 1 Cape Breton  107) --------------  145) --------------- 184) ---------------  222) ---------------   262) --------------- "
   echo "28) ---------------    68) CBC 1 Halifax      108) --------------  146) --------------- 185) ---------------  223) ---------------   263) ---------------"
   echo "29) ---------------    69) CBC 1 Corner Brook 109) --------------  147) --------------- 186) ---------------  224) ---------------   264) --------------- "
   echo "30) ---------------    70) CBC 1 Grand Falls  110) --------------  148) --------------- 187) ---------------  225) ---------------   265) ---------------  "    
   echo "31) ---------------    71) CBC 1 Labrador     111) --------------  149) --------------- 188) ---------------  226) ---------------   266) --------------- "
   echo "32) ---------------    72) CBC 1 St. Johns    112) --------------  150) --------------- 189) ---------------  227) ---------------   267) ---------------"
   echo "33) ---------------    73) CBC 1 Inuvik       113) -------------   151) --------------- 190) ---------------  228) ---------------   268) --------------- " 
   echo "34) ---------------    74) CBC 1 Yellowknife  114) -------------   152) --------------- 191) ---------------  229) ---------------   269) --------------- "  
   echo "35) ---------------    75) CBC 2 Halifax      115) -------------   153) --------------- 192) ---------------  230) ---------------   270) --------------- "
   echo "36) ---------------    76) CBC 2 Toronto      116) --------------  154) --------------- 193) ---------------  231) ---------------   271) ---------------  "
   echo "37) ---------------    77) CBC 2 Winnipeg     117) -------------   155) --------------- 194) ---------------  232) ---------------   272) --------------- "
   echo "38) ---------------    78) CBC 2 Edmonton     118) -------------   156) --------------- 195) ---------------  233) ---------------   273) ---------------"	
   echo "39) ---------------    79) CBC 2 Vancouver    119) ------------    157) --------------- 196) ---------------  234) ---------------   274) --------------- "
   echo "40) ---------------    80) CBC 2 Pacific      120) -------------   158)---------------  197) ---------------  235) ---------------   275) --------------- "
   echo "========================================================================================================================================================================"
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      ENDRADIO  "$version"   =================================================================================="
   echo "||      COLUMN 8         ||   COLUMN 9         ||   COLUMN 10       ||     COLUMN 11        ||    COLUMN 12       ||        COLUMN 13        ||      COLUMN 14    ||"
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
5) 

 rnum=$( expr $( head -c 2 /dev/urandom | od -A n -i ) % 15 ) 
 case $rnum in 
 0) link=http://50.7.130.118:80 ;;
 1) link=http://50.7.130.118:80 ;;
 2) link=http://50.7.130.116:80 ;;
 3) link=http://50.7.130.117:80 ;;
 4) link=http://50.7.79.18:80 ;;
 5) link=http://50.7.79.19:80 ;;
 6) link=http://50.7.130.114:80 ;;
 7) link=http://50.7.128.194:80 ;;
 8) link=http://50.7.128.195:80 ;;
 9) link=http://50.7.130.115:80 ;;
 10) link=http://50.7.79.92:80 ;;
 11) link=http://50.7.79.94:80 ;;
 12) link=http://50.7.79.93:80 ;;
 13) link=http://50.7.79.91:80 ;;
 14) link=http://50.7.79.90:80 ;;
 esac

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
# 16) RTE Radio 1 Dublin
16) link=http://www.listenlive.eu/rte1.m3u
use_paylist="no"
chan_name="RTE Radio 1 Dublin";;
# 17) RTE Radio 1 Extra Dublin
17) link=http://www.listenlive.eu/rte1extra.m3u
use_paylist="no"
chan_name="RTE Radio 1 Extra Dublin";;
# 18) RTE Radio 1 Extra Dublin
18) link=http://www.listenlive.eu/rte1extra.m3u
use_paylist="no"
chan_name="RTE Radio 1 Extra Dublin";;
# 19) News Talk 106-108 Dublin
19) link=http://communicorp.mp3.miisolutions.net:8000/communicorp/Newstalk_low.m3u
use_paylist="no"
chan_name="News Talk 106-108 Dublin";;

######## CBC RADIO CANADA #################

########## CBC RADIO 1
# 41) CBC Radio 1 Kamloops BC Canada
41) link=http://cbc_r1_kam.akacast.akamaistream.net/7/440/451661/v1/rc.akacast.akamaistream.net/cbc_r1_kam
use_paylist="no"
chan_name="CBC Radio 1 Kamloops,BC";;	
# 42) CBC Radio 1 Kelowna BC Canada
42) link=http://cbc_r1_kel.akacast.akamaistream.net/7/229/451661/v1/rc.akacast.akamaistream.net/cbc_r1_kel
use_paylist="no"
chan_name="CBC Radio 1 Kelowna,BC";;	
# 43) CBC Radio 1 Prince George BC Canada
43) link=http://cbc_r1_prg.akacast.akamaistream.net/7/966/451661/v1/rc.akacast.akamaistream.net/cbc_r1_prg
use_paylist="no"
chan_name="CBC Radio 1 Prince George,BC";;	
# 44) CBC Radio 1 Vancouver BC Canada
44) link=http://cbc_r1_vcr.akacast.akamaistream.net/7/723/451661/v1/rc.akacast.akamaistream.net/cbc_r1_vcr
use_paylist="no"
chan_name="CBC Radio 1 Vancouver,BC";;	
# 45) CBC Radio 1 Victoria BC Canada
45) link=http://cbc_r1_vic.akacast.akamaistream.net/7/728/451661/v1/rc.akacast.akamaistream.net/cbc_r1_vic
use_paylist="no"
chan_name="CBC Radio 1 Victoria,BC";;
# 46) CBC Radio 1 Whitehorse BC Canada
46) link=http://cbc_r1_whs.akacast.akamaistream.net/7/319/451661/v1/rc.akacast.akamaistream.net/cbc_r1_whs
use_paylist="no"
chan_name="CBC Radio 1 ,Whitehorse,YK";;
# 47) CBC Radio 1 Calgary AB Canada
47) link=http://cbc_r1_cgy.akacast.akamaistream.net/7/298/451661/v1/rc.akacast.akamaistream.net/cbc_r1_cgy
use_paylist="no"
chan_name="CBC Radio 1 Calgary,AB";;
# 48) CBC Radio 1 Edmonton AB Canada
48) link=http://cbc_r1_edm.akacast.akamaistream.net/7/904/451661/v1/rc.akacast.akamaistream.net/cbc_r1_edm
use_paylist="no"
chan_name="CBC Radio 1 Edmonton,AB";;
# 49) CBC Radio 1 Regina AB Canada
49) link=http://cbc_r1_reg.akacast.akamaistream.net/7/666/451661/v1/rc.akacast.akamaistream.net/cbc_r1_reg
use_paylist="no"
chan_name="CBC Radio 1 Regina,AB";;
# 50) CBC Radio 1 Saskatoon SK Canada
50) link=http://cbc_r1_ssk.akacast.akamaistream.net/7/842/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ssk
use_paylist="no"
chan_name="CBC Radio 1 Saskatoon,SK";;
# 51) CBC Radio 1 Winnipeg MB Canada
51) link=http://cbc_r1_wpg.akacast.akamaistream.net/7/831/451661/v1/rc.akacast.akamaistream.net/cbc_r1_wpg
use_paylist="no"
chan_name="CBC Radio 1 Winnipeg,MB";;	
# 52) CBC Radio 1 Iqaluit
52) link=http://cbc_r1_iqa.akacast.akamaistream.net/7/325/451661/v1/rc.akacast.akamaistream.net/cbc_r1_iqa
use_paylist="no"
chan_name="CBC Radio 1 Iqaluit,IN";;
# 53) CBC Radio 1 Kitchener-Waterloo ON Canada
53) link=http://cbc_r1_ekw.akacast.akamaistream.net/7/63/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ekw
use_paylist="no"
chan_name="CBC Radio 1 Kitchner-Waterloo,ON";;
# 54) CBC Radio 1 London ON Canada
54) link=http://cbc_r1_ldn.akacast.akamaistream.net/7/104/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ldn
use_paylist="no"
chan_name="CBC Radio 1 London,ON";;
# 55) CBC Radio 1 Ottawa ON Canada
55) link=http://cbc_r1_ott.akacast.akamaistream.net/7/613/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ott
use_paylist="no"
chan_name="CBC Radio 1 Ottawa,ON";;
# 56) CBC Radio 1 Sudbury ON Canada
56) link=http://cbc_r1_sud.akacast.akamaistream.net/7/380/451661/v1/rc.akacast.akamaistream.net/cbc_r1_sud
use_paylist="no"
chan_name="CBC Radio 1 Sudbury,ON";;
# 57) CBC Radio 1 Thunder Bay ON Canada
57) link=http://cbc_r1_tba.akacast.akamaistream.net/7/245/451661/v1/rc.akacast.akamaistream.net/cbc_r1_tba
use_paylist="no"
chan_name="CBC Radio 1 Thunder Bay ,ON";;
# 58) CBC Radio 1 Toronto ON Canada
58) link=http://cbc_r1_tor.akacast.akamaistream.net/7/632/451661/v1/rc.akacast.akamaistream.net/cbc_r1_tor
use_paylist="no"
chan_name="CBC Radio 1 Toronto,ON";;
# 59) CBC Radio 1 Windsor ON Canada
59) link=http://cbc_r1_wdr.akacast.akamaistream.net/7/813/451661/v1/rc.akacast.akamaistream.net/cbc_r1_wdr
use_paylist="no"
chan_name="CBC Radio 1 Windsor,ON";;
# 60) CBC Radio 1 Montreal QC Canada
60) link=http://cbc_r1_mtl.akacast.akamaistream.net/7/35/451661/v1/rc.akacast.akamaistream.net/cbc_r1_mtl
use_paylist="no"
chan_name="CBC Radio 1 Montreal, QC";;
# 61) CBC Radio 1  Nord Quebec QC Canada
61) link=http://cbc_r1_n_mtl.akacast.akamaistream.net/7/823/451661/v1/rc.akacast.akamaistream.net/cbc_r1_n_mtl
use_paylist="no"
chan_name="CBC Radio 1 Nord Quebec, QC";;
# 62) CBC Radio 1 Quebec City QC Canada
62) link=http://cbc_r1_qqu.akacast.akamaistream.net/7/29/451661/v1/rc.akacast.akamaistream.net/cbc_r1_qqu
use_paylist="no"
chan_name="CBC Radio 1 Quebec City,QC";;
# 63) CBC Radio 1 Fredericton NB Canada
63) link=http://cbc_r1_frd.akacast.akamaistream.net/7/553/451661/v1/rc.akacast.akamaistream.net/cbc_r1_frd
use_paylist="no"
chan_name="CBC Radio 1 Fredericton,NB";;
# 64) CBC Radio 1 Moncton NB Canada
64) link=http://cbc_r1_mct.akacast.akamaistream.net/7/383/451661/v1/rc.akacast.akamaistream.net/cbc_r1_mct
use_paylist="no"
chan_name="CBC Radio 1 Moncton, NB";;
# 65) CBC Radio 1 Saint John NB Canada
65) link=http://cbc_r1_snb.akacast.akamaistream.net/7/754/451661/v1/rc.akacast.akamaistream.net/cbc_r1_snb
use_paylist="no"
chan_name="CBC Radio 1 Saint John, NB";;
# 66) CBC Radio 1 Charlottetown NB Canada
66) link=http://cbc_r1_chr.akacast.akamaistream.net/7/169/451661/v1/rc.akacast.akamaistream.net/cbc_r1_chr
use_paylist="no"
chan_name="CBC Radio 1 Charlottetown, NB";;
# 67) CBC Radio 1 Cape Breton NB Canada
67) link=http://cbc_r1_syd.akacast.akamaistream.net/7/897/451661/v1/rc.akacast.akamaistream.net/cbc_r1_syd
use_paylist="no"
chan_name="CBC Radio 1 Cape Breton, NB";;	
# 68) CBC Radio 1 Halifax NFL Canada
68) link=http://cbc_r1_hfx.akacast.akamaistream.net/7/981/451661/v1/rc.akacast.akamaistream.net/cbc_r1_hfx
use_paylist="no"
chan_name="CBC Radio 1 Halifax, NFL";;
# 69) CBC Radio 1 Corner Brook NFL Canada
69) link=http://cbc_r1_cor.akacast.akamaistream.net/7/550/451661/v1/rc.akacast.akamaistream.net/cbc_r1_cor
use_paylist="no"
chan_name="CBC Radio 1 Corner Brook , NFL";;
# 70) CBC Radio 1 Grand Falls/Gander NFL Canada
70) link=http://cbc_r1_gfa.akacast.akamaistream.net/7/492/451661/v1/rc.akacast.akamaistream.net/cbc_r1_gfa
use_paylist="no"
chan_name="CBC Radio 1 Grand Falls/Gander, NFL";;
# 71) CBC Radio 1  Labrador NFL Canada
71) link=http://cbc_r1_gba.akacast.akamaistream.net/7/274/451661/v1/rc.akacast.akamaistream.net/cbc_r1_gba
use_paylist="no"
chan_name="CBC Radio 1  Labrador, NFL";;
# 72) CBC Radio 1  St. Johns NFL Canada
72) link=http://cbc_r1_snf.akacast.akamaistream.net/7/750/451661/v1/rc.akacast.akamaistream.net/cbc_r1_snf
use_paylist="no"
chan_name="CBC Radio 1 St. Johns, NFL";;
# 73) CBC Radio 1  Inuvik IN Canada
73) link=http://cbc_r1_ink.akacast.akamaistream.net/7/967/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ink
use_paylist="no"
chan_name="CBC Radio 1 Inuvik,IN";;
# 74) CBC Radio 1  Yellowknife YK Canada
74) link=http://cbc_r1_ykn.akacast.akamaistream.net/7/369/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ykn
use_paylist="no"
chan_name="CBC Radio 1 Yellowknife, YK";;
############### CBC Radio 2
# 75) CBC Radio 2 Halifax NFL Canada
75) link=http://cbc_r2_hfx.akacast.akamaistream.net/7/917/451661/v1/rc.akacast.akamaistream.net/cbc_r2_hfx
use_paylist="no"
chan_name="CBC Radio 1, Halifax NFL";;
# 76) CBC Radio 2 Toronto ON Canada
76) link=http://cbc_r2_tor.akacast.akamaistream.net/7/364/451661/v1/rc.akacast.akamaistream.net/cbc_r2_tor
use_paylist="no"
chan_name="CBC Radio 1, Toronto ON";;
# 77) CBC Radio 2 Winnipeg MB Canada
77) link=http://cbc_r2_wpg.akacast.akamaistream.net/7/233/451661/v1/rc.akacast.akamaistream.net/cbc_r2_wpg
use_paylist="no"
chan_name="CBC Radio 1, Winnipeg MB";;
# 78) CBC Radio 2 Edmonton AB Canada
78) link=http://cbc_r2_edm.akacast.akamaistream.net/7/40/451661/v1/rc.akacast.akamaistream.net/cbc_r2_edm
use_paylist="no"
chan_name="CBC Radio 1, Edmonton AB";;
# 79) CBC Radio 2 Vancouver BC Canada
79) link=http://cbc_r2_vcr.akacast.akamaistream.net/7/773/451661/v1/rc.akacast.akamaistream.net/cbc_r2_vcr
use_paylist="no"
chan_name="CBC Radio 1, Vancouver BC";;
# 80) CBC Radio 2 Pacific Canada
80) link=http://cbc_r2_ipt.akacast.akamaistream.net/7/669/451661/v1/rc.akacast.akamaistream.net/cbc_r2_ipt 
use_paylist="no"
chan_name="CBC Radio 1, Pacific BC";;
# 81) CBC Radio 2 Eastern Canada
81) link=http://cbc_r2_iet.akacast.akamaistream.net/7/50/451661/v1/rc.akacast.akamaistream.net/cbc_r2_iet 
use_paylist="no"
chan_name="CBC Radio 1, Eastern";;	

########################################

# 119) France Info
119) link=http://www.listenlive.eu/fr_franceinfo128.m3u
use_paylist="no"
chan_name="France Info";;	
# 120) France Info
120) link=http://www.listenlive.eu/fr_franceinter128.m3u
use_paylist="no"
chan_name="France Info";;
# 121) RFI Monde
121) link=http://www.listenlive.eu/rfimonde.m3u
use_paylist="no"
chan_name="RFI Monde";;
# 122) RFI Afrique
122) link=http://www.listenlive.eu/rfiafrique.m3u
use_paylist="no"
chan_name="RFI Afrique";;
# 123) Africa no 1
123) link=http://african1paris.ice.infomaniak.ch/african1paris-128.mp3.m3u
use_paylist="no"
chan_name="Africa no 1";;
# 124) Alta Frequenza Ajaccio 
124) link=http://str80.streamakaci.com:7020/listen.pls
use_paylist="no"
chan_name="Alta Frequenza Ajaccio";;
# 125) BFM Paris 
125) link=http://www.listenlive.eu/bfm.m3u
use_paylist="no"
chan_name="BFM Paris";;
# 126) Europe 1 
126) link=http://www.listenlive.eu/europe1.m3u
use_paylist="no"
chan_name="Europe 1";;
# 127) Kernews  
127) link=http://statslive.infomaniak.ch/playlist/kernews/kernews-128.aac/playlist.m3u
use_paylist="no"
chan_name="Kernews";;
 # 128) Radio Ici Maintenant Paris 
128) link=http://radio.rim952.fr:8000/stream.mp3.m3u
use_paylist="no"
chan_name="Radio Ici Maintenant Paris";;

################# Radio Canada ################################
# 129) Radio Canada Première Chaîne
129) link=http://2QMTL0.akacast.akamaistream.net:80/7/953/177387/v1/rc.akacast.akamaistream.net/2QMTL0
use_paylist="no"
chan_name="Radio Canada Première Chaîne";;
# 130) Radio Canada Espace Musique
130) link=http://7qmtl0.akacast.akamaistream.net/7/445/177407/v1/rc.akacast.akamaistream.net/7QMTL0
use_paylist="no"
chan_name="Radio Canada Espace Musique";;
# 131) Radio Canada RDI
131) link=http://RDIRADIO.akacast.akamaistream.net:80/7/501/177423/v1/rc.akacast.akamaistream.net/RDIRADIO
use_paylist="no"
chan_name="Radio Canada RDI";;



# 198) Pulse Radio
198) link=http://stream.pulsradio.com:5000/
use_paylist="no"
chan_name="Old Time Radio";;

# 236) Old Time Radio
236) link=http://www.otrfan.com:8000/stream.m3u 
use_paylist="no"
chan_name="Old Time Radio";;

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
q) echo "Type endradio to restart program. Bye."
exit "$?" ;;
m) channel_matrix
echo "Please Select a Number corresponding to an Internet Radio Stream, press n for the next menu, or press q to quit:" ;;
n) channel_matrix_2
echo "Please Select a Number corresponding to an Internet Radio Stream, press m for the main menu, or press q to quit:" ;;
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

echo "Type endradio to open a new streaming session."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

######################     END OF PROGRAM      ####################################################

