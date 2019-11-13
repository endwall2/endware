#! /bin/sh
######################################################################
# Title: endtunes.sh
# Description:  Clearnet streaming of internet radio streams using mpv, firejail
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: May 7, 2017
# Version: 0.07
# Revision Date: November 12, 2019
#
# Recent Changes: - Forked from endradio
#                 - Add multi language channels
#                 - forked from endstream 0.26
#                 - Channel menu stays on previous selection 
#####################################################################
# Dependencies: mpv, ffmpeg, read , firejail, curl, torsocks
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endtunes.sh ~/bin/endtunes
# $ cd ~/bin
# $ chmod u+wrx endtunes
# $ export PATH=~/bin:"$PATH"
#
# Run ENDTUNES
# $ endtunes
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
version="0.05"
rev_date="13/06/2017"
branch="gnu/linux"
product="ENDTUNES"
##################################################

USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/tunes.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"
# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
# define default headers
HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"
HEAD5="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"
uamode="off"
headmode="off"
### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{
   echo "====================================================      "$product" "$version"   =================================================================="
   echo "||       CLASSICAL      ||               ||    JAZZ          ||                  ||                   ||                  ||               ||"
   echo "============================================================================================================================================="
   echo "1) a1900-classical     41) CPR Open Air  81) Abacus Jazz     121) -------------- 161)-------------- 201)-------------- 241)--------------  "    
   echo "2) --------------      42) -----------   82) --------------  122) -------------- 162)-------------- 202)-------------- 242)--------------" 
   echo "3) BFC Classique       43) -----------   83) --------------- 123) -------------- 163)-------------- 203)-------------- 243)-------------- "  
   echo "4) KDFC Santa Rosa CA  44) -----------   84) --------------- 124) -------------- 164)-------------- 204)-------------- 244)--------------  "             
   echo "5) CPR Colorado        45) -----------   85) --------------- 125) -------------- 165)-------------- 205)-------------- 245)--------------"  
   echo "6) Classic XIX         46) -----------   86) --------------  126) -------------- 166)-------------- 206)-------------- 246)-------------- "  
   echo "7) A1 Baroque          47) -----------   87) --------------  127) -------------- 167)-------------- 207)-------------- 247)-------------- "
   echo "8) A1 Classical        48) -----------   88) --------------  128) -------------- 168)-------------- 208)-------------- 248)--------------"
   echo "9) A1 Symphony         49) -----------   89) --------------- 129) -------------- 169)-------------- 209)-------------- 249)---------------"
   echo "10) A1 Classic         50) -----------   90) --------------- 130) -------------- 170)-------------- 210)-------------- 250)---------------"
   echo "11) Abacus Classical   51) ------------  91) --------------- 131) -------------- 171)-------------- 211)-------------- 251)---------------"
   echo "12) Classical Channel  52) ------------  92) --------------- 132) -------------- 172)-------------- 212)-------------- 252)--------------- "
   echo "13) ABC Classical      53) ------------  93) --------------- 133) -------------- 173)-------------- 213)-------------- 253)---------------"
   echo "14) ABC Piano          54) ------------  94) --------------- 134) -------------- 174)-------------- 214)-------------- 254)---------------"
   echo "15) ------------       55) ------------  95) --------------- 135) -------------- 175)-------------- 215)-------------- 255)---------------"  
   echo "16) ------------       56) ------------  96) --------------  136) -------------- 176)-------------- 216)-------------- 256)---------------"
   echo "17) ------------       57) ------------  97) --------------- 137) -------------- 177)-------------- 217)-------------- 257)---------------  "
   echo "18) ------------       58) ------------  98) --------------- 138) -------------- 178)-------------- 218)-------------- 258)--------------- "	
   echo "19) ------------       59) ------------  99) --------------- 139) -------------- 179)-------------- 219)-------------- 259)--------------- "
   echo "20) ------------       60) ------------  100) -------------- 140) -------------- 180)-------------- 220)-------------- 260)---------------"  
   echo "21) ------------       61) ------------  101) -------------- 141) -------------- 181)-------------- 221)-------------- 261)--------------- "
   echo "22) ------------       62) ------------  102) -------------- 142) -------------- 182)-------------- 222)-------------- 262)---------------"       
   echo "23) ------------       63) ------------  103) -------------- 143) -------------  183)-------------- 223)-------------- 263)---------------"  
   echo "24) ---------------    64) ------------  104) -------------- 144) -------------- 184)-------------- 224)-------------- 264)--------------- "
   echo "25) ---------------    65) ------------  105) -------------- 145) -------------- 185)-------------- 225)-------------- 265)--------------- " 
   echo "26) ---------------    66) ------------  106) -------------- 146) -------------- 186)-------------- 226)-------------- 266)---------------"
   echo "27) ---------------    67) ------------  107) -------------- 147) -------------- 187)-------------- 227)-------------- 267)--------------- "
   echo "28) ---------------    68) ------------  108) -------------- 148) -------------- 188)-------------- 228)-------------- 268)---------------"
   echo "29) ---------------    69) ------------  109) -------------- 149) -------------- 189)-------------- 229)-------------- 269)--------------- "
   echo "30) ---------------    70) ------------  110) -------------- 150) -------------- 190)-------------- 230)-------------- 270)---------------  "    
   echo "31) ---------------    71) ------------  111) -------------- 151) -------------- 191)-------------- 231)-------------- 271)--------------- "
   echo "32) ---------------    72) ------------  112) -------------- 152) -------------- 192)-------------- 232)-------------- 272)---------------"
   echo "33) ---------------    73) ------------  113) -------------  153) -------------- 193)-------------- 233)-------------- 273)--------------- " 
   echo "34) ---------------    74) ------------  114) -------------  154) -------------- 194)-------------- 234)-------------- 274)--------------- "  
   echo "35) ---------------    75) ------------  115) -------------  155) -------------- 195)-------------- 235)-------------- 275)--------------- "
   echo "36) ---------------    76) ------------  116) -------------- 156) -------------- 196)-------------- 236)-------------- 276)---------------  "
   echo "37) ---------------    77) ------------  117) -------------  157) -------------- 197)-------------- 237)-------------- 277)--------------- "
   echo "38) ---------------    78) ------------  118) -------------  158) -------------- 198)-------------- 238)-------------- 278)---------------"	
   echo "39) ---------------    79) ------------  119) ------------   159) -------------- 199)-------------- 239)-------------- 279)--------------- "
   echo "40) ---------------    80) ------------  120) -------------  160)--------------- 200)-------------- 240)-------------- 280)--------------- "
   echo "============================================================================================================================================="
}	

