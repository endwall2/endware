#! /bin/sh
######################################################################
# Title: endradio.sh
# Description:  Anonymous Tor streaming of internet radio streams using mplayer, torsocks, firejail
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: May 7, 2017
# Version: 0.09
# Revision Date: Jan 27, 2018
#
# Recent Changes: - Add multi language channels
#                 - forked from endstream 0.26
#                 - Channel menu stays on previous selection 
#####################################################################
# Dependencies: mpv, ffmpeg, read , firejail, curl, torsocks, mpv, mplayer
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
######################################## BEGINNING OF PROGRAM    ##########################################################

###############  VERSION INFORMATION  ##############
version="0.09"
rev_date="27/01/2018"
branch="gnu/linux"
product="ENDRADIO"
##################################################
chan_columns="$HOME/bin/radio.txt"
cookie="$HOME/bin/cookies.txt"
stream_dump="$HOME/tmp/audiostream"
playlist_tmp="$HOME/tmp/playlist.tmp"
pidstore="$HOME/tmp/pid.tmp"
cache_size="512"
use_cookies="no"
#change this to whatever path/file you what to use as your user agents file
USERAGENTS=$HOME/bin/user_agents.txt 
# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
# define default headers
HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"

uamode="off"
headmode="off"
state="normal"


### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==========================================================     "$product" "$version"   ======================================================================="
   echo "||        NEWS       ||      CBC Canada    ||                ||       French      ||       German       ||       Spanish       ||    Spanish / Italian  ||"
   echo "============================================================================================================================================================"
   echo "1)BBC World Service   41)CBC 1 Kamloops     81)CBC 2 Eastern   121)France Info     161)SRF 1 Basel       201)Nacional d'Andorra  241)Nervión Bilbao  "    
   echo "2)NPR                 42)CBC 1 Kelowna      82)Euronews English122)France Inter    162)SRF 1 Aargau      202)RNE Madrid          242)Popular de Bilbao" 
   echo "3)MPR News            43)CBC 1 Prnc George  83)RT UK           123)RFI Monde       163)SRF 1 Baselland   203)RNE Classica Madrid 243)Rioja Cadena "  
   echo "4)WKSU News           44)CBC 1 Vancouver    84)France 24       124)RFI Afrique     164)SRF 1 Bern        204)RNE 3 Madrid        244)RCM "             
   echo "5)Infowars            45)CBC 1 Victoria     85)DW Englsih      125)Africa no 1     165)SRF 1 Ostschweiz  205)RNE 4 Barcelona     245)RTVA Seville"  
   echo "6)BBC Radio 1         46)CBC 1 Whitehorse   86)CBSN            126)Alta Frequenza  166)SRF 1 Zentralsch  206)RNE 5 Todo Noticias 246)RSI Uno Lugano "  
   echo "7)BBC Radio 2         47)CBC 1 Calgary      87)CNN             127)BFM Paris       167)SRF 1 Zürich      207)ABC Punto           247)RSI Due Lugano "
   echo "8)BBC Radio 3         48)CBC 1 Edmonton     88)Al Jazeera Audio128)Europe 1        168)SRF 2 Kultur      208)Aragón Radio        248)RSI Tre Lugano"
   echo "9)BBC Radio 4         49)CBC 1 Regina       89)RT America      129)Kernews         169)SRF 3             209)Cadena Barcelona    249)---------------"
   echo "10)BBC Radio 5        50)CBC 1 Saskatoon    90)RT English      130)Radio Ici       170)SRF 4 News        210)Cadena Bilbao       250)---------------"
   echo "11)BBC Radio 6        51)CBC 1 Winnipeg     91)Bloomberg Radio 131)Première Chaîne 171)SRF Virus         211)Cadena Sevilla      251)---------------"
   echo "12)BBC Radio 1 Extra  52)CBC 1 Iqaluit      92)BBC World News  132)Espace Musique  172)SRF Musikwelle    212)Cadena Badajoz      252)---------------"
   echo "13)BBC Radio 4 Extra  53)CBC 1 Kitchener    93)--------------- 133)RDI Montreal    173)Argovia Aarau     213)Cadena Valencia     253)---------------"
   echo "14)BBC Radio Sports   54)CBC 1 London       94)--------------- 134)Bel RTL Belgium 174)Bayern 1 Munich   214)Cadena Mallorca     254)---------------"
   echo "15)BBC Radio Asian    55)CBC 1 Ottawa       95)--------------- 135)DH Radio Belgium175)Bayern 2 Munich   215)Cadena Melilla      255)---------------"  
   echo "16)BBC World Service  56)CBC 1 Sudbury      96)--------------  136)RMC Info Monaco 176)B5 Aktuell Munich 216)Cadena Murcia       256)---------------"
   echo "17)RTE Dublin         57)CBC 1 Thunder Bay  97)--------------- 137)RSR La Premiere 177)B5 Plus Munich    217)Cadena Pamplona     257)---------------"
   echo "18)RTE Extra Dublin   58)CBC 1 Toronto      98)--------------- 138)RSR Espace 2    178)Deutschlandfunk   218)Cadena Tenerife     258)---------------"	
   echo "19)106-108 Talk Dublin59)CBC 1 Windsor      99)--------------- 139)RSR Couleur 3   179)Deutschradiokultur219)Cadena Zaragoza     259)---------------"
   echo "20)BFBS UK            60)CBC 1 Montreal     100)-------------- 140)RSR Option      180)hr-info Frankfurt 220)Cadena Santander    260)---------------"  
   echo "21)LBC 1152 AM London 61)CBC 1 Nord Quebec  101)-------------- 141)RTL Radio       181)MDR 1 Dresden     221)Cadena Toledo       261)---------------"
   echo "22)LBC 97.3 FM London 62)CBC 1 Quebec City  102)-------------- 142)--------------- 182)MDR 1 Magdeburg   222)Cadena Valladolid   262)---------------"       
   echo "23)Isles FM Stornoway 63)CBC 1 Fredericton  103)-------------- 143)--------------- 183)MDR 1 Erfurt      223)Cadena Ceuta        263)---------------"  
   echo "24)CPR News Colorado  64)CBC 1 Moncton      104)-------------- 144)--------------- 184)MDR AKTUELL       224)Catalunya Barcelona 264)---------------"
   echo "25)Jupiter Broadcast  65)CBC 1 Saint John   105)-------------- 145)--------------- 185)MDR KULTUR        225)Catalunya Informació265)---------------" 
   echo "26)Genesis GCN        66)CBC 1 Charlottetown106)-------------- 146)--------------- 186)NDR 90,3 Hamburg  226)COM Radio Barcelona 266)---------------"
   echo "27)Republic RBN       67)CBC 1 Cape Breton  107)-------------- 147)--------------- 187)NDR 1 Hannover    227)COPE Cantabria      267)---------------"
   echo "28)24/7 World Radio   68)CBC 1 Halifax      108)-------------- 148)--------------- 188)NDR 1 Schwerin    228)Crónicas Lanzarote  268)---------------"
   echo "29)KPFK               69)CBC 1 Corner Brook 109)-------------- 149)--------------- 189)NDR 1 Flensburg   229)esRadio Madrid      269)---------------"
   echo "30)KPFT               70)CBC 1 Grand Falls  110)-------------- 150)--------------- 190)NDR Kultur        230)esRadio Guadalajara 270)---------------"    
   echo "31)KPFT 2             71)CBC 1 Labrador     111)-------------- 151)--------------- 191)NDR Info          231)Onda Cero Madrid    271)---------------"
   echo "32)WPFW               72)CBC 1 St. Johns    112)-------------- 152)--------------- 192)NDR INDR          232)Onda Cero Noroeste  272)---------------"
   echo "33)WRYR-LP            73)CBC 1 Inuvik       113)-------------  153)--------------- 193)RBB InfoRadio     233)Onda Vasca Bilbao   273)---------------" 
   echo "34)WXOJ-LP            74)CBC 1 Yellowknife  114)-------------  154)--------------- 194)SR 3 Saarbrücken  234)RAC 1 Barcelona     274)---------------"  
   echo "35)WRFN-LP            75)CBC 2 Halifax      115)-------------  155)--------------- 195)SWR RP Mainz      235)Radio Asturias      275)---------------"
   echo "36)Liberty Radio      76)CBC 2 Toronto      116)-------------- 156)--------------- 196)SWR1 BW Stuttgart 236)Radio Bierzo        276)---------------"
   echo "37)1st Amendment      77)CBC 2 Winnipeg     117)-------------  157)--------------- 197)SWR2 Stuttgart    237)Galega Santiago     277)---------------"
   echo "38)Voice of America   78)CBC 2 Edmonton     118)-------------  158)--------------- 198)WDR5 Cologne      238)Galega Música       278)---------------"	
   echo "39)------------       79)CBC 2 Vancouver    119)------------   159)--------------- 199)Wüste Welle       239)Marca Barcelona     279)---------------"
   echo "40)------------       80)CBC 2 Pacific      120)-------------  160)--------------- 200)---------------   240)Menorca Mahón       280)---------------"
   echo "======================================================================================================================================================="
echo " " 
}	

channel_matrix_2()
{
   echo "====================================================    "$product" "$version"   ======================================================================="
   echo "||   Entertainment  ||     Russian        ||     BBC Regional     ||    BBC Regional   ||   COLUMN 12   ||    COLUMN 13   ||    Religious    ||"
   echo "================================================================================================================================================="
   echo "281)Pulse Radio     321)Radio Mayak Moscow  361)BBC Radio 1        401)BBC Shropshire  441)-----------   481)------------- 521)EWTN Radio"    
   echo "282)Old Time Radio  322)Radio Russia Moscow 362)BBC Radio 2        402)BBC Solent      442)-----------   482)------------- 522)EWTN Classic" 
   echo "283)c0vertElectr0   323)Radio Culture Moscow363)BBC Radio 3        403)BBC Somerset    443)-----------   483)------------- 523)EWTN Spanish"  
   echo "284)Deep Banjo      324)Vesti FM Moscow     364)BBC Radio 4        404)BBC Stoke       444)-----------   484)------------- 524)EWTN Ireland"             
   echo "285)Dark Ret        325)Business FM Moscow  365)BBC Radio 4 LW     405)BBC Suffolk     445)-----------   485)------------- 525)EWTN Philippines"  
   echo "286)BaroqueRadio    326)107.4 St Petersburg 366)BBC Radio 4 Extra  406)BBC Sussex      446)-----------   486)------------- 526)--------------"  
   echo "287)AnonyRadio      327)107.5 Ufa           367)BBC 5 Live         407)BBC Tees        447)-----------   487)------------- 527)--------------"
   echo "288)AnonyJazz       328)Gorod FM            368)BBC 5 Live Sports  408)BBC 3 Counties  448)-----------   488)------------- 528)--------------"
   echo "289)--------------- 329)Kommersant          369)BBC 6 Music        409)BBC Wiltshire   449)-----------   489)------------  529)--------------"
   echo "290)--------------- 330)Moskva FM Moscow    370)BBC 1Xtra          410)BBC WM 95.6     450)-----------   490)------------  530)--------------"
   echo "291)--------------- 331)NN Radio Nizhny     371)BBC Asian          411)BBC York        451)-----------   491)------------  531)--------------"
   echo "292)--------------- 332)Radio Moskvy        372)BBC World Service  412)BBC Scotland    452)-----------   492)------------  532)--------------"
   echo "293)--------------- 333)RSN Moscow          373)BBC Berkshire      413)BBC nan Gaidheal453)-----------   493)------------  533)--------------"
   echo "294)--------------- 334)UR-1 Kyiv           374)BBC Bristol        414)BBC Ulster      454)-----------   494)------------  534)--------------"
   echo "295)--------------- 335)UR-2 Promin Kyiv    375)BBC Cambridgeshire 415)BBC Foyle       455)-----------   495)------------  535)--------------"  
   echo "296)--------------- 336)UR-3 Kultura Kyiv   376)BBC Cornwall       416)BBC Wales       456)-----------   496)------------  536)--------------"
   echo "297)--------------- 337)UR-4 Int Kyiv       377)BBC Coventry       417)-----------     457)-----------   497)------------- 537)--------------"
   echo "298)--------------- 338)Business Radio Kyiv 378)BBC Cumbria        418)-----------     458)-----------   498)------------- 538)--------------"	
   echo "299)--------------  339)Ekvator FM Shpola   379)BBC Derby          419)-----------     459)-----------   499)------------- 539)--------------"
   echo "300)--------------- 340)Golos Stolytsi Kyiv 380)BBC Devon          420)-----------     460)-----------   500)------------- 540)--------------"  
   echo "301)--------------- 341)Radio ES Kyiv       381)BBC Essex          421)-----------     461)-----------   501)------------- 541)--------------"
   echo "302)--------------- 342)Radio Vesti Kyiv    382)BBC Gloucestershire422)-----------     462)-----------   502)------------- 542)--------------"       
   echo "303)--------------- 343)-------------       383)BBC Guernsey       423)-----------     463)-----------   503)------------- 543)--------------"  
   echo "304)--------------- 344)-------------       384)BBC Hereford       424)-----------     464)-----------   504)------------- 544)--------------"
   echo "305)--------------- 345)-------------       385)BBC Humberside     425)-----------     465)-----------   505)------------- 545)--------------"  
   echo "306)--------------- 346)-------------       386)BBC Jersey         426)-----------     466)-----------   506)------------- 546)--------------"
   echo "307)--------------- 347)-------------       387)BBC Kent           427)-----------     467)------------  507)------------- 547)--------------"
   echo "308)--------------- 348)-------------       388)BBC Lancashire     428)-----------     468)------------  508)------------- 548)--------------"
   echo "309)--------------- 349)--------------      389)BBC Leeds          429)-----------     469)------------  509)------------- 549)--------------"
   echo "310)--------------- 350)--------------      390)BBC Leicester      430)-----------     470)------------  510)------------- 550)--------------"    
   echo "311)--------------- 351)--------------      391)BBC Lincolnshire   431)-----------     471)------------  511)------------- 551)--------------"
   echo "312)--------------- 352)--------------      392)BBC London 94.9    432)-----------     472)------------  512)------------- 552)--------------"
   echo "313)--------------- 353)--------------      393)BBC Manchester     433)-----------     473)------------  513)------------- 553)--------------" 
   echo "314)--------------- 354)--------------      394)BBC Merseyside     434)-----------     474)------------  514)------------- 554)--------------"  
   echo "315)--------------- 355)--------------      395)BBC Newcastle      435)-----------     475)------------  515)------------- 555)--------------"
   echo "316)--------------- 356)--------------      396)BBC Norfolk        436)-----------     476)------------  516)------------- 556)--------------"
   echo "317)--------------- 357)--------------      397)BBC Northampton    437)-----------     477)------------  517)------------- 557)--------------"
   echo "318)--------------- 358)--------------      398)BBC Nottingham     438)-----------     478)------------  518)------------- 558)--------------"	
   echo "319)--------------- 359)--------------      399)BBC Oxford         439)-----------     479)------------  519)------------- 559)------------- "
   echo "320)--------------- 360)--------------      400)BBC Sheffield      440)-----------     480)------------  520)------------- 560)------------- "
   echo "================================================================================================================================================"
echo " " 
}	

for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo "ENDRADIO: listen to online radio streams behind tor using mpv"
   echo "Type in the terminal $ endradio "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endradio --help         # usage messages"
   echo "$ endradio --version      # print version information"
   echo "$ endradio --list-matrix  # channel list in matrix format"
   echo "$ endradio --list-all     # channel list in column format"
   echo "$ endradio --ua-tor       # use tor-browser user-agent"
   echo "$ endradio --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endradio --ua-ranstr    # use a random string as the user agent" 
   echo "$ endradio  55            # use channel number in command line"  
   echo "$ endradio  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDRADIO: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" == "--list-matrix" ]
   then 
   channel_matrix
   shift
   exit 0
   elif [ "$arg" == "--list-all" ]
   then
   more "$chan_columns"
   shift
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
  rnum=$( expr $( head -c 2 /dev/urandom | od -A n -i ) % 5 ) 
  case $rnum in 
  0) link=http://50.7.79.92:80
     #link=http://stream-aac.infowars.com 
     ;;
  1) link=http://50.7.79.18:80
     #http://stream-aac-us.infowars.com 
     ;;
  2) link=http://50.7.128.195:80
     #http://stream-aac-eu.infowars.com 
     ;;
  3) link=http://192.240.107.116:80
     #http://stream-mp3.infowars.com 
     ;;
  4) link=http://50.7.79.20:80
     #http://stream-mp3-us.infowars.com 
     ;;
  5) link=http://50.7.128.196:80
     #http://stream-mp3-eu.infowars.com 
     ;;
  esac
use_playlist="no"
chan_name="Infowars";;