channel_matrix_1()
{
   echo "===================================================     "$product" "$version"   =================================================================="
   echo "||   ------------   || --------------    ||  --------------    ||  -----------    ||    ---------  ||  ----------     ||                 ||"
   echo "============================================================================================================================================"
   echo "281)  -------------- 321)--------------   361) --------------    401) ------------441) ----------- 481) ------------- 521) --------------"    
   echo "282)  -------------- 322)--------------   362) --------------    402) ------------442) ----------- 482) ------------- 522) --------------" 
   echo "283) --------------- 323)--------------   363) --------------    403) ------------443) ----------- 483) ------------- 523) --------------"  
   echo "284) --------------- 324)--------------   364) --------------    404) ------------444) ----------- 484) ------------- 524) --------------"             
   echo "285) --------------- 325)--------------   365) --------------    405) ------------445) ----------- 485) ------------- 525) --------------"  
   echo "286) --------------- 326)--------------   366) --------------    406) ------------446) ----------- 486) ------------- 526) --------------"  
   echo "287) --------------- 327)--------------   367) --------------    407) ------------447) ----------- 487) ------------- 527) --------------"
   echo "288) --------------- 328)--------------   368) --------------    408) ------------448) ----------- 488) ------------- 528) --------------"
   echo "289) --------------- 329)--------------   369) --------------    409) ------------449) ----------- 489) ------------  529) --------------"
   echo "290) --------------- 330)--------------   370) --------------    410) ------------450) ----------- 490) ------------  530) --------------"
   echo "291) --------------- 331)--------------   371) --------------    411) ------------451) ----------- 491) ------------  531) --------------"
   echo "292) --------------- 332)--------------   372) --------------    412) ------------452) ----------- 492) ------------  532) --------------"
   echo "293) --------------- 333)--------------   373) --------------    413) ------------453) ----------- 493) ------------  533) --------------"
   echo "294) --------------- 334)--------------   374) --------------    414) ------------454) ----------- 494) ------------  534) --------------"
   echo "295) --------------- 335)--------------   375) --------------    415) ------------455) ----------- 495) ------------  535) --------------"  
   echo "296) --------------- 336)--------------   376) --------------    416) ------------456) ----------- 496) ------------  536) --------------"
   echo "297) --------------- 337)--------------   377) --------------    417) ----------- 457) ----------- 497) ------------- 537) --------------"
   echo "298) --------------- 338)--------------   378) --------------    418) ----------- 458) ----------- 498) ------------- 538) --------------"	
   echo "299) --------------- 339)--------------   379) --------------    419) ----------- 459) ----------- 499) ------------- 539) --------------"
   echo "300) --------------- 340)--------------   380) --------------    420) ----------- 460) ----------- 500) ------------- 540) --------------"  
   echo "301) --------------- 341)--------------   381) --------------    421) ----------- 461) ----------- 501) ------------- 541) --------------"
   echo "302) --------------- 342)--------------   382) --------------    422) ----------- 462) ----------- 502) ------------- 542) --------------"       
   echo "303) --------------- 343) -------------   383) --------------    423) ----------- 463) ----------- 503) ------------- 543) --------------"  
   echo "304) --------------- 344) -------------   384) --------------    424) ----------- 464) ----------- 504) ------------- 544) --------------"
   echo "305) --------------- 345) -------------   385) --------------    425) ----------- 465) ----------- 505) ------------- 545) --------------"  
   echo "306) --------------- 346) -------------   386) --------------    426) ----------- 466) ----------- 506) ------------- 546) --------------"
   echo "307) --------------- 347) -------------   387) --------------    427) ----------- 467) ----------- 507) ------------- 547) --------------"
   echo "308) --------------- 348) -------------   388) --------------    428) ----------- 468) ----------- 508) ------------- 548) --------------"
   echo "309) --------------- 349) --------------  389) --------------    429) ----------- 469) ----------- 509) ------------- 549) --------------"
   echo "310) --------------- 350) --------------  390)--------------     430) ----------- 470) ----------- 510) ------------- 550) --------------"    
   echo "311) --------------- 351) --------------  391) --------------    431) ----------- 471) ----------- 511) ------------- 551) --------------"
   echo "312) --------------- 352) --------------  392) --------------    432) ----------- 472) ----------- 512) ------------- 552) --------------"
   echo "313) --------------- 353) --------------  393) --------------    433) ----------- 473) ----------- 513) ------------- 553) --------------" 
   echo "314) --------------- 354) --------------  394) --------------    434) ----------- 474) ----------- 514) ------------- 554) --------------"  
   echo "315) --------------- 355) --------------  395) --------------    435) ----------- 475) ----------- 515) ------------- 555) --------------"
   echo "316) --------------- 356) --------------  396) --------------    436) ----------- 476) ----------- 516) ------------- 556) --------------"
   echo "317) --------------- 357) --------------  397) --------------    437) ----------- 477) ----------- 517) ------------- 557) --------------"
   echo "318) --------------- 358) --------------  398) --------------    438) ----------- 478) ----------- 518) ------------- 558) --------------"	
   echo "319) --------------- 359) --------------  399) --------------    439) ----------- 479) ----------- 519) ------------- 559) ------------- "
   echo "320) --------------- 360) --------------  400) --------------    440) ----------- 480) ----------- 520) ------------- 560) ------------- "
   echo "==========================================================================================================================================="
}	