# 6)  BBC Radio 1
6) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p
use_playlist="no"
chan_name="BBC Radio 1";;
# 7)  BBC Radio 2
7) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio2_mf_p
use_playlist="no"
chan_name="BBC Radio 2";;
# 8)  BBC Radio 3
8) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-aac-lc-a/format/pls/vpid/bbc_radio_three.pls
use_playlist="no"
chan_name=" BBC Radio 3";;
# 9)  BBC Radio 4
9) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio4fm_mf_p
use_playlist="no"
chan_name="BBC Radio 4";;
# 10)  BBC Radio 5
10) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio5live_mf_p
use_playlist="no"
chan_name="BBC Radio 5";;
# 11)  BBC Radio 6
11) link=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p
use_playlist="no"
chan_name="BBC Radio 6";;
# 12)  BBC Radio 1 Extra
12) link=http://www.bbc.co.uk/radio/listen/live/r1x_aaclca.pls
use_playlist="no"
chan_name="BBC Radio 1 Extra";;
# 13)  BBC Radio 4 Extra
13) link=http://www.bbc.co.uk/radio/listen/live/r4x_aaclca.pls
use_playlist="no"
chan_name="BBC Radio 4 Extra";;
# 14)  BBC Radio 5 Live Sports Extra
14) link=http://www.bbc.co.uk/radio/listen/live/r5lsp_aaclca.pls
use_playlist="no"
chan_name="BBC Radio 5 Live Sports Extra";;
# 15)  BBC Radio Asian Extra
15) link=http://www.bbc.co.uk/radio/listen/live/ran_aaclca.pls
use_playlist="no"
chan_name="BBC Radio Asian Extra";;
# 16) BBC World Service Backup
16) link=http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-eieuk_backup
use_paylist="no"
chan_name="BBC World Service";;
# 17) RTE Radio 1 Dublin
17) link=http://www.listenlive.eu/rte1.m3u
use_paylist="no"
chan_name="RTE Radio 1 Dublin";;
# 18) RTE Radio 1 Extra Dublin
18) link=http://www.listenlive.eu/rte1extra.m3u
use_paylist="no"
chan_name="RTE Radio 1 Extra Dublin";;
# 19) News Talk 106-108 Dublin
19) link=http://communicorp.mp3.miisolutions.net:8000/communicorp/Newstalk_low.m3u
use_paylist="no"
chan_name="News Talk 106-108 Dublin";;
# 20) BFBS UK
20) link=http://icy-e-04.sharp-stream.com/ssvcbfbs1.mp3.m3u
use_paylist="no"
chan_name="BFBS UK";;
# 21) LBC 1152 AM London
21) link=http://media-ice.musicradio.com:80/LBC1152.m3u
use_paylist="no"
chan_name="LBC 1152 AM London";;
# 22) LBC 97.3 FM London
22) link=http://media-ice.musicradio.com/LBC973.m3u
use_paylist="no"
chan_name="LBC 97.3 FM London";;
# 23) Isles FM Stornoway
23) link=http://hebrides.tv:8000/islesfm.m3u
use_paylist="no"
chan_name="Isles FM Stornoway";;
# 24) CPR News Colorado
24) link=http://livestream.cprnetwork.org/pls/live_newsinfo_aac.pls
use_paylist="no"
chan_name="CPR News Colorado";;
# 25) Jupiter Broadcasting
25) link=http://jblive.fm/
use_paylist="no"
chan_name="Jupiter Broadcasting";;

# 26) Genesis Communications Network 
26) 

 rnum=$( expr $( head -c 2 /dev/urandom | od -A n -i ) % 6 ) 
 case $rnum in 
 0) link=http://www.gcnlive.com/playlists/live/channel1.m3u ;;
 1) link=http://www.gcnlive.com/playlists/live/channel2.m3u ;;
 2) link=http://www.gcnlive.com/playlists/live/channel3.m3u ;;
 3) link=http://www.gcnlive.com/playlists/live/channel4.m3u ;;
 4) link=http://www.gcnlive.com/playlists/live/channel5.m3u ;;
 5) link=http://www.gcnlive.com/playlists/live/channel6.m3u ;;
 esac

use_playlist="no"
chan_name="Genesis Communications Network";;

# 27) Republic Broadcast Network 
27) link=http://republicbroadcasting.org/32k.pls
use_paylist="no"
chan_name="Republic Broadcast Network";;
# 28) 247 World Radio
28) 
method="mplayer"
#link=http://www.broadcastmatrix.com/optional/247world/winamp.pls
# 173.192.70.138
#link=http://page.cloudradionetwork.com/247radio/stream.php?port=7230
link=http://173.192.70.138:7230
use_paylist="no"
chan_name="24/7 World Radio";;
# 29) KPFK 
29) link=http://ic1.mainstreamnetwork.com/kpfk-fm.m3u
use_paylist="no"
chan_name="KPFK";;
# 30) KPFT
30) link=http://kpft.org/KPFT-hifi.m3u
use_paylist="no"
chan_name="KPFT";;
# 31) KPFT 2
31) link=http://kpft.org/KPFT-HD3-hifi.m3u
use_paylist="no"
chan_name="KPFT 2";;
# 32) WPFW
32) link=http://www.wpfwfm.org:8000/wpfw_128
use_paylist="no"
chan_name="WPFW";;
# 33) WRYR-LP
33) link=http://boa.mediacast1.com:9656/listen.pls
use_paylist="no"
chan_name="WRYR-LP";;
# 34) WXOJ-LP
34) link=http://valleyfree1.serverroom.us:5676/listen.pls
use_paylist="no"
chan_name="WXOJ-LP";;
# 35) WRFN-LP
35) link=http://www.streamlicensing.com/directory/index.cgi/playlist.pls?action=playlist&type=pls&sid=4253&stream_id=8011
use_paylist="no"
chan_name="WRFN-LP";;
# 36)Liberty Radio
36) link=http://lrn.fm/files/lrn.m3u
use_paylist="no"
chan_name="Liberty Radio";;
# 37) First Amendment Radio
37) link=http://firstamendmentradio.net/64k.pls
use_paylist="no"
chan_name="First Amendment Radio";;
# 38) Voice of America
38) link=https://voa28.akacast.akamaistream.net/7/325/437810/v1/ibb.akacast.akamaistream.net/voa28?download=1
use_paylist="no"
chan_name="Voice of America";;
# 39)

# 40)
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
chan_name="CBC Radio 1 Regina,SK";;
# 50) CBC Radio 1 Saskatoon SK Canada
50) link=http://cbc_r1_ssk.akacast.akamaistream.net/7/842/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ssk
use_paylist="no"
chan_name="CBC Radio 1 Saskatoon,SK";;
# 51) CBC Radio 1 Winnipeg MB Canada
51) link=http://cbc_r1_wpg.akacast.akamaistream.net/7/831/451661/v1/rc.akacast.akamaistream.net/cbc_r1_wpg
use_paylist="no"
chan_name="CBC Radio 1 Winnipeg,MB";;	
# 52) CBC Radio 1 Iqaluit NU
52) link=http://cbc_r1_iqa.akacast.akamaistream.net/7/325/451661/v1/rc.akacast.akamaistream.net/cbc_r1_iqa
use_paylist="no"
chan_name="CBC Radio 1 Iqaluit,NU";;
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
# 73) CBC Radio 1  Inuvik NWT Canada
73) link=http://cbc_r1_ink.akacast.akamaistream.net/7/967/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ink
use_paylist="no"
chan_name="CBC Radio 1 Inuvik,NWT";;
# 74) CBC Radio 1  Yellowknife YK Canada
74) link=http://cbc_r1_ykn.akacast.akamaistream.net/7/369/451661/v1/rc.akacast.akamaistream.net/cbc_r1_ykn
use_paylist="no"
chan_name="CBC Radio 1 Yellowknife, YK";;
############### CBC Radio 2
# 75) CBC Radio 2 Halifax NFL Canada
75) link=http://cbc_r2_hfx.akacast.akamaistream.net/7/917/451661/v1/rc.akacast.akamaistream.net/cbc_r2_hfx
use_paylist="no"
chan_name="CBC Radio 2, Halifax NFL";;
# 76) CBC Radio 2 Toronto ON Canada
76) link=http://cbc_r2_tor.akacast.akamaistream.net/7/364/451661/v1/rc.akacast.akamaistream.net/cbc_r2_tor
use_paylist="no"
chan_name="CBC Radio 2, Toronto ON";;
# 77) CBC Radio 2 Winnipeg MB Canada
77) link=http://cbc_r2_wpg.akacast.akamaistream.net/7/233/451661/v1/rc.akacast.akamaistream.net/cbc_r2_wpg
use_paylist="no"
chan_name="CBC Radio 2, Winnipeg MB";;
# 78) CBC Radio 2 Edmonton AB Canada
78) link=http://cbc_r2_edm.akacast.akamaistream.net/7/40/451661/v1/rc.akacast.akamaistream.net/cbc_r2_edm
use_paylist="no"
chan_name="CBC Radio 2, Edmonton AB";;
# 79) CBC Radio 2 Vancouver BC Canada
79) link=http://cbc_r2_vcr.akacast.akamaistream.net/7/773/451661/v1/rc.akacast.akamaistream.net/cbc_r2_vcr
use_paylist="no"
chan_name="CBC Radio 2, Vancouver BC";;
# 80) CBC Radio 2 Pacific Canada
80) link=http://cbc_r2_ipt.akacast.akamaistream.net/7/669/451661/v1/rc.akacast.akamaistream.net/cbc_r2_ipt 
use_paylist="no"
chan_name="CBC Radio 2, Pacific BC";;
# 81) CBC Radio 2 Eastern Canada
81) link=http://cbc_r2_iet.akacast.akamaistream.net/7/50/451661/v1/rc.akacast.akamaistream.net/cbc_r2_iet 
use_paylist="no"
chan_name="CBC Radio 2, Eastern";;	
##############################################################
# 82) Euronews English
82) link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_90p.m3u8
 #link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/5-live.m3u8 
use_paylist="no"
chan_name="Euronews";;	
# 83) RT UK
83) link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
use_paylist="no"
chan_name="RT America";;
# 84) France 24
84) link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master_96.m3u8
use_paylist="no"
chan_name="France 24";;
# 85) DW English
85) 
link=http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/index_5_a-b.m3u8
use_paylist="no"
chan_name="DW English";;
# 86) CBSN
86) 
link="https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8"
torsocks -i wget  --user-agent="$UA" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4"  -O "$playlist_tmp" "$link"
link=$( cat "$playlist_tmp" | awk '{ if ( $0 ~ /320x180/ ) i=NR; if ( NR == i+1 ) { print $0 } } ' | tail -n 1 )
rm "$playlist_tmp"
use_paylist="no"
chan_name="CBSN";;
# 87) CNN
87) 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-b.m3u8
use_paylist="no"
chan_name="CNN";;
# 88) Al Jazeera
88) link=http://players.brightcove.net/665003303001/rJgyhryKx_default/index.html?videoId=5321320347001
use_paylist="no"
chan_name="Al Jazeera";;
# 89) RT America
89) link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8
use_paylist="no"
chan_name="RT America";;
# 90) RT 
90) link=https://secure-streams.akamaized.net/rt/indexaudio.m3u8
use_paylist="no"
chan_name="RT ";;
# 91) Bloomberg Radio 
91)
link="https://17633.live.streamtheworld.com/WBBRAMAAC48/HLS/playlist.m3u8?sbmid=febb23cd-097c-4c94-94c6-9bbfe8a46d93&ttag=device:web"
use_playlist="no"
chan_name="Bloomberg Radio";;

# 91) BBC World News Service 
91)
link="http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-einws_backup"
use_playlist="no"
chan_name="BBC World News";;


########################################
# 121) France Info
121) link=http://www.listenlive.eu/fr_franceinfo128.m3u
use_paylist="no"
chan_name="France Info";;	
# 122) France Info
122) link=http://www.listenlive.eu/fr_franceinter128.m3u
use_paylist="no"
chan_name="France Info";;
# 123) RFI Monde
123) link=http://www.listenlive.eu/rfimonde.m3u
use_paylist="no"
chan_name="RFI Monde";;
# 124) RFI Afrique
124) link=http://www.listenlive.eu/rfiafrique.m3u
use_paylist="no"
chan_name="RFI Afrique";;
# 125) Africa no 1
125) link=http://african1paris.ice.infomaniak.ch/african1paris-128.mp3.m3u
use_paylist="no"
chan_name="Africa no 1";;
# 126) Alta Frequenza Ajaccio 
126) link=http://str80.streamakaci.com:7020/listen.pls
use_paylist="no"
chan_name="Alta Frequenza Ajaccio";;
# 127) BFM Paris 
127) link=http://www.listenlive.eu/bfm.m3u
use_paylist="no"
chan_name="BFM Paris";;
# 128) Europe 1 
128) link=http://www.listenlive.eu/europe1.m3u
use_paylist="no"
chan_name="Europe 1";;
# 129) Kernews  
129) link=http://statslive.infomaniak.ch/playlist/kernews/kernews-128.aac/playlist.m3u
use_paylist="no"
chan_name="Kernews";;
 # 130) Radio Ici Maintenant Paris 
130) link=http://radio.rim952.fr:8000/stream.mp3.m3u
use_paylist="no"
chan_name="Radio Ici Maintenant Paris";;

################# Radio Canada ################################
# 131) Radio Canada Première Chaîne
131) link=http://2QMTL0.akacast.akamaistream.net:80/7/953/177387/v1/rc.akacast.akamaistream.net/2QMTL0
use_paylist="no"
chan_name="Radio Canada Première Chaîne";;
# 132) Radio Canada Espace Musique
132) link=http://7qmtl0.akacast.akamaistream.net/7/445/177407/v1/rc.akacast.akamaistream.net/7QMTL0
use_paylist="no"
chan_name="Radio Canada Espace Musique";;
# 133) Radio Canada RDI
133) link=http://RDIRADIO.akacast.akamaistream.net:80/7/501/177423/v1/rc.akacast.akamaistream.net/RDIRADIO
use_paylist="no"
chan_name="Radio Canada RDI";;
###################################################################
# 134) Bel RTL Brussels Belgium 
134) link=http://www.listenlive.eu/belrtl.m3u
use_paylist="no"
chan_name="Bel RTL Brussels Belgium";;
# 135)DH Radio Brussels Belgium 
135) link=http://www.listenlive.eu/dhradio.m3u
use_paylist="no"
chan_name="DH Radio Brussels Belgium";;
# 136) RMC Info Monaco 
136) link=http://www.listenlive.eu/rmc.m3u
use_paylist="no"
chan_name="RMC Info Monaco";;
# 137) RSR La Premiere Lausanne
137) link=http://stream.srg-ssr.ch/la-1ere/mp3_128.m3u
use_paylist="no"
chan_name="RSR La Premiere Lausanne";;
# 138) RSR Espace 2 Lausanne
138) link=http://stream.srg-ssr.ch/espace-2/mp3_128.m3u
use_paylist="no"
chan_name="RSR Espace 2 Lausanne";;
# 139) RSR Couleur 3  
139) link=http://stream.srg-ssr.ch/couleur3/mp3_128.m3u
use_paylist="no"
chan_name="RSR Couleur 3";;
# 140) RSR Option Musique
140) link=http://stream.srg-ssr.ch/option-musique/mp3_128.m3u
use_paylist="no"
chan_name="RSR Option Musique";;
# 141) RTL Radio Lëtzebuerg Luxembourg
141) link=http://radio.rtl.lu/mp3.pls
use_paylist="no"
chan_name="RTL Radio Lëtzebuerg Luxembourg";;