channel_matrix_2()
{
   echo "===================================================     "$product" "$version"   =================================================================="
   echo "||   ------------   || --------------    ||  --------------    ||  -----------    ||    ---------  ||  ----------     ||                 ||"
   echo "============================================================================================================================================"
   echo "561)  -------------- 601)--------------   641) --------------    681) ------------721) ----------- 761) ------------- 801) --------------"    
   echo "562)  -------------- 602)--------------   642) --------------    682) ------------722) ----------- 762) ------------- 802) --------------" 
   echo "563) --------------- 603)--------------   643) --------------    683) ------------723) ----------- 763) ------------- 803) --------------"  
   echo "564) --------------- 604)--------------   644) --------------    684) ------------724) ----------- 764) ------------- 804) --------------"             
   echo "565) --------------- 605)--------------   645) --------------    685) ------------725) ----------- 765) ------------- 805) --------------"  
   echo "566) --------------- 606)--------------   646) --------------    686) ------------726) ----------- 766) ------------- 806) --------------"  
   echo "567) --------------- 607)--------------   647) --------------    687) ------------727) ----------- 767) ------------- 807) --------------"
   echo "568) --------------- 608)--------------   648) --------------    688) ------------728) ----------- 768) ------------- 808) --------------"
   echo "569) --------------- 609)--------------   649) --------------    689) ------------729) ----------- 769) ------------  809) --------------"
   echo "570) --------------- 610)--------------   650) --------------    690) ------------730) ----------- 770) ------------  810) --------------"
   echo "571) --------------- 611)--------------   651) --------------    691) ------------731) ----------- 771) ------------  811) --------------"
   echo "572) --------------- 612)--------------   652) --------------    692) ------------732) ----------- 772) ------------  812) --------------"
   echo "573) --------------- 613)--------------   653) --------------    693) ------------733) ----------- 773) ------------  813) --------------"
   echo "574) --------------- 614)--------------   654) --------------    694) ------------734) ----------- 774) ------------  814) --------------"
   echo "575) --------------- 615)--------------   655) --------------    695) ------------735) ----------- 775) ------------  815) --------------"  
   echo "576) --------------- 616)--------------   656) --------------    696) ------------736) ----------- 776) ------------  816) --------------"
   echo "577) --------------- 617)--------------   657) --------------    697) ----------- 737) ----------- 777) ------------- 817) --------------"
   echo "578) --------------- 618)--------------   658) --------------    698) ----------- 738) ----------- 778) ------------- 818) --------------"	
   echo "579) --------------- 619)--------------   659) --------------    699) ----------- 739) ----------- 779) ------------- 819) --------------"
   echo "580) --------------- 620)--------------   660) --------------    700) ----------- 740) ----------- 780) ------------- 820) --------------"  
   echo "581) --------------- 621)--------------   661) --------------    701) ----------- 741) ----------- 781) ------------- 821) --------------"
   echo "582) --------------- 622)--------------   662) --------------    702) ----------- 742) ----------- 782) ------------- 822) --------------"       
   echo "583) --------------- 623) -------------   663) --------------    703) ----------- 743) ----------- 783) ------------- 823) --------------"  
   echo "584) --------------- 624) -------------   664) --------------    704) ----------- 744) ----------- 784) ------------- 824) --------------"
   echo "585) --------------- 625) -------------   665) --------------    705) ----------- 745) ----------- 785) ------------- 825) --------------"  
   echo "586) --------------- 626) -------------   666) --------------    706) ----------- 746) ----------- 786) ------------- 826) --------------"
   echo "587) --------------- 627) -------------   667) --------------    707) ----------- 747) ----------- 787) ------------- 827) --------------"
   echo "588) --------------- 628) -------------   668) --------------    708) ----------- 748) ----------- 788) ------------- 828) --------------"
   echo "589) --------------- 629) --------------  669) --------------    709) ----------- 749) ----------- 789) ------------- 829) --------------"
   echo "590) --------------- 630) --------------  670)--------------     710) ----------- 750) ----------- 790) ------------- 830) --------------"    
   echo "591) --------------- 631) --------------  671) --------------    711) ----------- 751) ----------- 791) ------------- 831) --------------"
   echo "592) --------------- 632) --------------  672) --------------    712) ----------- 752) ----------- 792) ------------- 832) --------------"
   echo "593) --------------- 633) --------------  673) --------------    713) ----------- 753) ----------- 793) ------------- 833) --------------" 
   echo "594) --------------- 634) --------------  674) --------------    714) ----------- 754) ----------- 794) ------------- 834) --------------"  
   echo "595) --------------- 635) --------------  675) --------------    715) ----------- 755) ----------- 795) ------------- 835) --------------"
   echo "596) --------------- 636) --------------  676) --------------    716) ----------- 756) ----------- 796) ------------- 836) --------------"
   echo "597) --------------- 637) --------------  677) --------------    717) ----------- 757) ----------- 797) ------------- 837) --------------"
   echo "598) --------------- 638) --------------  678) --------------    718) ----------- 758) ----------- 798) ------------- 838) --------------"	
   echo "599) --------------- 639) --------------  679) --------------    719) ----------- 759) ----------- 799) ------------- 839) ------------- "
   echo "600) --------------- 640) --------------  680) --------------    720) ----------- 760) ----------- 800) ------------- 840) ------------- "
   echo "==========================================================================================================================================="
}