################# Deutsche ###############################
# Deutsche Schweiz
# 161)  Radio SRF 1 Basel
161) link=http://stream.srg-ssr.ch/drs1/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Basel";;
# 162) Radio SRF 1 Aargau Solothurn 
162) link=http://stream.srg-ssr.ch/regi_ag_so/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Aargau Solothurn";;
# 163) Radio SRF 1 Basel Baselland
163) link=http://stream.srg-ssr.ch/regi_bs_bl/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Basel Baselland";;
# 164) Radio SRF 1 Bern Freibourg Wallis 
164) link=http://stream.srg-ssr.ch/regi_be_fr_vs/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Bern Freibourg Wallis";;
# 165) Radio SRF 1 Ostschweiz
165) link=http://stream.srg-ssr.ch/regi_ost/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Ostschweiz";;
# 166) Radio SRF 1 Zentralschweiz
166) link=http://stream.srg-ssr.ch/regi_zentr/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Zentralschweiz";;
# 167) Radio SRF 1 Zürich Schaffhausen
167) link=http://stream.srg-ssr.ch/regi_zh_sh/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 1 Zürich Schaffhausen";;
# 168) Radio SRF 2 Kultur
168) link=http://stream.srg-ssr.ch/drs1/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 2 Kultur";;
# 169) Radio SRF 3 
169) link=http://stream.srg-ssr.ch/drs3/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 3";;
# 170) Radio SRF 4 News
170) link=http://stream.srg-ssr.ch/drs4news/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF 4 News";;
# 171) Radio SRF Virus
171) link=http://stream.srg-ssr.ch/drsvirus/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF Virus";;
# 172) Radio SRF Musikwelle
172) link=http://stream.srg-ssr.ch/drsmw/mp3_128.m3u
use_paylist="no"
chan_name="Radio SRF Musikwelle";;
# 173) Argovia News Aarau
173) link=http://icecast.argovia.ch/argovianews.m3u
use_paylist="no"
chan_name="Argovia News Aarau";;
# 174) Bayern 1 Munich
174) link=http://streams.br-online.de/bayern1_2.m3u
use_paylist="no"
chan_name="Bayern 1  Munich";;
# 175) Bayern 2 Munich
175) link=http://streams.br-online.de/bayern2_2.m3u
use_paylist="no"
chan_name="Bayern 2  Munich";;
# 176) B5 Aktuell Munich
176) link=http://streams.br-online.de/b5aktuell_2.m3u
use_paylist="no"
chan_name="B5 Aktuell Munich";;	
# 177) B5 Plus Munich 
177) link=http://streams.br-online.de/b5plus_2.m3u
use_paylist="no"
chan_name="B5 Plus Munich";;	
# 178) Deutschlandfunk Cologne
178) link=http://www.dradio.de/streaming/dlf.m3u
use_paylist="no"
chan_name="Deutschlandfunk Cologne";;
# 179) Deutschlandradiokultur Berlin
179) link=http://www.dradio.de/streaming/dkultur.m3u
use_paylist="no"
chan_name="Deutschlandradiokultur Berlin";;
# 180) hr-info Frankfurt
180) link=http://metafiles.gl-systemhaus.de/hr/hrinfo_2.m3u
use_paylist="no"
chan_name="hr-info Frankfurt";;
# 181) MDR 1 Radio Sachsen Dresden 
181) link=http://avw.mdr.de/livestreams/mdr1_radio_sachsen_live_128.m3u
use_paylist="no"
chan_name="MDR 1 Radio Sachsen Dresden";;
# 182) MDR 1 Radio Sachsen-Anhalt Magdeburg 
182) link=http://avw.mdr.de/livestreams/mdr1_radio_sachsen-anhalt_live_128.m3u
use_paylist="no"
chan_name="MDR 1 Radio Sachsen-Anhalt Magdeburg";;
# 183) MDR 1 Radio Thüringen Erfurt 
183) link=http://avw.mdr.de/livestreams/mdr1_radio_thueringen_live_128.m3u
use_paylist="no"
chan_name="MDR 1 Radio Thüringen Erfurt";;
# 184) MDR AKTUELL Livestream Leipzig 
184) link=http://avw.mdr.de/livestreams/mdr_aktuell_live_128.m3u
use_paylist="no"
chan_name="MDR AKTUELL Livestream Leipzig";;
# 185) MDR KULTUR Livestream Halle  
185) link=http://avw.mdr.de/livestreams/mdr_kultur_live_128.m3u
use_paylist="no"
chan_name="MDR KULTUR Livestream Halle";;
# 186) NDR 90,3 Hamburg   
186) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndr903.m3u
use_paylist="no"
chan_name="NDR 90,3 Hamburg";;
# 187) NDR 1 Niedersachsen Hannover
187) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndr1niedersachsen.m3u
use_paylist="no"
chan_name="NDR 1 Niedersachsen Hannover";;
# 188) NDR 1 Radio MV Schwerin
188) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndr1radiomv.m3u
use_paylist="no"
chan_name="NDR 1 Radio MV Schwerin";;
# 189) NDR 1 Welle Nord Flensburg 
189) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndr1wellenord.m3u
use_paylist="no"
chan_name="NDR 1 Welle Nord Flensburg";;
# 190) NDR Kultur Hamburg  
190) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndrkultur.m3u
use_paylist="no"
chan_name="NDR Kultur Hamburg" ;;
# 191) NDR Info Hamburg 
191) link=http://www.ndr.de/resources/metadaten/audio/m3u/ndrinfo.m3u
use_paylist="no"
chan_name="NDR Info Hamburg" ;;
# 192) NDR INDR Info Spezia Hamburg 
192) link=http://ndrstream.ic.llnwd.net/stream/ndrstream_ndrinfo_spezial_hi_mp3.m3u
use_paylist="no"
chan_name="NDR INDR Info Spezia Hamburg" ;;
# 193) RBB InfoRadio Berlin 
193) link=http://www.inforadio.de/live.m3u
use_paylist="no"
chan_name="RBB InfoRadio Berlin" ;; 
# 194) SR 3 Saarlandwelle Saarbrücken 
194) link=http://streaming01.sr-online.de/sr3_2.m3u
use_paylist="no"
chan_name="SR 3 Saarlandwelle Saarbrücken" ;; 
# 195) SWR RP Mainz 
195) link=http://mp3-live.swr.de/swr1rp_m.m3u
use_paylist="no"
chan_name="SWR RP Mainz" ;; 
# 196) SWR1 BW Stuttgart 
196) link=http://mp3-live.swr.de/swr1bw_m.m3u
use_paylist="no"
chan_name="SWR1 BW Stuttgart" ;; 
# 197) SWR2 Stuttgart 
197) link=http://mp3-live.swr.de/swr2_m.m3u
use_paylist="no"
chan_name="SWR2 Stuttgart" ;; 
# 198) WDR5 Cologne 
198) link=http://www.wdr.de/wdrlive/media/wdr5.m3u
use_paylist="no"
chan_name="WDR5 Cologne" ;; 
# 199) Wüste Welle Tübingen 
199) link=http://livestream.wueste-welle.de:8000/mp3.m3u
use_paylist="no"
chan_name="Wüste Welle Tübingen" ;; 

#################### SPANISH ###############################
# 201) Radio Nacional d'Andorra Andorra la Vella
201) link=mms://194.158.91.91/Rna
use_paylist="no"
chan_name="Radio Nacional d'Andorra Andorra la Vella";; 
# 202) RNE Radio Nacional Madrid
202) link=http://www.listenlive.eu/rneradio1.m3u
use_paylist="no"
chan_name="RNE Radio Nacional Madrid";;
# 203) RNE Radio Clásica Madrid
203) link=http://www.listenlive.eu/rneradioclasica.m3u
use_paylist="no"
chan_name="RNE Radio Clásica Madrid";;
# 204) RNE Radio 3 Madrid
204) link=http://www.listenlive.eu/rneradio3.m3u
use_paylist="no"
chan_name="RNE Radio 3 Madrid";;
# 205) RNE Ràdio 4 Barcelona
205) link=http://www.listenlive.eu/rneradio4.m3u
use_paylist="no"
chan_name="RNE Ràdio 4 Barcelona";;
# 206) RNE Radio 5 Todo Noticias Madrid
206) link=http://www.listenlive.eu/rneradio5.m3u
use_paylist="no"
chan_name="RNE Radio 5 Todo Noticias Madrid";;
# 207) ABC Punto Radio Tenerife
207) link=http://94.23.22.181:8031/listen.pls
use_paylist="no"
chan_name="ABC Punto Radio Tenerife";;
# 208) Aragón Radio Zaragoza
208) link=mms://aragonfmwmlive.fplive.net/aragonfmwmlive-live/aragonradio01
use_paylist="no"
chan_name="Aragón Radio Zaragoza";;
# 209) Cadena Ser Radio Barcelona
209) link=http://playerservices.streamtheworld.com/pls/SER_BARCELONA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Barcelona";;
# 210) Cadena Ser Radio Bilbao
210) link=http://provisioning.streamtheworld.com/pls/SER_BILBAO.pls
use_paylist="no"
chan_name="Cadena Ser Radio Bilbao";;
# 211) Cadena Ser Radio Sevilla
211) link=http://provisioning.streamtheworld.com/pls/SER_SEVILLA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Sevilla";;
# 212) Cadena Ser Extremadura Badajoz
212) link=http://provisioning.streamtheworld.com/pls/SER_Extremadura.pls
use_paylist="no"
chan_name="Cadena Ser Extremadura Badajoz";;
# 213) Cadena Ser Radio Valencia
213) link=http://provisioning.streamtheworld.com/pls/SER_VALENCIA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Valencia";;
# 214) Cadena Ser I.Ballears Mallorca 
214) link=http://provisioning.streamtheworld.com/pls/SER_MALLORCA.pls
use_paylist="no"
chan_name="Cadena Ser I.Ballears Mallorca";;
# 215) Cadena Ser Radio Melilla
215) link=http://provisioning.streamtheworld.com/pls/SER_MELILLA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Melilla";;
# 216) Cadena Ser Radio Murcia
216) link=http://provisioning.streamtheworld.com/pls/SER_MURCIA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Murcia";;
# 217) Cadena Ser Radio Pamplona Pamplona
217) link=http://provisioning.streamtheworld.com/pls/SER_PAMPLONA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Pamplona Pamplona";;
# 218) Cadena Ser Radio Club Tenerife Santa Cruz de Tenerife
218) link=http://provisioning.streamtheworld.com/pls/SER_TENERIFE.pls
use_paylist="no"
chan_name="Cadena Ser Radio Club Tenerife Santa Cruz de Tenerife";;
# 219) Cadena Ser Radio Zaragoza
219) link=http://provisioning.streamtheworld.com/pls/SER_ZARAGOZA.pls
use_paylist="no"
chan_name="Cadena Ser Radio Zaragoza";;
# 220) Cadena Ser Santander 
220) link=http://provisioning.streamtheworld.com/pls/SER_SANTANDER.pls
use_paylist="no"
chan_name="Cadena Ser Santander";;
# 221) Cadena Ser Toledo
221) link=http://provisioning.streamtheworld.com/pls/SER_TOLEDO.pls
use_paylist="no"
chan_name="Cadena Ser Toledo";;
# 222) Cadena Ser Radio Valladolid Valladolid
222) link=http://provisioning.streamtheworld.com/pls/SER_VALLADOLID.pls
use_paylist="no"
chan_name="Cadena Ser Radio Valladolid Valladolid";;
# 223) Cadena Ser Ceuta
223) link=http://provisioning.streamtheworld.com/pls/SER_CEUTA.pls
use_paylist="no"
chan_name="Cadena Ser Ceuta";;
# 224) Catalunya Ràdio Barcelona
224) link=http://www.catradio.cat/directes/catradio_http.m3u
use_paylist="no"
chan_name="Catalunya Ràdio Barcelona";;
# 225) Catalunya Informació
225) link=http://www.catradio.cat/directes/catinfo_http.m3u
use_paylist="no"
chan_name="Catalunya Informació";;
# 226) COM Radio Barcelona
226) link=http://comradio-streaming.gnuine.com:8100/mac22.m3u
use_paylist="no"
chan_name="COM Radio Barcelona";;
# 227) COPE Cantabria Santander
227) link=http://www.deportescopecantabria.com:8000/listen.pls
use_paylist="no"
chan_name="COPE Cantabria Santander";;
# 228) Crónicas Radio Lanzarote
228) link=http://85.48.192.60:8000/listen.pls
use_paylist="no"
chan_name="Crónicas Radio Lanzarote";;
# 229) esRadio Madrid
229) link=http://livestreaming3.esradio.fm/stream64.mp3.m3u
use_paylist="no"
chan_name="esRadio Madrid";;
# 230) esRadio Guadalajara
230) link=http://91.121.68.52:8054/listen.pls
use_paylist="no"
chan_name="esRadio Guadalajara";;
# 231) Onda Cero Radio Madrid
231) link=http://ondacerolivewm.fplive.net/ondacerowmlive-live/oc_madrid
use_paylist="no"
chan_name="Onda Cero Radio Madrid";;
# 232) Onda Cero Noroeste
232) link=http://escuchar.ondaceronoroeste.es/playlists/ondacero.m3u
use_paylist="no"
chan_name="Onda Cero Noroeste";;
# 233) Onda Vasca Bilbao
233) link=http://shoutcast.zeroa.stream.ntteo.flumotion.com/zeroa/shoutcast.mp3.m3u
use_paylist="no"
chan_name="Onda Vasca Bilbao";;
# 234) RAC 1 Barcelona
234) link=http://www.rac1.org/audio/Player/nou_rac1.pls
use_paylist="no"
chan_name="RAC 1 Barcelona";;
# 235) Radio Asturias SER Oviedo
235) link=http://194.169.201.177:8085/radioasturias.m3u
use_paylist="no"
chan_name="Radio Asturias SER Oviedo";;
# 236) Radio Bierzo Ponferrada
236) link=mms://80.34.10.12:7007/
use_paylist="no"
chan_name="Radio Bierzo Ponferrada";;
# 237) Radio Galega Santiago de Compostela
237) link=http://85.91.64.29/listen.pls?sid=1
use_paylist="no"
chan_name="Radio Galega Santiago de Compostela";;
# 238) Radio Galega Música Santiago de Compostela
238) link=http://85.91.64.29/listen.pls?sid=2
use_paylist="no"
chan_name="Radio Galega Música Santiago de Compostela";;
# 239) Radio Marca Barcelona
239) link=http://radioweb.radiomarcabarcelona.com:9000/stream.m3u
use_paylist="no"
chan_name="Radio Marca Barcelona";;
# 240) Radio Menorca SER Mahón
240) link=http://server7.20comunicacion.com:8040/listen.pls
use_paylist="no"
chan_name="Radio Menorca SER Mahón";;
# 241) Radio Nervión Bilbao
241) link=http://radionervion.streaming-pro.com:8010/listen.pls
use_paylist="no"
chan_name="Radio Nervión Bilbao";;
# 242) Radio Popular de Bilbao
242) link=http://centova.nsprimario.com/tunein.php/radiopopular/playlist.pls
use_paylist="no"
chan_name="Radio Popular de Bilbao";;
# 243) Radio Rioja Cadena Ser
243) link=http://streaming.radiorioja.es:9996/listen.pls
use_paylist="no"
chan_name="Radio Rioja Cadena Ser";;
# 244) RCM
244) link=http://podcast.rtvcm.es:8000/stream.m3u
use_paylist="no"
chan_name="RCM";;
# 245) RTVA Radio Andalucía Información Seville
245) link=http://radioandalucia.rtva.stream.flumotion.com/rtva/radioandalucia.mp3.m3u
use_paylist="no"
chan_name="RTVA Radio Andalucía Información Seville";;
################## ITALIAN ##################################
# Svizzera Italiana:
# 246) RSI Rete Uno Lugano
246) link=http://stream.srg-ssr.ch/reteuno/mp3_128.m3u
use_paylist="no"
chan_name="RSI Rete Uno Lugano";;
# 247) RSI Rete Due Lugano
247) link=http://stream.srg-ssr.ch/retedue/mp3_128.m3u
use_paylist="no"
chan_name="RSI Rete Due Lugano";;
# 248) RSI Rete Tre Lugano
248) link=http://stream.srg-ssr.ch/retetre/mp3_128.m3u
use_paylist="no"
chan_name="RSI Rete Tre Lugano";;
##########################################################################

# 281) Pulse Radio
281) link=http://stream.pulsradio.com:5000/
use_paylist="no"
chan_name="Pulse Radio";;
# 282) Old Time Radio
282) link=http://www.otrfan.com:8000/stream.m3u 
use_paylist="no"
chan_name="Old Time Radio";;
# 283) c0vertElectr0
283) link=http://76qugh5bey5gum7l.onion/c0vertElectr0   
use_paylist="yes"
chan_name="c0vertElectr0";;
# 284) DeepBanjo
284) link=http://76qugh5bey5gum7l.onion/DeepBanjo  
use_paylist="yes"
chan_name="DeepBanjo";;
# 285) DarkRet
285) link=http://76qugh5bey5gum7l.onion/DarkRet  
use_paylist="yes"
chan_name="DarkRet";;
# 286) BaroqueRadio
286) link=http://76qugh5bey5gum7l.onion/BaroqueRadio  
use_paylist="yes"
chan_name="Baroque Radio";;
# 287) Anony Radio
287) link=http://76qugh5bey5gum7l.onion/AnonyRadio 
use_paylist="yes"
chan_name="Anony Radio";;
# 288) Anony Jazz
288) link=http://76qugh5bey5gum7l.onion/AnonyJazz 
use_paylist="yes"
chan_name="Anony Jazz";;



############################################################################
###################### RUSSIAN #########################################
# 321) Radio Mayak Moscow
321) link=http://www.listenlive.eu/ru_mayak.m3u 
use_paylist="no"
chan_name="Radio Mayak Moscow";;
# 322) Radio Russia Moscow 
322) link=http://www.listenlive.eu/ru_rus.m3u 
use_paylist="no"
chan_name="Radio Russia Moscow";;
# 323) Radio Culture Moscow
323) link=http://www.listenlive.eu/ru_kultura.m3u 
use_paylist="no"
chan_name="Radio Culture Moscow";;
# 324) Vesti FM Moscow
324) link=http://www.listenlive.eu/ru_vestifm.m3u 
use_paylist="no"
chan_name="Vesti FM Moscow";;
# 325) Business FM Moscow
325) link=http://m1.bfm.ru:8000/fm64.m3u 
use_paylist="no"
chan_name="Business FM Moscow";;
# 326) Business FM 107.4 St Petersburg
326) link=http://www.listenlive.eu/businessfmspb.m3u 
use_paylist="no"
chan_name="Business FM 107.4 St Petersburg";;
# 327) Business FM 107.5 Ufa
327) link=http://92.50.139.190:8000/listen.pls 
use_paylist="no"
chan_name="Business FM 107.5 Ufa";;
# 328) Gorod FM Ekaterinburg
328) link=http://radio.gorodfm.ru:8000/gorodfm.m3u 
use_paylist="no"
chan_name="Gorod FM Ekaterinburg";;
# 329) Kommersant FM Moscow
329) link=http://www.listenlive.eu/kommersant.m3u 
use_paylist="no"
chan_name="Kommersant FM Moscow";;
# 330) Moskva FM Moscow
330) link=http://livestream.rfn.ru:8080/moscowfm128.m3u 
use_paylist="no"
chan_name="Moskva FM Moscow";;
# 331) NN Radio Nizhny Novgorod
331) link=http://cast.r52.ru:8000/nrd.m3u 
use_paylist="no"
chan_name="NN Radio Nizhny Novgorod";;
# 332) Radio Moskvy Moscow
332) link=http://livestream.rfn.ru:8080/moscowtalk128.m3u 
use_paylist="no"
chan_name="Radio Moskvy Moscow";;
# 333) Radio RSN Moscow
333) link=http://www.listenlive.eu/radiorsn.m3u 
use_paylist="no"
chan_name="Radio RSN Moscow";;