for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo "ENDTUNES: listen to online radio streams behind tor using mpv"
   echo "Type in the terminal $ endtunes "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endtunes --help         # usage messages"
   echo "$ endtunes --version      # print version information"
   echo "$ endtunes --list-matrix  # channel list in matrix format"
   echo "$ endtunes --list-all     # channel list in column format"
   echo "$ endtunes --ua-tor       # use tor-browser user-agent"
   echo "$ endtunes --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endtunes --ua-ranstr    # use a random string as the user agent"
   echo "$ endtunes  55            # use channel number in command line"  
   echo "$ endtunes  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDTUNES: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
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
   elif [ "$arg" == "--ua-rand" ]
   then
   uastate="rand"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-ranstr" ]
   then
   uastate="ranstr"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-tor" ]
   then
   uastate="tor"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-row1" ]
   then
   uastate="row1"
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
done

########################### FUNCTIONS ###########################################################

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    MAIN  ENGLISH  ##################################
# 1) a1900-classical
1) link=http://listen.radionomy.com/a1900-classical.m3u
use_paylist="no"
chan_name="a1900-classical";;
# 2) 

# 3)  BFC Classique
3) link=http://listen.radionomy.com/bfcclassique.m3u
use_playlist="no"
chan_name="BFC Classique";;
# 4)  KDFC Classical Santa Rosa California
4) 
#link=http://96.aac.pls.kdfc.live
# link=http://128.mp3.pls.kdfc.live
#link=http://19483.live.streamtheworld.com:80/KDFCFMAAC_SC
link=https://19483.live.streamtheworld.com:443/KDFCFMAAC_SC
use_playlist="no"
chan_name="KDFC Santa Rosa California";;
# 5)  CPR Colorado Classical
5) link=http://livestream.cprnetwork.org/pls/live_classical_aac.pls
use_playlist="no"
chan_name="Colorado Public Radio Classical";;
# 6)  Classique XIX
6) link=http://listen.radionomy.com/classique-xix.m3u
use_playlist="no"
chan_name="Classique XIX";;
# 7) A.1.ONE.Baroque
7) link=http://listen.radionomy.com/a1onebaroque.m3u
use_playlist="no"
chan_name="A1 Baroque";;
# 8) A.1.ONE.Classical
8) link=http://listen.radionomy.com/a1oneclassical.m3u
use_playlist="no"
chan_name="A1 Classical";;
# 9) A.1.ONE.SYMPHONY
9) link=http://listen.radionomy.com/a1onesymphony.m3u
use_playlist="no"
chan_name="A1 Symphony";;
# 10) A.1.ONE.CLASSSIC
10) link=http://listen.radionomy.com/aclassicfm-web.m3u
use_playlist="no"
chan_name="A1 Classic";;
# 11) Abacus Classic
11) link=http://listen.abacus.fm/classical.m3u
use_playlist="no"
chan_name="Abacus Classic";;
# 12) The Classical Channel
12) link=http://listen.radionomy.com/theclassicalchannel.m3u
use_playlist="no"
chan_name="The Classical Channel";;
# 13) ABC Classical
13) link=http://listen.radionomy.com/abc-classic.m3u
use_playlist="no"
chan_name="ABC Classical";;
# 14) ABC Piano
14) link=http://listen.radionomy.com/abc-piano.m3u
use_playlist="no"
chan_name="ABC Piano";;


# 41)  CPR Colorado Open Air
41) link=http://livestream.cprnetwork.org/pls/live_openair_aac.pls
use_playlist="no"
chan_name="Colorado Public Radio Open Air";;

# 81) Abacus Beethoven
81) link=http://listen.abacus.fm/smoothjazz.m3u
use_playlist="no"
chan_name="Abacus Beethoven";;

esac

}

###################################### FUNCTIONS #########################################

######################### Function to check the menu status and deal with user input ###################################################
menu_status()
{
input=$1
if [ "$input" = "" ]
then
chan_state="return"
menstat="no"
elif [ "$input" = "q" ]
then
menstat="yes"
menu="q"
elif [ "$input" = "Q" ]
then
menstat="yes"
menu="q"
elif [ "$input" = "n" ]
then 
menstat="yes"
menu="n"
elif [ "$input" = "N" ]
then 
menstat="yes"
menu="n"
elif [ "$input" = "m" ]
then
menstat="yes"
menu="m"
elif [ "$input" = "M" ]
then
menstat="yes"
menu="m"
elif [ "$input" = "ua-tor" ]
then
menstat="yes"
menu="$menu"
uastate="tor"
uamode="on"
elif [ "$input" = "ua-row1" ]
then
menstat="yes"
menu="$menu"
uastate="row1"
uamode="on"
elif [ "$input" = "ua-rand" ]
then
menstat="yes"
menu="$menu"
uastate="rand"
uamode="on"
elif [ "$input" = "ua-ranstr" ]
then
menstat="yes"
menu="$menu"
uastate="ranstr"
uamode="on"
elif [ "$input" = "ua-off" ]
then
menstat="yes"
menu="$menu"
uastate="off"
uamode="off"
elif [ "$input" = "+" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "]" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "]]" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "+++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "++++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" = "-" ]
then
menstat="no"
chan_state="-"
elif [ "$input" = "[" ]
then
menstat="no"
chan_state="-"
elif [ "$input" = "[[" ]
then
menstat="no"
chan_state="-"
elif [ "$input" = "--" ]
then
menstat="no"
chan_state="-"
elif [ "$input" = "---" ]
then
menstat="no"
chan_state="-"
elif [ "$input" -lt 841 ]
then
menstat="no"
chan_state="numeric"
else
menstat="no"
chan_state="alpha"
fi
}

############################## Function for Channel Menu Switching, m,n,q channel matrix display
menu_switch()
{
input=$1
case "$input" in
q) echo "Type endstream to restart program. Bye."
exit "$?" ;;
s) 
men_num="$men_num"
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, n for the next menu, or q to quit:" ;;
m)
men_num=$(expr 0)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, n for the next menu, or q to quit:" ;;
n) 
men_num=$(expr "$men_num" + 1)
men_num=$(expr "$men_num" % 3)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, m for the main menu, n for the next menu, or q to quit:" ;;
esac
}