############## UKRAINE
# 334) UR-1 Kyiv 
334) link=http://nrcu.gov.ua:8000/ur1-mp3.m3u 
use_paylist="no"
chan_name="UR-1 Kyiv";;
# 335) UR-2 Promin Kyiv 
335) link=http://nrcu.gov.ua:8000/ur2-mp3.m3u 
use_paylist="no"
chan_name="UR-2 Promin Kyiv";;
# 336) UR-3 Kultura Kyiv 
336) link=http://nrcu.gov.ua:8000/ur3-mp3.m3u 
use_paylist="no"
chan_name="UR-3 Kultura Kyiv";;
# 337) UR-4 International Kyiv 
337) link=http://nrcu.gov.ua:8000/ur4-mp3.m3u 
use_paylist="no"
chan_name="UR-4 International Kyiv";;
# 338) Business Radio Kyiv 
338) link=http://217.20.164.163:8018/listen.pls 
use_paylist="no"
chan_name="Business Radio Kyiv";;
# 339) Ekvator FM Shpola
339) link=http://212.1.95.94:8000/EkvatorFM.m3u 
use_paylist="no"
chan_name="Ekvator FM Shpola";;
# 340) Golos Stolytsi Kyiv
340) link=http://cast.radiogroup.com.ua:8000/106fm.m3u 
use_paylist="no"
chan_name="Golos Stolytsi Kyiv";;
# 341) Radio ES Kyiv 
341) link=http://live.galaradio.com:8000/kiev.m3u 
use_paylist="no"
chan_name="Radio ES Kyiv";;
# 342) Radio Vesti Kyiv  
342) link=http://212.26.132.60:8000/vesti_mp3.m3u
use_paylist="no"
chan_name="Radio Vesti Kyiv";;

############### BBC Regional ##########################
# 361) BBC Radio 1 
361) link=http://www.listenlive.eu/bbcradio1.m3u 
use_paylist="no"
chan_name="BBC Radio 1 ";;
# 362) BBC Radio 2 
362) link=http://www.listenlive.eu/bbcradio2.m3u 
use_paylist="no"
chan_name="BBC Radio 2 ";;
# 363) BBC Radio 3 
363) link=http://www.listenlive.eu/bbcradio3.m3u 
use_paylist="no"
chan_name="BBC Radio 3 ";;
# 364) BBC Radio 4 
364) link=http://www.listenlive.eu/bbcradio4.m3u 
use_paylist="no"
chan_name="BBC Radio 4 ";;
# 365) BBC Radio 4 LW 
365) link=http://www.listenlive.eu/bbcradio4lw.m3u 
use_paylist="no"
chan_name="BBC Radio 4 LW";;
# 366) BBC Radio 4 Extra
366) link=http://www.listenlive.eu/bbcradio4extra.m3u 
use_paylist="no"
chan_name="BBC Radio 4 Extra";;
# 367) BBC 5 Live 
367) link=http://www.listenlive.eu/bbc5live.m3u 
use_paylist="no"
chan_name="BBC 5 Live";;
# 368) BBC 5 Live Sports Extra 
368) link=http://www.listenlive.eu/bbc5liveextra.m3u 
use_paylist="no"
chan_name="BBC 5 Live Sports Extra ";;
# 369) BBC 6 Music 
369) link=http://www.listenlive.eu/bbc6music.m3u 
use_paylist="no"
chan_name="BBC 6 Music";;
# 370) BBC 1Xtra
370) link=http://www.listenlive.eu/bbc1xtra.m3u 
use_paylist="no"
chan_name="BBC 1Xtra";;
# 371) BBC Asian Network
371) link=http://www.listenlive.eu/bbcasian.m3u  
use_paylist="no"
chan_name="BBC Asian Network";;
# 372) BBC World Service 
372) link=http://www.bbc.co.uk/worldservice/meta/live/mp3/eneuk.pls  
use_paylist="no"
chan_name="BBC World Service";;
# 373) BBC Radio Berkshire Reading 
373) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_berkshire/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Berkshire Reading";;
# 374) BBC Radio Bristol 
374) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_bristol/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Bristol";;
# 375) BBC Radio Cambridgeshire 
375) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_cambridge/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Cambridgeshire";;
# 376) BBC Radio Cornwall Truro 
376) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_cornwall/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Cornwall Truro";;
# 377) BBC Coventry and Warwickshire 
377) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_coventry_warwickshire/format/pls.pls  
use_paylist="no"
chan_name="BBC Coventry and Warwickshire";;
# 378) BBC Radio Cumbria Carlisle 
378) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_cumbria/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Cumbria Carlisle";;
# 379) BBC Radio Derby 
379) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_derby/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Derby";;
# 380) BBC Radio Devon Plymouth 
380) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_devon/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Devon Plymouth";;
# 381) BBC Essex Chelmsford 
381) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_essex/format/pls.pls  
use_paylist="no"
chan_name="BBC Essex Chelmsford";;
# 382) BBC Radio Gloucestershire 
382) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_gloucestershire/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Gloucestershire";;
# 383) BBC Radio Guernsey St Sampson's 
383) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_guernsey/format/pls.pls  
use_paylist="no"
chan_name="BBC Radio Guernsey St Sampson's";;
# 384) BBC Hereford/Worcester
384) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_hereford_worcester/format/pls.pls  
use_paylist="no"
chan_name="BBC Hereford/Worcester";;
# 385) BBC Radio Humberside 
385) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_humberside/format/pls.pls 
use_paylist="no"
chan_name="BBC Radio Humberside";;
# 386)BBC Radio Jersey St.Helier 
386) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_jersey/format/pls.pls 
use_paylist="no"
chan_name="BBC Radio Jersey St.Helier";;
# 387) BBC Radio Kent Maidstone 
387) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_kent/format/pls.pls 
use_paylist="no"
chan_name="BBC Radio Kent Maidstone";;
# 388) BBC Radio Lancashire 
388) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_lancashire/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Lancashire";;
# 389) BBC Radio Leeds  
389) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_leeds/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Leeds";;
# 390) BBC Radio Leicester 
390) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_leicester/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Leicester";;
# 391) BBC Radio Lincolnshire 
391) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_lincolnshire/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Lincolnshire";;
# 392) BBC London 94.9 
392) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_london/format/pls.pls
use_paylist="no"
chan_name="BBC London 94.9";;
# 393) BBC Radio Manchester 
393) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_manchester/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Manchester";;
# 394) BBC Radio Merseyside
394) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_merseyside/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Merseyside";;
# 395) BBC Newcastle
395) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_newcastle/format/pls.pls
use_paylist="no"
chan_name="BBC Newcastle";;
# 396) BBC Radio Norfolk 
396) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_norfolk/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Norfolk";;
# 397) BBC Radio Northampton 
397) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_northampton/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Northampton";;
# 398) BBC Radio Nottingham 
398) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_nottingham/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Nottingham";;
# 399) BBC Radio Oxford 
399) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_oxford/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Oxford";;
# 400) BBC Radio Sheffield 
400) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_sheffield/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Sheffield";;
# 401) BBC Radio Shropshire 
401) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_shropshire/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Shropshire";;
# 402) BBC Radio Solent 
402) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_solent/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Solent";;
# 403) BBC Somerset 
403) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_somerset_sound/format/pls.pls
use_paylist="no"
chan_name="BBC Somerset";;
# 404) BBC Radio Stoke 
404) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_stoke/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Stoke";;
# 405) BBC Radio Suffolk
405) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_suffolk/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Suffolk";;
# 406) BBC Sussex
406) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_sussex/format/pls.pls
use_paylist="no"
chan_name="BBC Sussex";;
# 407) BBC Tees 
407) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_tees/format/pls.pls
use_paylist="no"
chan_name="BBC Tees";;
# 408) BBC Three Counties Radio 
408) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_three_counties_radio/format/pls.pls
use_paylist="no"
chan_name="BBC Three Counties Radio";;
# 409) BBC Wiltshire 
409) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_wiltshire/format/pls.pls
use_paylist="no"
chan_name="BBC Wiltshire";;
# 410) BBC WM 95.6  
410) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_wm/format/pls.pls
use_paylist="no"
chan_name="BBC WM 95.6";;
# 411)  BBC Radio York 
411) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_york/format/pls.pls
use_paylist="no"
chan_name="BC Radio York";;
# 412) BBC Radio Scotland 
412) link=http://www.listenlive.eu/bbcradioscotland.m3u
use_paylist="no"
chan_name="BBC Radio Scotland";;
# 413) BBC Radio nan Gaidheal 
413) link=http://www.listenlive.eu/bbcradionangaidheal.m3u
use_paylist="no"
chan_name="BBC Radio nan Gaidheal";;
# 414) BBC Radio Ulster 
414) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_ulster/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Ulster";;
# 415) BBC Radio Foyle 
415) link=http://open.live.bbc.co.uk/mediaselector/5/select/version/2.0/mediaset/http-icy-mp3-a/vpid/bbc_radio_foyle/format/pls.pls
use_paylist="no"
chan_name="BBC Radio Foyle";;
# 416) BBC Radio Wales 
416) link=http://www.listenlive.eu/bbcradiowales.m3u
use_paylist="no"
chan_name="BBC Radio Wales";;