######################################## Function to select the user agent
select_agent(){
if [ "$uamode" == "on" ]
 then
   if [ "$uastate" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$uastate" == "ranstr" ]
   then 
     # make a random string as the user agent 
     bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
     #UA="$( head -c "$bytes" /dev/urandom | base64 -i | cut -d "=" -f 1 | cut -d "+" -f 1 | cut -d "/" -f 1 )"
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')" 
   elif [ "$uastate" == "tor" ] 
   then
     UA="$UA_torbrowser" 
   elif [ "$uastate" == "row1" ] 
   then
     UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
     UA=""
   fi 
 fi
}

############## FUNCTION TO PLAY THE CHANNEL

######################## FUNCTION FOR PLAYING MEDIA STREAM CHANNELS #############################
play_channel()
{
if [ "$menstat" = "no" ]
then
getlink=1
channel_select "$num"
echo "$chan_name Channel $num" 
  
  if [ "$uamode" = "on" ]
  then 
  echo "$UA"
   
    if [ "$use_cookies" = "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl -A "$UA" --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback  --no-video --cache=yes --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen "$link"  
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen "$link"  
    else
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" = "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --ytdl-format="$format" --no-resume-playback --cache=yes --fullscreen --loop-playlist=inf --no-video  --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --no-video --loop-playlist=inf --cache=yes --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen "$link"  
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback  --no-video --loop-playlist=inf --cache=yes --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback  --no-video  --loop-playlist=inf --cache=yes --fullscreen "$link"  
    else
    mpv --ytdl-format="$format" --no-resume-playback --no-video --loop-playlist=inf --cache=yes --fullscreen "$link" 
    fi
     
  fi
clear
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
format=""
method=""
read entry
else 
clear
menu_switch "$menu"
chan_state="normal"
menstat="no"
format=""
method=""
read entry
fi
}

################################ Function to set the channel number 
set_channel()
{
chan_state=$1
if [ "$chan_state" = "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" = "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" = "return" ]
then
num="$num"
elif [ "$chan_state" = "numeric" ]
then 
num="$entry"
else 
num="$num"
fi
}

##############################    MAIN PROGRAM      ######################################
clear
### Select the user agent
select_agent

# initialize menu and channels
menu="s"
men_num=0
entry=1
num=1

############## USER INPUT FIRST RUN  ###################################
##  If input is non empty display and select
if [ "$1" != "" ]
then
  echo "$1"
  # take channel input from command line
  entry="$1" 
elif [ "$1" = "" ]  # else redisplay the channel matrix at previous page and ask for user input
then
  channel_matrix_"$men_num"
  echo "Please Select a Number corresponding to a Media Live Stream:"
  read entry
  if [ "$entry" = "q" ]
  then 
   echo "Type endstream to open a new stream."
   exit "$?"
  elif [ "$entry" = "" ]
  then
   entry=1
   num=1
  fi
fi

### Case to remove void input on channel +/- at first selection 
if [ "$chan_state" = "+" ]
then 
chan_state="return"
entry=1
num=1
elif [ "$chan_state" = "-" ]
then 
chan_state="return"
entry=1
num=1
fi

menu_status "$entry"
set_channel "$chan_state"
# get the menu selection status
### Play the media stream
play_channel

### While loop to keep the menu up
while [ "$entry" != "q" ]
do
select_agent 
menu_status "$entry"
set_channel "$chan_state"
play_channel
done

echo "Type endtunes to open a new streaming session."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"
######################     END OF PROGRAM      ####################################################