############################   RELIGIOUS  ##########################################
# 521) EWTN 1 
521) 
link=http://audiocdn.mainstreaming.tv/101160/radio-english-mp3
#link=http://ewtn.mp3.miisolutions.net/ewtnradioenglish/mp3
use_paylist="no"
chan_name="EWTN Radio";;
# 522) EWTN Classics 
522) 
link=http://audiocdn.mainstreaming.tv/101164/radio-classics-mp3
#link=http://ewtn.mp3.miisolutions.net/ewtnradioplus/mp3
use_paylist="no"
chan_name="EWTN Classic";;
# 523) EWTN Spanish
523) 
link=http://audiocdn.mainstreaming.tv/101162/radio-spanish-mp3
#link=http://ewtn.mp3.miisolutions.net/ewtnradiospanish/mp3
use_paylist="no"
chan_name="EWTN Spanish";;
# 524) EWTN Ireland /GB
524) 
link=http://audiocdn.mainstreaming.tv/101168/radio-sky-mp3
use_paylist="no"
chan_name="EWTN Ireland /GB";;
# 525) EWTN Philippines
525) 
link=http://audiocdn.mainstreaming.tv/101166/radio-philippines-mp3
#link=http://ewtn.mp3.miisolutions.net/ewtnradiospanish/mp3
use_paylist="no"
chan_name="EWTN Philippines";;



esac

}

############################  FUNCTIONS   ####################################################
# Function to check the menu status
menu_status()
{
input=$1
if [ "$input" == "" ]
then
chan_state="return"
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
elif [ "$input" == "ua-tor" ]
then
menstat="yes"
menu="$menu"
uastate="tor"
uamode="on"
elif [ "$input" == "ua-row1" ]
then
menstat="yes"
menu="$menu"
uastate="row1"
uamode="on"
elif [ "$input" == "ua-rand" ]
then
menstat="yes"
menu="$menu"
uastate="rand"
uamode="on"
elif [ "$input" == "ua-ranstr" ]
then
menstat="yes"
menu="$menu"
uastate="ranstr"
uamode="on"
elif [ "$input" == "ua-off" ]
then
menstat="yes"
menu="$menu"
uastate="off"
uamode="off"
elif [ "$input" == "+" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "+++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "++++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "-" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == "--" ]
then
menstat="no"
chan_state="-"
elif [ "$input" -lt 600 ]
then
menstat="no"
chan_state="numeric"
else
menstat="no"
chan_state="alpha"
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
echo "Please Select a Number corresponding to an Internet Radio Stream, press + to increment, - to decrement, n for the next menu, or q to quit:" ;;
n) channel_matrix_2
echo "Please Select a Number corresponding to an Internet Radio Stream, press + to increment, - to decrement, m for the main menu, or q to quit:" ;;
esac
}

################################### MAIN PROGRAM #################################################

# initialize menu
menu="m"
method="normal"


### Select the user agent
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


if [ "$1" != "" ]
then
echo "$1"
# take channel input from command line
entry="$1" 
elif [ "$1" == "" ]
then
channel_matrix
echo "Please Select a Number corresponding to an Internet Radio Live Stream:"

read entry
num="$entry"

  if [ "$entry" == "q" ]
  then 
  echo "Type endradio to open a new stream."
  exit "$?"
  elif [ "$entry" == "" ]
  then
  entry=1
  num="$entry"
  fi
fi

menu_status $entry

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$1"
elif [ "$chan_state" == "numeric" ]
then
num="$entry"
else 
num="$num"
fi

# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select "$num"
 echo "$chan_name Channel $num"
 
 
 if [ "$uamode" == "on" ]
  then 
  echo "$UA"

  if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --user-agent="$UA" --no-video --cache="$cache_size" --loop-playlist=inf --stream-lavf-o=timeout=10000000 --playlist="$link" 
  elif [ "$method" == "stream_dump" ]
  then
     if  [ -s "$pidstore" ]
     then
     firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix mplayer "$stream_dump" 
     echo "wait for a couple of seconds for more data to load and then try the station again"
     sleep 3
     else
     torsocks wget --user-agent="$UA" --header="$HEAD1" --header=--"$HEAD2" --header="$HEAD3" --header=="$HEAD4" -b -q -O "$stream_dump" "$link" 1> "$pidstore"
     echo "wait for a couple of seconds and try the station again"
     sleep 3
     fi 
  elif [ "$method" == "mplayer" ]
  then 
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mplayer -novideo -cache "$cache_size" -playlist "$link" 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --user-agent="$UA" --no-video --cache="$cache_size" "$link" 
  fi
  
 else
 
   if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --no-video --cache="$cache_size" --loop-playlist=inf --stream-lavf-o=timeout=10000000 --playlist="$link" 
  elif [ "$method" == "stream_dump" ]
  then
     if  [ -s "$pidstore" ]
     then
     firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix mplayer "$stream_dump" 
     echo "wait for a couple of seconds for more data to load and then try the station again"
     sleep 3
     else
     torsocks wget -b -q -O "$stream_dump" "$link" 1> "$pidstore"
     echo "wait for a couple of seconds and try the station again"
     sleep 3
     fi 
  elif [ "$method" == "mplayer" ]
  then 
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mplayer -novideo -cache "$cache_size" "$link" 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --no-video --cache="$cache_size" "$link" 
  fi
 fi

if [ "$method" == "$stream_dump" ]
then
 if [ -s "$stream_dump" ]
 then
 rm -f "$stream_dump"
 fi
fi
  
 menu_switch "$menu" 
 echo "You were watching "$chan_name" on Channel "$num" "
 chan_state="normal"
 method="normal"
 read entry
 else 
 menu_switch "$menu"
 read entry

fi

while [ "$entry" != q ]
do

### Select the user agent
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

menu_status $entry

if [ "$entry" == "q" ]
then 
echo "Type endradio to open a new stream."
exit "$?"
fi

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
elif [ "$chan_state" == "numeric" ]
then
num="$entry"
else 
num="$num"
fi

if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name Channel $num"


 if [ "$uamode" == "on" ]
  then 
  echo "$UA"

  if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --user-agent="$UA" --no-video --cache="$cache_size" --loop-playlist=inf --stream-lavf-o=timeout=10000000 --playlist="$link" 
  elif [ "$method" == "stream_dump" ]
  then
     if  [ -s "$pidstore" ]
     then
     firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix mplayer "$stream_dump" 
     echo "wait for a couple of seconds for more data to load and then try the station again"
     sleep 2
     else
     torsocks wget --user-agent="$UA" --header="$HEAD1" --header="$HEAD2" --header="$HEAD3" --header="$HEAD4" -b -q -O "$stream_dump" "$link" 1> "$pidstore"
     echo "wait for a couple of seconds and try the station again"
     sleep 2
     fi 
  elif [ "$method" == "mplayer" ]
  then 
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mplayer -novideo -cache "$cache_size" -playlist "$link" 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --user-agent="$UA" --no-video --cache="$cache_size" "$link" 
  fi
  
 else
 
  if [ "$use_playlist" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --no-video --cache="$cache_size" --loop-playlist=inf --stream-lavf-o=timeout=10000000 --playlist="$link" 
  elif [ "$method" == "stream_dump" ]
  then
     if  [ -s "$pidstore" ]
     then
     firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix mplayer "$stream_dump" 
     echo "wait for a couple of seconds for more data to load and then try the station again"
     sleep 2
     else
     torsocks wget -b -q -O "$stream_dump" "$link" 1> "$pidstore"
     echo "wait for a couple of seconds and try the station again"
     sleep 2
     fi 
  elif [ "$method" == "mplayer" ]
  then 
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mplayer -novideo -cache "$cache_size" "$link" 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet torsocks -i mpv --no-video --cache="$cache_size" "$link" 
  fi
   
 fi
  
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
method="normal"
read entry
else 
menu_switch "$menu"
chan_state="normal"
method="normal"
menstat="no"
read entry

fi
done

echo "Type endradio to open a new streaming session."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

## clean up pid and stream dump
if [ -s "$pidstore" ]
then
kill -9 $(cut -d . -f 1 "$pidstore" | awk '{ print $5 }' )
rm -f "$stream_dump"
rm -f "$pidstore"
fi   

exit "$?"

######################     END OF PROGRAM      ####################################################
