#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team, 
# All Rights Reserved
# Creation Date: February 22, 2017
# Version: 0.6327
# Revision Date: January 09, 2019
#
# Recent Changes: - Use shell functions to reduce redundancy
#####################################################################
# Dependencies: youtube-dl, mpv, streamlink, read , curl, sed, awk, grep
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
version="0.6327"
rev_date="09/01/2019"
branch="gnu/linux"
product="ENDSTREAM"
##################################################
temp_pl="$HOME/tmp/master.m3u8"
USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"
# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0"
# define default headers
HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"
HEAD5="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"
uamode="off"
headmode="off"

torsocks_ip=127.0.0.1
torsocks_port=9050
#torsocks_ip=192.168.1.103
#torsocks_port=9050

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{ 
   echo "============================================================    "$product"  "$version"   =========================================================================="
   echo "||     ENGLISH      ||    ENGLISH II   ||     FRANCAIS      ||      ESPANOL     ||      EAST EUROPE      ||   SOUTH EUROPE/TURK      ||  ARABIC/FARSI/Pashtun/||"
   echo "=============================================================================================================================================================" 
   echo "1)SKY News London UK 41)BBC Parliament UK81)France 24 FR      121)RT Espanol       161)WDR DE            201)RSI CH                    241)RT Arabic"    
   echo "2)BBC London UK      42)Oireachtas TV IE 82)BFM TV FR         122)DW Espanol       162)DW Deutsch        202)SkyTG 24 IT               242)France 24 Arabic" 
   echo "3)RT UK              43)Made in Leeds    83)BFM Business FR   123)CGTN Espanol     163)ZDK InfoKanal     203)Telecolor Lombardia IT    243)BBC Arabic"
   echo "4)RTE News NOW IE    44)Made in Tyne     84)RT France         124)France24 Espanol 164)Tagesschau/MOMA DE204)Teletutto Brescia IT      244)DW Arabic"             
   echo "5)France 24 English  45)Made in Cardiff  85)France Info TV    125)Euronews ES      165)Euronews DE       205)QVC Italian               245)CGTN Arabic"  
   echo "6)DW English         46)Fiji One         86)TV5 Monde FR      126)Hispan TV IR     166)QVC DE            206)Italia channel            246)Al Jazeera QA"  
   echo "7)Russia Today       47)NDTV IN          87)CGTN Francais     127)Magala TV ES     167)ADR Alpha DE      207)Mediaon BergamoTV IT      247)Al Jazeera Doc QA"
   echo "8)CBSN USA           48)NewsX IN         88)Euronews FR       128)Guada TV ES      168)Radio 21 DE       208)News24.city Milan IT      248)Al Jazeera Mubasher QA"
   echo "9)Bloomberg USA      49)QVC USA          89)Africa News       129)GRANADA TV ES    169)DW Deutsch + DE   209)Radio TV Rome IT          249)KSA 1 SA"
   echo "10)RT America        50)TSC CA           90)TVA CA            130)C5N AR           170)W24 Wein AT       210)Udinews TV Udine IT       250)SBC SA"
   echo "11)Newsy USA         51)TWIT USA         91)RDI ICI CA        131)AcequiaMendozaAR 171)Tirol TV AT       211)DiTV Canale 89 Lucchese IT251)KSA Sports SA"
   echo "12)ABC News USA      52)Jupiter Broadcast92)RTS UN CH         132)Todo Noticias AR 172)Auftanken AT      212)RTM Arcevia IT            252)Al Arabiya AE"
   echo "13)TRT World TK      53)FIOS1 LongIsland 93)France 2          133)La Nacion AR     173)SRF CH CH         213)50NewsVersiliaViareggio IT253)Al Mayadeen LB"
   echo "14)Al Jazeera        54)FiOS1 New Jersey 94)France 3          134)TV5 AR           174)Musig24 TV CH     214)50 Canale Pisa IT         254)Belqees TV YE"
   echo "15)Press TV Iran     55)Lake Tahoe TV    95)ARTE Francais     135)KZO AR           175)TV OOST BE        215)Teleliberta Piacenza IT   255)Sky Arabic AE"  
   echo "16)India Today       56)TVW Washington   96)France O          136)Canal 2 AR       176)AT5 NL            216)ONE TV NBC 112 Milan IT   256)Alghad EG"
   echo "17)CGTN Beijing      57)DC Network       97)Bidtween FR       137)Canal 6 AR       177)Euronews Russian  217)Euronews IT               257)Extra News EG"
   echo "18)NHK World JP      58)DC Capitol       98)Azur TV Nice FR   138)Canal 7 AR       178)POCCNR 24 RU      218)ONE MT                    258)CBC Sofra EG"	
   echo "19)News Asia SG      59)DC Knowledge     99)IL TV FR          139)Canal 13 AR      179)RBC TV RU         219)Z1 Televizija HR          259)CBC Drama EG"
   echo "20)ABC AU            60)Laurel TV MD     100)BFM Paris FR     140)CN23 AR          180)CGTN Russian      220)RTV Posavina HR           260)DMC Live EG"  
   echo "21)Arise News NG     61)Southeastern TV  101)Alsace 20 FR     141)Telemax AR       181)Vesti FM RU       221)OsjeckaTV HR              261)Al-Fallujah IQ"
   echo "22)NEWSMAX USA       62)Texas State TV   102)Mosaik TV FR     142)Vorterix AR      182)Current Time VOA  222)Tomix Wein HR             262)AFAQ TV IQ"       
   echo "23)Free Speech TV USA63)MNN 5 NY USA     103)QVC Francais     143)TV Publica AR    183)RTR Planeta RU    223)Euronews HU               263)Karbarla IQ"  
   echo "24)Infowars Live     64)MNN 1 NY USA     104)8 Monte Blanc FR 144)Bolivia TV BO    184)Perviy RU         224)SKY Folk MK               264)Euronews Arabic"
   echo "25)United Nations TV 65)MNN 2 NY USA     105)TV7 Bordeaux FR  145)Cosmovision TV BO185)Music Box RU      225)Star Lamia GR             265)ANB Sat USA" 
   echo "26)WGN 9 Chicago     66)MNN 3 NY USA     106)RTS DEUX CH      146)Mega CL          186)MOCKBA 24 RU      226)Action 24 GR              266)Suryoyo Sat SE"
   echo "27)News12 Brooklyn   67)MNN 4 NY USA     107)LCP FR           147)CNN CL           187)1TV HD RU         227)Euronews GR               267)Safeer TV UK"
   echo "28)News12 LongIsland 68)BronxNet NY USA  108)Public Senate FR 148)Telemedeline CO  188)Planeta 4 RU      228)TRT Haber TR              268)BBC Persian"
   echo "29)FiOS1 HudsonValley69)CNN PH           109)CPAC 1 CA        149)Teleantioquia CO 189)Planeta 6 RU      229)NTV TR                    269)Iran Aryaee"
   echo "30)Weather Nation    70)CNN Live USA     110)Assemblee QC CA  150)TeleSUR VE       190)TPEANEP TV RU     230)HaberTurk TV              270)DidgahNew TV IR"    
   echo "31)Weather Channel   71)CNN HLN          111)Canal Savoir CA  151)Globovision VE   191)5 Live RU         231)Star TV TR                271)Aryen TV IR"
   echo "32)BYUTV USA         72)Fox News Talk    112)Gong Cinema      152)NTN24 VE         192)POCCNR 1 HD RU    232)CNN Turk TR               272)PTN PARS TV USA"
   echo "33)VOA USA           73)CNBC             113)GONG MAX         153)Conciencia VE    193)News 24 UA        233)KRT Kulture TR            273)Euronews Persian" 
   echo "34)RT Documentary    74)-------------    114)BX1 BE           154)VPItv VE         194)UA TV UA          234)La Legul TV TR            274)Ariana TV AF"  
   echo "35)CGTN Documentary  75)-------------    115)France Info Radio155)Guatevision GT   195)Thromadske UA     235)TGRT Haber TR             275)TOLO NEWS AF"
   echo "36)CBC CA            76)-------------    116)Europe 1 FR      156)Excelsior MX     196)Espresso UA       236)TVNET Canali TR           276)------------"
   echo "37)CBC News CA       77)-------------    117)RTL FR           157)---------------  197)News 1 UA         237)Show TV TR                277)------------"
   echo "38)CPAC 1 CA         78)-------------    118)RFI FR           158)---------------  198)ZIK UA            238)Euronews Turk             278)------------"	
   echo "39)Africa News       79)-------------    119)France Inter     159)---------------  199)Ukraine 5 UA      239)Top News Albania          279)------------"
   echo "40)Euronews English  80)-------------    120)RMC INFO FR      160)---------------  200)TV Publica Moldova240)-------------             280)------------"
   echo "=========================================================================================================================================================="
	
}  	                                    
  
channel_matrix_1()	
{
   echo "============================================================    "$product"  "$version"   ======================================================================"
   echo "||      INDIAN      ||     ASIA        || SOUTH ASIA / AFRICA||      EXTRA         ||    ENTERTAINMENT    ||    RELIGIOUS     ||      REL/ GOV      ||"
   echo "============================================================================================================================================================"
   echo "281)Aaj Tak PK       321)CCTV 4 China   361)DZMM ABS-CBN      401)RSBN Auburn USA    441)Music Choice Play  481)Vatican Media     521)Vatican Media Eng"    
   echo "282)DIN News PK      322)ECB 51 TW      362)PTV Philippines   402)Seminole TV        442)M2O Music Channel  482)EWTN Americas     522)EnjoySt.Moritz " 
   echo "283)Minhaj PK        323)ECB Finance TW 363)NET TV Jakarta ID 403)WVIT 30 Hartford   443)Radio Monte Carlo  483)EWTN Ireland      523)Quaran English"  
   echo "284)Barkat PK        324)TTV TW         364)NET LIVE ID       404)NBC 11 Bay Area    444)Virgin Radio       484)EWTN Africa       524)TTB Network"             
   echo "285)Geo News PK      325)CTV TW         365)NET Comedy ID     405)WXXV25             445)H!T Music          485)EWTN Asia         525)Vatican Deutsch"  
   echo "286)SAMAA PK         326)FTV TW         366)Buddha MM         406)NBC 2 Florida      446)Now Music TV       486)Salt&Light TV     526)Vatican Italiano"  
   echo "287)Shaski India     327)CTS World TW   367)VietTV VN         407)WCCB Charlotte     447)California Music   487)Catholic TV       527)Temple Institute"
   echo "288)SunNews          328)SET News TW    368)VietSky USA       408)WSJ Live           448)NRJ Hits FR        488)CTND Detroit      528)ABC News 1  "
   echo "289)TV9 India        329)CTI TW         369)ABHPTV VN         409)CTV Event CA       449)Rockland Radio     489)Shalom USA        529)ABC News 2"
   echo "290)Rajya Sabha      330)SET iNews TW   370)Earthquake 24 JP  410)CNN Event 1        450)Adult Swim         490)Shalom World      530)ABC News 3  "
   echo "291)TV9 Gujarat      331)Formosa TW     371)Arirang News TV   411)CNN Event 2        451)PJ Masks           491)Shalom Europe     531)ABC News 4 "
   echo "292)News 7 Tamil     332)TzuChi DaAi TW 372)Arirang TV KR     412)CNN Event 3        452)Talking Tom        492)EWTN Espanol      532)ABC News 5 "
   echo "293)News 18 India    333)DaAiVideo TW   373)OnTV HK CN        413)NBC News Event     453)Talking Tom Mini   493)EWTN Deutsch      533)ABC News 6"
   echo "294)Aaj Tak          334)DaAi Live TW   374)--------------    414)Buffalo TV         454)Fashion Europe     494)KtO Catholique    534)ABC News 7 "
   echo "295)NTV Telugu       335)TLTV TW        375)--------------    415)Panama City        455)Fashion 1 TV ES    495)CBN               535)ABC News 8" 
   echo "296)ABN Telugu       336)Sinda TV       376)--------------    416)Pawleys Island     456)Jasmin TV USA      496)CBN News          536)ABC News 9  "
   echo "297)Vanitha TV       337)Cheng Sin TV   377)--------------    417)America Thinks     457)TYT USA            497)NRB               537)ABC News 10  "
   echo "298)HMT Telugu       338)CTS 2 TW       378)Africa News       418)Bloomberg Europe   458)MLB Network        498)Church Channel    538)KY3 Springfield IL"	
   echo "299)India TV IN      339)SJTV TW        379)Africa24          419)Bloomberg Asia     459)NFL Now            499)TBN               539)KNBC 4 News"
   echo "300)Survana News     340)Da Li TW       380)SIKKA Afrique     420)HSN                460)RED BULL TV        500)God TV            540)EBS EU "  
   echo "301)i News Telugu    341)SDTV TW        381)Channels 24 NG    421)HSN 2              461)STADIUM            501)Amazing Facts     541)EBS Plus EU"
   echo "302)PTTV Tamil IN    342)FANS TV TW     382)TVC News NG       422)Bloomberg Australia462)Allkey Shop        502)It's Supernatural 542)UN Trustship"       
   echo "303)DD News          343)Hong Kong TV   383)KTN Kenya KE      423)Bloomberg USPoli   463)Sorgatronmedia     503)Shepherd's Chapel 543)UN EOSOC"  
   echo "304)REPORTER LIVE    344)GET TV USA     384)EbruTV KE         424)Bloomberg Live     464)Amouranth          504)IHOP              544)Dail Eireann IE"
   echo "305)AsiaNet News     345)Arirang Korea  385)KTN Home KE       425)Bloomberg EU Live  465)Geek and Sundry    505)BVOVN             545)Senad Eireann IE"  
   echo "306)V6 News          346)TBS KR         386)NTV Uganda UG     426)Bloomberg Asia Live466)Buzzr Gameshows    506)3ABN              546)Oireachtas CR 1 IE"
   echo "307)Aaj Tak IN       347)YTN DMB KR     387)SPARK UG          427)PBS NewsHour       467)RTE 1              507)3ABN Latino       547)Oireachtas CR 2 IE"
   echo "308)ETV AndhraPradesh348)YTN Sci KR     388)Joy News GH       428)CBC The National   468)RTE 2              508)3ABN Francais     548)Oireachtas CR 3 IE"
   echo "309)News 18 Tamil    349)Channel 23 KR  389)ADOM GH           429)AP Top Stories     469)RTE Jr.            509)LLBN TV           549)Oireachtas CR 4 IE"
   echo "310)Jaya Plus        350)KBS World24 KR 390)Bukedde TV GH     430)Democracy Now      470)TG4 Gaelic IE      510)Hillsong          550)CPAC Event 1"    
   echo "311)TEZ TV           351)YTN 27 KR      391)EBC ET            431)Infowars RealNews  471)NASA TV Media      511)JUCE TV           551)CPAC Event 2"
   echo "312)Dili Aaj Tak     352)CGNTV          392)Walf SN           432)Infowars WarRoom   472)NASA Public Educ   512)Salt and Light    552)CPAC Event 3"
   echo "313)Sagarmatha Nepal 353)YTV USA        393)EriTV ER          433)Infowars Event     473)RobotChicken       513)Harbor Light      553)CPAC Event 4" 
   echo "314)Derana LK        354)Atlanta AM790  394)SABC ZA           434)-----------        474)RetroTV            514)St. Mary's Coptic 554)CPAC Event 5"  
   echo "315)Swarnavahini LK  355)ANN24 JP       395)Afro Worldview ZA 435)-----------        475)-----------        515)Word of God Greek 555)CPAC Event 6"
   echo "316)Kaliagnar News   356)Sol!ve 24 JP   396)ITV ZA            436)-----------        476)-----------        516)Shalom America    556)CPAC Event 7"
   echo "317)--------------   357)KBS 24 JP      397)Parliament ZA     437)-----------        477)-----------        517)Shalom India      557)CPAC Event 8"
   echo "318)--------------   358)QVC Japan      398)--------------    438)-----------        478)-----------        518)Powervision TV    558)CPAC Orig Lang"	 
   echo "319)--------------   359)BSC 24 1 JP    399)--------------    439)-----------        479)-----------        519)-------------     559)RUPTLY"
   echo "320)--------------   360)BSC 24 2 JP    400)--------------    440)-----------        480)-----------        520)-------------     560)-------------"
   echo "================================================================================================================================================================="
}    
#  
 
channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ====================================================================="
   echo "||     OVERFLOW     ||    Latino Extra   ||   Latino Mucho Mas   || Portugues/French Extra||     USA Local 2    ||     USA Local 3   ||   LiveStream 1   ||"
   echo "======================================================================================================================================================"
   echo "561)CBC Vancouver    601)VIVE VE            641)Azteca 7 MX       681)Euronews PT         721)FOX News Preview   761)News 12 KTVZ7     801)Sangat Birmingham "    
   echo "562)CBC Yellowknife  602)Vatican Media ES   642)------------      682)TV Assemblelia BR   722)Beach TV           762)NewsWest 9 KWES DC802)Sikh Channel " 
   echo "563)CBC Edmonton     603)Televen VE         643)EsteCanal TV      683)TV Canaco Nova      723)Daytona Beach      763)Orange TV         803)Dashmesh  "  
   echo "564)CBC Calgary      604)Impacto USA        644)Cinevision DR     684)Igreja de Graca     724)Shepard Smith      764)PGCPS             804)Iberia TV  "             
   echo "565)CBC Regina       605)UCVTV CL           645)Nuevolaredo MX    685)Assemblelia Ales    725)WUSA9 Breaking     765)RyeTV             805)Obieqtivi TV   "  
   echo "566)CBC Winnepeg     606)UCVTV 2 CL         646)Sinart CR         686)Boas Nova           726)WCNC Breaking      766)Seattle Channel   806)ortonville   "  
   echo "567)CBC Windsor      607)Univision MX       647)Bethel Panama     687)Fundacao Nazzare    727)WCCB News          767)Atlanta TV        807)Holiday & Cruise  "
   echo "568)CBC Toronto      608)Cablenet AR        648)Poder de Dios BO  688)STF Brazil          728)UGA TV             768)Temple TV         808)Vision Cruise AU "
   echo "569)CBC Ottawa       609)Telpintv AR        649)TVDIARIO MX       689)TV Estudio Brasil   729)TVW2 Washington    769)Vienna HQ         809)Vision Cruise UK"
   echo "570)CBC Montreal     610)Canal8 MarPlataAR  650)BoliviaTV BO      690)Radio Justica       730)Action News KNVN   770)Escambia          810)102.3 NOW! TV CA "
   echo "571)CBC Frederickton 611)Univision USA      651)GUATEVISION GT    691)EXA FM Brasil       731)Alaska ASD         771)CBS Sports        811)TourbusTV USA "
   echo "572)CBC Charlottetown612)Canal 2 AR         652)RTV ES            692)RIT TV BR           732)Bowie TV           772)WYCW Carolinas    812)Ezekiel TV"
   echo "573)CBC Halifax      613)ABC Paraguay       653)Medios Publicos   693)Gott24.TV           733)Escambia TV        773)FOX 10 News       813)Emmanuel TV "
   echo "574)CBC St. John's   614)Abya Yala BO       654)Tele Bahia DR     694)TV Fatima Paroquia  734)FOX 5 DC (WTTG)    774)WHO 13            814)Shalom World"
   echo "575)CBC News Montreal615)UFROVision CL      655)Iglesia Advent USA695)You Content 98      735)Garland TV         775)Erie News         815)KIFI ABC 8 Idaho Falls" 
   echo "576)MB TV Monte Blanc616)Campo Abierto CL   656)Expande Puebla MX 696)Rede Genesis PT     736)Greenbelt TV       776)WISTV             816)ESPN Seattle"
   echo "577)Generations TV   617)UNITV AR           657)Ayuda Universal MX697)MEIO Teresina BR    737)House Represent    777)Gem Shopping USA  817)King County TV Preston"
   echo "578)La Vendee        618)TelePacifico CO    658)Canal 27 Esperanza698)Medalhao Persa BR   738)KRBC-TV            778)C-SPAN 1 USA      818)KIRO Radio Seattle"	
   echo "579)OUATCH TV        619)Venevision VE      659)TELEAMIGA         699)Talenu TV TPA       739)New Orleans TV     779)C-SPAN 2 USA      819)KOIN CBS 6 Portland"
   echo "580)Telesud          620)Telediario AR      660)Poli tv Bogota CO 700)TV Miramar BR       740)KTVB               780)C-SPAN 3 USA      820)KPTV FOX 12 Portland"  
   echo "581)Var Azur         621)TVeo Cordoba AR    661)UNTREF UN3 AR     701)TV Zimbo AO         741)Key TV             781)------------      821)KTVZ 21 Bend Oregon"
   echo "582)VL               622)PSN Tijuana MX     662)RUAV Univalle CO  702)TV RAIAR AO         742)KOB4 News          782)------------      822)KEZI ABC 9 Eugene"       
   echo "583)BFM TV           623)CNN Espanol        663)JesusTV GT        703)SescTV SaoPaulo BR  743)KPNX Breaking      783)------------      823)KOIN 6 Extra Portland"  
   echo "584)TV 7 Bordeaux    624)Paraguay Noticias  664)FGTV USA          704)Rede Super BeloBR   744)KXAN News          784)------------      824)KSL NOW Salt Lake "
   echo "585)8 Monte Blacnc 2 625)Canal Tr3ce CO     665)Evangelio Eterno  705)Talenu Luanda AO    745)Miami TV           785)------------      825)KUSI San Diego"  
   echo "586)teleGrenoble     626)Cali TV            666)BoliviaTV La Paz  706)Vatican Media PT    746)KNTV-TV            786)------------      826)KEYT ABC 3 Santa Barbara"
   echo "587)RTL 2            627)Canal 12 CO        667)Cosmovision TV    707)ACTION              747)KNTV Telemundo     787)------------      827)KHSL CBS 12 Redding"
   echo "588)OUI FM           628)Imagen Radio MX    668)Libre Cali CO     708)CNEWS FR            748)NBC2 News KTUU     788)------------      828)KRCR ABC 7 Redding "
   echo "589)D24TV            629)Euronews ES        669)MONARCA Hidalgo MX709)i24 News IL         749)News2 WCBD         789)------------      829)KION CBS 5/46 Salinas"
   echo "590)------------     630)Teleamazonas       670)Yuma CO           710)SYTRAL Rhone FR     750)News4 WRC Wash D.C.790)------------      830)KSBY NBC 6 Santa Barbara"    
   echo "591)------------     631)TV Camara PY       671)Dominio MX        711)Vedia BE            751)News4 White House  791)------------      831)KESQ ABC 3 Palm Springs  "
   echo "592)------------     632)Tu Canal Panama    672)Senal UNTREF      712)MABI CA             752)News5 WCYB         792)------------      832)KCOY CBS 12 Santa Maria "
   echo "593)------------     633)Colosal TV 1       673)NRT 4 monclova    713)Vatican Media FR    753)NewsWest 9 KWES    793)------------      833)MCAET Salinas " 
   echo "594)------------     634)A24 AR             674)Este Canal        714)TVM Paris FR        754)NBC4 WNBC          794)------------      834)KVVB CH.33 Victorville"  
   echo "595)------------     635)Canal 8 AR         675)Telecafe Bogota   715)C-Star              755)NBC4 WNBC Traffic  795)------------      835)KOAA NBC 5 Colorado"
   echo "596)------------     636)CanalShowsport AR  676)TVUNAM 20         716)Journal TVLandes    756)NBC5 WMAQ          796)------------      836)KRDO ABC 13 Colorado"
   echo "597)------------     637)WIPR Puerto Rico   677)EVTV Miami        717)TV 7 FR             757)NBC 10 KTEN        797)------------      837)Freedom Solar TV Kersey"
   echo "598)------------     638)La Mega Bogota CO  678)Enlacetv Espanol  718)-------------       758)NBC 12 WWBT        798)------------      838)KTVK 3 TV Arizona"	
   echo "599)------------     639)TV UNAM MX         679)------------      719)-------------       759)NBC 29 WVIR        799)------------      839)KMVP 24/7 Phoenix"
   echo "600)------------     640)Telecafe CO        680)------------      720)-------------       760)NBC 13 WNYT        800)------------      840)KTAR News Phoenix"
   echo "============================================================================================================================================================="
}	                     
            
channel_matrix_3()	
{
   echo "============================================================    "$product"  "$version"   ============================================================================="
   echo "||      LiveStream 2      ||    LiveStream 3       ||      LiveStream 4     ||     LiveStream 5     ||       LiveStream 6      ||    LiveStream 7      ||   Livestream 8  ||"
   echo "==================================================================================================================================================================="
   echo "841)KOLD 13 Tucson        881)WCYB NBC 5 Bristol    921)WKRG CBS 5 Mobile     961)KLTV ABC 7 Tyler TX   1001)KNPN Fox26 St Joseph 1041)AWCATV Educ     1081)------------"    
   echo "842)KPHO CBS 5 Pheonix    882)WRIC ABC 8 Petersburg 922)WALA FOX10 Mobile     962)KTXS 12 ABC Abilene   1002)KCTV CBS5 Kansas MO  1042)FHSU TIGER MEDIA1082)------------" 
   echo "843)KVOA NBC 4 Tuscon     883)WWBT NBC 12 Richmond  923)WBRC FOX 6 Birmingham 963)KFDA CBS10 AmarilloTX 1003)KHNL Honolulu        1043)Essex County    1083)------------"  
   echo "844)KYMA NBC 11 Yuma      884)Brunswick TV3 NH      924)Oakwood Uni Huntsville964)KZTV CBS10 CorpusX    1004)ThinkTech Honolulu   1044)CNPTVCaribbean  1084)------------"             
   echo "845)NewsChannel5 LasVegas 885)LRPATV CH25 NH        925)WJZY FOX 46 Charlotte 965)KFDX NBC3 WitchitaFls 1005)KFVE 9 Honolulu      1045)LOBO STATION    1085)------------"  
   echo "846)VSiN Vegas Stats      886)WJBK FOX 2 Detroit    926)WCCB Charlotte CW     966)Galveston County      1006)KHON CBS2 Ala Mona   1046)Maricopa College1086)------------"  
   echo "847)KCLV FOX 2 Las Vegas  887)WWTV 9 Mt. Pleasent   927)WYCW CW 62 Carolinas  967)KAUZ CBS 6 Winters    1007)KVZK 2 Am.Samoa      1047)WLTH AM 1370    1087)------------"
   echo "848)KVVU FOX 5 Las Vegas  888)WFIE NBC 14 Evansville928)WNCT CBS 9 Greenville 968)KXXV ABC 25 Waco      1008)PNC K57 Fox 6 Guam   1048)Lake Tahoe      1088)------------"
   echo "849)Native Media Sante Fe 889)WANE Ft. Wayne        929)WCBD NBC 2 Charleston 969)KVIA ABC-7 El Paso    1009)Joe Pags             1049)Florida Gaming  1089)------------"
   echo "850)Santa Fe Media        890)WFFT FOX 55 Indiana   930)WWAY ABC3 Willmington 970)KCBD NBC 11 Lubbock   1010)CGTN America         1050)Kidd Kraddick   1090)------------"
   echo "851)WTNH 8 New Haven      891)WTHI 10 Terre Haute   931)WBTV CBS 3 Charlotte  971)Lex & Terry Lufkin    1011)BlabTV               1051)RMG-TV Cleavland1091)------------"
   echo "852)WFSB 3 Hartford       892)WISH 8 Indianapolis   932)CBS 17 Rahliegh NC    972)KSWO ABC 7 Winters TX 1012)Mike Malloy Show     1052)ICOinvestor     1092)------------"
   echo "853)CharmTV Baltimore     893)EKBTV Pikeville KY    933)WCSC CBS 5 Charleston 973)------------          1013)Nasdaq Bell          1053)Luigi Pellegrini1093)------------"
   echo "854)WTTG Fox 5 DC         894)WTVQ ABC 36 Lexington 934)WSPA CBS 7 Spartanberg974)ESPN 97.5 Houston TX  1014)Westerville.TV 543   1054)Bengu Turk TK   1094)------------"
   echo "855)WWLP 22 Springfield   895)WPSD-TV Paducah       935)WMBF Myrtle Beach     975)Granbury Media TX     1015)Kingdom Access       1055)i24 News Israel 1095)------------"
   echo "856)WestMass News Chicopee896)Lex 18 Lexington      936)WIS NBC 10 Columbia   976)KCOH TV Houston TX    1016)Plaistow Access      1056)------------    1096)------------"
   echo "857)Milford TV            897)WFLA NBC 8 Tampa Bay  937)WSMV NBC 4 Nashville  977)KXAN NBC Austin       1017)Topeka City          1057)------------    1097)------------"
   echo "858)Milford TV Educate    898)WTVT FOX 13 Tampa Bay 938)WBBJ ABC 7 Tennesee   978)KSLA 12 Shreveport    1018)Shelby County        1058)------------    1098)------------"	
   echo "859)WWOR Secaucus NJ      899)Island TV Miami       939)WDEF CBS12 Chattanooga979)WAFB CBS9 BatonRouge  1019)Provincetown         1059)------------    1099)------------ "
   echo "860)WNYW Fox 5 New York   900)City of Tampa         940)WMC NBC 5 Memphis     980)WVUE FOX8 NewOrleans  1020)CITV Hamilton Bermuda1060)------------    1100)------------ "  
   echo "861)WROC CBS 8 Rochester  901)WFLX FOX 29 Palm Beach941)2nd Presbyter Memphis 981)KLFY 10 Lafayette     1021)Shalom Media KIDS    1061)------------    1101)------------ "
   echo "862)WABC 77 New York      902)WYKE TV 47 Hormosassa 942)ETSU Fine Arts Johnson982)WDFL 18 SC/LA         1022)Lutheran Penfield    1062)------------    1102)------------ "       
   echo "863)WJHL CBS 11 Johnson   903)WJBF Augusta GA       943)EPlusTV6 Jackson      983)KSLA CBS12 Shreveport 1023)Whole Life Ministries1063)------------    1103)------------ "  
   echo "864)DayTraderRockStar     904)WMGT 41 NBC Macon GA  944)KELO Keloland ND/SD   984)HTV10 Houma LA        1024)St. Catharine Church 1064)------------    1104)------------ "
   echo "865)NYXT Manhattan NYC    905)WSAV NBC 3 Savannah   945)KVRR Fargo ND         985)KPLC NBC7 LakeCharles 1025)Glory to God         1065)------------    1105)------------ "  
   echo "866)MNN-FSTV              906)WTOC 11 Savannah      946)KDLT Sioux Falls SD   986)KATC ABC3 Lafayette   1026)St. Helena Chapel    1066)------------    1106)------------ "
   echo "867)Fox 8 Cleveland       907)WTVM ABC 9 Columbus   947)GovTV Watertown SD    987)HU16 Harding Sercy    1027)St Patrick Dumbarton 1067)------------    1107)------------ "
   echo "868)WIVM TV39 Canton      908)WRBL CBS 3 Columbus   948)KELO CBS Sioux Falls  988)KSNT Weather Wichita  1028)VTNTV VICTORY        1068)------------    1108)------------"
   echo "869)WBNS 10 Columbus      909)WGCL CBS46 Atlanta    949)KIMT 3 Mason City     989)WPS-TV Wichita Public 1029)TMN WORD TV          1069)------------    1109)------------ "
   echo "870)WNYT NBC 13 Sandusky  910)WALB NBC 10 Albany    950)WDIO ABC 10/13 Duluth 990)KSNW NBC 3 Witchita   1030)Parkside Radio       1070)------------    1110)------------ "    
   echo "871)WBNS 10 Radar Columbus911)WDAM 7 Hattiesburg    951)KAAL ABC 6 Rochester  991)KSNT Kansas OK        1031)FGTV FreqGlory       1071)------------    1111)------------ "
   echo "872)WBNS 10 Columbus      912)WLOX ABC13 Mississippi952)KQDS FOX 21 Duluth    992)Enid TV OK 1          1032)HJTV Healing Jesus   1072)------------    1112)------------ "
   echo "873)WOIO CBS 19 Clevland  913)WJTV CBS 12 Jackson   953)KSTP ABC 5 St. Paul   993)KMOV CBS4 St. Louis   1033)APTV Apocalypse      1073)------------    1113)------------" 
   echo "874)WTOL CBS 11 Toledo    914)WLBT FOX 40 Jackson   954)KMSP FOX 9 Minneapolis994)KMIZ ABC 17 Missouri  1034)Marytown Chapel      1074)------------    1114)------------ "  
   echo "875)WCMH NBC 4 Columbus   915)WHLT Hattiesburg      955)St. Cloud Times UTVS  995)PolkCounty BolivarMO  1035)Guaranty Media       1075)------------    1115)------------"
   echo "876)WTXF FOX 29 Philli    916)WSFA 12 Montgomory    956)WHLT 12 Whitehall     996)KOLR CBS10 Springfield1036)Pro Football Hall    1076)------------    1116)------------"
   echo "877)WBRE NBC Wilkes Barre 917)WBRC FOX6 Birmingham  957)WFLD Fox 32 Chicago   997)Branson TV MO         1037)Lance Hope RSL       1077)------------    1117)------------ "
   echo "878)WPHL TV ABC 6 Philli  918)WAKA CBS 8 Alabama    958)WAND NBC 17 Decatur   998)EUTV Springfield MO   1038)XBTV RosecroftRaceway1078)------------    1118)------------ "	
   echo "879)WFMZ 69 Allen Town    919)WAAY ABC 31 Huntsville959)WFLD Fox 32 Chicago   999)KY3 Springfield MO    1039)Park City TV PCTV    1079)------------    1119)------------ "
   echo "880)WPRI Fox 12 Providence920)CBS 42 Birmingham     960)KRIV FOX 26 Houston   1000)KQTV 2 St. Joseph MO 1040)AAA Guayama          1080)------------    1120)------------ "
   echo "================================================================================================================================================================="
}              	         
                    
channel_matrix_4()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||  LiveStream 10      ||   LiveStream 11   ||    Column 3       ||   Column      4     ||  Column 5         ||    Column 6        ||   Locations    ||"
   echo "======================================================================================================================================================"
   echo "1121)------------     1161)------------      1201)------------      1241)------------     1281)------------      1321)------------     1361)NASA ISS 1 "    
   echo "1122)------------     1162)------------      1202)------------      1242)------------     1282)------------      1322)------------     1362)Venice Bridge " 
   echo "1123)------------     1163)------------      1203)------------      1243)------------     1283)------------      1323)------------     1363)JacksonHole Sq "  
   echo "1124)------------     1164)------------      1204)------------      1244)------------     1284)------------      1324)------------     1364)JacksonHole Rust"             
   echo "1125)------------     1165)------------      1205)------------      1245)------------     1285)------------      1325)------------     1365)Aosta Sarre Italy"  
   echo "1126)------------     1166)------------      1206)------------      1246)------------     1286)------------      1326)------------     1366)Buenos Aires  "  
   echo "1127)------------     1167)------------      1207)------------      1247)------------     1287)------------      1327)------------     1367)Amsterdam NL "
   echo "1128)------------     1168)------------      1208)------------      1248)------------     1288)------------      1328)------------     1368)Shibua Japan"
   echo "1129)------------     1169)------------      1209)------------      1249)------------     1289)------------      1329)------------     1369)Akiba Japan"
   echo "1130)------------     1170)------------      1210)------------      1250)------------     1290)------------      1330)------------     1370)Yahoo Japan "
   echo "1131)------------     1171)------------      1211)------------      1251)------------     1291)------------      1331)------------     1371)Steamy Mountain"
   echo "1132)------------     1172)------------      1212)------------      1252)------------     1292)------------      1332)------------     1372)Naman Seoul "
   echo "1133)------------     1173)------------      1213)------------      1253)------------     1293)------------      1333)------------     1373)Shizuoka Japan"
   echo "1134)------------     1174)------------      1214)------------      1254)------------     1294)------------      1334)------------     1374)Yokohama Japan "
   echo "1135) ------------    1175)------------      1215)------------      1255)------------     1295)------------      1335)------------     1375)Mount Fuji Japan" 
   echo "1136)------------     1176)------------      1216)------------      1256)------------     1296)------------      1336)------------     1376)Hart Beach NL"
   echo "1137)------------     1177)------------      1217)------------      1257)------------     1297)------------      1337)------------     1377)Port Du Quebec "
   echo "1138)------------     1178)------------      1218)------------      1258)------------     1298)------------      1338)------------     1378)Durango Colorado"	
   echo "1139)------------     1179)------------      1219)------------      1259)------------     1299)------------      1339)------------     1379)StarDot 1"
   echo "1140)------------     1180)------------      1220)------------      1260)------------     1300)------------      1340)------------     1380)Youing Japan "  
   echo "1141)------------     1181)------------      1221)------------      1261)------------     1301)------------      1341)------------     1381)StarDot 4  "
   echo "1142)------------     1182)------------      1222)------------      1262)------------     1302)------------      1342)------------     1382)StarDot 5  "       
   echo "1143)------------     1183)------------      1223)------------      1263)------------     1303)------------      1343)------------     1383)StarDot 6  "  
   echo "1144)------------     1184)------------      1224)------------      1264)------------     1304)------------      1344)------------     1384)London 1  "
   echo "1145)------------     1185)------------      1225)------------      1265)------------     1305)------------      1345)------------     1385)London 2"  
   echo "1146)------------     1186)-------------     1226)------------      1266)------------     1306)------------      1346)------------     1386)London 3  "
   echo "1147)------------     1187)------------      1227)------------      1267)------------     1307)------------      1347)------------     1387)Berlin Airport "
   echo "1148)------------     1188)------------      1228)------------      1268)------------     1308)------------      1348)------------     1388)Los Angeles Port"
   echo "1149)------------     1189)------------      1229)------------      1269)------------     1309)------------      1349)------------     1389)ITS COM Japan"
   echo "1150)------------     1190)------------      1230)------------      1270)------------     1310)------------      1350)------------     1390)China Shoreline"    
   echo "1151)------------     1191)------------      1231)------------      1271)------------     1311)------------      1351)------------     1391)------------"
   echo "1152)------------     1192)------------      1232)------------      1272)------------     1312)------------      1352)------------     1392)------------"
   echo "1153)------------     1193)------------      1233)------------      1273)------------     1313)------------      1353)------------     1393)------------" 
   echo "1154)------------     1194)------------      1234)------------      1274)------------     1314)------------      1354)------------     1394)------------"  
   echo "1155)------------     1195)------------      1235)------------      1275)------------     1315)------------      1355)------------     1395)------------"
   echo "1156)------------     1196)------------      1236)------------      1276)------------     1316)------------      1356)------------     1396)------------"
   echo "1157)------------     1197)------------      1237)------------      1277)------------     1317)------------      1357)------------     1397)------------"
   echo "1158)------------     1198)------------      1238)------------      1278)------------     1318)------------      1358)------------     1398)------------"	
   echo "1159)------------     1199)------------      1239)------------      1279)-----------      1319)------------      1359)------------     1399)------------"
   echo "1160)------------     1200)------------      1240)------------      1280)-----------      1320)------------      1360)------------     1400)------------"
   echo "==================================================================================================================================================="
}	

############################  FUNCTIONS ##################################################################

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    ENGLISH     ##################################
################     UK    #################################
# 1) Sky News
1)
if [ "$getlink" = 1 ]
then
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/07.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/06.m3u8
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/05.m3u8
###link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/03.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/02.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/01.m3u8
fi
#method="Tor"
#method="Proxychains"
TAG=" SKYNEWS____"
keyword="Sky"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCd6knJkq4XBNHZATKWFNmGQ/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky News" ;;

# 2) BBC News London
2) 
keyword=":"
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-news
#link="https://1636691764.rsc.cdn77.org/LS-ATL-54548-11/tracks-v1a1/mono.m3u8"
fi

TAG=" BBCNEWS____"
use_cookies="yes"
method="Tor"
chan_name="BBC News London" ;; 

# 3) RT UK
3)
if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/rt-uk-air/ 

link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-1k_v5.m3u8
#link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-2k_v5.m3u8
#link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-3k_v5.m3u8
#link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-4k_v5.m3u8
#link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-5k_v5.m3u8
###AUDIO
#link=https://rt-uk.secure.footprint.net/1106-inadv-qidx-0k_v5.m3u8

#######################
#link=https://secure-streams.akamaized.net/rt-uk/index.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index1600.m3u8
###link=https://secure-streams.akamaized.net/rt-uk/in3dex800.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
#link=https://www.filmon.com/tv/russia-today-2
fi
#method="Proxychains"
#method="Tor"
use_cookies="no"
TAG=" RTUK_______"
chan_name="RT UK" ;;

############### IRELAND ###########################################################
# 4) RTE News NOW  
4)   
if [ "$getlink" = 1 ]
then 
#link=http://wmsrtsp1.rte.ie/live/android.sdp/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2089682,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=1024x576
link="http://wmsrtsp1.rte.ie/live/android.sdp/chunklist_w127240369.m3u8"
#link="http://wmsrtsp1.rte.ie/live/android.sdp/playlist.m3u8" 
#link="http://cdn.rasset.ie/hls-live/_definst_/newsnow.m3u8"
#method="Tor"
fi
use_cookies="no"
TAG=" RTENEWS____"
chan_name="RTE News NOW" ;;

################## FRANCE ###############################################
# 5) France 24 Anglais 
5) 
keyword="FRANCE 24 Live"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
# link=http://www.dailymotion.com/video/xigc8z
fi

#method="Tor"
use_cookies="no"
TAG=" FRANCE24___"
chan_name="France 24 English";;
################## GERMANY ###################################333
# 6) DW English
6) 
keyword="DW"

if [ "$getlink" = 1 ]
then

#link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
###link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-b.m3u8?sd=10&rebase=on"
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelleenglish/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 

fi
#method="Tor"
use_cookies="no"
TAG=" DWENG______"
chan_name="DW English" ;;

#################### RUSSIA  ################################
# 7) Russia Today
7)

if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/ 

link=https://rt-news.secure.footprint.net/1103-inadv-qidx-1k_v5.m3u8
#link=https://rt-news.secure.footprint.net/1103-inadv-qidx-2k_v5.m3u8
#link=https://rt-news.secure.footprint.net/1103-inadv-qidx-3k_v5.m3u8
#link=https://rt-news.secure.footprint.net/1103-inadv-qidx-4k_v5.m3u8
#link=https://rt-news.secure.footprint.net/1103-inadv-qidx-5k_v5.m3u8
#### AUDIO
#link=https://rt-news.secure.footprint.net/1103-inadv-qidx-0k_v5.m3u8

#############################
#link=https://secure-streams.akamaized.net/rt/index.m3u8
#link=https://secure-streams.akamaized.net/rt/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt/index1600.m3u8
######link=https://secure-streams.akamaized.net/rt/index800.m3u8
#link=https://secure-streams.akamaized.net/rt/index400.m3u8
#link=https://secure-streams.akamaized.net/rt/indexaudio.m3u8
## link=https://www.filmon.com/tv/russia-today-1

fi
#method="Tor"
use_cookies="no"
TAG=" RT_________"
chan_name="Russia Today" ;;
########################## USA MAINSTREAM ###################################################
# 8) CBSN 
8)
keyword="LIVE"
if [ "$getlink" = 1 ]
then
#link="https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8"
#link=$( curl "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 )?BANDWIDTH=1689600
####link="$(curl --socks5 "$socks_ip":"$socks_port" -A "$UA" $( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 1029600.m3u8 | tail -n 1 ) "
link="$(curl -A "$UA" $( curl -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 3009600.m3u8 | tail -n 1 ) "

# BANDWIDTHS: 3009600 2481600 1689600 1029600 580800 264000 

#link=https://www.cbsnews.com/common/video/dai_prod.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
#
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/CBSNewsOnline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)

fi
# method="Tor"
use_cookies="no"
TAG=" CBSN_______"
chan_name="CBSN" ;;
# 9) Bloomberg Business USA
9) 
keyword="Bloomberg"
if [ "$getlink" = 1 ]
then
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://liveproduseast.akamaized.net/us/Channel-USTV-AWS-virginia-1/Source-USTV-1000-1_live.m3u8
fi
#method="Tor"
use_cookies="no"
TAG=" BLMBRG_____"
chan_name="Bloomberg Business USA";;  
# 10) RT America
10)
if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/rt-america-air/

link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-1k_v5.m3u8
#link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-2k_v5.m3u8
#link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-3k_v5.m3u8
#link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-4k_v5.m3u8
#link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-5k_v5.m3u8
###AUDIO
#link=https://rt-usa.secure.footprint.net/1105-inadv-qidx-0k_v5.m3u8

#################################
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index1600.m3u8
####link=https://secure-streams.akamaized.net/rt-usa/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8

fi

#method="Tor"
use_cookies="no"
TAG="RT_AMR____"
chan_name="RT America" ;;
# 11) Newsy
11) 

if [ "$getlink" = 1 ]
then
#link=http://www.newsy.com/live/
link="https://content.jwplatform.com/players/hBmO7M6k"
#link=https://www.filmon.com/tv/newsy
fi
#method="Tor"
use_cookies="no"
TAG="NEWSY-----"
chan_name="Newsy" ;;
# 12)ABC News USA 
12)

if [ "$getlink" = 1 ]
then
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=320x180,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=320x180,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1200000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1200000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2499000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2499000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4000000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_4000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4000000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_4000_av-b.m3u8?sd=10&rebase=on"
fi
#method="Tor"
use_cookies="no"
TAG="ABC_USA---"
chan_name="ABC News USA" ;;
###################################

############################# MIDDLE EAST ##############################################################
# 13) TRT World
13) 
keyword="TRT"

if [ "$getlink" = 1 ]
then
#link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=654000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=818000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=776000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=972000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=871000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
fi
#method="Tor"
use_cookies="no"
TAG="TRTWORLD--"
chan_name="TRT World";;   
# 14) Al Jazeera
14) 
keyword="Al Jazeera English - Live" 

if [ "$getlink" = 1 ]
then
#link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
link=https://english.streaming.aljazeera.net/aljazeera/english2/index4147.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index2073.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index1296.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index783.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index576.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index255.m3u8
#########################
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index4147.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index2073.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index1296.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index783.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index576.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english1/index255.m3u8
##############################
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/160audio.m3u8
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
##method="Tor"
use_cookies="no"
TAG="ALJAZ_ENG_"
chan_name="Al Jazeera English" ;;  

############################## IRAN ##########################################
# 15) Press TV
15)

if [ "$getlink" = 1 ]
then
#link=https://www.filmon.com/tv/press-tv
link="https://5a61de8ed719d.streamlock.net/liveprs/smil:liveprs.smil/chunklist_w92271025_b594100_slen.m3u8"
#link=http://107.189.40.49:1935/live/ptven/playlist.m3u8
#link=http://107.189.40.49:1935/live/ngrp:ptven_all/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1380059,CODECS="avc1.66.40,mp4a.40.2",RESOLUTION=1280x720
#link=http://107.189.40.49:1935/live/ptven/chunklist_w1092714967.m3u8
fi
use_cookies="no"
TAG="PRESSTV___"
chan_name="Press TV" ;;  

################### INDIA  ########################################
# 16) India TODAY
16)
keyword="IndiaToday Live TV"
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link="https://feeds.intoday.in/hltapps/api/master.m3u8"
#link="$( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 896000p | tail -n 1 )"
link="$( curl -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 2128000pb | tail -n 1 )"
# BANDWIDTH=2128000pb.m3u8 896000pb.m3u8 428000pb.m3u8
fi
use_cookies="no"
#method="Tor"
TAG="INDIATODAY"
chan_name="India TODAY English" ;;  
###########################  ASIA-OCEANIA   ############################################
# 17) CGTN China English
17) 
keyword="Live"
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/manifest.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,NAME="720p HD"
link=https://live.cgtn.com/1000/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=2,BANDWIDTH=564000,NAME="360p SD"
#link=https://live.cgtn.com/500/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=3,BANDWIDTH=192000,NAME="180p 3G"
#link=https://live.cgtn.com/200/prog_index.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link="https://api.new.livestream.com/accounts/7082210/events/7115682/live.m3u8?BANDWIDTH=1756000"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
fi
###method="Tor"
use_cookies="no"
TAG="CGTN_ENG__"
chan_name="CGTN China English" ;;
# 18)NHK World Japan 
18)
if [ "$getlink" = 1 ]
then
#link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index.m3u8 
#EXT-X-STREAM-INF:BANDWIDTH=2310000,AVERAGE-BANDWIDTH=2310000,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_2100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1298000,AVERAGE-BANDWIDTH=1298000,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=990000,AVERAGE-BANDWIDTH=990000,CODECS="avc1.42c01e,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_900.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=660000,AVERAGE-BANDWIDTH=660000,CODECS="avc1.42c01e,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#####link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_600.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c01e,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_400.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="eng",NAME="Alternate Audio",AUTOSELECT=YES,DEFAULT=NO,URI="index_64.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=220000,AVERAGE-BANDWIDTH=220000,CODECS="avc1.42c01e,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_200.m3u8"
fi
###method="Tor"
use_cookies="no"
TAG="NHKWORLDJP"
chan_name="NHK World Japan" ;;

# 19) Channel News Asia Singapore
19)

if [ "$getlink" = 1 ]
then
link="https://drsh196ivjwe8.cloudfront.net/hls/cnai/03.m3u8"
#link="https://drsh196ivjwe8.cloudfront.net/hls/cnai/02.m3u8"
#link="https://drsh196ivjwe8.cloudfront.net/hls/cnai/01.m3u8"
fi
# method="Tor"
use_cookies="no"
TAG="NEWSASIASG"
chan_name="Channel News Asia Singapore" ;;

########################## AUSTRALIA ###########################################
# 20)  ABC News Australia 
20) 
keyword="ABC" 

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   

link="https://abc-iview-mediapackagestreams-1.akamaized.net/out/v1/50345bf35f664739912f0b255c172ae9/index_1.m3u8"
#link="https://abc-iview-mediapackagestreams-1.akamaized.net/out/v1/50345bf35f664739912f0b255c172ae9/index_2.m3u8"
#link="https://abc-iview-mediapackagestreams-1.akamaized.net/out/v1/50345bf35f664739912f0b255c172ae9/index_3.m3u8"

#link=https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=306000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_250_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=514000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
####link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_450_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=730000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_650_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=846000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_750_av-p.m3u8?sd=10&rebase=on"
#BANDWIDTH=295680

#link=http://iphonestreaming.abc.net.au/news24/news24_vlo.m3u8
#BANDWIDTH=398944
#link=http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8
#BANDWIDTH=553888
#link=http://iphonestreaming.abc.net.au/news24/news24_med.m3u8
#0BANDWIDTH=708832
#link=http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8
#BANDWIDTH=64000
#link=http://iphonestreaming.abc.net.au/news24/news24_vloaudio.m3u8
fi
####method="Tor"
use_cookies="no"
TAG="ABC_AU____"
chan_name="ABC News Australia" ;;
########################### AFRICA ############################################
# 21) Arise News Nigeria/London
21) 
keyword="Arise"
link=http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
#method="Tor"
use_cookies="no"
TAG="ARISE_NG__"
chan_name="Arise News Nigeria/London";; 
##################    ALTERNATIVE MEDIA   ##################################################
# 22) NEWSMAX USA
22) 
keyword="Newsmax"

if [ "$getlink" = 1 ]
then
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_720.m3u8
##link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_480.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_360.m3u8
# "http://www.newsmaxtv.com/"
# link=https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8
#link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 

fi
##method="Tor"
use_cookies="no"
TAG="NEWSMAX___"
chan_name="NEWSMAX USA";;
# 23)Free Speech TV
23)

if [ "$getlink" = 1 ]
then
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1692100,RESOLUTION=848x480,CODECS="avc1.4D401F,mp4a.40.5"
link=https://edge.free-speech-tv-live.top.comcast.net/out/u/39569_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1191846,RESOLUTION=640x360,CODECS="avc1.4D401F,mp4a.40.5"
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/39569_4.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=791856,RESOLUTION=512x288,CODECS="avc1.42C01E,mp4a.40.5"
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/39569_5.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=191727,CODECS="mp4a.40.5"
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/39569_6.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="FREESPEECH"
chan_name="Free Speech TV" ;;   
# 24)  Infowars Live 
24)

if [ "$getlink" = 1 ]
then
#link=https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/index_800_a-p.m3u8?sd=10&rebase=on"
fi
# method="Tor"
use_cookies="no"
TAG="INFOWARS__"
chan_name="Infowars Event" ;;
############################# GOVERNMENT#####################################################
############### UNITED NATIONS #################################################
# 25) United Nations UN Web TV
25) 
keyword="LIVE"
### UN WEB TV
if [ "$getlink" = 1 ]
then
link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
#link=https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=828000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.5"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_828_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=640x480,CODECS="avc1.77.30, mp4a.40.5"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"

#format="best"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"
##Trustship Chamber
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
####method="Tor"
use_cookies="no"
TAG="UN_TV_____"
chan_name="United Nations UN Web TV" ;; 
########################## LOCAL USA NEWS ##################################################
# 26) WGN 9 Chicago 
26) 
if [ "$getlink" = 1 ]
then
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8"
#http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-b.m3u8?sd=10&rebase=on"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_2500_av-b.m3u8?sd=10&rebase=on"
fi
####method="Tor"
use_cookies="no"
TAG="WGN_9_CHG_"
chan_name="WGN 9 Chicago" ;;
# 27)News 12 Brooklyn 
27) 

if [ "$getlink" = 1 ]
then
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12KN
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group",NAME="eng",DEFAULT=YES,AUTOSELECT=YES,LANGUAGE="en",URI="http://hls.iptv.optimum.net/news12/nipadlive/06_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="group",NAME="spa",DEFAULT=NO,AUTOSELECT=YES,LANGUAGE="en",URI="http://hls.iptv.optimum.net/news12/nipadlive/07_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=630176,RESOLUTION=320x180,CODECS="avc1.42c00d,mp4a.40.2",AUDIO="group"
#link="http://hls.iptv.optimum.net/news12/nipadlive/01_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1079872,RESOLUTION=480x270,CODECS="avc1.42c01e,mp4a.40.2",AUDIO="group"
#link="http://hls.iptv.optimum.net/news12/nipadlive/02_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2286080,RESOLUTION=960x540,CODECS="avc1.42c01f,mp4a.40.2",AUDIO="group"
#link="http://hls.iptv.optimum.net/news12/nipadlive/03_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3189984,RESOLUTION=1280x720,CODECS="avc1.42c01f,mp4a.40.2",AUDIO="group"
#link="http://hls.iptv.optimum.net/news12/nipadlive/04_new.m3u8?cdnHost=167.206.237.144&callsign=N12KN"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=121824,CODECS="mp4a.40.2",AUDIO="group"
fi
####method="Tor"
use_cookies="no"
TAG="News12_BK_"
chan_name="News 12 Brooklyn" ;;

# 28)News 12 Long Island 
28) 

if [ "$getlink" = 1 ]
then
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12LI_WEST
fi
####method="Tor"
use_cookies="no"
TAG="News12_LI_"
chan_name="News 12 Long Island" ;;

# 29) FiOS1 News Lower Hudson Valley
29) 

if [ "$getlink" = 1 ]
then
#link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_is35xshu/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=396000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=396000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.34"
link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1is35xshu_1@64997/index_3_av-b.m3u8?sd=10&rebase=on"
fi
# method="Tor"
use_cookies="no"
TAG="FIOS1_HUD_"
chan_name="FiOS1 News Lower Hudson Valley" ;;

#################### NATIONAL / LOCAL Weather #####################################################
# 30) Weather Nation
30) 

if [ "$getlink" = 1 ]
then
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2128000,RESOLUTION=1280x720
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b2128000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=504000,RESOLUTION=480x270
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b464000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=724000,RESOLUTION=640x360
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b664000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1054000,RESOLUTION=640x360
#####link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b964000.m3u8
fi
#####method="Tor"
use_cookies="no"
TAG="WEATHNERNA"
chan_name="Weather Nation" ;; 
# 31) The Weather Channel
31)

if [ "$getlink" = 1 ]
then
#link=http://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_2400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://weather-lh.akamaihd.net/i/twc_1@92006/index_2400_av-b.m3u8?sd=10&rebase=on"
fi
#####method="Tor" 
use_cookies="no"
TAG="WEATHNERCH"
chan_name="The Weather Channel" ;;
# 32) Bringham Young University TV BYUTV Mormon 
32)

if [ "$getlink" = 1 ]
then
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
#EXT-X-MEDIA:TYPE=CLOSED-CAPTIONS,GROUP-ID="CC",LANGUAGE="eng",NAME="EN",INSTREAM-ID="CC1"
#EXT-X-STREAM-INF:BANDWIDTH=290400,AVERAGE-BANDWIDTH=290400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=400x224,FRAME-RATE$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_264.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=510400,AVERAGE-BANDWIDTH=510400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=400x224,FRAME-RATE$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_464.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=950400,AVERAGE-BANDWIDTH=950400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=640x360,FRAME-RAT$
#####link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_864.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1830400,AVERAGE-BANDWIDTH=1830400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540,FRAME-R$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_1664.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2820400,AVERAGE-BANDWIDTH=2820400,CODECS="avc1.640028,mp4a.40.5",RESOLUTION=1280x720,FRAME-$
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_2564.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=4470400,AVERAGE-BANDWIDTH=4470400,CODECS="avc1.640028,mp4a.40.5",RESOLUTION=1280x720,FRAME-$
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_4064.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.5",CLOSED-CAPTIONS="CC"
#link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_64.m3u8
fi
#####method="Tor"
use_cookies="no"
TAG="BYU_TV____"
chan_name="Bringham Young University BYU TV USA" ;;
##################    DOCUMENTARY   ##################################################
# 33)VOA
33)

if [ "$getlink" = 1 ]
then
#link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=857000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613000,RESOLUTION=524x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1589000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2078000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
#link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-b.m3u8?sd=10&rebase=on"
#link=https://www.filmon.com/tv/voa-english
fi
##method="Tor"
use_cookies="no"
TAG="VOA_______"
chan_name="VOA" ;;

########################### EASTERN DOCUMENTARIES ##############################################
# 34) RT Documentary
34) 

if [ "$getlink" = 1 ]
then
#link=https://rtd.rt.com/on-air/
link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-1k_v5.m3u8
#link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-2k_v5.m3u8
#link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-3k_v5.m3u8
#link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-4k_v5.m3u8
#link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-5k_v5.m3u8
## AUDIO 
#link=https://rt-doc.secure.footprint.net/1101-inadv-qidx-0k_v5.m3u8

#link="https://secure-streams.akamaized.net/rt-doc/index.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index2500.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index1600.m3u8"
#####link="https://secure-streams.akamaized.net/rt-doc/index800.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index400.m3u8"
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
fi
#####method="Tor"
use_cookies="no"
TAG="RT_DOC____"
chan_name="RT Documentary" ;;

# 35) CGTN Documentary
35)

if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-d.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
#link=http://livedoc.cgtn.com/1000d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
link=http://livedoc.cgtn.com/500d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://livedoc.cgtn.com/200d/prog_index.m3u8
fi
###method="Tor"
use_cookies="no"
TAG="CGTN_DOC__"
chan_name="CGTN Documentary" ;;
######################## CANADA #################################
# 36) CBC Canada
36)

if [ "$getlink" = 1 ]
then
link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master1.m3u8"
#link="http://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
fi
#####method="Tor"
use_cookies="no"
TAG="CBC_CA____"
chan_name="CBC Canada";;
# 37) CBC News Network Canada
37)
if [ "$getlink" = 1 ]
then
link="https://1359547862.rsc.cdn77.org/LS-ATL-54548-8/tracks-v4a1/mono.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="CBCNEWSNET"
chan_name="CBC News Network Canada";; 
########################## CANADIAN GOVERNMENT #########################
# 38) CPAC 1 Canada  
38)

if [ "$getlink" = 1 ]
then
#link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1/master.m3u8
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1/master.m3u8
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248522/1242843915001_4/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=612830,RESOLUTION=640x360,CODECS="avc1.77.31,mp4a.40.5"
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1539347909947/Layer1_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=920204,RESOLUTION=720x404,CODECS="avc1.77.31,mp4a.40.5"
link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1539347909947/Layer2_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3172598,RESOLUTION=1280x720,CODECS="avc1.77.31,mp4a.40.5"
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1539347909947/Layer3_master.m3u8

# Original Language
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3/master.m3u8
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1518231308621/Layer1_master.m3u8
# French
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8

fi
####method="Tor"
use_cookies="no"
TAG="CPAC_1_CA_"
chan_name="CPAC 1 Canada" ;;

###########################################################
# 39) Africa News
39)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x6i7vf8
#link="https://stream-03.sv6.dailymotion.com/sec(Rt6MMB82ZLcHsd-t3Q1ireG1DpwZZ7TP04NU4YH4148)/dm/3/x6i7vf8/live-2.m3u8"
#link="https://stream-03.sv6.dailymotion.com/sec(Rt6MMB82ZLcHsd-t3Q1ireG1DpwZZ7TP04NU4YH4148)/dm/3/x6i7vf8/live-1.m3u8"
#link="https://stream-03.sv6.dailymotion.com/sec(Rt6MMB82ZLcHsd-t3Q1ireG1DpwZZ7TP04NU4YH4148)/dm/3/x6i7vf8/live-3.m3u8"
use_cookies="no"
format=hls-720
#format=hls-480
###method="Tor"
fi
####method="Tor"
use_cookies="no"
TAG="AFRICA_NEWS__"
chan_name="Africa News English" ;;

# 40) EuroNews English
40) 
keyword="euronews"
method="Tor"

if [ "$getlink" = 1 ]
then
#link="http://www.euronews.com/live"

#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://www.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d \/ -f 3,4,5 | sed 's/\\//g' )
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_224p.m3u8"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://www.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_90p/' )
link="$radix"
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_90p/' )

#http://euronews-en-p-api.hexaglobe.net/a3618e54b21c1c5dd38e7b36efb549fb/5c234c7f/euronews/euronews-euronews-website-web-responsive-2/en/stream_info.php
#http://euronews-en-b9-cdn.hexaglobe.net/c72edfc1e45108d5a4e00b9798951041/5c234cf7/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenbkp_eng.smil/playlist.m3u8
#http://euronews-en-p10-cdn.hexaglobe.net/f31d32ca80e7af93810eaa12ff2fb0b9/5c234cf7/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | grep "$keyword" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8
fi
use_cookies="no"
TAG="EURONEWS_EN__"
chan_name="Euronews English" ;; 


#############################  ENGLISH EXTRA #############################################
# 41) BBC Parliament 
41)
#keyword=":"
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-parliament
fi
use_cookies="yes"
####method="Tor"
TAG="BBC_PARLIM___"
chan_name="BBC Parliament" ;;
########################## IRELAND ##############################################
# 42) OIreachtas TV IE
42)
if [ "$getlink" = 1 ]
then  
link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1338000,CODECS="avc1.66.32,mp4a.40.2",RESOLUTION=854x480
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1063000,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=640x360
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b978000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=513000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=426x240
####link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b478000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=128000,CODECS="mp4a.40.2"q
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b128000.m3u8
fi
####method="Tor"
use_cookies="no"
TAG="ORIEACHTAS_IE"
chan_name="Oireachtas TV IE" ;; 
############################## Made in ###########################################
# 43) Made in Leeds
43)
if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
fi
##method="Tor"
TAG="MADEIN_LEEDS"
chan_name="Made in Leeds" ;;
# 44) Made in Tyne & Wear
44)

if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
fi
###method="Tor"
TAG="MADEIN_TYNE__"
chan_name="Made in Tyne & Wear" ;;
# 45) Made in Cardiff
45)

if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/x5ev9xg
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
fi
###method="Tor"
TAG="MADEIN_CARDIFF"
chan_name="Made in Cardiff" ;;
#####################################
# 46)Fiji One
46)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/19514369/fijitvstream"

link="$( curl "https://livestream.com/accounts/19514369/fijitvstream" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"

#link="https://api.new.livestream.com/accounts/19514369/events/6947821/broadcasts/178003819.secure.m3u8?dw=80&hdnea=st=1532300156~exp=1532301956~acl=/i/19514369_6947821_lsij45kqt9nyyt15htt_1@356040/*~hmac=7bd7f4119ce7cfff884af05d0c80144ce702a3286ba1ca17619fa00c53cce643"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1628000,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=856x480
#link="https://secure-playlist.livestream.com/streams/19514369_6947821_lsij45kqt9nyyt15htt_1/media/19514369_6947821_lsij45kqt9nyyt15htt_1@1628000pb.m3u8?dw=80&token=1532473173_75f7f9fa2b3331fb47f8cf81defa7993dc34e380&ts=1532296800"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1628000,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=856x480
#link="https://secure-playlist.livestream.com/streams/19514369_6947821_lsij45kqt9nyyt15htt_1/media/19514369_6947821_lsij45kqt9nyyt15htt_1@1628000p.m3u8?dw=80&token=1532473173_59e9e6991069b4127db610f63dcdd4d04f456795&ts=1532296800"
fi
use_cookies="no"
TAG="FIJI_ONE_____"
chan_name="Fiji One" ;;

# 47) NDTV India
47)
if [ "$getlink" = 1 ]
then
#link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=128000,RESOLUTION=640x480,CODECS="avc1.64001f, mp4a.40.2"
#link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/index_96_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=256000,RESOLUTION=640x480,CODECS="avc1.64001f, mp4a.40.2"
#link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/index_224_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=384000,RESOLUTION=640x480,CODECS="avc1.64001f, mp4a.40.2"
#link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/index_352_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=512000,RESOLUTION=640x480,CODECS="avc1.64001f, mp4a.40.2"
#link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/index_480_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=768000,RESOLUTION=640x480,CODECS="avc1.64001f, mp4a.40.2"
link="https://ndtvstream-lh.akamaihd.net/i/ndtv_24x7_1@300633/index_736_av-p.m3u8?sd=10&rebase=on"
fi
use_cookies="no"
TAG="NDTV_IN______"
chan_name="NDTV India" ;;
# 48) NewsX India 
48)
if [ "$getlink" = 1 ]
then
link="https://d3cjrhqx3ygiqt.cloudfront.net/abr/ngrp:newsx_all/playlist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1778000,CODECS="avc1.77.40,mp4a.40.2",RESOLUTION=558x406
#link="https://d3cjrhqx3ygiqt.cloudfront.net/abr/ngrp:newsx_all/chunklist_w906609032_b1628000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=788000,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=396x288
#link="https://d3cjrhqx3ygiqt.cloudfront.net/abr/ngrp:newsx_all/chunklist_w906609032_b728000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=348000,CODECS="avc1.77.21,mp4a.40.2",RESOLUTION=296x216
#link="https://d3cjrhqx3ygiqt.cloudfront.net/abr/ngrp:newsx_all/chunklist_w906609032_b328000.m3u8"
fi
use_cookies="no"
TAG="NEWSX_IN_____"
chan_name="NewsX India" ;;
##################################

############################## SHOPPING ##########################################################
# 49)  QVC 
49) 

if [ "$getlink" = 1 ]
then
keyword="QVC Live Stream"
#link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=174000,RESOLUTION=320x180,SUBTITLES="subs"
#link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b174000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=64000,CODECS="mp4a.40.2",SUBTITLES="subs"
#link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b64000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=332000,RESOLUTION=320x180,SUBTITLES="subs"
#link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b332000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=732000,RESOLUTION=640x360,SUBTITLES="subs"
#####link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b732000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1128000,RESOLUTION=848x480,SUBTITLES="subs"
#link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b1128000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1928000,RESOLUTION=1024x576,SUBTITLES="subs"
link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b1928000.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
#####method="Tor"
use_cookies="no"
TAG="QVC_EN____"
chan_name="QVC English" ;;
# 50) The Shopping Channel TSC
50)

if [ "$getlink" = 1 ]
then

#link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=992000,RESOLUTION=848x480,CODECS="avc1.640029, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2200000,RESOLUTION=1280x720,CODECS="avc1.640029, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2200000,RESOLUTION=1280x720,CODECS="avc1.640029, mp4a.40.2"
link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1428000,RESOLUTION=848x480,CODECS="avc1.640029, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-b.m3u8?sd=10&rebase=on"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-b.m3u8?sd=10&rebase=on"
fi
#####method="Tor"
use_cookies="no"
TAG="TSC_______"
chan_name="The Shopping Channel TSC" ;;
################################## TECHNOLOGY ##############################
# 51)  TWiT USA
51) 
keyword="TWiT Live"


if [ "$getlink" = 1 ]
then
####Twitch
link=https://www.twitch.tv/twit 

#USTREAM
# https://r46932538-1-1524-channel-wss-live.ums.ustream.tv/1/ustream
# link=https://www.ustream.tv/channel/1524
# method="livestreamer"
# format="mobile_720p"
# mobile_252p (worst), mobile_360p, mobile_486p, mobile_720p

# YOUTUBE
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi

#####method="Tor"
use_cookies="no"
TAG="TWIT_USA__"
chan_name="TWiT USA" ;;
# 52) Juptier Broadcasting USA
52) 

if [ "$getlink" = 1 ]
then
link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8	
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
### USTREAM ####
#link=http://www.ustream.tv/channel/JupiterBroadcasting

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="JUPITERBROAD___"
chan_name="Jupiter Broadcasting USA" ;;
#############################################################
# 53) FiOS1 News Long Island
53) 

if [ "$getlink" = 1 ]
then
#link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_b159ee77/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
link="https://urtmpkal-f.akamaihd.net/i/1b159ee77_1@192104/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1b159ee77_1@192104/index_1_av-b.m3u8?sd=10&rebase=on"
fi
# method="Tor"
use_cookies="no"
TAG="FIOS1LONGISLD__"
chan_name="FiOS1 News Long Island" ;;
# 54) FiOS1 News New Jersey 
54)

if [ "$getlink" = 1 ]
then
#link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_if6bcg01/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1if6bcg01_1@394073/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
link="https://urtmpkal-f.akamaihd.net/i/1if6bcg01_1@394073/index_1_av-b.m3u8?sd=10&rebase=on"
fi

#method="Tor"
use_cookies="no"
TAG="FIOS1_NEWJERSEY"
chan_name="FiOS1 News New Jersey" ;;
# 55) Lake Tahoe TV
55)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/21822229/events/6450069"
link="$( curl "https://livestream.com/accounts/21822229/events/6450069"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
TAG="LAKE_TAHOE____"
chan_name="Lake Tahoe TV" ;;
# 56)  TVW Washington State TV
56)

if [ "$getlink" = 1 ]
then
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1257472,CODECS="avc1.77.32,mp4a.40.2",RESOLUTION=1280x720
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b1155072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1066072,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=640x360
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b981072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=516072,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=426x240
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b481072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=351072,CODECS="avc1.66.21,mp4a.40.2",RESOLUTION=284x160
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b331072.m3u8
fi
use_cookies="no"
TAG="TVW_WASH_______"
chan_name="TVW Washington State TV" ;; 
############# WASHINGTON DC #################################
# 57) District of Columbia Network
57)
if [ "$getlink" = 1 ]
then
#link=http://video.oct.dc.gov/out/u/DCN.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=364035,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=664059,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864061,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1064061,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=http://video.oct.dc.gov/out/u/21_4.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="DC_NETWORK_____"
chan_name="District of Columbia Network" ;;
# 58) District of Columnbia 
58)

if [ "$getlink" = 1 ]
then
#link=http://video.oct.dc.gov/out/u/DCC.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=364063,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/15_1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=664058,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/15_2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864062,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/15_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1064088,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=http://video.oct.dc.gov/out/u/15_12.m3u8
fi
# method="Tor"
use_cookies="no"
TAG="DCC___________"
chan_name="District of Columbia" ;;

# 59) DC Knowledge Network
59)

if [ "$getlink" = 1 ]
then
#link=http://video.oct.dc.gov/out/u/DKN.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=428009,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/96_7.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=728053,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/96_8.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=927908,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/96_9.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1127917,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=http://video.oct.dc.gov/out/u/96_10.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="DC_KNOWLEDGE___"
chan_name="District of Columbia DC Knowledge Network USA";; 

# 60) Laurel TV Laurel Maryland USA 
60)
if [ "$getlink" = 1 ]
then
#link=https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=600000
link="https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist_w1325653752_b600000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=300000
#link="https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist_w1325653752_b300000.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="LAUREL_MARYLAND"
chan_name="Laurel TV Laurel Maryland USA" ;;

# 61) Southeastern Channel
61)
if [ "$getlink" = 1 ]
then
#http://thesoutheasternchannel.com/live-stream/
link=http://147.174.13.196/live/WIFI-1296k-540p/WIFI-1296k-540p.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="SOUTHEASTERN___"
chan_name="Southeastern Channel" ;;
# 62) TSTV  Texas State University TV
62)

if [ "$getlink" = 1 ]
then
link=http://tstv-stream.tsm.utexas.edu/hls/livestream_hi/index.m3u8
#link=http://tstv-stream.tsm.utexas.edu/hls/livestream_low/index.m3u8
fi
##method="Tor"
use_cookies="no"
TAG="TSTV_TEXAS_____"
chan_name="TSTV Texas State University TV" ;;
################################## MNN ########################################### 
################## MANHATTAN NEIGHBOURHOOD NETWORK HD
# 63)MNN Channel 5 Manhattan Neighbourhood Network HD New York USA
63)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/17251372/events/4846282"
link="$( curl "https://livestream.com/accounts/17251372/events/4846282" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.m3u8
#link="https://api.new.livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.m3u8"
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.smil
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.smil
fi
##method="Tor"
use_cookies="no"
TAG="MNN_5__HD_"
chan_name="MNN Channel 5 New York USA" ;;

# 64) MNN Channel 1 New York USA
64)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6480540/events/2616259"
link="$( curl "https://livestream.com/accounts/6480540/events/2616259" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
# method="Tor"
use_cookies="no"
TAG="MNN_1__________"
chan_name="MNN Channel 1 New York, USA" ;;
# 65) MNN 2 Lifestyle New York, USA
65)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6478976/events/2616018"
link="$( curl "https://livestream.com/accounts/6478976/events/2616018" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
#link="http://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.smil"
#link="https://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.secure.smil"
#link="http://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.m3u8?dw=80&hdnea=st=1532302872~exp=1532304672~acl=/i/6478976_2616018_lsijmgxu5lc98vrv9py_1@447454/*~hmac=4b08011d98f184c3a97ec486fc168bb0fa185dd7cfc0864c5f648785a949270b"
#link="https://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.secure.m3u8?dw=80&hdnea=st=1532302872~exp=1532304672~acl=/i/6478976_2616018_lsijmgxu5lc98vrv9py_1@447454/*~hmac=4b08011d98f184c3a97ec486fc168bb0fa185dd7cfc0864c5f648785a949270b"
fi
##method="Tor"
use_cookies="no"
TAG="MNN_2__________"
chan_name="MNN Channel 2 New York, USA" ;;
# 66) MNN Channel 3 New York, USA 
66)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6312590/events/2611503"
link="$( curl "https://livestream.com/accounts/6312590/events/2611503"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
## method="Tor"
use_cookies="no"
TAG="MNN_3__________"
chan_name="MNN Channel 3 New York, USA" ;;
# 67) MNN Channel 4 New York, USA 
67)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6478935/events/2616010"
link="$( curl "https://livestream.com/accounts/6478935/events/2616010"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
## method="Tor"
use_cookies="no"
TAG="MNN_4__________"
chan_name="MNN Channel 4 New York, USA" ;;

# 68) BronxNet NY USA
68)

if [ "$getlink" = 1 ]
then
#link="https://reflect-live-bronxnet.cablecast.tv/live/live.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
link="https://reflect-live-bronxnet.cablecast.tv/live/WIFI-1896k-720p/WIFI-1896k-720p.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=570400,RESOLUTION=480x270,NAME="CELL-496k-270p"
#link="https://reflect-live-bronxnet.cablecast.tv/live/CELL-496k-270p/CELL-496k-270p.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="BRONXNET__"
chan_name="BronxNet NY USA";; 

############################# CNN ###################################################
# 69) CNN PHILIPPINES
69)
if [ "$getlink" = 1 ]
then
link=rtmp://54.251.134.121/live/15273.sdp
fi
use_cookies="no"
####method="Tor"
TAG="CNN_PH______"
chan_name="CNN PHILIPPINES";;
# 70) CNN Live  
70)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
####link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-b.m3u8?sd=10&rebase=on"
#link="https://1861340594.rsc.cdn77.org/ls-54548-1/tracks-v1a1/mono.m3u8"
fi
use_cookies="no"
####method="Tor"
TAG="CNN_LIVE___"
chan_name="CNN Live" ;;  
# 71) CNN HLN Headline News USA
71)
if [ "$getlink" = 1 ]
then
link="https://1161275585.rsc.cdn77.org/LS-ATL-54548-7/tracks-v4a1/mono.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="CNN_HLN____"
chan_name="CNN HLN USA";; 

######################## FOX NEWS USA ########################################################
# 72) Fox News Talk
72)  

if [ "$getlink" = 1 ]
then
link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=476x268,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=476x268,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=728000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=728000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=66000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=66000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-b.m3u8?sd=10&rebase=on"
fi
## method="Tor"
use_cookies="no"
TAG="FOX_TALK_"
chan_name="Fox News Talk" ;; 
# 73) CNBC USA
73)

if [ "$getlink" = 1 ]
then
link="https://1674331492.rsc.cdn77.org/LS-ATL-54548-14/tracks-v1a1/mono.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="CNBC______"
chan_name="CNBC USA";; 

# 74)
# 75) 
# 76)
# 77)
# 78)
# 79)
# 80)

#EXTINF:0 group-title=”US: _”,US: PBS
#http://atlas.its.virginia.edu:8088/hls/m3u8/PBS.m3u8
#EXTINF:0 group-title=”US: _”,US: PLANET GREEN
#http://80.80.160.168/live/4/live.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/chunklist_b4192000.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC 2
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/1af4a53fda904f6c90a4389c8fe92dc0/manifest.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC BEAUTY IQ
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/4bc0e8c660c94c00afcdae21479e2b95/chunklist_b4192000.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC OPT 1
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/cd5bfeab75a34ba18301490388fd4daa/manifest.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC OPT 2
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#EXTINF:0 group-title=”US: _”,US: QVC2
#http://qvclvp2.mmdlive.lldns.net/qvclvp2/1af4a53fda904f6c90a4389c8fe92dc0/chunklist_b4192000.m3u8

################################################    FRENCH   ###################################
# 81) France 24 
81)
keyword="FRANCE 24 en Direct" 

if [ "$getlink" = 1 ]
then
#link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master_900.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="France 24" ;;                                               
# 82) BFM TV
82)

if [ "$getlink" = 1 ]
then 
link=https://players.brightcove.net/876450610001/HJeY2afE_default/index.html?videoId=5615950982001
#link=https://bfmtvalive1-a.akamaihd.net/8a3483ffeb9d40f0a738c1392f2bcc14/eu-central-1/876450610001/profile_1/87cd96eea0644453bd913833950774b0/chunklist_ssaiM.m3u8
#link=http://csm-e.dai.bfmtv.com/csm/live/109797390.m3u8
#link=https://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
#link=link=https://www.filmon.com/tv/bfm-tv
fi
use_cookies="no"
#format=hls-1080@60-0 
#format=hls-1080@60-1
#format=hls-720@60-0 
#format=hls-720@60-1 
#format=hls-480-0
#format=hls-480-1
#format=hls-380-0
#format=hls-380-1
#format=hls-240-0
#format=hls-240-1

#method="Tor"
chan_name="BFM TV";;
## 83) BFM BFM BUSINESS
83)

if [ "$getlink" = 1 ]
then 
link="https://players.brightcove.net/876450612001/HycrnmXI_default/index.html?videoId=1920204345001"
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_0_fra/audio_0_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_0/video_0.m3u8
## link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_4_fra/audio_4_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_19/video_19.m3u8
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-4.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-3.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-2.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-1.m3u8"
fi
format=""
use_cookies="no"
#method="Tor"
chan_name="BFM Busineess France" ;;
# 84) RT Francais
84)

if [ "$getlink" = 1 ]
then
#link=https://rt-france.secure.footprint.net/1107-inadv-qidx-1k_v5.m3u8
link=https://rt-france.secure.footprint.net/1107-inadv-qidx-2k_v5.m3u8
#link=https://rt-france.secure.footprint.net/1107-inadv-qidx-3k_v5.m3u8
#link=https://rt-france.secure.footprint.net/1107-inadv-qidx-4k_v5.m3u8
#link=https://rt-france.secure.footprint.net/1107-inadv-qidx-5k_v5.m3u8
#####AUDIO
#link=https://rt-france.secure.footprint.net/1107-inadv-qidx-0k_v5.m3u8

#link=https://secure-streams.akamaized.net/rt-fr/index.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/indexaudio.m3u8
fi

use_cookies="no"
#method="Tor"
chan_name="RT France" ;;
# 85) France Info TV
85) 
keyword="franceinfo"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
#link=https://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
#link=https://livefrancetv.akamaized.net/simulcast/France_Info/dash_monde/ZXhwPTE1MjUxODIxMzZ+YWNsPSUyZnNpbXVsY2FzdCUyZkZyYW5jZV9JbmZvJTJmZGFzaF9tb25kZSp+aG1hYz1mZDU1NmM2NmE5ODExZWNlOGI5YjQ1MDc3ZDA2ZTQ4YTg1Y2FmNTkyNTdiY2Q4MWI1YzU4YjRiMWE0M2MxYmUw/France_Info.mpd
link="http://videos.francetv.fr/video/SIM_Franceinfo"
fi
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
format="best"
use_cookies="no"
#method="Tor"
chan_name="France Info TV" ;;  
# 86)TV5 Monde Info
86)

if [ "$getlink" = 1 ]
then
#link=https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=362435,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=362435,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=571616,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=571616,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764771,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764771,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1088642,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1088642,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1378624,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1378624,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2196150,RESOLUTION=1920x1080,CODECS="mp4a.40.2,avc1.4d4029"
link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2196150,RESOLUTION=1920x1080,CODECS="mp4a.40.2,avc1.4d4029"
#link="http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_1.m3u8"
fi

use_cookies="no"
#method="Tor"
chan_name="TV5 Monde Info FR" ;;
# 87) CGTN Francais 
87)

if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-f.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=http://livefr.cgtn.com/1000f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=http://livefr.cgtn.com/500f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://livefr.cgtn.com/200f/prog_index.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="CGTN Francais" ;; 
# 88) Euronews Francais
88) 
keyword="euronews"
method="Tor"

if [ "$getlink" = 1 ]
then
#link="http://fr.euronews.com/live"

#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://fr.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d \/ -f 3,4,5 | sed 's/\\//g' )
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_224p.m3u8"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://fr.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_90p/' )
link=$radix
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_90p/' )

#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_720p.m3u8"
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_540p.m3u8"
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_360p.m3u8"
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_224p.m3u8"
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_180p.m3u8"
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_90p.m3u8"

#link="http://euronews-fr-p7-cdn.hexaglobe.net/a83a4cc1267c84bca975bb0c4613d6ea/5c2317d8/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/playlist.m3u8"
#link="http://euronews-fr-b11-cdn.hexaglobe.net/08a0b33973df2395b91626f2ac363bcb/5c2317d8/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrbkp_fre.smil/playlist.m3u8"
fi

#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Francais" ;;  
# 89) Africa News Francais
89) 
keyword="DIRECT"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
link="https://www.dailymotion.com/video/x6i37o5"
fi

use_cookies="no"
#method="Tor"
chan_name="Africa News Francais" ;;
# 90) TVA CA
90) 

if [ "$getlink" = 1 ]
then
link="https://players.brightcove.net/5481942443001/r1t0JFRjG_default/index.html?videoId=5827595278001"	
#link="https://chainetvauls-lh.akamaihd.net/i/tvago_1@410563/index_3000_av-p.m3u8?sd=10&rebase=on&hdntl=exp=1545537772~acl=/*~data=hdntl~hmac=91261c56e5a10151f55734ad3d4bc0c0c2e1d4b04ebc36e9abf5b2aef008f51f"
fi
use_cookies="no"
#method="Tor"
chan_name="TVA CA";;
# 91) RDI Radio Canada ICI 
91)

if [ "$getlink" = 1 ]
then
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
fi
## method="Tor"
use_cookies="no"
chan_name="RDI Radio Canada ICI" ;;
# 92) RTS UN
92) 

if [ "$getlink" = 1 ]
then
#link=http://par-3.firstone.tv/hls/22797bb2-c681-91ce-2f29-fd5690f82b91.m3u8
link=https://www.filmon.com/tv/rts-un
fi
use_cookies="no" 
#method="Tor"
chan_name="RTS UN" ;;
# 93) FRANCE 2
93)

if [ "$getlink" = 1 ]
then 
#link=http://par-4.firstone.tv/hls/1f181ce3-b1d5-70a2-8cc7-9f6ef5df7d89.m3u8
link=https://www.filmon.com/tv/france-2
fi
use_cookies="no"
#method="Tor"
chan_name="France 2" ;;
# 94) France 3 
94)

if [ "$getlink" = 1 ]
then 
#link=http://par-4.firstone.tv/hls/f5d676d6-692f-eb8c-8c3c-34f741a0f7b3.m3u8
link=https://www.filmon.com/tv/france-3-rhone-alpes
fi

use_cookies="no"
#method="Tor"
chan_name="France 3" ;;
# 95) ARTE FRANCAIS
95) 

if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/arte-francais
fi

use_cookies="yes" 
#method="Tor"
chan_name="ARTE Francais" ;;
# 96) France O
96)

if [ "$getlink" = 1 ]
then 
link=https://www.filmon.com/tv/france-0
fi
## method="Tor"
use_cookies="yes"
chan_name="France O" ;;
# 97) Bidtween La chaîne TV des Enchères FR
97)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/25334545/events/7803598"
link="$( curl "https://livestream.com/accounts/25334545/events/7803598" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
## method="Tor:
use_cookies="no"
chan_name="Bidtween La chaîne TV des Enchères FR" ;;
# 98) Azur TV Nice
98)

if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/x13x1q2 
fi

use_cookies="no"
#method="Tor"
chan_name="Azur TV Nice" ;;
# 99) IL TV France
99)

if [ "$getlink" = 1 ]
then
link=rtmp://str81.creacast.com:80/iltv/high
fi
use_cookies="no"
#method="Tor"
chan_name="IL TV" ;;
# 100) BFM Paris Francais
100)

if [ "$getlink" = 1 ]
then   
link=https://players.brightcove.net/5132998232001/H1bPo8t6_default/index.html?videoId=5152968636001
#link=http://bfmparishdslive-lh.akamaihd.net/i/DVMR_PARIS@429747/master.m3u8
fi

use_cookies="no"
#method="Tor"
chan_name="BFM Paris Francais" ;;
# 101) Alsace 20 France
101)

if [ "$getlink" = 1 ]
then
#link="http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=716736,CODECS="avc1.42801e,mp4a.40.2",RESOLUTION=640x360
#link=http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b657536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=355936,CODECS="avc1.428015,mp4a.40.2",RESOLUTION=480x270
#link=http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b329536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1550536,CODECS="avc1.428020,mp4a.40.2",RESOLUTION=1280x720
link=http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b1415536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=175536,CODECS="avc1.42800d,mp4a.40.2",RESOLUTION=416x234
#link=http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b165536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3211264,CODECS="avc1.4d4028,mp4a.40.2",RESOLUTION=1920x1080
#link=http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b3211264.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="Alsace 20 France" ;;
# 102) Mosaik TV Francais
102)
keyword="Diffusion en direct de mosaiktv"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
## method="Tor"
use_cookies="no" 
chan_name="Mosaik TV" ;;
## 103)QVC Francais
103) 
keyword="en direct"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
# method="Tor"
use_cookies="no"
chan_name="QVC Francais" ;;  
# 104) 8 Mont Blanc FR
104)

if [ "$getlink" = 1 ]
then
link="http://www.dailymotion.com/video/x3wqv8b"
fi
use_cookies="no"
#method="Tor"
chan_name="8 Mont Blanc FR" ;;
# 105) TV7 Bordeaux
105)

if [ "$getlink" = 1 ]
then
link=http://62.210.204.108:1935/livtv7vo/myStream.smil/playlist.m3u8
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b828000_slfra.m3u8
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b328000_slfra.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="TV7 Bordeaux" ;;
# 106) RTS DEUX
106) 
if [ "$getlink" = 1 ]
then
#link=http://par-4.firstone.tv/hls/f1074899-4ce9-5908-4f1f-25aee6dc0ef7.m3u8
link=https://www.filmon.com/tv/rts-deux
fi
use_cookies="no" 
#method="Tor"
chan_name="RTS DEUX" ;;
# 107) LCP Assemblee National France
107)

if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/xji3qy

fi
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="LCP Assemblee National France" ;;
# 108) Public Senate France
108)

if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/xkxbzc
fi
use_cookies="no"
#format=hls-720
format=hls-480	
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Public Senate France" ;;
# 109) CPAC 1 Francais
109)

if [ "$getlink" = 1 ]
then
#link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
link=http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="CPAC 1 Francais Canada" ;;
# 110) Assemblee Nationale du Quebec Francais
110)
if [ "$getlink" = 1 ]
then
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="Assemblee Nationale du Quebec Francais Canada" ;;
# 111)Canal Savoir Francais
111)

if [ "$getlink" = 1 ]
then
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="Canal Savoir Canada" ;;
# 112) GONG Asian Cinema Francais
112)

if [ "$getlink" = 1 ]
then
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="GONG Asian Cinema Francais" ;;
# 113) GONG MAX
113)

if [ "$getlink" = 1 ]
then
link=http://51.254.215.79/appflux/gongmax/GONGMAX/gongmax_1280/chunks.m3u8 
fi
use_cookies="no"
#method="Tor"
chan_name="GONG MAX" ;;
# 114) BX1 BE
114)

if [ "$getlink" = 1 ]
then
#link=http://149.202.81.107:1935/stream/live/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1638908,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=960x540
link=http://149.202.81.107:1935/stream/live/chunklist_w635316941.m3u8
#link=http://149.202.81.107:1935/stream/live/chunklist_w1279780159.m3u8 
fi
use_cookies="no"
#method="Tor"
chan_name="BX1 BE" ;;
# 115) France Info Radio
115) 

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
fi
format=hls-380
use_cookies="no"
#method="Tor"
chan_name="France Info Radio" ;;
# 116) Europe 1
116)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
fi
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Europe 1" ;;
# 117) RFI
117) 
keyword="RFI en Direct"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
fi
use_cookies="no"  
chan_name="RFI Francais" ;;
# 118) RTL En direct
118)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
# link=http://www.dailymotion.com/video/xl1km0
fi
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#method="Tor"
chan_name="RTL En Direct" ;;
# 119) France Inter
119) 
keyword="France Inter en direct"

if [ "$getlink" = 1 ]
then
#link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#format=hls-720
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="France Inter" ;; 
# 120) RMC INFO TALK SPORT RADIO FRANCE
120)  

if [ "$getlink" = 1 ]
then
link=https://players.brightcove.net/876630703001/SkKvZlxI_default/index.html?videoId=2623007265001
fi
use_cookies="no"
chan_name="RMC INFO TALK SPORT France" ;;

###################  SPANISH  #################################
# 121) RT Espanol
121) 
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then
link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-1k_v5.m3u8
#link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-2k_v5.m3u8
#link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-3k_v5.m3u8
#link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-4k_v5.m3u8
#link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-5k_v5.m3u8

### AUDIO
#link=https://rt-esp.secure.footprint.net/1102-inadv-qidx-0k_v5.m3u8

#link=https://secure-streams.akamaized.net/rt-esp/index.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index800.m3u8
#####link=https://secure-streams.akamaized.net/rt-esp/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/indexaudio.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEIhICHOQOonjE6V0SLdrHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://actualidad.rt.com/en_vivo2
fi

use_cookies="no"
#method="Tor"
chan_name="RT Espanol" ;;
# 122) DW Espanol
122) 
keyword="DW Español en VIVO"

if [ "$getlink" = 1 ]
then
#link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_1_av-b.m3u8?sd=10&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_a-b.m3u8?sd=10&rebase=on"

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi

use_cookies="no"
#method="Tor"
chan_name="DW Espanol" ;;
# 123) CGTN Espanol
123)

if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-e.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link="http://livees.cgtn.com/1000e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link="http://livees.cgtn.com/500e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
###link="http://livees.cgtn.com/200e/prog_index.m3u8"
fi
use_cookies="no"
#method="Tor"
chan_name="CGTN Espanol" ;;
###################### FRANCIA ##########################################
# 124) France 24 Espanol
124)

if [ "$getlink" = 1 ]
then 
keyword="Vivo"
#link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_ES_LO_HLS/live_web.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master_900.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUdOoVWuWmgo1wByzcsyKDQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
#method="Tor"
chan_name="France 24 Espanol" ;;

# 125) Euronews Espanol
125) 
keyword="euronews"
method="Tor"

if [ "$getlink" = 1 ]
then
#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://es.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d \/ -f 3,4,5 | sed 's/\\//g' )
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrespri_spa.smil/ewnsabrespri_spa_360p.m3u8"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://es.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
link=$radix
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrespri_spa_90p/' )

#link="http://es.euronews.com/live"
fi
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
#keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Espanol" ;;  
# 126) Hispan TV Iran
126) 
keyword="HispanTV"

if [ "$getlink" = 1 ]
then
#link="https://5a61de8ed719d.streamlock.net/live/smil:live.smil/playlist.m3u8"
link="https://5a61de8ed719d.streamlock.net/live/smil:live.smil/chunklist_w2093826190_b644100_slen.m3u8"
#link=http://178.32.255.199:1935/live/hispantv/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no" 
chan_name="HispanTV Iran" ;;
############## ESPANIA ######################################
# 127) Magala TV Spain  Malaga,Andalusia,Spain
127)
keyword="Directo de Málaga"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="Magala TV Spain" ;;  
# 128)  GUADA TV Guadalajara (España)
128) 
keyword="directo"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oPWmhiUTekfM5vcWsORLg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Guada TV Spain" ;; 
# 129) GRANADA TV ES
129)  
keyword="GRANADA"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Steadycamline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="GRANADA TV ES" ;; 
######################### ARGENTINA ##############################################
# 130) c5n Argentina
130) 
keyword="C5N"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
# link=http://www.c5n.com/
fi
use_cookies="no"
chan_name="c5n Argentina" ;;
# 131) Canal Acequia Mendoza AR
131)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6450028/events/5813077"
link="$( curl "https://livestream.com/accounts/6450028/events/5813077"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Canal Acequia Mendoza AR" ;;
# 132) Todo Noticias Argentina
132) 
keyword="TN en vivo"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
fi
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 133) La Nacion TV Argentina
133) 
keyword="LN+"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
fi
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 134)TV5 Argentina
134)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/20819504/events/6036256"
link="$( curl "https://livestream.com/accounts/20819504/events/6036256"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="TV5 Argentina" ;;
# 135) KZO En Vivo Canal 30
135) 
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;; 
# 136)  Canal 2 Argentina
136)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/679322/Canal2Jujuy"
link="$( curl "https://livestream.com/accounts/679322/Canal2Jujuy"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Canal 2 Argentina" ;;
# 137) Canal 6 San Rafael Argentina 
137) 
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
fi
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 138) Canal 7 Mendoza Argentina
138) 
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
fi
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 139) Canal 13 San Juan Argentina  
139)  
keyword="Juan"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;; 
# 140) CN23 Argentina
140)  
keyword="CN23"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="CN23 Argentina" ;;   
# 141) Telemax Argentina
141)

if [ "$getlink" = 1 ]
then
#link="http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=364000,RESOLUTION=320x180
#link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b364000_sleng.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864000,RESOLUTION=640x360
#link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b864000_sleng.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1828000,RESOLUTION=1280x720
link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b1828000_sleng.m3u8
fi
use_cookies="no"
chan_name="Telemax Argentina" ;; 
# 142) VORTERIX AR
142)  
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="VORTERIX AR" ;;
# 143) TV Publica Argentina   ****
143)  
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="TV Publica Argentina" ;;

################ BOLIVIA ##################################
## 144) Bolivia TV BO
144)

if [ "$getlink" = 1 ]
then
#link=https://livestream.com/accounts/10468276/boliviatv
link="$( curl "https://livestream.com/accounts/10468276/boliviatv"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Bolivia TV BO" ;; 
# 145) Cosmovision TV BO
145)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/16628908/cosmovisionhd"
link="$( curl "https://livestream.com/accounts/16628908/cosmovisionhd"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Cosmovision BO" ;;
######################       CHILE       #################################
# 146)Senal Internacional Mega Chile
146)  
keyword="Mega"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/programasmega/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
# 147)  CNN Chile CNN Chile
147)

if [ "$getlink" = 1 ]
then
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
fi
use_cookies="no"
chan_name="CNN Chile" ;;
################## Colombia ###################
# 148)Telemedellin CO
148)  
keyword="Telemedellin"

if [ "$getlink" = 1 ]
then
#link=https://livestream.com/accounts/4608897/events/7111788/
link="$( curl "https://livestream.com/accounts/4608897/events/7111788/"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCW_16ow2scNATL0NSxlBtPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="Telemedellin CO" ;; 
# 149) Teleantioquia Espanol  Canal de televisión pública del Departamento de Antioquia. Colombia
149)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/9427524/al-aire"
link="$( curl "https://livestream.com/canal-teleantioquia/events/8459038"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Teleantioquia CO" ;;
################# VENEZUELA
# 150) TeleSUR Venezuela
150) 
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
# link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
fi
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 151) Globovision Venezeula
151) 
keyword="Globovisión"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
fi
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 152) NTN24 Venezuela
152) 
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 153) CONSCIENCIA TV   *****
153)  
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "
" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
fi
use_cookies="no"
chan_name="CONCIENCIA TV" ;;
# 154) VPItv Venezuela
154) 
keyword="VIVO"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="VPItv Venezuela" ;;
#################### CENTRAL AMERICA    ########################
## 155) Guatevision GT
155)

if [ "$getlink" = 1 ]
then
#link=https://livestream.com/accounts/25697071/en-vivo
link="$( curl "https://livestream.com/accounts/25697071/en-vivo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Guatevision GT" ;; 
#################### MEXICO #########################################################
# 156) Excelsior TV Mexico
156) 
keyword="Transmisión en directo de Excélsior TV"

if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;


####################################### NORTHERN EUROPE ##############################################################
################  GERMAN   #######################################
# 161) WDR Germany
161)

if [ "$getlink" = 1 ]
then
# link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_184_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_184_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_320_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_320_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_608_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_608_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1216000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_1216_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1216000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_1216_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_1992_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_1992_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2691000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_2692_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2691000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_2692_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_3776_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_3776_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_184_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_184_a-b.m3u8?sd=10&rebase=on"
fi
use_cookies="no"
chan_name="WDR Germany" ;;
# 162)DW Deutsch Welle 
162)
keyword="DW"

if [ "$getlink" = 1 ]
then
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8"   
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_5_a-b.m3u8?sd=10&rebase=on"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelle/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi

use_cookies="no"
chan_name="DW Deutsch Welle";;
# 163) ZDK InfoKanal
163)

if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/zdf-infokanal
fi
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
# 164)  Tagessschau 24 Germany
164)

if [ "$getlink" = 1 ]
then
#link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_320_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_320_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_608_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_608_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1152000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1152_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1152000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1152_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1992_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1992_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_3776_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_3776_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_a-b.m3u8?sd=10&rebase=on"
fi
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 165) Euronews Deutsch
165) 
method="Tor"
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
if [ "$getlink" = 1 ]
then
#link="http://de.euronews.com/live"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://de.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_360p/' )
link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_90p/' )
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Euronews Deutsch" ;;
# 166)QVC DE 
166)
if [ "$getlink" = 1 ]
then
link="http://llnw.live.qvc.simplestream.com/hera/remote/qvcde_primary_sdi7/2/prog_index.m3u8"
fi
use_cookies="no"
chan_name="QVC DE " ;;  
# 167) ADR Alpha Live DE
167)
if [ "$getlink" = 1 ]
then  
link="https://br-i.akamaihd.net/i/tafeln/br-fernsehen/br-fernsehen-tafel_,0,A,B,E,C,X,.mp4.csmil/index_2_av.m3u8?null=0"
fi
use_cookies="no"
chan_name="ADR Alpha Live DE" ;;  
# 168) Radio 21 Nachreichten DE Germany 
168)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/22300508/events/6675945"
link="$( curl "https://livestream.com/accounts/22300508/events/6675945"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Radio 21 Nachreichten DE" ;;
# 169)  DW Deutsch +     GEOregion blocked
169)
if [ "$getlink" = 1 ]
then 
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8" 
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_a-b.m3u8?sd=10&rebase=on"
fi
method="Tor"
use_cookies="no"
chan_name="DW Deutsch + DE" ;;

################  Austria
# 170) W24 Wein Austria
170)
if [ "$getlink" = 1 ]
then
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
fi
use_cookies="no"
chan_name="W24 Wein, Austria" ;; 
# 171) Tirol TV Austria
171)
if [ "$getlink" = 1 ]
then
#link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
link=http://lb.hd-livestream.de:1935/live/TirolTV/chunklist_w1916857628.m3u8
fi
use_cookies="no"
chan_name="Tirol TV Austria" ;;
# 172) auftanken.tv Austria
172)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/26170820/events/7915290"
link="$( curl "https://livestream.com/accounts/26170820/events/7915290"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="auftanken.tv Austria" ;;
############################### Switzerland###############################################
# 173) SRF CH
173)
if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/srf-1
fi
use_cookies="yes"
chan_name="SRF CH" ;;
# 174) Musig24 TV Switzerland Deutsche
174)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/16598383/events/6923855"
link="$( curl "https://livestream.com/accounts/16598383/events/6923855"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="musig24 TV Switzerland Deutsche" ;;
################## DUTCH
########## BELGIUM 
# 175)TV OOST BE Dutch
175)
if [ "$getlink" = 1 ]
then
link="https://urtmpkal-f.akamaihd.net/i/156m2vpg5_1@322941/index_1_av-p.m3u8?sd=10&rebase=on"
fi
use_cookies="no"
chan_name="TV OOST BE Dutch" ;;  
########## NETHERLANDS
# 176)AT5 NETHERLANDS
176)
if [ "$getlink" = 1 ]
then
#link="https://ngx.cr6.streamzilla.xlcdn.com/session/9a63fab68b13d1eca45acd9e1b890d70/sz/atvijf/wowza4/live/live.smil/playlist.m3u8"
#link="https://ngx.cr2.streamzilla.xlcdn.com/session/cfe18ffd42a318a654dd596ef2097868/sz/atvijf/wowza4/live/live.smil/chunklist_b1048576.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1153433,RESOLUTION=640x512
#link="https://ngx.cr6.streamzilla.xlcdn.com/session/9a63fab68b13d1eca45acd9e1b890d70/sz/atvijf/wowza4/live/live.smil/chunklist_b1048576.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2306867,RESOLUTION=768x608
link="https://ngx.cr6.streamzilla.xlcdn.com/session/9a63fab68b13d1eca45acd9e1b890d70/sz/atvijf/wowza4/live/live.smil/chunklist_b2097152.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3460300,RESOLUTION=1920x1536
#link="https://ngx.cr6.streamzilla.xlcdn.com/session/9a63fab68b13d1eca45acd9e1b890d70/sz/atvijf/wowza4/live/live.smil/chunklist_b3145728.m3u8"
fi
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;
#######################   EASTERN EUROPE ############################################
############### RUSSIAN ################################
# 177)  Euronews Russian
177)
#method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://ru.euronews.com/live"

#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://ru.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrrupri_rus_90p/' )

#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist.m3u8
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_2m.m3u8
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_1m.m3u8
fi
use_cookies="no"
chan_name="Euronews Russian" ;;
# 178) Россия 24
178) 
keyword="24"
if [ "$getlink" = 1 ]
then
link=http://live.russia.tv/index/index/channel_id/3
#link=http://www.filmon.com/tv/rossiya-24
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 179) RBC TV RUSSIA
179)
if [ "$getlink" = 1 ]
then
link=http://online.video.rbc.ru/online/rbctv_480p/index.m3u8
#link=http://online.video.rbc.ru/online/rbctv_360p/index.m3u8
fi
use_cookies="no"
chan_name="RBC TV Russia" ;;
# 180) CGTN Russian
180)
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-r.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
#link=http://liveru.cgtn.com/1000r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
link=http://liveru.cgtn.com/500r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://liveru.cgtn.com/200r/prog_index.m3u8
fi
use_cookies="no"
chan_name="CGTN Russian" ;;
# 181) Vesti FM Russia
181) 
keyword="Вести ФМ"
if [ "$getlink" = 1 ]
then
link=http://live.russia.tv/index/index/channel_id/199
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 182)  Current Time VOA
182)
keyword="НАСТОЯЩЕЕ ВРЕМЯ"
if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/current-time-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/currenttimetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="yes"
chan_name="Current Time VOA" ;;
# 183) RTR Planeta
183)
if [ "$getlink" = 1 ]
then
link=http://live.russia.tv/index/index/channel_id/82
#link=http://www.filmon.com/tv/rtr-planeta
fi
use_cookies="no"
chan_name="RTR Planeta" ;;
# 184) Perviy Kanal Europa
184)
if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/perviy-kanal-europa
fi
use_cookies="yes"
chan_name="Perviy Kanal Europa" ;;
# 185) Music Box Russia
185)
if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/music-box-russia
fi
use_cookies="yes"
chan_name="Music Box Russia" ;;
# 186) MOSCKVA 24 RU
186)
if [ "$getlink" = 1 ]
then
link=http://live.russia.tv/index/index/channel_id/76
#link=http://www.ontvtime.ru/live/moskva24.html
fi
#method="Tor"
use_cookies="no"
chan_name="MOSCKVA 24 RU" ;; 
# 187) 1TV HD RU
187)
if [ "$getlink" = 1 ]
then
link=https://edge1.1internet.tv/dash-live11/streams/1tv/1tvdash.mpd
#link=https://edge1.1internet.tv/hls-live/livepkgr/_definst_/1tv.m3u8
fi
# method="Tor"
use_cookies="no"
chan_name="1TV HD RU" ;; 
# 188) Planeta Channel 4 Russia
188)
if [ "$getlink" = 1 ]
then
link=http://wse.planeta-online.tv:1935/live/channel_4/chunklist.m3u8
fi
# method="Tor"
use_cookies="no"
chan_name="Planeta Channel 4 Russia" ;;
# 189) Planeta Channel 6 Russia
189)
if [ "$getlink" = 1 ]
then
link=http://wse.planeta-online.tv:1935/live/channel_6/chunklist.m3u8
fi
# method="Tor"
use_cookies="no"
chan_name="Planeta Channel 6 Russia" ;;
# 190) ТВ-ТРЕЙЛЕР Russia
190)
if [ "$getlink" = 1 ]
then
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
fi
# method="Tor"
use_cookies="no"
chan_name="TPEYNEP TV RU" ;;
# 191) 5 RU
191)
keyword="Пятого канала"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGM8ZTtduKll7X8RiGe6N8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.ontvtime.ru/general/channel5.html
fi
use_cookies="no"
chan_name="5 Live RU" ;;
# 192) POCCNR 1 HD RU
192)
if [ "$getlink" = 1 ]
then
#link=http://live.russia.tv/index/index/channel_id/86
link=http://live.russia.tv/index/index/channel_id/1
fi
## method="Tor"
use_cookies="no"
chan_name="POCCNR 1 HD RU" ;; 
############## Broken
# 188) NTV RU
# 188)
# link=www.ntv.ru
# use_cookies="no"
# chan_name="NTV RU" ;;
# 189)  TNT RU  
# 189)
# link=http://www.ontvtime.ru/general/tnt.html
# use_cookies="no"
# chan_name="TNT RU" ;;
# 190)  POCCNR K RU
# 190)m
# link=http://www.ontvtime.ru/live/russiak-2.html
# use_cookies="no"
# chan_name="POCCNR K RU" ;;
# 193)POCCNR K RU
# 193)
#link=http://live.russia.tv/index/index/channel_id/86
#link=http://live.russia.tv/index/index/channel_id/4
#use_cookies="no"
#chan_name="POCCNR K RU" ;; 
######################### UKRAINE  ##################################
# 193) News 24 UA
193) 
keyword="24"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news24ru/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="24 TV UA" ;;
# 194) UA TV Ukraine 
194) 
keyword="UATV"
if [ "$getlink" = 1 ]
then
link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_mid/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_hi/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_low/index.m3u8
fi
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 195) Thromadske Ukraine
195) 
keyword="#Громадське (Наживо)"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 196) Еспресо Ukraine
196) 
keyword="LIVE"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 197) News 1 Ukraine
197) 
keyword="NEWSONE"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 198) ZIK UA
198)
keyword="ZIK"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUOsDBuiB_1zkRixc33TgSg/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="ZIK UA" ;;
# 199) Ukraine Channel 5 
199) 
keyword="5.ua"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="Ukraine 5" ;;
# 198) UA TV Ukraine Tartar
# 198) 
# keyword="UATV"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC-ni_mzd-eCHgkIMY2jOEoA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="UA TV Qirimatarca Ukraine" ;;
################# Moldova
# 200) TV Publica Moldova
200)
if [ "$getlink" = 1 ]
then
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
fi
use_cookies="no"
chan_name="TV Publica Moldova" ;;

########################### SOUTHERN EUROPE ################################################

##########################  Italian  ####################################################### 
# 201) RSI LA CH
201)
if [ "$getlink" = 1 ]
then
link=http://www.filmon.com/tv/rsi-la-1
fi
use_cookies="yes"
chan_name="RSI LA CH" ;;
# 202) SkyTG 24 Italian
202)
if [ "$getlink" = 1 ]
then
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
fi
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 203) Telecolor Lombardia Italy
203)
if [ "$getlink" = 1 ]
then
# link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=313356,RESOLUTION=320x240
# link=http://telecolor.econcept.it/live/telecolor.isml/QualityLevels\(298000\)/manifest\(format=m3u8-aapl\).m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=466656,RESOLUTION=400x300
# link=http://telecolor.econcept.it/live/telecolor.isml/QualityLevels\(448000\)/manifest\(format=m3u8-aapl\).m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=671056,RESOLUTION=640x480
link=http://telecolor.econcept.it/live/telecolor.isml/QualityLevels\(648000\)/manifest\(format=m3u8-aapl\).m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=53456
# link=http://telecolor.econcept.it/live/telecolor.isml/QualityLevels\(48000\)/manifest\(format=m3u8-aapl\).m3u8
fi
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 204) Teletutto Brescia Italy
204)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/701633/events/4147166"
link="$( curl "https://livestream.com/accounts/701633/events/4147166"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Teletutto Brescia Italy" ;;
# 205) QVC Itallian
205) 
keyword="QVC in diretta"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="QVC Italian" ;; 
# 206) Italia channel
206)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/277367/events/7379093"
#link="$( curl "https://livestream.com/accounts/277367/events/7379093"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Italia channel" ;;
# 207) Mediaon BergamoTV Italian
207)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/245066/events/3063596"
link="$( curl "https://livestream.com/accounts/245066/events/3063596"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Mediaon BergamoTV Italian" ;;
# 208) news24.city Milan Italy 
208)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/16586959/events/7803832"
link="$( curl "https://livestream.com/accounts/16586959/events/7803832"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="news24.city Milan Italy " ;;
# 209) Radio Radio TV Rome Italy 
209)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/11463451/tvlive"
link="$( curl "https://livestream.com/accounts/11463451/tvlive"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Radio Radio TV Rome Italy" ;;
# 210) Udinews TV Udine Italy
210)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/11217196/Udinese"
link="$( curl "https://livestream.com/accounts/11217196/Udinese"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Udinews TV Udine Italy" ;;
# 211) DiTV Canale 89 Lucchese Channel Italy 
211)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/21477830/events/7298093"
link="$( curl "https://livestream.com/accounts/21477830/events/7298093"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="DiTV Canale 89 Lucchese Channel Italy " ;;
# 212) RTM TV Arcevia Italy
212)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/10831729/events/3759913"
link="$( curl "https://livestream.com/accounts/10831729/events/3759913"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="RTM TV Arcevia Italy" ;;
# 213) 50 News Versilia Viareggio Italy  
213)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/25529830/events/7893732"
#link="$( curl "https://livestream.com/accounts/25529830/events/7893732"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="50 News Versilia Viareggio Italy" ;;
# 214) 50 Canale Pisa Italy 
214)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/19968830/events/7801416"
#link="$( curl "https://livestream.com/accounts/19968830/events/7801416"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="50 Canale Pisa Italy" ;;
# 215) Telelibertà Piacenza Italy 
215)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/17114188/events/4902226"
link="$( curl "https://livestream.com/accounts/17114188/events/4902226"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Telelibertà Piacenza Italy" ;;
# 216) ONE TV NBC 112 LIVE Milan Italy 
216)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/1326279/events/8235236"
link="$( curl "https://livestream.com/accounts/1326279/events/8235236"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="ONE TV NBC 112 LIVE Milan Italy" ;;
# 217) Euronews Italian 
217) 
#method="Tor-Streamlink"
#link="http://it.euronews.com/live"
method="Tor"
if [ "$getlink" = 1 ]
then
radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://it.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_540p/' )
link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabritpri_ita_90p/' )
fi
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Italian" ;;
################# MALTA #######################################
# 218)ONE Malta MT
218)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/18398100/ONELive"
link="$( curl "https://livestream.com/accounts/18398100/ONELive"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="ONE Malta MT" ;;
###################  CROATIA   ##########################
# 219) Z1 Televizija Zagreb, Croatia 
219)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/26764475/events/8122530"
link="$( curl "https://livestream.com/accounts/26764475/events/8122530"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Z1 Televizija Zagreb, Croatia " ;;
# 220) RTV Posavina TV Zagreb Croatia
220)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/20748106/events/7596004"
link="$( curl "https://livestream.com/accounts/20748106/events/7596004"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="RTV Posavina TV Zagreb Croatia" ;;
# 221) OsjeckaTV Zagreb Croatia 
221)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/20748093/events/6049691"
#link="$( curl "https://livestream.com/accounts/20748093/events/6049691"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="OsjeckaTV Zagreb Croatia " ;;
# 222) Tomix TV Wein AT Croatian 
222)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/12156095/events/3802250"
link="$( curl "https://livestream.com/accounts/12156095/events/3802250"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Tomix TV Wein AT Croatian" ;;

########################### HUNGARIAN ####################################
# 223) Euronews Hungarian
223) 
#method="Tor-Streamlink"
method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://hu.euronews.com/live"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://hu.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_540p/' )
link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrhubkp_hun_90p/' )

fi

format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Hungarian" ;;
################### GREEK ######################################
# 224) Sky TV Folk Skopje, Macedonia
224) 
keyword="LIVE"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCz69ZZjQ_9TnZPCgfVUQjxQ/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="Sky TV Folk Skopje, Macedonia MK";;
## 225) Star Lamia
225)
if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
fi
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 226) Action 24 Greece HD
226)
if [ "$getlink" = 1 ]
then 
link=http://www.dailymotion.com/video/x61fbhs
fi
use_cookies="no"		
chan_name="Action 24 Greece HD" ;;
# 227) Euronews Greek
227) 
method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://gr.euronews.com/live"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://gr.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_540p/' )
link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrelpri_gre_90p/' )

fi

#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsgr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Greek" ;;

################### TURKEY  ########################  
## 228) TRT Haber Turkey 
228) 
keyword="TRT"
if [ "$getlink" = 1 ]
then
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=624000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=124000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=822000,RESOLUTION=852x480,CODECS="avc1.66.30, mp4a.40.2"
link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_900_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=124000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_900_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1017000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_1500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=124000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_1500_av-b.m3u8?sd=10&rebase=on"

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 229) NTV Turkey
229) 
keyword="NTV"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="NTV Turkey";;
## 230) HaberTurk TV
230) 
keyword="Habertürk"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="HaberTurk TV";;
# 231) Star TV  Turkish
231)
keyword="Star"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Star TV Turkey";;
# 232) CNN Turk 
232) 
keyword="CNN TÜRK CANLI YAYINI"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="CNN Turk";;
# 233) KRT Kulture TV
233) 
keyword="KRT"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="KRT Kulture TV";;
# 234) La Legul TV
234) 
keyword="Lâlegül TV Canlı Yayın Akışı"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="La Legul TV";;
# 235) TGRT Haber TV
235) 
keyword="TGRT"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="TGRT Haber TV";;
# 236) TVNET Canali Yayin
236) 
keyword="TVNET Canlı Yayın"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 237) Show TV Turkey
237) 
keyword="Show"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="Show TV Turkey" ;;
# 238) Euronews Turkish
238) 
#method="Tor-Streamlink"
method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://tr.euronews.com/live"
radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://tr.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
link=$radix
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_90p/' )
fi
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsgr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Turkish" ;;

# 239) Top News Albania
239)
if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x6inuzo
fi
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
use_cookies="no"
chan_name="Top News Albania" ;;



####################################################
################## ARABIC  ##########################################
# 236) AMMAN TV Jordan***
# 236)
# link="https://livestream.com/alkawn/events/7612516"
# use_cookies="no"
# chan_name="AMMAN TV Jordan" ;;
# 241) RT Arabic 
241) 
keyword="RT"

if [ "$getlink" = 1 ]
then
link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-1k_v5.m3u8
#link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-2k_v5.m3u8
#link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-3k_v5.m3u8
#link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-4k_v5.m3u8
#link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-5k_v5.m3u8

### AUDIO
#link=https://rt-arab.secure.footprint.net/1104-inadv-qidx-0k_v5.m3u8

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
#link=https://secure-streams.akamaized.net/rt-arab/index.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/indexaudio.m3u8
fi

use_cookies="no"
chan_name="RT Arabic" ;;
# 242) France 24 Arabic
242) 
keyword="الأخبار "
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://static.france24.com/live/F24_AR_LO_HLS/live_web.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1095600,AVERAGE-BANDWIDTH=1095600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000,AUDIO="program_audio"
link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master_900.m3u8
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_1",AUTOSELECT=YES,DEFAULT=YES,URI="master_96.m3u8"
fi
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 243) BBC Arabic
243) 
keyword="BBC Arabic Live"
if [ "$getlink" = 1 ]
then
#link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_192_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_800_av-p.m3u8?sd=10&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="BBC Arabic" ;;
# 244)  DW Arabic
244) 
keyword="DW عربية مباشر"
if [ "$getlink" = 1 ]
then
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_a-b.m3u8?sd=10&rebase=on"

#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi

use_cookies="no"
chan_name="DW Arabic" ;;
# 245) CGTN Arabic
245)
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=http://livear.cgtn.com/1000a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=http://livear.cgtn.com/500a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://livear.cgtn.com/200a/prog_index.m3u8
fi
use_cookies="no"
chan_name="CGTN Arabic" ;;

####################################################################################
# 246) Al Jazeera Arabic Qatar QA
246) 
keyword="Live Stream"
if [ "$getlink" = 1 ]
then
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/appleman.m3u8
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/300.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/160.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/160audio.m3u8
#link=http://www.aljazeera.net/broadcastschedule
#link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 247) Al Jazeera Documentary Arabic QA
247) 
if [ "$getlink" = 1 ]
then
link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/1600kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/1200kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/800kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/600kStream.m3u8
fi
use_cookies="no"
chan_name="Al Jazeera Documentary Arabic " ;;  
# 248) Al Jazeera Mubasher QA
248)
if [ "$getlink" = 1 ]
then 
#link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/appleman.m3u8
link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/800.m3u8
#link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/600.m3u8
#link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/300.m3u8
#link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/160.m3u8
#link=http://aljazeera-mubasher-apple-live.adaptive.level3.net/apple/aljazeera/mubasher/160audio.m3u8
fi
use_cookies="no"
chan_name="Al Jazeera Mubasher QA " ;;  
############################## SAUDI TV   #########################################
# 249) Saudi Channel 1 Green KSA 1
249) 
keyword="القناة"
if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/saudi-arabian-tv-1
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/playlist.m3u8"
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/chunklist_b1800000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1800000,RESOLUTION=1920x1080,CLOSED-CAPTIONS=NONE
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/chunklist_b1800000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=1280x720,CLOSED-CAPTIONS=NONE
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/chunklist_b1400000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=900000,RESOLUTION=853x480,CLOSED-CAPTIONS=NONE
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/chunklist_b900000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=400000,RESOLUTION=426x240,CLOSED-CAPTIONS=NONE
#link="https://cllive.itworkscdn.net/ksa1live/token=nva=1545449470~dirs=1~hash=0d65a12846782e40eb34d/ksa1.smil/chunklist_b400000.m3u8"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="yes"
chan_name="Kingdom of Saudi Arabia Channel 1 Green" ;;
# 250) Saudi Broadcasting Corporation SBC SA
250)
if [ "$getlink" = 1 ]
then 
#link="https://cllive.itworkscdn.net/sbclive/token=nva=1545449478~dirs=1~hash=04f2dd0f578d2fa4c23fa/sbc.smil/playlist.m3u8"
link="https://cllive.itworkscdn.net/sbclive/token=nva=1545449478~dirs=1~hash=04f2dd0f578d2fa4c23fa/sbc.smil/chunklist_b2000000.m3u8"
#link="https://cllive.itworkscdn.net/sbclive/token=nva=1545449478~dirs=1~hash=04f2dd0f578d2fa4c23fa/sbc.smil/chunklist_b1400000.m3u8"
#link="https://cllive.itworkscdn.net/sbclive/token=nva=1545449478~dirs=1~hash=04f2dd0f578d2fa4c23fa/sbc.smil/chunklist_b860000.m3u8"
#link="https://cllive.itworkscdn.net/sbclive/token=nva=1545449478~dirs=1~hash=04f2dd0f578d2fa4c23fa/sbc.smil/chunklist_b585000.m3u8"
fi
keyword="بث مباشر"
use_cookies="no"
chan_name="Saudi Broadcasting SBC" ;;
# 251) Kingdom of Saudi Arabia Sports Channel KSA Sports
251) 
keyword="القنوات"
if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/saudi-arabian-tv-sports
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#"http://www.shashatcom.sa/assets/themes/TriTheme/libraries/bootstrap/css/bootstrap.min.css.mapno"
fi
use_cookies="no"

chan_name="Saudi Sports Channel 4 Red" ;;
# 252) Al Arabiya, Dubai, United Arab Emirates 
252) 
keyword="قناة"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Al Arabiya, Dubai, UAE " ;;
# 253) Al Mayadeen,  Beirut, Lebanon
253) 
keyword="Live"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="Al Mayadeen, Beirut, Lebanon" ;;  
# 254) Belqees TV Yemen Arabic
254)
keyword="قناة بلقيس "
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/12233888/events/3819374"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="Belqees TV Yemen Arabic" ;;
# 255) SKY Arabic, Abu Dhabi, UAE
255) 
keyword="البث المباشر"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="SKY Arabic, Abu Dhabi, UAE" ;;
# 256)Alghad TV Cairo Egypt
256)  
keyword="Alghad"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaJykDM6rs776xPgzVvLkzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="AlGhad, Cairo, Egypt" ;; 
# 257) eXtra News Egypt Arabic
257) 
keyword="Live Stream"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 258) CBC Egypt Sofra Arabic
258) 
keyword="Live"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 259) CBC Egypt Arabic Drama 
259) 
keyword="Live"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 260) DMC Live EG
260) 
keyword="dmc"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="DMC LIVE EG" ;;
# 261) Al-Fallujah Tv Channel IRAQ
261)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/4671269/falluajh"
#link=https://livestream.com/karbala-tv/events/7672592
fi
use_cookies="no"
chan_name="Al-Fallujah Tv Channel IRAQ" ;; 
# 262) AFAQ TV IRAQ
262) 
keyword="LIVE"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/afaqiraq/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="AFAQ TV IRAQ" ;; 
# 263) Karbarla Satellite Channel IRAQ
263)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/11436227/events/3998452"
#link="https://livestream.com/karbala-tv/events/3998452"
link="$( curl "https://livestream.com/karbala-tv/events/3998452"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Karbarla Satellite Channel IRAQ" ;;
# 264) Euronews Arabic
264) 
keyword="euronews"
method="Tor"

if [ "$getlink" = 1 ]
then
#link="http://tr.euronews.com/live"
radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://arabic.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
link=$radix
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_90p/' )
fi

#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Arabic" ;;  
# 265) ANB TV ANBSAT Assyrian National Broadcasting, San Jose California USA
265)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/933317/events/2295471"
link="$( curl "https://livestream.com/accounts/933317/events/2295471"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="ANB TV Assyrian National Broadcasting, San Jose California USA" ;;
# 266)Suryoyo Sat Södertälje, Sweden  Syrian Turoyo
266)
if [ "$getlink" = 1 ]
then
link="https://livestream.com/accounts/10187302/events/6785118"
link="$( curl "https://livestream.com/accounts/10187302/events/6785118"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Suryoyo Sat Södertälje, Sweden Syrian Turoyo " ;;
# 267) Safeer TV UK Islamic
267)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/karbala-tv/events/7672592"
link="$( curl "https://livestream.com/karbala-tv/events/7672592"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Safeer TV UK Islamic" ;;
################################## FARSI / PERSIAN  ###########################################################
# 268)  BBC Persian
268) 
keyword="پخش زنده"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
fi
use_cookies="no"
chan_name="BBC Persian";;
# 269)  Iran Aryaee San Bernadino California 
269)
#link="https://livestream.com/accounts/11825802/events/3752117"
link="$( curl "https://livestream.com/accounts/11825802/events/3752117"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Iran Aryaee San Bernadino California" ;;
# 270) DidgahNew TV Iranian 
270)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/27146356/events/8147101"
link="$( curl "https://livestream.com/accounts/27146356/events/8147101"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="DidgahNew TV Iranian" ;;
# 271) Aryen TV Iran Kurdish
271)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/22902829/events/7609059"
link="$( curl "https://livestream.com/accounts/22902829/events/7609059"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Aryen TV Iran Kurdish" ;;
# 272) PTN Pars TV USA Persian
272)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/5901056/events/4455330"
link="$( curl "https://livestream.com/accounts/5901056/events/4455330"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="PTN Pars TV USA Persian" ;;
# 273)Euronews Farsi (Persian)
273) 
keyword="euronews"
#method="Tor-Streamlink"
method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://fa.euronews.com/live"
radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://fa.euronews.com/live"| cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
link=$radix
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_90p/' )

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  

fi
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
use_cookies="no"
#method="Tor"
chan_name="Euronews Farsi Persian" ;;  
################# AFGHANISTAN ######################################
# 274) Ariana TV Afghanistan
274) 
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/9180830/events/6727975"
link="$( curl "https://livestream.com/accounts/9180830/events/6727975"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Ariana TV Afghanistan" ;;
## 275) TOLO NEWS AFGHANISTAN
275) 
keyword="Live"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";;

# 276)
# 277)
# 278)
# 279)
# 280)
 
###########################################################  PAGE 2  ###############################################################

##################### PAKISTAN  ############################
# 281)Aaj News PK
281) 
keyword="Live"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdHy-hnyIEZBHkPJecz9RtA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
fi
use_cookies="no"
chan_name="Aaj News PK" ;;  
# 282)Din News PK
282) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKh7t3sgs671fSeqsXjlN0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.dailymotion.com/video/x5ubgo9 
use_cookies="no"
chan_name="Din News PK" ;; 
# 283) Minhaj TV Pakistan 
283)
link="https://livestream.com/accounts/547271/MinhajTV"
use_cookies="no"
chan_name="Minhaj TV Pakistan" ;;
# 284) TV Arcana Barkat TV PK
284)
link="https://livestream.com/accounts/25119151/events/7597894"
use_cookies="no"
chan_name="TV Arcana Barkat TV" ;;
# 285) Geo News PK
285) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/geonews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Geo News PK" ;;   
# 286) SAMAA TV Pakistan
286) 
keyword="SAMAA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV Pakistan" ;;    

###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 287) Shaski India
287) 
keyword="Sakshi"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 288) SunNews 
288) 
keyword="SUN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 289) TV9 India Live
289) 
keyword="TV9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV9 Live India";;    
# 290) Rajya Sabha TV
290) 
keyword="Rajya"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 291) TV9 Gujarat
291) 
keyword="Tv9 Gujarati LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 292) News 7 Tamil
292) 
keyword="Tamil"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 293) News 18 India
293) 
keyword="News18 India Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 18 India" ;;
# 294) Aaj Tak 
294) 
keyword="Aaj"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;; 
# 295) NTV Telugu
295) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 296) ABN Telugu
296) 
keyword="ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 297) Vanitha TV 
297) 
keyword="Vanitha TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 298) HMT Telugu
298) 
keyword="HMTV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 3 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 299) India TV IN
299)    
#link=http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237//master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=244000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=244000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=576000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=576000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_1_av-b.m3u8?sd=10&rebase=on"
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IndiaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="India TV IN" ;; 
# 300) Suvarna News
300)
keyword="SUVARNA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Suvarna News" ;;     
# 301)i News Telugu
301) 
keyword="iNews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="iNews Telugu" ;; 
# 302) Puthiyah Thalimurai Tamil Live News
302) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Puthiyah Thalimurai Tamil Live News";;
## 303) DD News
303) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
# 304) REPORTER LIVE
304) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 305) AsiaNet News
305) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 306)V6 News
306) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="V6 News" ;;
# 307) Aaj Tak TV IN
307) 
keyword="Aaj Tak"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aaj Tak TV IN" ;;  
# 308) ETV Andhra Pradesh
308) 
keyword="ETV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 309) News 18 Tamilnadu
309) 
keyword="News18"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 310) Jaya Plus
310) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) "  
use8_cookies="no"
chan_name="Jaya Plus" ;;
# 311) TEZ TV
311) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;
# 312) Dilli Aaj Tak
312) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 313) Sagarmatha Nepal
313) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sagarmathatvnepal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Sagramatha Nepal" ;;  
# 314) Derana Sri Lanka  
314)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvderanavideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Derana Sri Lanka" ;;  
# 315) Swarnavahini Sri Lanka 
315)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCAH7R88V7gz7RqJv78nNOzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Swarnavahini Sri Lanka " ;;  
# 316) Kalaignar News
316) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar News" ;;

# 317)
# 318)
# 319)
# 320)

################### BROKEN / Offline
# Media One News
# 185)
# keyword="Live"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="Media One";;
### 188)  Desi TV
# 188)  
# link=http://www.dailymotion.com/video/x5lt6jg
# use_cookies="no"
# chan_name="Desi TV" ;; 
# 185) Pilupu TV Telugu America
# 185) 
#link=http://www.dailymotion.com/video/x60vptw
#use_cookies="no"
#chan_name="Pilupu TV Telugu America" ;; 
################## ASIA ######################################################################
################ CHINESE MANDARIN CANTONESE  ####################
# 321) CCTV 4 Chinese
321) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;
############## TAIWAN TAIWANESE ##############################
# 322) EBC 51 News Taiwan
322) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 323) EBC Finance Taiwan
323) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
# 324) TTV News Taiwan  
324) 
keyword="TTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 325) CTV Taiwan 
325) 
keyword="中視新聞台 LIVE直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 326) FTV Taiwan
326) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 327) CTS World News HD Taiwan
327) 
keyword="國會頻道１ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 328) SET News Taiwan
328) 
keyword="SET"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 329) CTI Taiwan 
329) 
keyword="CTI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;
# 330) SET iNEWS Taiwan
330) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setmoney159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SET iNEWS Taiwan" ;; 
# 331) Formosa News HD Taiwan
331) 
keyword="Formosa"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Formosa News HD Taiwan";;
#  332) TzuChi DaAi World Taiwan 
332) 
keyword="DaAi World HD"
link=https://www.dailymotion.com/video/x5crdro
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 333) 大愛電視 Tzu Chi DaAiVideo 
333) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 334) 大愛一臺HD Live 直播
334)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;;  
# 335) TLTV
335) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 336) Sinda Television
336) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 337) Cheng Sin TV
337) 
keyword="誠心衛星電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 338) CTS World News HD 2 Taiwan
338) 
keyword="國會頻道２ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD 2" ;;
# 339) SJTV TW
339) 
keyword="SJTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SJTVonline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SJTV TW";;
# 340) 119 Live 電視台大立  Da Li Taiwan  
340)
keyword="119"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Da Li Taiwan" ;;
# 341) SDTV 04CH Taiwan  
341)
keyword="04CH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCBWzi-vMywDa05QYA2jHxwQ/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SDTV 04CH TW" ;;
# 342) Fanstelevision Taiwan  
342)
keyword="番薯衛星電視台現場直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2UCHUxTWVkSqP6MILU5Bqw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Fans TV TW" ;;
# 343) Hong Kong TV
343)
link=rtmp://live.hkstv.hk.lxdns.com/live/hks
use_cookies="no"
chan_name="Hong Kong TV" ;;
# 344) GETV Chinese California USA
344)
#link="https://livestream.com/accounts/23191280/events/8122971"
link="$( curl "https://livestream.com/accounts/23191280/events/8122971"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="GETV Chinese California USA" ;;
# 345) Arirang TV Korea English
345) 
keyword="Arirang" 
#link=http://www.filmon.com/tv/arirang-tv
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#BANDWIDTH=1728000,RESOLUTION=1280x720
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1728000_sleng.m3u8
#BANDWIDTH=1328000,RESOLUTION=960x540
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1328000_sleng.m3u8
#BANDWIDTH=928000,RESOLUTION=850x480
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b928000_sleng.m3u8
#BANDWIDTH=528000,RESOLUTION=640x360
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b528000_sleng.m3u8
#link=http://worldlive-ios.arirang.co.kr/arirang/arirangtvworldios.mp4.m3u8
#link=http://worldlive-ios.arirang.co.kr/cdnlive-hls/arirangwlive/_definst_/liveevent/tvworld2.m3u8
use_cookies="no"
chan_name="Arirang TV Korea" ;; 
# 346) TBS Live Korea  
346) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 347) YTN DMB Korea  
347) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 348) YTN Science Korea  
348) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnscience/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 349) Channel 23 Korea  
349) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 350) KBS World 24 Korea
350) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 351) YTN 27 Korea 
351)
keyword="YTN LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnnews24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN LIVE Korea" ;; 
# 352) CGNTV America Korean Los Angeles California 
352)
#link="https://livestream.com/accounts/13207573/cgntv"
link="$( curl "https://livestream.com/accounts/13207573/cgntv"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CGNTV America Korean Los Angeles California " ;;
# 353) YTV America Live Korean LA CA USA
353)
#link="https://livestream.com/accounts/15217951/events/4355473"
link="$( curl "https://livestream.com/accounts/15217951/events/4355473"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="YTV America Live Korean LA CA USA" ;;
# 354) Atlanta Radio Korea AM790
354)
#link="https://livestream.com/accounts/19465449/events/6357808"
link="$( curl "https://livestream.com/accounts/19465449/events/6357808"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Atlanta Radio Korea AM790" ;;
# 355) ANN JapaNews 24 Japan
355) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ANNnewsCH/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANN News 24 Japan" ;;
# 356) Sol!ve 24 Japan
356) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
# 357) KBS Live 24 Japan  
357) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
#  358) QVC JAPAN SHOPPING CHANNEL
358) 
keyword="QVC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;

# 359) BSC 24 1
359) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 360) BSC 24 2
360) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 

####################################### SOUTH ASIAN ####################################################################
################# TAGALOG FILIPINO #############################       
# 361) DZMM ABS-CBN Philippeans Radio
361) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 362) PTV Philippines
362)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ Indonesia  #########################################
# 363) Net TV Jakarta Indonesia
363) 
keyword="NET" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Net TV Jakarta Indonesia" ;;
# 364) Net TV LIVE Jakarta Indonesia
364) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Net TV Live Jakarta Indonesia" ;;
# 365) Net TV First Comedy Jakarta Indonesia
365) 
keyword="COMEDY" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Net TV First Comedy Jakarta Indonesia" ;;
##################### Myanmar #########################################
# 366) skynet Buddha Myanmar
366)
#link="https://livestream.com/accounts/7228455/events/3875181"
link="$( curl "https://livestream.com/accounts/7228455/events/3875181"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Buddha Myanmar MM" ;;
############### Viet Nam  #####################################
# 367) VietTV VN
367)
link=http://www.filmon.com/tv/vtc-10
use_cookies="yes"
chan_name="VietTV VN" ;;
# 368) Viet Sky TV Anaheim California
368)
#link="https://livestream.com/accounts/27136431/events/8142772"
link="$( curl "https://livestream.com/accounts/27136431/events/8142772"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Viet Sky TV Anaheim California" ;;
# 369) ABHPTV Daily Broadcast Vietnamese  An Bình Hạnh Phúc
369)
#link="https://livestream.com/accounts/13311218/events/7250967"
link="$( curl "https://livestream.com/accounts/13311218/events/7250967"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ABHPTV Daily Broadcast An Bình Hạnh Phúc Vietnamese " ;;
#####################################
# 370) Earthquake 24  
370) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 371) Arirang News 
371) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang News TV" ;; 
# 372) Arirang Culture TV Korean 
372) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangkorean/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang Culture TV Korean" ;; 
# 373) OnTV Hong Kong
373) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 374)
# 375)
# 376)
# 377)
#########################################   AFRICA    ##############################################
# 378) Africa News Live
378)
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 379) Africa24 Francaise
379) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24 Francais" ;; 
# 380) SIKKA TV Afrique Francaise
380) 
keyword="SIKKA TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SIKKA TV Afrique Francais" ;; 
# 381) Channels 24 Nigeria NG
381) 
keyword="Channels Television"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
#link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria NG";;
# 382)TVC News Nigeria NG
382) 
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria NG";;
# 383) NTV Uganda UG
383) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda UG" ;; 
# 384) SPARK TV Uganda UG
384)
keyword="Spark TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SPARK TV Uganda UG" ;;  
# 385)  KTN Kenya KE
385) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya KE" ;; 
# 386) EbruTV Kenya KE
386)
link=http://www.dailymotion.com/video/x67n3k1
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
format=hls-240
chan_name="EbruTV Kenya KE" ;;
# 387)KTN Home Kenya KE
387)
link=http://www.dailymotion.com/video/x67ck0p
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="KTN Home Kenya KE" ;;
# 388) Joy News Ghana GH
388) 
keyword="Joy News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana GH";;
# 389)  ADOM TV GH
389) 
keyword="Adom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV Ghana GH" ;;    
# 390) Bukedde TV GH
390) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bukedde TV GH";;
# 391) EBC Ethiopia 
391) 
keyword="\#EBC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="EBC Ethiopia";;
# 392) Walf TV Senegal 
392)  
link=http://www.dailymotion.com/video/x5s5vw3
use_cookies="no"
chan_name="Walf TV Senegal" ;; 
# 393) EriTV Eritrea ET
393)
link=http://www.filmon.com/tv/eri-tv
use_cookies="yes"
chan_name="EriTV Eritrea ET" ;;  
# 394)SABC Digital News South Africa ZA
394) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa ZA" ;;  
# 395)Afro World View South Africa ZA
395) 
keyword="Afro"
#link="http://196.33.130.34:1935/live-ann7/ann7.smil/playlist.m3u8"
#link=rtmp://196.33.130.34/live-ann7/ann7-mid.stream
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=550000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b550000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=250000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=480x270
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b250000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1300000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=1280x720
#link=http://196.33.130.34:1935/live-ann7/ann7.smil/chunklist-b1300000.m3u8
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/playlist.m3u8
#link=rtmp://46.4.25.213/live-ann7/ann7-mid.stream
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Afro Worldview ZA" ;; 
# 396) iTV Networks South Africa ZA
396)
link="https://livestream.com/accounts/7079896/events/4406003"
#link="$( curl "https://livestream.com/accounts/7079896/events/4406003"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="iTV Networks South Africa ZA" ;;
# 397) Parliament of the Republic of South Africa ZA
397) 
keyword="Plenary"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ParliamentofRSA/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Parliament of the Republic of South Africa ZA" ;; 
# 398) D24
398)
link=https://www.dailymotion.com/video/x6cq41k
use_cookies="no"
chan_name="D24" ;;  
# 399) Afrique Media
399)
link=https://www.dailymotion.com/video/x5dk3kj
use_cookies="no"
chan_name="Afrique Media" ;;  
# 400) DBM TV
400)
link=https://www.dailymotion.com/video/x5qokx5
use_cookies="no"
chan_name="DBM TV" ;;  




##################################### LOCAL NEWS USA #################################################################### 
# 401) RSBN Auburn Alabama USA
401) 
keyword="RSBN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA"  ;;
############################ LOCAL NEWS USA############################################# 
# 402) Seminole TV Florida
402) 
link=http://video.seminolecountyfl.gov:1935/live/SGTV/chunklist.m3u8
use_cookies="no"
chan_name="Seminole TV (Florida)" ;;

############################  TRANSIENT BROADCAST NEWS #############################################
# 403) WVIT 30 News Hartford
403) 
link=http://wvitlive-f.akamaihd.net/i/wvitb2_1@71164/master.m3u8
use_cookies="no"
chan_name="WVIT 30 News Hartford" ;;
# 404) NBC 11 Bay Area
404) 
link=http://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/index_1286_av-p.m3u8
use_cookies="no"
chan_name="NBC 11 Bay Area" ;;
# 405) WXXV25 24/7 Mississippi
405)
link=http://api.new.livestream.com/accounts/22998687/events/6864865/live.m3u8
use_cookies="no"
chan_name="WXXV25 24/7 Mississippi" ;; 
# 406) NBC2 South West Florida
406)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NBC2swfl/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="NBC2 South West Florida" ;;  
# 407) WCCB Charlotte, South Carolina
407)
link=http://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB Charlotte, South Carolina" ;;

########################### NEWS FEEDS #########################################
# 408) WSJ Live
408)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 409)  CTV NEWS Canada
409)
#CTV NEWS HD
link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News17.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News16.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
##link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News14.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News13.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News12.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News11.m3u8
use_cookies="no"
####method="Tor"
chan_name="CTV News Canada" ;;
##################### CNN ##########################
# 410) CNN Event 1
410)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 1" ;;
# 411) CNN Event 2
411)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 2" ;;
# 412) CNN Event 3
412)
link=http://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 3" ;;
# 413) NBC News Live Event
413)
#link=https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x234,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x234,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2595000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2595000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/index_2500_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="NBC News Live Event" ;; 

# 414) Buffalo TV
414)
#link=http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=607551,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=491x360
link="http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/chunklist_w1047718971.m3u8"
use_cookies="no"
chan_name="Buffalo TV" ;;

# 415) Beach TV - Panama City
415)
#link=http://media4.tripsmarter.com:1935/LiveTV/BTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3361387,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/BTVHD/chunklist_w1613239205.m3u8"
use_cookies="no"
chan_name="Beach TV - Panama City" ;; 
# 416) Beach TV - Pawleys Island
416)
#link=http://media4.tripsmarter.com:1935/LiveTV/MTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3363641,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/MTVHD/chunklist_w1433596674.m3u8"
use_cookies="no"
chan_name="Beach TV - Pawleys Island" ;;

# 417)What America Thinks
417) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 418) Bloomberg Europe
418)
#link=https://www.bloomberg.com/live/europe
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_live.m3u8
#link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/master.m3u8
#link=http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 419) Bloomberg Asia
419)
#link=https://www.bloomberg.com/live/asia
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_live.m3u8
use_cookies="no"
chan_name="Bloomberg Asia" ;;
# 420) HSN
420) 
keyword="HSN Live"
#link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 421) HSN 2
421) 
keyword="HSN2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 422)Bloomberg Australia
422)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/aus_live.m3u8
use_cookies="no"
chan_name="Bloomberg Australia" ;;
#################### TRANSIENT ######################################## 
# 423) Bloomberg US Politics
423)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_politics.m3u8
use_cookies="no"
chan_name="Bloomberg US Politics" ;;
# 424) Bloomberg Live Event
424)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_event.m3u8
use_cookies="no"
chan_name="Bloomberg US Live Event" ;;
# 425) Bloomberg EU Live Event
425)
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_event.m3u8
use_cookies="no"
chan_name="Bloomberg EU Live Event" ;;
# 426) Bloomberg Asia Live Event
426)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_event.m3u8
use_cookies="no"
chan_name="Bloomberg Asia Live Event" ;;
######################## PODCAST ###########################################
# 427) PBS NewsHour Video
427) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 428)  CBC The National
428) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 429) AP Top Stories
429) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 430) Democracy Now Headlines 
430) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;   

########################### INFOWARS EXTRAS #######################################################
# 431)Infowars RealNews
431)
#link=https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=955000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=125000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/index_800_a-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Infowars RealNews" ;;
# 432)Infowars WarRoom 
432)
#link=https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=955000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=125000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_a-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Infowars WarRoom " ;;
# 433)Infowars Podcast
433)
keyword="Infowars"
#link=http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=928000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=128000,CODECS="mp4a.40.2"
#link="http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/index_800_a-b.m3u8?sd=10&rebase=on"

#link=http://www.infowars.com/show
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUJNY4nfdomMppNDZNZc4nA/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
####method="Tor"
use_cookies="no"
chan_name="Infowars Podcast" ;; 
#####################################################################################################

# 440)

################### Entertainment #############################
# 441) Music Choice Play HD
441)
#link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/playlist.m3u8
link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/chunklist.m3u8
use_cookies="no"
chan_name="Music Choice Play HD" ;;
# 442)M2O Music
442) 
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=48000,CODECS="mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_48_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=48000,CODECS="mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_48_a-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_110_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_110_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=240000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=240000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=440000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=440000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=640000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=640000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_600_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="M2O Music" ;;
# 443) Radio Monte Carlo RMC
443)
#link=http://wow01.105.net/live/rmc1/playlist.m3u8  
#EXT-X-STREAM-INF:BANDWIDTH=1009334,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=720x432
link=http://wow01.105.net/live/rmc1/chunklist_w1187407711.m3u8
#link=rtmp://fms.105.net:1935/live/rmc1
use_cookies="no"
chan_name="Radio Monte Carlo" ;; 
# 444) Virgin Radio
444) 
#link=http://wow01.105.net/live/virgin1/playlist.m3u8  
#EXT-X-STREAM-INF:BANDWIDTH=1026811,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=720x432
link=http://wow01.105.net/live/virgin1/chunklist_w1964894926.m3u8
# link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Radio" ;;
# 445) H!T Music Channel
445)
link=http://1mstream.digicable.hu/hitmusic/hitmusic.m3u8
use_cookies="no"
chan_name="H!T Music Channel" ;;
# 446) Now Music TV
446)
#link="http://live.aatw.simplestreamcdn.com/now/live.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2500000,RESOLUTION=1024x576,CODECS="avc1.4d401f,mp4a.40.2"
#link="http://live.aatw.simplestreamcdn.com/now/5/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=1024x576,CODECS="avc1.4d401f,mp4a.40.2"
#link="http://live.aatw.simplestreamcdn.com/now/1/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=1024x576,CODECS="avc1.4d401f,mp4a.40.2"
#link="http://live.aatw.simplestreamcdn.com/now/2/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1200000,RESOLUTION=1024x576,CODECS="avc1.4d401f,mp4a.40.2"
link="http://live.aatw.simplestreamcdn.com/now/3/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1800000,RESOLUTION=1024x576,CODECS="avc1.4d401f,mp4a.40.2"
#link="http://live.aatw.simplestreamcdn.com/now/4/prog_index.m3u8"
use_cookies="no"
chan_name="Now Music TV" ;;
# 447) California Music Channel
447)
link=http://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMCUSA/CCURstream0.m3u8
use_cookies="no"
chan_name="California Music Channel" ;;
# 448) NRJ Hits Francais
448)
link=http://5.196.138.6:1935/live/nrjbelgique/chunklist_w1339281553.m3u8   
use_cookies="no"
chan_name="NRJ Hits Francais" ;;
# 449) Rockland Radio TV
449)
#link="https://livestream.com/accounts/22300522/events/6680139"
link="$( curl "https://livestream.com/accounts/22300522/events/6680139"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Rockland Radio TV" ;;
#################### REALITY / LIVE ACTION #########################
#  450) Adult Swim 
450) 
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=334400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=416x234
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer0.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=554400,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=416x234
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=884400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=640x360
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1445400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=640x360
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2050400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=852x480
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer4.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2820400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer5.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3920400,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer6.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5570400,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer7.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=140800,CODECS="mp4a.40.2"
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer8.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
################################################################################
##################### ANIMATION ############################## 
# 451) PJ Masks
451) 
keyword="PJ" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCY2jUnU118sVkdj2xafiJ0g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PJ Masks" ;;
# 452) Talking Tom and Friends
452) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 453) Talking Tom and Friends Minis
453) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;
############################# FASHION ##########################################################    
# 454) Fashion TV Europe
454)  
link=http://www.dailymotion.com/video/x3m6nld
use_cookies="no"
chan_name="Fashion TV Europe" ;; 
# 455) Fashion 1 Spain
455) 
link=http://www.dailymotion.com/video/x2t9nsf
use_cookies="no"
chan_name="Fashion 1 Spain" ;; 
# 456) Jasmin TV
456) 
#link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8 
link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/chunklist_w1121252134.m3u8
use_cookies="no"
chan_name="Jasmin TV" ;;  
# 457) The Young Turks
457)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
#############################################################
###############################   SPORTS   ######################################################
# 458) MLB Network
458)
#link=http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/master_wired.m3u8
link="http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/$( curl -A "$UA" "http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/master_wired.m3u8" | grep 2400 | tail -n 1 )"
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/1200K/1200_slide.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1800000
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/1800K/1800_slide.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2400000
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/2400K/2400_slide.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3000000
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/3000K/3000_slide.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=500000
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/500K/500_slide.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000
#MLB_VIDEO_MLBN_FAUX_LINEAR_STREAM_1_MLBN_Linear_Stream_Tuesday_20180605_1528215796537/800K/800_slide.m3u8
use_cookies="no"
chan_name="MLB Network" ;;
# 459) NFL Now Live
459)
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW.m3u8 
#EXT-X-STREAM-INF:BANDWIDTH=233200,AVERAGE-BANDWIDTH=233200,CODECS="avc1.66.30,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_200k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=510400,AVERAGE-BANDWIDTH=510400,CODECS="avc1.66.30,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_464k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=730400,AVERAGE-BANDWIDTH=730400,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_664k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1060400,AVERAGE-BANDWIDTH=1060400,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_964k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2305600,AVERAGE-BANDWIDTH=2305600,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_2000k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1390400,AVERAGE-BANDWIDTH=1390400,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_1200k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3405600,AVERAGE-BANDWIDTH=3405600,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_3000k.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5055600,AVERAGE-BANDWIDTH=5055600,CODECS="avc1.4d401f,mp4a.40.2",FRAME-RATE=29.970
#link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW_4500k.m3u8
use_cookies="no"
chan_name="NFL Now Live" ;; 
# 460) RED BULL TV 
460)
#link=https://dms.redbull.tv/v3/linear-borb/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6InBlcnNvbmFsX2NvbXB1dGVyIiwiY291bnRyeV9jb2RlIjoidXMiLCJleHBpcmVzIjoiMjAxNy0wOS0xNlQxNzo0NjowMy45NjM0NjI4NDJaIiwib3NfZmFtaWx5IjoiaHR0cCIsInJlbW90ZV9pcCI6IjEwLjE1Ny4xMTIuMTQ4IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xMl81KSBBcHBsZVdlYktpdC82MDMuMi40IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xMC4xLjEgU2FmYXJpLzYwMy4yLjQiLCJ1aWQiOiJkOGZiZWYzMC0yZDhhLTQwYTUtOGNjNy0wNzgxNGJhMTliNzMifQ.Q_38FNpW3so5yrA5FQt9qBuix3dTulKpb6uQ0dRjrtY/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=290400,AVERAGE-BANDWIDTH=290400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
#link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_264.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=635800,AVERAGE-BANDWIDTH=635800,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=426x240,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
#link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_578.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1020800,AVERAGE-BANDWIDTH=1020800,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
#link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_928.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1826000,AVERAGE-BANDWIDTH=1826000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=960x540,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_1660.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3696000,AVERAGE-BANDWIDTH=3696000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
#link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_3360.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=7326000,AVERAGE-BANDWIDTH=7326000,CODECS="avc1.4d4028,mp4a.40.2",RESOLUTION=1920x1080,FRAME-RATE=30.000,CLOSED-CAPTIONS=NONE
#link=https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_6660.m3u8
use_cookies="no"
chan_name="RED BULL TV" ;; 
# 461) STADIUM
461)
link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/master/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/hls/live/522512/mux_4/master.m3u8  
#EXT-X-STREAM-INF:CODECS="avc1.42c015,mp4a.40.2",AVERAGE-BANDWIDTH=840400,RESOLUTION=512x288,FRAME-RATE=29.97,BANDWIDTH=840400
#link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/manifest/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/2109ca5f-73d7-4976-983f-3a8672da3994/0.m3u8
#EXT-X-STREAM-INF:CODECS="avc1.77.30,mp4a.40.2",AVERAGE-BANDWIDTH=1240800,RESOLUTION=640x360,FRAME-RATE=29.97,BANDWIDTH=1240800
#link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/manifest/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/2109ca5f-73d7-4976-983f-3a8672da3994/1.m3u8
#EXT-X-STREAM-INF:CODECS="avc1.4d401f,mp4a.40.2",AVERAGE-BANDWIDTH=1790800,RESOLUTION=896x504,FRAME-RATE=29.97,BANDWIDTH=1790800
link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/manifest/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/2109ca5f-73d7-4976-983f-3a8672da3994/2.m3u8
#EXT-X-STREAM-INF:CODECS="avc1.4d401f,mp4a.40.2",AVERAGE-BANDWIDTH=2340800,RESOLUTION=960x540,FRAME-RATE=29.97,BANDWIDTH=2340800
#link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/manifest/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/2109ca5f-73d7-4976-983f-3a8672da3994/3.m3u8
#EXT-X-STREAM-INF:CODECS="avc1.64001f,mp4a.40.2",AVERAGE-BANDWIDTH=3440800,RESOLUTION=1280x720,FRAME-RATE=29.97,BANDWIDTH=3440800
#link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/manifest/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/2109ca5f-73d7-4976-983f-3a8672da3994/4.m3u8
use_cookies="no"
chan_name="STADIUM" ;; 
######################### TWITCH  ##############################################
# 462) All Key shop
462)
link=https://www.twitch.tv/allkeyshop_tv
use_cookies="no"
####method="Tor"
chan_name="All Key Shop";;
# 463) Sorgatronmedia
463)
link=https://www.twitch.tv/sorgatronmedia
use_cookies="no"
####method="Tor"
chan_name="Sorgatronmedia";;
# 464) Amouranth
464)
link=https://www.twitch.tv/amouranth
use_cookies="no"
####method="Tor"
chan_name="Amouranth";;
# 465) Geek and Sundry
465)
link=https://www.twitch.tv/geekandsundry
use_cookies="no"
####method="Tor"
chan_name="Geek and Sundry";;
# 466) Buzzr Game Shows
466)
link=https://www.twitch.tv/buzzr
#####method="Tor"
use_cookies="no"
chan_name="Buzzr (Game Shows)";;
# 467) RTE 1
467)
link=http://akamai.rasset.ie/hls-live/_definst_/rte1/rte1-720.m3u8
#link=http://akamai.rasset.ie/hls-live/_definst_/rte1/rte1-576.m3u8
#####method="Tor"
use_cookies="no"
chan_name="RTE 1 IE";;
# 468) RTE 2
468)
link=http://akamai.rasset.ie/hls-live/_definst_/rte2/rte2-720.m3u8
#link=http://akamai.rasset.ie/hls-live/_definst_/rte2/rte2-576.m3u8
#####method="Tor"
use_cookies="no"
chan_name="RTE 2 IE";;
# 469) RTE Jr
469)
link=https://cdn.rasset.ie/hls-live/_definst_/rtejr/rtejr-720.m3u8
#link=https://cdn.rasset.ie/hls-live/_definst_/rtejr/rtejr-576.m3u8
#####method="Tor"
use_cookies="no"
chan_name="RTE Jr. IE";;
# 470) T4G Ireland
470)
link=http://csm-e.cds1.yospace.com/csm/live/74246610.m3u8
#####method="Tor"
use_cookies="no"
chan_name="T4G IE";;

############################### USTREAM  ##################################################
# 471) NASA TV Media
471) 
keyword="Media"
#link="https://nasa-i.akamaihd.net/hls/live/253565/NASA-NTV1-Public/master.m3u8"
link="https://nasa-i.akamaihd.net/hls/live/253565/NASA-NTV1-Public/master_2000.m3u8"
#link=http://www.ustream.tv/channel/nasa-media-channel
# method="Streamlink"
#format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 472) NASA TV Public Education
472) 
keyword="NASA TV Public-Education"
#link=http://www.ustream.tv/nasahdtv
#link="https://nasa-i.akamaihd.net/hls/live/253566/NASA-NTV2-Media/master.m3u8"
link="https://nasa-i.akamaihd.net/hls/live/253566/NASA-NTV2-Media/master_2000.m3u8"
#method="Streamlink"
#format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Public-Education" ;; 
##################################################

# 473)ROBOT CHICKEN
473)
link=https://adultswim-vodlive.cdn.turner.com/live/robot-chicken/stream.m3u8
#####method="Tor"
use_cookies="no"
chan_name="ROBOT CHICKEN";;

# 474)RETRO TV
474)
link=http://247retrotv.com:1935/live/smil:247retro.smil/playlist.m3u8
#####method="Tor"
use_cookies="no"
chan_name="Retro TV";;






########################  RELIGIOUS PROGRAMMING   ############################
# 481) Vatican Media 
481) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vatican/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vatican Media" ;;
# 482) EWTN English
482) 
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283781001
use_cookies="no"
chan_name="EWTN America" ;;
# 483) EWTN Ireland 
483) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409261120001
use_cookies="no"
chan_name="EWTN Ireland" ;;
# 484) EWTN Africa
484) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 485) EWTN Asia
485) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;
# 486) Salt and Light Television Canada
486)
link="https://livestream.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/tracks-v1a1/index.m3u8"
#link="https://livestream.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/index.m3u8"
#EXT-X-STREAM-INF:CLOSED-CAPTIONS=NONE,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.64001f,mp4a.40.2",AVERAGE-BANDWIDTH=1712766,BANDWIDTH=2140957
#link="https://livestream.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/tracks-v1a1/tracks-v1a1/mono.m3u8"
use_cookies="no"
chan_name="Salt and Light Television Canada" ;;
# 487)Catholic TV (USA) 
487) 
#link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/master.m3u8
# link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/index_1_av-p.m3u8 
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=645000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=646000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2496000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2496000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://catholictvhd-lh.akamaihd.net/i/ctvhd_1@88148/index_1_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Catholic TV (USA)" ;;
# 488) CTND Catholic Television Network Detroit  
488)
#link="https://livestream.com/accounts/19963560/events/5721749"
link="$( curl "https://livestream.com/accounts/19963560/events/5721749"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CTND Catholic Television Network Detroit" ;;
# 489) Shalom Media Catholic USA 
489)
#link="https://livestream.com/shalomworld/events/7359508"
link="$( curl "https://livestream.com/shalomworld/events/7359508"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic USA" ;;
# 490) Shalom Media Catholic Australia
490)
#link="https://livestream.com/shalomworld/events/7551704"
link="$( curl "https://livestream.com/shalomworld/events/7551704"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic Auastralia" ;;
# 491) Shalom Media Catholic Europe
491)
#link="https://livestream.com/accounts/25038049/events/7358643"
link="$( curl "https://livestream.com/accounts/25038049/events/7358643"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic Europe" ;;
# 492) EWTN Spanish 
492) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;; 
# 493)  EWTN German
493) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 494) KtO Catholique
494)
#link=http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x178,CODECS="avc1.66.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x178,CODECS="avc1.66.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_1200_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="KtO Catholique" ;;
# 495) CBN
495)
#link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2064000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_2000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2064000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/index_2000_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="CBN" ;;
# 496)CBN News
496)
#link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_150_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_150_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_900_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_900_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="CBN News" ;;
# 497)NRB Network
497)
#link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/chunklist_w1520783238.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 498) The Church Channel
498)
#link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="The Church Channel" ;;
# 499) TBN
499)
#link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=848x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=848x480,CODECS="avc1.66.30, mp4a.40.2"
link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_2528_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_2528_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/index_282_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="TBN" ;;
# 500)GOD TV (USA) 
500) 
#link=http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=313000,RESOLUTION=320x180,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=313000,RESOLUTION=320x180,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=563000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=563000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1227000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1227000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1856000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1856000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2656000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_2528_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2656000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_2528_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3456000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_3200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3456000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_3200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/index_282_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="GOD TV (USA)" ;;
# 501) Amazing Facts TV (Christian)
501) 
keyword="AFTV"
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/master.m3u8
link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1134820847.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 502) It's Supernatural! Network (Christian)
502) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 503) Shepherd's Chapel, Gravette Arkansas  
503) 
keyword="Chapel"
#link="https://livestream.com/accounts/14403440/events/4227022"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Shepherd's Chapel, Gravette Arkansas" ;;
# 504) International House of Prayer (IHOP) (Christian)
504) 
keyword="Live"
#link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/master.m3u8
#link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_1000_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_2500_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
#link="https://ihoplive-f.akamaihd.net/i/ihopkc_tprhd@142185/index_4001_av-p.m3u8?sd=6&set-segment-duration=quality&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 505) Belivers Voice of Victory Network
505) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 506) Three Angels BroadCasting
506) 
keyword="Three Angels"
#link=http://moiptvus-lh.akamaihd.net:80/i/3abnlive_1@328342/index_800_av-p.m3u8 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels Broadcasting Network" ;; 
# 507) 3ABN Latino
507)  
keyword="3ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3abnlatino/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="3ABN Latino" ;; 
# 508) 3ABN Francais
508)  
link="http://aos01.3abn.adaptive.level3.net/hls-live/mediaoppremux-fre_multi/_definst_/live/stream3.m3u8"
use_cookies="no"
chan_name="3ABN Francais" ;;   
# 509) LLBN TV
509) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 510) Hillsong Channel
510)
#link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_282_a-b.m3u8?sd=10&rebase=on"

use_cookies="no"
chan_name="Hillsong Channel" ;;
# 511) JUCE TV
511)
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=275000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=275000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=550000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=550000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1136000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1136000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1687000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1687000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=31000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=31000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_282_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="JUCE TV" ;;
# 512) Salt and Light TV Portage Michigan
512) 
keyword="Salt"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 513) Harbor Light Radio
513) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 514) St. Marys Coptic
514) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 515) Word of God Greek
515) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 516) Shalom Media Catholic America 
516)
#link="https://livestream.com/shalomworld/events/7511845"
link="$( curl "https://livestream.com/shalomworld/events/7511845"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic America"  ;;
# 517) Shalom Media Catholic India
517)
#link="https://livestream.com/shalomworld/events/7483919"
link="$( curl "https://livestream.com/shalomworld/events/7483919" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic India" ;;
# 518) Powervision TV
518) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 519)
# 520)
###################  MIXER    ###################
# 521) Vatican Media English
521) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxIsefyl9g9A5SGWA4FvGIA/videos" |  grep "$keyword" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Vatican Media English" ;;
# 522)Enjoy St.Moritz CH Switzerland
522)
#link="https://livestream.com/accounts/2090099/events/7221364"
link="$( curl "https://livestream.com/accounts/2090099/events/7221364" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Enjoy St.Moritz CH Switzerland" ;;
# 523)Quran English Arabic
523) 
keyword="Quran Hidayah"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 524)TTB Network
524)
link=http://www.dailymotion.com/video/x14tgdi
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="TTB Network" ;;
# 525) Vatican Media Deutsch
525)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticande/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Deutsch" ;; 
# 526) Vatican Media Italiano
526)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Italiano" ;; 
# 527) Temple Institute
527) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
###########################################################
# 528) ABC News USA  1
528)
link="https://abclive1-lh.akamaihd.net/i/abc_live01@423395/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 1" ;;
# 529)ABC News USA 2
529)
link="https://abclive1-lh.akamaihd.net/i/abc_live02@423396/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 2" ;;
# 530)ABC News USA 3
530)
link="https://abclive1-lh.akamaihd.net/i/abc_live03@423397/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 3" ;;
# 531)ABC News USA 4
531)
link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 4" ;;
# 532)ABC News USA 5
532)
link="https://abclive1-lh.akamaihd.net/i/abc_live05@423399/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 5" ;;
# 533)ABC News USA 6
533)
link="https://abclive1-lh.akamaihd.net/i/abc_live06@423400/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 6" ;;
# 534)ABC News USA 7
534)
link="https://abclive1-lh.akamaihd.net/i/abc_live07@423401/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 7" ;;
# 535)ABC News USA 8
535)
link="https://abclive1-lh.akamaihd.net/i/abc_live08@423402/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 8" ;;
# 536)ABC News USA 9
536)
link="https://abclive1-lh.akamaihd.net/i/abc_live09@423403/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 9" ;;
# 537)ABC News USA 10
537)
link="https://abclive1-lh.akamaihd.net/i/abc_live10@420897/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 10" ;;
# 538)KY3 Springfield IL USA
538)
#link=https://livestream.com/accounts/4699618/live
link="$( curl "https://livestream.com/accounts/4699618/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KY3 Springfield IL USA" ;;
# 539) KNBC 4 News (Los Angeles)
539) 
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;

# 427)
#### ABC LIVE STREAMS
#link="https://abclive1-lh.akamaihd.net/i/abc_live01@423395/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live02@423396/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live03@423397/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live05@423399/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live06@423400/index_2500_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live07@423401/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live08@423402/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live09@423403/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive1-lh.akamaihd.net/i/abc_live10@420897/index_4000_av-p.m3u8?sd=10&rebase=on"
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_1200_av-p.m3u8?sd=10&rebase=on"
#https://abclive1-lh.akamaihd.net/i/abc_live10@420897/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 2
#https://abclive1-lh.akamaihd.net/i/abc_live02@423396/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 3
#https://abclive1-lh.akamaihd.net/i/abc_live03@423397/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 4
#https://abclive1-lh.akamaihd.net/i/abc_live04@423398/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 5
#https://abclive1-lh.akamaihd.net/i/abc_live05@423399/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 6
#https://abclive1-lh.akamaihd.net/i/abc_live06@423400/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 7
#https://abclive1-lh.akamaihd.net/i/abc_live07@423401/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 8
#https://abclive1-lh.akamaihd.net/i/abc_live08@423402/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 9
#https://abclive1-lh.akamaihd.net/i/abc_live09@420891/master.m3u8
#EXTINF:0, tvg-logo="" group-title="",ABC News Digital 11
#https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8
####PREVIEW STREAMS
#link="https://abclive1-lh.akamaihd.net/i/abc_preview02@425077/master.m3u8"
#link="https://abclive1-lh.akamaihd.net/i/abc_preview06@425081/index_100_av-p.m3u8?sd=10&rebase"
#link="https://abclive1-lh.akamaihd.net/i/abc_preview09@425084/index_100_av-p.m3u8?sd=10&rebase=on"

#####################################################

###################### EUROPEAN UNION #################################
# 540) EBS European Commision
540)
if [ "$getlink" = 1 ]
then
link=https://ott.ec.streamcloud.be/live/disk1/EBS/hls_or/EBS-audio_AACL_qaa_66400_201=66400-video=800000.m3u8
fi
use_cookies="no"
##method="Tor"
TAG="EBS_EU______"
chan_name="EBS European Commision" ;;
# 541) EBS European Commision
541)
if [ "$getlink" = 1 ]
then
link=https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_or/EBSplus-audio_AACL_qaa_66400_401=66400-video=800000.m3u8
fi
use_cookies="no"
##method="Tor"
TAG="EBS+_EU______"
chan_name="EBS Plus European Commision" ;;
#############################################################
###############################  GOVERNMENT #####################################################################
# 542) United Nations UN Trustship Chamber
542) 
keyword="LIVE"
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
##Trustship Chamber
link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="United Nations UN Trustship Chamber" ;;  
# 543) United Nations UN ESOSOC Chamber
543) 
keyword="LIVE"
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
##Trustship Chamber
link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="United Nations UN ESOSOC Chamber" ;;  

############## IRELAND ###############
# 544) Dail Eireann IE
544) 
link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/chunklist_b1228000.m3u8   
#link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/playlist.m3u8
#link=https://media.heanet.ie/oirlive/dail/ngrp:dail.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Dail Eireann IE" ;; 
# 545) Senad Eireann IE
545) 
link=https://oirlive.heanet.ie/seanad/ngrp:seanad.stream_all/playlist.m3u8   
#link=https://media.heanet.ie/oirlive/seanad/ngrp:seanad.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Senad Eireann IE" ;; 
# 546)# 540)Oireachtas Committee Room 1 
546) 
link=https://oirlive.heanet.ie/cr1/ngrp:cr1.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 1" ;; 
# 547)# 540)Oireachtas Committee Room 2 
547) 
link=https://oirlive.heanet.ie/cr2/ngrp:cr2.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 2" ;; 
# 548) Oireachtas Committee Room 3 
548) 
link=https://oirlive.heanet.ie/cr3/ngrp:cr3.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 3" ;; 
# 549)Oireachtas Committee Room 4 
549) 
link=https://oirlive.heanet.ie/cr4/ngrp:cr4.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 4" ;;
##############################################
# 550) CPAC Event 1
550) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248522/1242843915001_4/master.m3u8	
use_cookies="no"
chan_name="CPAC Event 1" ;;
# 551) CPAC Event 2
551) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248523/1242843915001_5/master.m3u8
use_cookies="no"
chan_name="CPAC Event 2" ;;
# 552) CPAC Event 3
552) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248524/1242843915001_6/master.m3u8
use_cookies="no"
chan_name="CPAC Event 3" ;;
# 553) CPAC Event 4
553) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248525/1242843915001_7/master.m3u8
use_cookies="no"
chan_name="CPAC Event 4" ;;
# 554) CPAC Event 5
554) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248526/1242843915001_8/master.m3u8
use_cookies="no"
chan_name="CPAC Event 5" ;;
# 555) CPAC Event 6
555) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248527/1242843915001_9/master.m3u8
use_cookies="no"
chan_name="CPAC Event 6" ;;
# 556) CPAC Event 7
556) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248528/1242843915001_10/master.m3u8
use_cookies="no"
chan_name="CPAC Event 7" ;;
# 557) CPAC Event 8
557) 
link=http://bcoveliveios-i.akamaihd.net/hls/live/248529/1242843915001_11/master.m3u8
use_cookies="no"
chan_name="CPAC Event 8" ;;
# 558) CPAC Original Language
558) 
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613957,RESOLUTION=640x360,CODECS="avc1.77.31,mp4a.40.5"
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1527593775815/Layer1_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=921218,RESOLUTION=720x404,CODECS="avc1.77.31,mp4a.40.5"
link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1527593775815/Layer2_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3171997,RESOLUTION=1280x720,CODECS="avc1.77.31,mp4a.40.5"
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1527593775815/Layer3_master.m3u8
use_cookies="no"
chan_name="CPAC Original Language" ;;

# 559) RUPTLY LIVE RT
559)
link=https://hls-lw.rt.com/hls/ptr-strm.m3u8
use_cookies="no"
chan_name="RUPTLY LIVE RT" ;;
# 560) 


################## MENU 3   ##################
########################## CBC CANADA #################################
# 561) CBC Vancouver BC Canada 
561)
link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master5.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master4.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master3.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master2.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Vancouver, British Columbia, Canada ";;

# 562) CBC Yellowknife North West Territories Canada 
562)
link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master5.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master4.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master3.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master2.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Yellowknife, Northwest Territories, Canada ";;

# 563) CBC Edmonton Alberta Canada 
563)
link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master5.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master4.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master3.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master2.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Edmonton, Alberta,  Canada ";;

# 564) CBC Calgary Alberta Canada 
564)
link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master5.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master4.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master3.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master2.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Calgary, Alberta, Canada ";;

# 565) CBC Regina Saskatchewan  Canada 
565)
link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master5.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master4.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master3.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master2.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Regina Saskatchewan Canada ";;

# 566) CBC Winnepeg Manitoba Canada 
566)
link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master5.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master4.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master3.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master2.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Winnepeg, Manitoba, Canada ";;

# 567) CBC Windsor Ontario Canada 
567)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Windsor, Ontario, Canada ";;

# 568) CBC Toronto Ontario Canada 
568)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Toronto, Ontario, Canada ";;

# 569) CBC Ottawa Ontario Canada 
569)
link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master1.m3u8"
#link="http://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Ottawa Canada";;

# 570) CBC Montreal Quebec Canada 
570)
link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master5.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master4.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master3.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master2.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Montreal, Quebec, Canada ";;

# 571) CBC Frederickton New Brunswick Canada 
571)
link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master5.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master4.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master3.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master2.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Frederickton, New Brunswick, Canada ";;

# 572) CBC Charlottetown Prince Edward Island Canada 
572)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Charlottetown, Prince Edward Island, Canada ";;

# 573) CBC Halifax Nova Scotia Canada 
573)
link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master5.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master4.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master3.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master2.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Halifax, Nova Scotia, Canada ";;

# 574) CBC St. John's Newfoundland Canada 
574)
link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC St. John's, Newfoundland, Canada ";;

# 575) CBC News Montreal Canada 
575)
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_2500_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_1800_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_700_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_400_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_256_av-p.m3u8?sd=10&rebase=on"
#link="http://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC News, Montreal, Canada";;

# 576) MB TV Monte Blanc 
576)
link="https://www.dailymotion.com/video/x6142rr"
#####method="Tor"
use_cookies="no"
chan_name="MB TV Monte Blanc";;

# 577) Generations TV
577)
link="https://www.dailymotion.com/video/x2fxcwq"
#####method="Tor"
use_cookies="no"
chan_name="Generations TV";;

# 578) Tv Vendée - Le Direct
578)
link="https://www.dailymotion.com/video/x38yjeb"
#####method="Tor"
use_cookies="no"
chan_name="Tv Vendée";;

# 579) OUATCH TV 
579)
link="https://www.dailymotion.com/video/xuw47s"
#####method="Tor"
use_cookies="no"
chan_name="Tv Vendée";;

# 580) Suivez Telesud
580)
link="https://www.dailymotion.com/video/x52et3w"
#####method="Tor"
use_cookies="no"
chan_name="Suivez Telesud";;

# 581) VAR AZUR
581)
link="https://www.dailymotion.com/video/x630wrb"
#####method="Tor"
use_cookies="no"
chan_name="VAR AZUR";;

# 582) VL
582)
link="https://www.dailymotion.com/video/x35m6bz"
#####method="Tor"
use_cookies="no"
chan_name="VL";;

# 583)  BFM TV
583)
link="https://www.dailymotion.com/video/xgz4t1"
#####method="Tor"
use_cookies="no"
chan_name="BFM TV";;

# 584) TV7 Bordeaux
584)
link="https://www.dailymotion.com/video/x46ancl"
#####method="Tor"
use_cookies="no"
chan_name="TV7 Bordeaux";;

# 585) 8 Mont Blanc Live 2
585)
link="https://www.dailymotion.com/video/x6nhqs0"
#####method="Tor"
use_cookies="no"
chan_name="8 Mont Blanc Live 2";;

# 586) téléGrenoble Isère
586)
link="https://www.dailymotion.com/video/x128fjo"
#####method="Tor"
use_cookies="no"
chan_name="téléGrenoble Isère";;

# 587) RTL2 
587)
link="https://www.dailymotion.com/video/x2tzzpj"
#####method="Tor"
use_cookies="no"
chan_name="RTL2";;

# 588) OUI FM 
588)
link="https://www.dailymotion.com/video/x10990v"
#####method="Tor"
use_cookies="no"
chan_name="OUI FM";;

# 589) D24TV
589)
link="https://www.dailymotion.com/video/x6cq41k"
#####method="Tor"
use_cookies="no"
chan_name="D24TV";;


# 600)
#############   ESPANOL EXTRA  #####################################
# 601) VIVE Venezuela
601) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCg6uD_hL72AFeZuMJL5u07w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VIVE Venezuela" ;;
# 602) Vatican Media
602)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanes/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
# 603) Televen 
602) 
keyword="Televen EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcNva2dC9BR8QR_G02xDFqw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Televen Venezuela" ;;
# 604) Impacto USA 
604)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/impactotv2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Impacto USA" ;;
# 605) UCVTV CL  Universidad Católica de Valparaíso
605)  
keyword="UCVTV EN VIVO"
#link="http://unlimited1-us.dps.live/ucvtv/ucvtv.smil/ucvtv/livestream2/chunks.m3u8?nimblesessionid=14582063"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV Chile" ;;
# 606) UCVTV CL  Universidad Católica de Valparaíso
606)  
keyword="UCVTV EN VIVO"
link="http://unlimited1-us.dps.live/ucvtv2/ucvtv2.smil/ucvtv2/livestream2/chunks.m3u8?nimblesessionid=14583770"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV 2 Chile" ;;

###################################
# 607) Noticiero Univision MX
607)  
keyword="Noticiero"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UnivisionNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Noticiero Univision MX" ;;
# 608) Canal 2 Cablenet San Vicente Argentina  
608)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 609)Canal 2 Telpintv Pinamar AR  
609)  
keyword="Telpin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelpinVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 2 Telpintv Pinamar AR" ;;  
# 610) Canal 8 Mar del Plata
610) 
keyword="Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 611) Canal 11 de Salta Argentina
611)  
keyword="Salta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCy-r-BQ5BQRU6rzGS73-WBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 11 de Salta Argentina" ;;  
# 612) UNITVE AR  Universidad Nacional de Villa Maria, Córdoba ***
612) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_NtgyVHyQJfy3YlM6XdQdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UNITVE Cordoba AR" ;;
################## PARAGUAY #####################################
# 613) ABC TV Paraguay   
613)  
keyword="ABC"
link=http://www.ustream.tv/channel/21235831
method="livestreamer"
format="best"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalabctv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ABC TV Paraguay" ;;
################# BOLIVIA #####################################
# 614) Abya Yala Bolivia  ****
614)  
keyword="Abya Yala"
link=https://www.ustream.tv/channel/23484517
method="livestreamer"
format="best"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYVYGzj8t64hFAz2T-udG5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Abya Yala Bolivia" ;;
# 615) UFRO Vision Chile *****
615)  
keyword="UFRO"
linkl=https://mdstrm.com/share/live/580a80b827de0ae2086ea6d8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5H9zdp-3M24xWWJunhLJmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UFRO Vision Chile" ;;  
# 616) CAMPO ABIERTO Santiago Chile
616) 
keyword="TRANSMISIÓN CAMPO ABIERTO TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwcZwWgpdrF-JsOkquSD59w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CAMPO ABIERTO Santiago Chile" ;;
# 617) UNITV Universidad Nacional de General Sarmiento AR
617)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWCJwDsCdRn_pwHNpLwEJcw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UNITV Universidad Nacional de General Sarmiento AR" ;;  
# 618) TelePacifico Colombia  ****
618) 
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpywwd47pfQSwBO8pXZwXrw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 
# 619) Venevision VE
619)  
keyword="Emisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Venevision VE" ;; 
# 620) Telediario AR  
620)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1-SmZtkXTg2ufhLMpwiRIg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telediario AR" ;;
# 621) TVeo Canal 41 Cordoba AR
621)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9kgE-365dvz6zJEUX1dFiw/?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TVeo Canal 41 Cordoba AR" ;; 
# 622) PSN Tijuana Mexico
622) 
keyword="PSN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";; 
## 623) Senal de CNN en Espanol
623)
keyword="CNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnenespanolcom/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal de CNN en Espanol" ;; 
## 624) Paraguay Noticias
624)
#link=https://livestream.com/accounts/25680986/events/7856569
link="$( curl "https://livestream.com/accounts/25680986/events/7856569" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Paraguay Noticias" ;; 
## 625) Canal Tr3ce
625) 
link=https://cdn.logicideas.media/canaltrece-live/smil:MNQW4.smil/chunklist_b1500000.m3u8
use_cookies="no"
chan_name="Canal Tr3ce CO" ;;
## 626) Cali TV
626) 
link=http://vbox.cehis.net/live-calitv/calitv1/chunklist_w1780377540.m3u8 
use_cookies="no"
chan_name="Cali TV CO" ;;
## 627) Canal 12 CO
627) 
link=http://edge.teveo.com.co/live/AeAAAgAJAAFFA1IAyADIVKgAAAAAAAAAAlqjj_e4Rz22AAAA/chunklist_w1858463102.m3u8 
use_cookies="no"
chan_name="Canal 12 CO" ;;
# 628) Imagen Radio Mexico
628) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 629)Euronews Espanol
629)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 630) Teleamazonas
630)  
keyword="Live"
#link=https://livestream.com/accounts/1359588/Noticiero24Horas
link="$( curl "https://livestream.com/accounts/1359588/Noticiero24Horas" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Teleamazonas" ;; 
# 631) TV Camara Paraguay
631) 
keyword="DIRECTO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCRVeQhiqhUAxRRUod7F-K3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV Camara Paraguay" ;; 
# 632) Tu Canal Panama PA
632)  
keyword="directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Tu Canal Panama PA" ;; 
# 633)Colosal TV 1 
633)  
#EXT-X-STREAM-INF:BANDWIDTH=745613,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=720x480
link="http://k3.usastreams.com:1935/colosaltv1/colosaltv1/chunklist_w147840137.m3u8"
#link="http://k3.usastreams.com:1935/colosaltv1/colosaltv1/chunklist_w516008458.m3u8"
use_cookies="no"
chan_name="Colosal TV 1" ;;  
# 634) WIPR Puerto Rico
634)
#link="https://livestream.com/accounts/16550960/events/8077197"
link="$( curl "https://livestream.com/accounts/16550960/events/8077197"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WIPR Puerto Rico" ;;
# 635) A24 Argentina
635) 
keyword="A24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 636) Canal 8 San Juan Argentina   ****
636) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;; 
# 637) Showsport Cordoba Argentina
637)  
keyword="Showsport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CanalShowsport/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Showsport Argentina" ;;  
# 638) La Mega Bogotá 90.9 FM CO
638)
#link="https://livestream.com/accounts/13907141/lamegabogota"
link="$( curl "https://livestream.com/accounts/13907141/lamegabogota"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="La Mega Bogotá 90.9 FM CO" ;;
# 639)TV UNAM MX
639)
#link="https://livestream.com/accounts/27177136/events/8157904"
link="$( curl "https://livestream.com/accounts/27177136/events/8157904"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV UNAM MX" ;;
# 640)Canal Telecafé CO
640)
#link="https://livestream.com/accounts/1015476/events/7158511"
link="$( curl "https://livestream.com/accounts/1015476/events/7158511"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal Telecafé CO" ;;
# 160)Azteca 7 MX
160)  
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=528000,RESOLUTION=426x240,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=528000,RESOLUTION=426x240,CODECS="avc1.77.30, mp4a.40.2"
link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=877000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=877000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=128000,CODECS="mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=128000,CODECS="mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Azteca 7 MX" ;; 
# 642) EsteCanal TV 
642)
#link="https://livestream.com/accounts/8817409/events/7051352"
link="$( curl "https://livestream.com/accounts/8817409/events/7051352"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="EsteCanal TV" ;;
# 643) Cinevision Canal 19 Dominican Republic 
643)
#link="https://livestream.com/accounts/9430235/canal19"
link="$( curl "https://livestream.com/accounts/9430235/canal19"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Cinevision Canal 19 Dominican Republic" ;;
# 644) Nuevolaredo.tv Flujo de Puentes Internacionales nuevo laredo MX
644)
#link="https://livestream.com/accounts/13480210/events/4837379"
link="$( curl "https://livestream.com/accounts/13480210/events/4837379"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Neuvo Larado TV MX" ;;
# 645) Sinart Digital Señal Canal 13 CR 
645)
#link="https://livestream.com/accounts/1532727/events/8158158"
link="$( curl "https://livestream.com/accounts/1532727/events/8158158"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Sinart Digital Señal Canal 13 CR " ;;
# 646) BethelTV Bethel Panamá
646)
#link="https://livestream.com/accounts/16567960/events/7963429"
link="$( curl "https://livestream.com/accounts/16567960/events/7963429"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="BethelTV Bethel Panamá" ;;
# 647) Poder de Dios TV La Paz Bolivia
647)
#link="https://livestream.com/accounts/25268891/TV"
link="$( curl "https://livestream.com/accounts/25268891/TV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Poder de Dios TV La Paz Bolivia" ;;
# 648) TVDIÁRIO 145 Mexico 
648)
#link="https://livestream.com/accounts/7328757/events/7373344"
link="$( curl "https://livestream.com/accounts/7328757/events/7373344"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TVDIÁRIO 145 Mexico" ;;
# 649) BoliviaTV La Paz Bolivia
649)
#link="https://livestream.com/accounts/10468276/boliviatv"
link="$( curl "https://livestream.com/accounts/10468276/boliviatv"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 650) GUATEVISION Guatemala
650)
#link="https://livestream.com/accounts/25697071/en-vivo"
link="$( curl "https://livestream.com/accounts/25697071/en-vivo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="GUATEVISION Guatemala" ;;
# 651) Onda Cádiz RTV Spain
651)
#link="https://livestream.com/accounts/22727797/directo"
link="$( curl "https://livestream.com/accounts/22727797/directo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Onda Cádiz RTV Spain" ;;
# 652) Streaming Medios Públicos Señal Nacional
652)
#link="https://livestream.com/accounts/27228685/events/8175786"
link="$( curl "https://livestream.com/accounts/27228685/events/8175786"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Streaming Medios Públicos Señal Nacional" ;;
# 653) Tele Bahia Santo Domingo ,Dominican Republic
653)
#link="https://livestream.com/accounts/18988261/events/7725211"
link="$( curl "https://livestream.com/accounts/18988261/events/7725211"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Tele Bahia Santo Domingo ,Dominican Republic" ;;
# 654)Iglesia Advenimiento del Séptimo Día Advenimiento TV Dallas Texas
654)
#link="https://livestream.com/accounts/13655021/events/4355864"
link="$( curl "https://livestream.com/accounts/13655021/events/4355864"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Advenimiento TV Dallas Texas" ;;
# 655) Expande TV Puebla Mexico 
655)
#link="https://livestream.com/accounts/7277442/envivo"
link="$( curl "https://livestream.com/accounts/7277442/envivo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Expande TV Puebla Mexico" ;;
# 656) Tv Universal Centro de Ayuda Universal Mexico
656)
#link="https://livestream.com/accounts/4486152/oracionmedianoche"
link="$( curl "https://livestream.com/accounts/4486152/oracionmedianoche"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Tv Universal Centro de Ayuda Universal Mexico" ;;
# 657) Canal 27, El Canal de la Esperanza.
657)
#link="https://livestream.com/accounts/13639189/events/6356013"
link="$( curl "https://livestream.com/accounts/13639189/events/6356013"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal 27, El Canal de la Esperanza." ;;
# 658) teleamiga TELEAMIGA INTERNACIONAL 
658)
#link="https://livestream.com/accounts/18971084/events/6841479"
link="$( curl "https://livestream.com/accounts/18971084/events/6841479"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TELEAMIGA INTERNACIONAL" ;;
# 659) Politv Poli tv Bogota Colombia 
659)
#link="https://livestream.com/accounts/12256908/events/6185792"
link="$( curl "https://livestream.com/accounts/12256908/events/6185792"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Poli tv Bogota Colombia" ;;
# 660) UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina 
660)
#link="https://livestream.com/accounts/5198918/events/3229548"
link="$( curl "https://livestream.com/accounts/5198918/events/3229548"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina " ;;
# 661) Asociación RUAV Univalle - Canal Universitario Cali Colombia
661)
#link="https://livestream.com/accounts/2541970/events/1932032"
link="$( curl "https://livestream.com/accounts/2541970/events/1932032"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Asociación RUAV Univalle - Canal Universitario Cali Colombia" ;;
# 662) Canal JesusTV Guatemala 
662)
#link="https://livestream.com/accounts/17608437/events/4834657"
link="$( curl "https://livestream.com/accounts/17608437/events/4834657"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal JesusTV Guatemala " ;;
# 663) FGTV Frecuencias de Gloria Jacksonville Florida 
663)
#link="https://livestream.com/accounts/3107466/events/3858724"
link="$( curl "https://livestream.com/accounts/3107466/events/3858724"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="FGTV Frecuencias de Gloria Jacksonville Florida" ;;
# 664) El Evangelio Eterno EEE Network en Los Angeles Canal 63.5
664)
#link="https://livestream.com/accounts/116136/EEENet"
link="$( curl "https://livestream.com/accounts/116136/EEENet"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="El Evangelio Eterno EEE Network en Los Angeles Canal 63.5" ;;
# 665) BoliviaTV La Paz Bolivia
665)
#link="https://livestream.com/accounts/10468276/BtvDeportes"
link="$( curl "https://livestream.com/accounts/10468276/BtvDeportes"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 666) Cosmovision TV Cosmovision HD
666)
#link="https://livestream.com/accounts/16628908/cosmovisionhd"
link="$( curl "https://livestream.com/accounts/16628908/cosmovisionhd"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Cosmovision TV" ;;
# 667) Emisora Virtual Onda Libre Cali CO 
667)
#link="https://livestream.com/accounts/2541970/events/5178171"
link="$( curl "https://livestream.com/accounts/2541970/events/5178171"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Emisora Virtual Onda Libre Cali CO " ;;
# 668) TV MONARCA Ciudad Hidalgo, Michoacán, Mexico
668)
#link="https://livestream.com/accounts/17594956/events/5033533"
link="$( curl "https://livestream.com/accounts/17594956/events/5033533"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV MONARCA Ciudad Hidalgo, Michoacán, Mexico" ;;
# 669) Yuma Virtual TV Barrancabermeja CO
669)
#link="https://livestream.com/accounts/17972814/events/6311476"
link="$( curl "https://livestream.com/accounts/17972814/events/6311476"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Yuma Virtual TV Barrancabermeja CO" ;;
# 670) Dominio Radio: En Vivo Mexico
670)
#link="https://livestream.com/accounts/26841641/events/8163521"
link="$( curl "https://livestream.com/accounts/26841641/events/8163521"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Dominio Radio: En Vivo Mexico" ;;
# 671) Señal UNTREF
671)
#link="https://livestream.com/accounts/16129323/events/7659666"
link="$( curl "https://livestream.com/accounts/16129323/events/7659666"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Señal UNTREF" ;;
# 672)NRT Canal 4 monclova
672)
#link="https://livestream.com/accounts/24089527/events/7172314"
link="$( curl "https://livestream.com/accounts/24089527/events/7172314"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="NRT Canal 4 monclova" ;;
# 673) Este Canal Tv
673)
#link="https://livestream.com/accounts/8817409/events/7051352"
link="$( curl "https://livestream.com/accounts/8817409/events/7051352"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Este Canal Tv" ;;
# 674) Canal Telecafé Bogota Colombia
674)
#link="https://livestream.com/accounts/1015476/events/7158511"
link="$( curl "https://livestream.com/accounts/1015476/events/7158511"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal Telecafé Bogota Colombia" ;;
# 675) TVUNAM 20 Transmisión de la Dirección General de Televisión Universitaria
675)
#link="https://livestream.com/accounts/27177136/events/8157904"
link="$( curl "https://livestream.com/accounts/27177136/events/8157904"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TVUNAM 20" ;;
# 676)EVTV Miami
676)  
keyword="EVTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elvenezolanotv/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EVTV Miami" ;; 
# 677)Enlacetv Espanol Irving Texas 
677)
#link="https://livestream.com/accounts/2675843/enlace"
link="$( curl "https://livestream.com/accounts/2675843/enlace"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Enlacetv Espanol Irving Texas" ;;

######################## Portuguese #########################
# 681) Euronews Portugues
681)
keyword="euronews em"
method="Tor"

#ink="http://pt.euronews.com/live"
radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://pt.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptpri_por_90p/' )
link="$radix"
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_720p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_540p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_360p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_224p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_180p/' )
#link=$( echo $radix | sed 's/playlist/ewnsabrptbkp_por_90p/' )

#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Euronews Portugues" ;;
################ BRAZIL   ################################
# 682) TV Assemblelia BR
682)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCIxlLEYzjWPLb_CXpc-e74w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Assemblelia" ;;
# 683) TV Canaco Nova
683)
keyword="Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvcancaonova/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Canaco Nova" ;;
# 684) TV Igreja Internacional de Graca
684)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_hwWljVyb_o3yzasx-bG2g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Igreja Internacional de Graca" ;;
# 685) TV Ales Assembleia Legeslativa
685)
keyword="Ales"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alescomunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Ales Assembleia Legeslativa" ;;
# 686) TV Boas Nova
686)
keyword="Play"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/boasnovasoficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Boas Nova" ;;
# 687) Fundacao Nazzare de Communicaco
687)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FNComunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Fundacao Nazzare de Communicaco" ;;
# 688) STF Brazil
688)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 689) TV Estúdio Brasil
689)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 690) Rádio Justiça - Ao Vivo  
690)  
keyword="Rádio Justiça"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Radio Justicia" ;;  
# 691) EXA FM 93.9
691)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
# 692) RIT TV BR
692)  
keyword="RIT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA0bOG0NUfJ855eDtHSxOkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="RIT TV BR" ;;
# 693)  Gott24.TV International 
693)
#link="https://livestream.com/accounts/1106752/events/6785217"
link="$( curl "https://livestream.com/accounts/1106752/events/6785217"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Gott24.TV International" ;;
# 694) TV Fátima Paróquia de Fátima em Direto
694)
#link="https://livestream.com/accounts/22203883/events/6579475"
link="$( curl "https://livestream.com/accounts/22203883/events/6579475"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV Fátima Paróquia de Fátima em Direto" ;;
# 695) You Content 98 Live Belo Horizonte Brasil 
695)
#link="https://livestream.com/accounts/15418920/98livebh"
link="$( curl "https://livestream.com/accounts/15418920/98livebh"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="98 Live Belo Horizonte Brasil" ;;
# 696) Rede Gênesis Europa TV Gênesis Europa Lisbon Portugal
696)
#link="https://livestream.com/accounts/6602768/events/3378204"
link="$( curl "https://livestream.com/accounts/6602768/events/3378204"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV Gênesis Europa Lisbon Portugal" ;;
# 697) SISTEMA MEIO NORTE DE COMUNICAÇÃO TV MEIO Teresina Brasil
697)
#link="https://livestream.com/accounts/3332377/tvmeionortehd"
link="$( curl "https://livestream.com/accounts/3332377/tvmeionortehd"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV MEIO Teresina Brasil" ;;
# 698)SescTV HD Sao Paulo BR
698)
#link="https://livestream.com/accounts/16991778/NoAr"
link="$( curl "https://livestream.com/accounts/16991778/NoAr"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="SescTV HD Sao Paulo BR" ;;
# 699) Medalhão Persa BR
699)
#link="https://livestream.com/accounts/7533066/tvmedalhao"
link="$( curl "https://livestream.com/accounts/7533066/tvmedalhao"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Medalhão Persa BR" ;;
# 700)Talenu TV TPA Online Portuguese
700)
#link="https://livestream.com/accounts/1181452/events/5141181"
link="$( curl "https://livestream.com/accounts/1181452/events/5141181"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Talenu TV TPA Luanda Angola" ;;
# 701)TV Miramar Mozambique Portuguese
701)
#link="https://livestream.com/accounts/21076186/events/6180705"
link="$( curl "https://livestream.com/accounts/21076186/events/6180705"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV Miramar Mozambique Portuguese" ;;
# 702)TV Zimbo Online Angola Portuguese
702)
#link="https://livestream.com/accounts/19766999/events/5548210"
link="$( curl "https://livestream.com/accounts/19766999/events/5548210"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV Zimbo Online Angola Portuguese" ;;
# 703) TV RAIAR Angola Portuguese 
703)
#link="https://livestream.com/accounts/26069467/tv-raiar"
link="$( curl "https://livestream.com/accounts/26069467/tv-raiar"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV RAIAR Angola Portuguese" ;;
# 704)Rede Super Belo Horizonte BR
704)
#link="https://livestream.com/accounts/10205943/events/3429501"
link="$( curl "https://livestream.com/accounts/10205943/events/3429501"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Rede Super Belo Horizonte BR" ;;
# 705)  SescTV Sao Paulo Brasil  
705)
#link="https://livestream.com/accounts/16991778/NoAr"
link="$( curl "https://livestream.com/accounts/16991778/NoAr"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="SescTV Sao Paulo Brasil" ;;
# 706) Vatican Media
706)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGYSq4b4DXmtK4jyq6r-FYg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
#######################################################################################################
###################################### FRANCAIS EXTRA ##########################################
# 707) ACTION Francais
707)
link=http://live-s101.abweb.com/liveabs101/ngrp:action.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="ACTION Francais" ;;
# 708) CNEWS France
708)
link=http://www.dailymotion.com/video/x3b68jn
# link=http://www.dailymotion.com/embed/video/x3b68jn
method="Tor"
use_cookies="no"
#format=hls-1080
#format=hls-1080@60
#format=hls-720@60
# format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="CNEWS France" ;;
# 709) i24 News en Direct
709) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="i24 Francais";; 
# 710)SYTRAL Rhone FR
710) 
keyword="DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SytralTCL/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="SYTRAL Rhone FR" ;;
# 711) Vedia BE
711)
# https://www.vedia.be/www/live
link=https://5a0b00d270652.streamlock.net/live/vedia-live/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1785849,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=1280x720
#link=https://5a0b00d270652.streamlock.net/live/vedia-live/chunklist_w1404141724.m3u8
use_cookies="no"
#method="Tor"
chan_name="Vedia BE" ;;
# 712) MABI TV Canada
712) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="MABI TV Canada" ;;
# 713) Vatican Media  
713) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Vatican Media" ;;  
# 714) TVM FR
714)
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist_w1158771188.m3u8
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist.m3u8
link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TVM FR" ;;
# 715) C-Star 
715)
link=http://www.dailymotion.com/video/x5idxor
#link=https://stream-07.dc3.dailymotion.com/41/dm/3/x5idxor/live-2.m3u8
use_cookies="no"
chan_name="C-Star" ;;
# 716) Direct Journal TVLandes    
716) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Direct Journal Tvlandes"  ;; 
# 717) TV 7 Francais
717)  
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TV 7 Francais" ;;  



################################################################################## 

#################################   COLUMN 4 ############################################
# 721) FOX News Channel Preview (No Audio)
721)  
link="https://fnurtmp-f.akamaihd.net/i/FNCPREV_1@143121/master.m3u8"
use_cookies="no"
chan_name="FOX News Channel Preview Preview (No Audio)" ;; 
# 722) Beach TV DTVHD
722)
#link=http://media4.tripsmarter.com:1935/LiveTV/DTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3472194,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/DTVHD/chunklist_w1668636762.m3u8"
use_cookies="no"
chan_name="Beach TV -DTVHD" ;;
# 723) Daytona Beach TV
723)
#link=http://oflash.dfw.swagit.com/live/daytonabeachfl/smil:std-4x3-1-a/chucklist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=512000,RESOLUTION=480x360
link="http://oflash.dfw.swagit.com/live/daytonabeachfl/smil:std-4x3-1-a/chunklist_w645874079_b512000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=312000,RESOLUTION=320x240
#link="http://oflash.dfw.swagit.com/live/daytonabeachfl/smil:std-4x3-1-a/chunklist_w645874079_b312000.m3u8"
use_cookies="no"
chan_name="Daytona Beach TV" ;;
# 724) Shepard Smith Breaking News
724)
link=http://fnurtmp-f.akamaihd.net/i/SHEPSMITH_1@459383/master.m3u8
use_cookies="no"
chan_name="Shepard Smith Breaking News" ;;  
# 725) WUSA9 Breaking News
725)
link=https://wusa-lh.akamaihd.net/i/WUSA_Breaking_1@98930/master.m3u8
use_cookies="no"
chan_name="WUSA9 Breaking News" ;; 
# 726) WCNC Breaking News audio
726)
link=http://wcnc-lh.akamaihd.net/i/WCNC_Breaking_1@195112/master.m3u8
use_cookies="no"
chan_name="WCNC Breaking News audio" ;; 
# 727) WCCB News Rising
727)
link=https://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB News Rising" ;;  
# 728) UGA TV
728)
link=http://mmuga-lh.akamaihd.net/i/ctlcable_1@349875/master.m3u8
use_cookies="no"
chan_name="UGA TV" ;;   
# 729) TVW2 Washington State TV
729)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVW2_all/master.m3u8
use_cookies="no"
chan_name="TVW2 Washington State TV" ;; 
# 730) Action News Now (KNVN)
730)
link=https://api.new.livestream.com/accounts/26511688/events/7954874/live.m3u8
use_cookies="no"
chan_name="Action News Now (KNVN)" ;; 
# 731) Anchorage Alaska ASD TV
731)
link=http://64.22.99.223/AnchorageSchoolsAKLIVE/_definst_/AnchorageSchoolsAKLIVE.stream/chunklist.m3u8
use_cookies="no"
chan_name="Anchorage Alaska ASD TV" ;; 
# 732) Bowie TV
732)
link=http://granicusliveus3-a.akamaihd.net/cityofbowie/G0466_001/playlist.m3u8
use_cookies="no"
chan_name="Bowie TV" ;;
# 733) Escambia TV
733)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;
# 734) Fox 5 Washington DC (WTTG-TV)
734)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="Fox 5 Washington DC (WTTG-TV)" ;;
# 735) Garland TV
735)
link=http://oflash-alt.dfw.swagit.com/live/garlandtx/smil:hd-16x9-1-a/chunklist.m3u8
use_cookies="no"
chan_name="Garland TV" ;;
# 736) Greenbelt TV
736)
link=http://granicusliveus4-a.akamaihd.net/greenbeltmd/G0610_001/chunklist.m3u8
use_cookies="no"
chan_name="Greenbelt TV" ;;
# 737) House of Representatives
737)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:HouseChannel_all/chucklist.m3u8
use_cookies="no"
chan_name="House of Representatives" ;;
# 738) KRBC-TV
738)
link=http://krbc-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="KRBC-TV" ;;
# 739)New Orleans TV2
739)
#link=http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3382572,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/chunklist_w1797542626.m3u8"
use_cookies="no"
chan_name="New Orleans TV" ;;

# 740) KTVB
740)
link=http://ktvb-lh.akamaihd.net/i/KTVB_Shows_1@60359/master.m3u8
use_cookies="no"
chan_name="KTVB" ;;
# 741) Key TV Florida
741)
link=http://media4.tripsmarter.com:1935/LiveTV/KTVHD/chunklist_w363623166.m3u8
use_cookies="no"
chan_name="Key TV Florida" ;;
# 742) KOB4 News Albacurqe NM
742)
link=https://api.new.livestream.com/accounts/10066184/events/3399986/live.m3u8
use_cookies="no"
chan_name="KOB4 News Albacurqe NM" ;;
# 743) KPNX Breaking 1
743)
link=https://b_kpnx-f.akamaihd.net/i/KPNXBreaking_1@398330/master.m3u8
use_cookies="no"
chan_name="KPNX Breaking 1" ;;
# 744) KXAN News Austin TX NBC
744)
link=https://api.new.livestream.com/accounts/1506296/events/1569171/live.m3u8
use_cookies="no"
chan_name="KXAN News Austin TX NBC" ;;
# 745) Miami TV
745)
link=http://oflash.dfw.swagit.com/live/miamibeachfl/smil:std-16x9-1-a/chunklist_w1459206316_b878000.m3u8
use_cookies="no"
chan_name="Miami TV" ;;
# 746) NBC Bay Area (KNTV-TV)
746)
link=https://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/master.m3u8
use_cookies="no"
chan_name="NBC Bay Area (KNTV-TV)" ;;
# 747) KNTV-TV NBC / Telemundo 48 Bay Area
747)
link=https://kntvlive-f.akamaihd.net/i/kntvb1_1@15530/master.m3u8
use_cookies="no"
chan_name="KNTV-TV NBC Telemundo 48 Bay Area" ;;
# 748) NBC2 News (KTUU-TV))
748)
link=httpx://api.new.livestream.com/accounts/7987479/events/2929660/live.m3u8
use_cookies="no"
chan_name="NBC2 News (KTUU-TV)" ;;
# 749) News2 (WCBD-TV)
749)
link=https://api.new.livestream.com/accounts/8360295/events/2976321/live.m3u8
use_cookies="no"
chan_name="News2 (WCBD-TV)" ;;
# 750) News4 (WRC-TV)
750)
link=https://wrclive-f.akamaihd.net/i/wrcb1_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 (WRC-TV)" ;;
# 751)News4 White House Cam (WRC-TV)
751)
link=https://wrclive-f.akamaihd.net/i/wrcb2_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 White House Cam (WRC-TV)" ;;
# 752)News5 WCYB
752)
link=https://api.new.livestream.com/accounts/8522497/events/3012727/live.m3u8
use_cookies="no"
chan_name="News5 WCYB" ;;
# 753)NewsWest 9 (KWES)
753)
link=https://api.new.livestream.com/accounts/16923548/events/4681078/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 (KWES)" ;;
# 754)NBC4 New York News (WNBC-TV)
754)
link=https://wnbclive-f.akamaihd.net/i/wnbca1_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV)" ;;
# 755) NBC4 New York News (WNBC-TV) alt
755)
link=https://wnbclive-f.akamaihd.net/i/wnbca2_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV) alt" ;; 
# 756) NBC5 News (WMAQ-TV)
756)
link=https://wmaqlive-f.akamaihd.net/i/wmaqa1_1@22923/master.m3u8
use_cookies="no"
chan_name="NBC5 News (WMAQ-TV)" ;;
# 757) NBC 10 News (KTEN-TV)
757)
link=https://kten-lh.akamaihd.net/i/KTEN_1079@5589/master.m3u8
use_cookies="no"
chan_name="NBC 10 News (KTEN-TV)" ;;
# 758) NBC 12 News (WWBT-TV)
758)
link=https://api.new.livestream.com/accounts/11203782/events/3629264/live.m3u8
use_cookies="no"
chan_name="NBC 12 News (WWBT-TV)" ;;
# 759) NBC 29 (WVIR-TV)
759)
link=http://wvir-lh.akamaihd.net/i/WVIR_736@78303/master.m3u8?forceCacheClearSM=530806100000
use_cookies="no"
chan_name="NBC 29 (WVIR-TV)" ;;
# 760) NBC News Channel 13 (WNYT-TV)
760)
link=https://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 (WNYT-TV)" ;;
# 761) NewsChannel 12 KTVZ
761)
link=https://api.new.livestream.com/accounts/19128364/events/5285531/live.m3u8
use_cookies="no"
chan_name="NewsChannel 12 KTVZ" ;;
# 762) NewsWest 9 KWES Washington DC USA
762)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 KWES Washington DC USA" ;;
# 763) Orange TV  // works behind tor
763)
link=http://otv3.ocfl.net:1936/OrangeTV/smil:OrangeTV.smil/playlist.m3u8
use_cookies="no"
chan_name="Orange TV" ;;
# 764) PGCPS
764)
link=http://reflect.live.pgcps.cablecast.tv/live/WIFI-696k-360p/WIFI-696k-360p.m3u8
use_cookies="no"
chan_name="PGCPS" ;;
# 765) RyeTV
765)
link=http://oflash.dfw.swagit.com/live/ryeny/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="RyeTV" ;;
# 766) Seattle Channel
766)
link=https://wowzaprod121-i.akamaihd.net/hls/live/266526/d2ea1f60/playlist.m3u8
use_cookies="no"
chan_name="Seattle Channel" ;;
# 767) Atlanta Channel
767)
#link=http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3418933,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/chunklist_w2098604614.m3u8"
use_cookies="no"
chan_name="Atlanta Channel" ;; 
# 768) Temple TV
768)
link=http://streaming.temple.edu/tutvlive/_definst_/mp4:play/chunklist.m3u8
use_cookies="no"
chan_name="Temple TV" ;;
# 769) Town of Vienna Community Network [HQ]
769)
link=https://granicusliveus2-a.akamaihd.net/vienna-va/G1359_003/playlist.m3u8
use_cookies="no"
fchan_name="Town of Vienna Community Network [HQ]" ;;
# 770) Escambia TV
770)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;
# 771) CBS Sports 
771) 
#link=http://cbssportsliveios-i.akamaihd.net/hls/live/200603/cbklive3/master-3500.m3u8
link="https://cbssportsdc-i.akamaihd.net/518856/dc_1/master.m3u8"
use_cookies="no"
chan_name="CBS Sports" ;;
# 772) WYCW Carolinas
772)
#link="https://livestream.com/accounts/8366412/live"
link="$( curl "https://livestream.com/accounts/8366412/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WYCW Carolinas" ;;
# 773) FOX 10 News 
773)
#link="https://livestream.com/accounts/1859803/live"
link="$( curl "https://livestream.com/accounts/1859803/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="FOX 10 News" ;;
# 774) WHO HD 13
774)
link="https://api.new.livestream.com/accounts/9976600/events/3382760/live.m3u8"
use_cookies="no"
chan_name="WHO HD 13" ;;
# 775) Erie News Now (WICU-TV)
775)
link="http://wicu-lh.akamaihd.net/i/WICU_1356@78350/master.m3u8"
use_cookies="no"
chan_name="Erie News Now (WICU-TV)" ;;
# 776) WISTV
776)
link="http://wistv-lh.akamaihd.net/i/WISTV_822@68771/master.m3u8"
use_cookies="no"
chan_name="WISTV" ;;
# 777) Gem Shopping Network USA
777)
#link="https://livestream.com/accounts/3486453/events/7709515"
link="$( curl "https://livestream.com/accounts/3486453/events/7709515"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Gem Shopping Network USA" ;;

########################## AMERICAN GOVERNMENT ####################################################
# 778) C-SPAN 1 HD
778)
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
####link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_200_a-b.m3u8?sd=10&rebase=on"

######################################
#link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/index_200_a-b.m3u8?sd=10&rebase=on"
##method="Tor"
use_cookies="no"
chan_name="C-SPAN 1" ;;
##########################
# 779) C-SPAN 2 HD
779)
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_200_a-b.m3u8?sd=10&rebase=on"

#######################################################
#link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/index_200_a-b.m3u8?sd=10&rebase=on"

####method="Tor"
use_cookies="no"
chan_name="C-SPAN 2 HD" ;;
# 780) C-SPAN 3 HD
780)

#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1064000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_200_a-b.m3u8?sd=10&rebase=on"
########################################################
#link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_200_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/index_200_a-b.m3u8?sd=10&rebase=on"

####method="Tor"
use_cookies="no"
chan_name="C-SPAN 3 HD" ;;





################################################ Live Stream #########################################################
# 801) Sangat Television Birmingham England 
801)
#link="https://livestream.com/accounts/6986636/sangattv"
link="$( curl "https://livestream.com/accounts/6986636/sangattv"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Sangat Television Birmingham England" ;;
# 802) Sikh Channel Sikh Channel (Global Broadcast) Aston England 
802)
#link="https://livestream.com/accounts/5296919/live"
link="$( curl "https://livestream.com/accounts/5296919/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Sikh Channel Aston England" ;;
# 803) Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada
803)
#link="https://livestream.com/accounts/472363/events/3109892"
link="$( curl "https://livestream.com/accounts/472363/events/3109892"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada" ;;
################## GEORGIAN ##############################################
# 804) Iberia TV Live Georgia 
804)
#link="https://livestream.com/accounts/19735751/events/7830877"
link="$( curl "https://livestream.com/accounts/19735751/events/7830877"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Iberia TV Georgia" ;;
# 805) Obieqtivi TV Georgia 
805)
#link="https://livestream.com/accounts/2064453/events/1886556"
link="$( curl "https://livestream.com/accounts/2064453/events/1886556"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Obieqtivi TV Georgia" ;;
##################### ENGLISH ###########################
# 806) ortonvilletelevision
806)
#link="https://livestream.com/accounts/17285258/events/7143508"
link="$( curl "https://livestream.com/accounts/17285258/events/7143508"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ortonvilletelevision" ;;
# 807) Holiday & Cruise TV
807)
#link="https://livestream.com/accounts/22779659/events/6788901"
link="$( curl "https://livestream.com/accounts/22779659/events/6788901"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Holiday & Cruise TV" ;;
# 808) Vision Cruise AU
808)
#link="https://livestream.com/accounts/22779659/events/8027429"
link="$( curl "https://livestream.com/accounts/22779659/events/8027429"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Vision Cruise AU" ;;
# 809) Vision Cruise UK
809)
#link="https://livestream.com/accounts/22779659/events/8027222"
link="$( curl "https://livestream.com/accounts/22779659/events/8027222"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Vision Cruise UK" ;;
# 810) 102.3 NOW! TV Edmonton AB,CA
810)
#link="https://livestream.com/accounts/4683311/events/3747538"
link="$( curl "https://livestream.com/accounts/4683311/events/3747538"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="102.3 NOW! TV Edmonton AB,CA" ;;
# 811)TourbusTV USA
811)
#link="https://livestream.com/accounts/22843174/TourbusTV"
link="$( curl "https://livestream.com/accounts/22843174/TourbusTV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TourbusTV USA" ;;
# 812)Ezekiel TV Channel
812)
#link="https://livestream.com/accounts/19491040/events/6866917"
link="$( curl "https://livestream.com/accounts/19491040/events/6866917"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Ezekiel TV" ;;
# 813) Emmanuel TV
813)
#link="https://livestream.com/accounts/23202872/events/7200883"
link="$( curl "https://livestream.com/accounts/23202872/events/7200883"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Emmanuel TV" ;;
# 814) Shalom World Australia
814)
#link="https://livestream.com/accounts/25038049/events/7551704"
link="$( curl "https://livestream.com/accounts/25038049/events/7551704"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom World Australia" ;;

########################################## USA LOCAL NEWS ####################################################################3

############################################### NORTH WEST  ###############################################################################

##################Idaho################## 
# 815) KIFI ABC 8 Idaho Falls Idaho 
815)
#link="https://livestream.com/accounts/18796284/Live"
link="$( curl "https://livestream.com/accounts/18796284/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KIFI ABC 8 Idaho Falls Idaho " ;;
#################Washington############## 
# 816) 710 ESPN Seattle Washington
816)
#link="https://livestream.com/accounts/21148436/live"
link="$( curl "https://livestream.com/accounts/21148436/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="710 ESPN Seattle Washington" ;;
# 817) King County TV Preston, Washington USA 
817)
#link="https://livestream.com/accounts/15175343/events/4485487"
link="$( curl "https://livestream.com/accounts/15175343/events/4485487"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name=" King County TV Preston, Washington USA " ;;
# 818) KIRO Radio Seattle Washington 
818)
#link="https://livestream.com/accounts/21148570/live"
link="$( curl "https://livestream.com/accounts/21148570/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KIRO Radio Seattle Washington" ;;
##################Oregon##################  
# 819)  KOIN CBS 6 Portland Oregon USA
819)
#link="https://livestream.com/accounts/1864610/live"
link="$( curl "https://livestream.com/accounts/1864610/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KOIN CBS 6 Portland Oregon USA" ;;
# 820)KPTV FOX 12 Portland Oregon 
820)
#link="https://livestream.com/accounts/6908462/Live"
link="$( curl "https://livestream.com/accounts/6908462/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KPTV FOX 12 Portland Oregon" ;;
# 821) KTVZ 21 Bend Oregon 
821)
#link="https://livestream.com/accounts/19128364/Live"
link="$( curl "https://livestream.com/accounts/19128364/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KTVZ 21 Bend Oregon" ;;
# 822) KEZI ABC 9 Eugene, Oregon
822)
#link="https://livestream.com/accounts/26511759/live"
link="$( curl "https://livestream.com/accounts/26511759/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KEZI ABC 9 Eugene, Oregon" ;;
# 823) KOIN 6 Extras Portland Oregon
823)
#link="https://livestream.com/accounts/1864610/events/3314050"
link="$( curl "https://livestream.com/accounts/1864610/events/3314050"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KOIN 6 Extras Portland Oregon" ;;

###################Utah####################  
# 824) KSL NOW Salt Lake City Utah USA 
824)
#link="https://livestream.com/accounts/22711876/live"
link="$( curl "https://livestream.com/accounts/22711876/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSL NOW Salt Lake City Utah USA " ;;

#################Wyoming#################

#################Montana################# 

################################################################################## SOUTH WEST #########################

###################California################# 
# 825)  KUSI NEWS 24/7 San Diego California USA
825)
#link="https://livestream.com/accounts/25082096/live"
link="$( curl "https://livestream.com/accounts/25082096/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KUSI NEWS 24/7 San Diego California USA" ;;
# 826) KEYT ABC 3 Santa Barbara CA USA
826)
#link="https://livestream.com/accounts/19285506/live"
link="$( curl "https://livestream.com/accounts/19285506/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KEYT ABC 3 Santa Barbara CA USA" ;;
# 827) KHSL Action News NOW  CBS 12  Chico/Redding. California USA
827)
#link="https://livestream.com/accounts/26511688/live"
link="$( curl "https://livestream.com/accounts/26511688/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KHSL Action News NOW Chico/Redding California  USA" ;;
# 828) KRCR ABC 7 Redding California USA
828)
#link="https://livestream.com/accounts/10262876/events/3724366"
link="$( curl "https://livestream.com/accounts/10262876/events/3724366"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KRCR ABC 7 Redding California USA" ;;
# 829) KION CBS 5/46 Salinas California USA
829)
#link="https://livestream.com/accounts/19128738/events/7300156"
link="$( curl "https://livestream.com/accounts/19128738/events/7300156"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KION CBS 5/46 Salinas California USA" ;;
# 830) KSBY NBC 6 Santa Barbara California 
830)
#link="https://livestream.com/accounts/15512095/live"
link="$( curl "https://livestream.com/accounts/15512095/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSBY NBC 6 Santa Barbara California" ;;
# 831) KESQ ABC 3 FOX 11 Palm Springs, California
831)
#link="https://livestream.com/accounts/20847880/live"
link="$( curl "https://livestream.com/accounts/20847880/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KESQ ABC 3 FOX 11 Palm Springs, California" ;;
# 832) KCOY CBS 12 Santa Maria California USA 
832)
#link="https://livestream.com/accounts/19128628/live"
link="$( curl "https://livestream.com/accounts/19128628/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KCOY CBS 12 Santa Maria California USA" ;;
# 833) MCAET Salinas California 
833)
#link="https://livestream.com/accounts/7781243/events/7871771"
link="$( curl "https://livestream.com/accounts/7781243/events/7871771"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="MCAET Salinas California" ;;
# 834) KVVB.TV CH.33 Victorville,California KVVB.TV | Ch 33.1 
834)
#link="https://livestream.com/accounts/9450048/events/3542162"
link="$( curl "https://livestream.com/accounts/9450048/events/3542162"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVVB.TV CH.33 Victorville,CA" ;;
####################Colorado#################
# 835) KOAA NBC 5 Colorado Springs Colorado, USA
835)
#link="https://livestream.com/accounts/13725886/live"
link="$( curl "https://livestream.com/accounts/13725886/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KOAA NBC 5 Colorado Springs Colorado, USA" ;;
# 836) KRDO ABC 13 Colorado Springs Colorado 
836)
#link="https://livestream.com/accounts/17592934/live"
link="$( curl "https://livestream.com/accounts/17592934/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KRDO ABC 13 Colorado Springs Colorado" ;;
# 837) GalaxyUniverseTV Freedom Solar TV Kersey, CO, USA
837)
#link="https://livestream.com/accounts/12141749/events/7685294"
link="$( curl "https://livestream.com/accounts/12141749/events/7685294" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Freedom Solar TV Kersey, CO, USA" ;;

####################Arizona################# 
# 838) KTVK 3 TV Arizona USA
838)
#link="https://livestream.com/accounts/12643960/live"
link="$( curl "https://livestream.com/accounts/12643960/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KTVK 3 TV Arizona USA" ;;
# 839) KMVP 24/7 Phoenix Arizona Sports 98.7 FM 
839)
#link="https://livestream.com/accounts/24089066/live"
link="$( curl "https://livestream.com/accounts/24089066/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KMVP 24/7 Phoenix Arizona Sports 98.7 FM " ;;
# 840) KTAR News Phoenix Arizona 
840)
#link="https://livestream.com/accounts/24088937/live"
link="$( curl "https://livestream.com/accounts/24088937/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KTAR News Phoenix Arizona " ;;
# 841) KOLD 13 Tucson, Arizona
841)
#link="https://livestream.com/accounts/11042990/live"
link="$( curl "https://livestream.com/accounts/11042990/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KOLD 13 Tucson, Arizona" ;;
# 842) KPHO CBS 5 Pheonix Arizona 
842)
#link="https://livestream.com/accounts/6907826/LIVE"
link="$( curl "https://livestream.com/accounts/6907826/LIVE"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KPHO CBS 5 Pheonix Arizona " ;;
# 843) KVOA NBC 4 Tuscon Arizona
843)
#link="https://livestream.com/accounts/15512011/live"
link="$( curl "https://livestream.com/accounts/15512011/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVOA NBC 4 Tuscon Arizona" ;;
# 844) KYMA NBC 11 Yuma Arizona 
844)
#link="https://livestream.com/accounts/20242841/live"
link="$( curl "https://livestream.com/accounts/20242841/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KYMA NBC 11 Yuma Arizona" ;;

####################Nevada###################  
# 845) NewsChannel5+ Las Vegas, Nevada
845)
#link="https://livestream.com/accounts/3827561/live"
link="$( curl "https://livestream.com/accounts/3827561/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="NewsChannel5+ Las Vegas, Nevada" ;;
# 846) VSiN - Vegas Stats & Information Network Las Vegas Nevada 
846)
#link="https://livestream.com/accounts/22774234/events/6897936"
link="$( curl "https://livestream.com/accounts/22774234/events/6897936"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="VSiN - Vegas Stats & Information Network Las Vegas Nevada " ;;
# 847) City of Las Vegas KCLV FOX 2 Nevada 
847)
#link="https://livestream.com/accounts/11449855/events/8026296"
link="$( curl "https://livestream.com/accounts/11449855/events/8026296"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="City of Las Vegas KCLV FOX 2 Nevada" ;;
# 848)KVVU FOX 5 Las Vegas Nevada  
848)
#link="https://livestream.com/accounts/6910894/Live"
link="$( curl "https://livestream.com/accounts/6910894/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVVU FOX 5 Las Vegas Nevada " ;;
####################New Mexico############### 
# 849)Native Media Network NMN Native Media Network Sante Fe New Mexico USA NDN1.com
849)
#link="https://livestream.com/accounts/13196214/events/3994033"
link="$( curl "https://livestream.com/accounts/13196214/events/3994033"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Native Media Network, Santa Fe New Mexico USA" ;;
# 850) Santa Fe Media Network New Mexico USA
850)
#link="https://livestream.com/accounts/13196214/events/5972197"
link="$( curl "https://livestream.com/accounts/13196214/events/5972197"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Santa Fe Media Network New Mexico USA" ;;

#################################################################################### NORTH EAST #########################

##################Connecticut#################### 
# 851)WTNH 8 New Haven CT 
851)
#link="https://livestream.com/accounts/1864656/live"
link="$( curl "https://livestream.com/accounts/1864656/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTNH 8 New Haven CT" ;;
# 852) WFSB 3 Hartford Connecticut USA
852)
#link="https://livestream.com/accounts/6372985/live"
link="$( curl "https://livestream.com/accounts/6372985/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFSB 3 Hartford Connecticut USA" ;;
##################Delaware#######################  

###################Maine#########################  

####################Maryland#####################  

# 853) CharmTV Baltimore Maryland
853)
#link="https://livestream.com/accounts/13988426/events/4134572"
link="$( curl "https://livestream.com/accounts/13988426/events/4134572"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CharmTV Baltimore Maryland" ;;
################# Washington DC ####################
# 854) WTTG Fox 5 Washington DC USA
854)
#link="https://livestream.com/accounts/2363281/live"
link="$( curl "https://livestream.com/accounts/2363281/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTTG Fox 5 Washington DC USA" ;;

####################Massachusetts################  
# 855) WWLP 22 Springfield Massachusetts
855)
#link="https://livestream.com/accounts/1866220/live"
link="$( curl "https://livestream.com/accounts/1866220/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WWLP 22 Springfield Massachusetts" ;;
# 856) Western Mass News Chicopee Massachusetts
856)
#link="https://livestream.com/accounts/6140816/live"
link="$( curl "https://livestream.com/accounts/6140816/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Western Mass News Chicopee Massachusetts" ;;
# 857) Milford TV - Milford, MA Massachusetts 
857)
#link="https://livestream.com/accounts/13918823/MilfordTV"
link="$( curl "https://livestream.com/accounts/13918823/MilfordTV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Milford TV - Milford, MA Massachusetts" ;;
# 858) Milford TV Educational Channel - Milford, MA
858)
#link="https://livestream.com/accounts/13568947/MilfordTVEducational"
link="$( curl "https://livestream.com/accounts/13568947/MilfordTVEducational"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Milford TV Educational Channel - Milford, MA" ;;
####################New Jersey###################  
# 859) WWOR Secaucus New Jersey
859)
#link="https://livestream.com/accounts/6372957/live"
link="$( curl "https://livestream.com/accounts/6372957/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WWOR Secaucus New Jersey " ;;

#####################New York####################  
# 860)  WNYW Fox 5 New York USA
860)
#link="https://livestream.com/accounts/6372917/live"
link="$( curl "https://livestream.com/accounts/6372917/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WNYW Fox 5 New York USA" ;;
# 861) WROC CBS 8 Rochester NY USA
861)
#link="https://livestream.com/accounts/21078314/live"
link="$( curl "https://livestream.com/accounts/21078314/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WROC CBS 8 Rochester NY USA" ;;
# 862) Cumulus NYC 77 WABC New York USA
862)
#link="https://livestream.com/cumulusnyc/live"
link="$( curl"https://livestream.com/cumulusnyc/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Cumulus NYC 77 WABC New York USA" ;;
# 863) WJHL CBS 11 Johnson City, New York 
863)
#link="https://livestream.com/accounts/7264167/live"
link="$( curl "https://livestream.com/accounts/7264167/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WJHL CBS 11 Johnson City, New York" ;;
# 864) DayTraderRockStar Show New York City New York 
864)
#link="https://livestream.com/accounts/4878/events/2540723"
link="$( curl "https://livestream.com/accounts/4878/events/2540723"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="DayTraderRockStar Show New York City" ;;
# 865) NYXT Manhattan NYC New York USA
865)
#link="https://livestream.com/accounts/19770665/events/5522162"
link="$( curl "https://livestream.com/accounts/19770665/events/5522162"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="NYXT Manhattan NYC New York USA" ;;
# 866) Manhattan Neighborhood Network MNN-FSTV
866)
#link="https://livestream.com/accounts/17251237/events/6391580"
link="$( curl "https://livestream.com/accounts/17251237/events/6391580"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Manhattan Neighborhood Network MNN-FSTV" ;;

#######################Ohio###################### 
# 867)  Fox 8 Cleveland Ohio USA 
867)
#link="https://livestream.com/accounts/57501/live"
link="$( curl "https://livestream.com/accounts/57501/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Fox 8 Cleveland Ohio USA" ;;
# 868) WIVM TV39 WIVM Local TV Canton Ohio 
868)
#link="https://livestream.com/accounts/17488475/events/4802826"
link="$( curl "https://livestream.com/accounts/17488475/events/4802826"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WIVM TV39 WIVM Local TV Canton Ohio" ;;
# 869) WBNS 10 Columbus Ohio
869)
#link="https://livestream.com/accounts/18624165/live"
link="$( curl "https://livestream.com/accounts/18624165/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBNS 10 Columbus Ohio" ;;
# 870) WNYT NBC 13 Upper Sandusky, Ohio
870)
#link="https://livestream.com/accounts/12240447/live"
link="$( curl "https://livestream.com/accounts/12240447/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WNYT NBC 13 Upper Sandusky, Ohio" ;;
# 871) WBNS 10 Breaking News Radar Columbus, Ohio
871)
#link="https://livestream.com/accounts/26237278/events/8075621"
link="$( curl "https://livestream.com/accounts/26237278/events/8075621"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBNS 10 Breaking News Radar Columbus, Ohio " ;;
# 872) WBNS 10 Breaking News Columbus, Ohio
872)
#link="https://livestream.com/WBNSbreakingnews/live"
link="$( curl "https://livestream.com/WBNSbreakingnews/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBNS 10 Breaking News Columbus, Ohio " ;;
# 873) WOIO CBS 19 Clevland Ohio 
873)
#link="https://livestream.com/accounts/11017897/live"
link="$( curl "https://livestream.com/accounts/11017897/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WOIO CBS 19 Clevland Ohio" ;;
# 874) WTOL CBS 11 Toledo Ohio 
874)
#link="https://livestream.com/accounts/12003465/live"
link="$( curl "https://livestream.com/accounts/12003465/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTOL CBS 11 Toledo Ohio" ;;
# 875) WCMH NBC 4 Columbus Ohio
875)
#link="https://livestream.com/accounts/7338206/live"
link="$( curl "https://livestream.com/accounts/7338206/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WCMH NBC 4 Columbus Ohio" ;;

####################Pennsylvania#################  
# 876) WTXF FOX 29 News Philadelphia, Pennsylvania USA
876)
#link="https://livestream.com/accounts/6370754/live"
link="$( curl "https://livestream.com/accounts/6370754/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTXF FOX 29 News Philadelphia, Pennsylvania USA" ;;
# 877)WBRE NBC Wilkes Barre Pennslyvannia USA
877)
#link="https://livestream.com/accounts/21077947/live"
link="$( curl "https://livestream.com/accounts/21077947/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBRE NBC Wilkes Barre Pennslyvannia USA" ;;
# 878) WPHL TV ABC 6 Philladelphia Pennsylvania
878)
#link="https://livestream.com/accounts/25565610/live"
link="$( curl "https://livestream.com/accounts/25565610/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WPHL TV ABC 6 Philladelphia, Pennsylvania" ;;
# 879) WFMZ 69 Traffic Allen Town Penslyvania 
879)
#link="https://livestream.com/accounts/14384745/traffic"
link="$( curl "https://livestream.com/accounts/14384745/traffic" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFMZ 69 Traffic Allen Town Penslyvania " ;;
####################Rhode Island#################  
# 880) WPRI Fox 12 Providence Rhode Island 
880)
#link="https://livestream.com/accounts/1864876/live"
link="$( curl "https://livestream.com/accounts/1864876/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WPRI Fox 12 Providence Rhode Island" ;;

#####################Vermont#####################  

#####################Virginia####################  
# 881) WCYB NBC 5 Bristol Virginia VA
881)
#link="https://livestream.com/accounts/8522497/live"
link="$( curl "https://livestream.com/accounts/8522497/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WCYB NBC 5 Bristol Virginia VA" ;;
# 882) WRIC ABC 8 Petersburg, Virginia
882)
#link="https://livestream.com/accounts/7425298/live"
link="$( curl "https://livestream.com/accounts/7425298/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WRIC ABC 8 Petersburg, Virginia" ;;
# 883) WWBT NBC 12 Richmond Virginia 
883)
#link="https://livestream.com/accounts/11203782/live"
link="$( curl "https://livestream.com/accounts/11203782/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WWBT NBC 12 Richmond Virginia" ;;
####################West Virginia################  

###################New Hampshire#################  
# 884) Brunswick TV3 New Hampshire
884)
#link="https://livestream.com/accounts/13788599/events/6330198"
link="$( curl "https://livestream.com/accounts/13788599/events/6330198"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Brunswick TV3 New Hampshire" ;;
# 885) LRPATV CH25 New Hampshire USA
885)
#link="https://livestream.com/accounts/3480937/channel25"
link="$( curl "https://livestream.com/accounts/3480937/channel25"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="LRPATV CH25 New Hampshire USA" ;;

####################Michigan#####################
# 886) WJBK FOX 2 Detroit Michigan USA 
886)
#link="https://livestream.com/accounts/6396566/live"
link="$( curl "https://livestream.com/accounts/6396566/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WJBK FOX 2 Detroit Michigan USA" ;; 
# 887) WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan  
887)
#link="https://livestream.com/accounts/25637691/live"
link="$( curl "https://livestream.com/accounts/25637691/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan" ;;

#####################Indiana##################### 
# 888)  WFIE NBC 14 Evansville Indiana USA
888)
#link="https://livestream.com/accounts/11981465/live"
link="$( curl "https://livestream.com/accounts/11981465/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFIE NBC 14 Evansville Indiana USA" ;;
# 889) WANE Ft. Wayne Indiana
889)
#link="https://livestream.com/accounts/1849716/live"
link="$( curl "https://livestream.com/accounts/1849716/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WANE Ft. Wayne Indiana" ;;
# 890) WFFT FOX 55 Indiana USA
890)
#link="https://livestream.com/accounts/26511747/live"
link="$( curl "https://livestream.com/accounts/26511747/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFFT FOX 55 Indiana USA" ;;
# 891) WTHI 10 Terre Haute Indiana
891)
#link="https://livestream.com/accounts/1866274/live"
link="$( curl "https://livestream.com/accounts/1866274/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTHI 10 Terre Haute Indiana" ;;
# 892) WISH 8 Indianapolis Indiana USA
892)
#link="https://livestream.com/accounts/1858612/live"
link="$( curl "https://livestream.com/accounts/1858612/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WISH 8 Indianapolis Indiana USA" ;; 
####################Kentucky#####################
# 893) EKB- TV EKBTV Live Pikeville Kentucky 
893)
#link="https://livestream.com/accounts/6461963/events/4113877"
link="$( curl "https://livestream.com/accounts/6461963/events/4113877"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="EKB- TV EKBTV Live Pikeville Kentucky" ;;
# 894) WTVQ ABC 36 Lexington Kentucky USA
894)
#link="https://livestream.com/accounts/19871819/live"
link="$( curl "https://livestream.com/accounts/19871819/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTVQ ABC 36 Lexington Kentucky USA" ;;
# 895) WPSD-TV Paducah Kentucky 
895)
#link="https://livestream.com/accounts/21317942/live"
link="$( curl "https://livestream.com/accounts/21317942/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WPSD-TV Paducah Kentucky" ;;
# 896) Lex 18 Lexington Kentucky
896)
#link="https://livestream.com/accounts/1493287/live"
link="$( curl "https://livestream.com/accounts/1493287/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Lex 18 Lexington Kentucky" ;;
############################################################################  SOUTH EAST #########################

#####################Florida#####################  
# 897) WFLA NBC 8 Tampa Bay Florida USA
897)
#link="https://livestream.com/accounts/6140981/live"
link="$( curl "https://livestream.com/accounts/6140981/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFLA NBC 8 Tampa Bay Florida USA" ;;
# 898)  WTVT / FOX 13 Tampa Bay, Florida USA
898)
#link="https://livestream.com/accounts/6180769/live"
link="$( curl "https://livestream.com/accounts/6180769/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTVT / FOX 13 Tampa Bay, Florida USA" ;;
# 899) Island TV Live Broadcast Miami FL USA
899)
#link="https://livestream.com/accounts/1420/Islandtvlive"
link="$( curl "https://livestream.com/accounts/1420/Islandtvlive"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Island TV Live Broadcast Miami FL USA" ;;
# 900) City of Tampa Television FL, USA
900)
#link="https://livestream.com/accounts/12251681/CTTV"
link="$( curl "https://livestream.com/accounts/12251681/CTTV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="City of Tampa Television FL, USA" ;;
# 901) WFLX FOX 29 West Palm Beach, Florida,
901)
#link="https://livestream.com/accounts/12755354/live"
link="$( curl "https://livestream.com/accounts/12755354/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFLX FOX 29West Palm Beach, Florida, " ;;
# 902)  WYKE TV 47 Hormosassa Springs Florida
902)
#link="https://livestream.com/accounts/9261275/events/7602204"
link="$( curl "https://livestream.com/accounts/9261275/events/7602204"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WYKE TV 47 Hormosassa Springs Florida" ;;
#####################Georgia#####################  
# 903) WJBF Augusta Georgia 
903)
#link="https://livestream.com/accounts/7601347/live"
link="$( curl "https://livestream.com/accounts/7601347/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WJBF Augusta Georgia" ;;
# 904)WMGT 41 NBC Macon Georgia USA
904)
#link="https://livestream.com/accounts/15227391/live"
link="$( curl "https://livestream.com/accounts/15227391/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WMGT 41 NBC Macon Georgia USA" ;;
# 905) WSAV NBC 3 Savannah, Georgia
905)
#link="https://livestream.com/accounts/7682273/live"
link="$( curl "https://livestream.com/accounts/7682273/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WSAV NBC 3 Savannah, Georgia" ;;
# 906) WTOC 11 Savannah, Georgia
906)
#link="https://livestream.com/accounts/11006691/live"
link="$( curl "https://livestream.com/accounts/11006691/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTOC 11 Savannah, Georgia" ;;
# 907) WTVM ABC 9 Columbus Georgia 
907)
#link="https://livestream.com/accounts/11379799/live"
link="$( curl "https://livestream.com/accounts/11379799/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WTVM ABC 9 Columbus Georgia " ;;
# 908) WRBL News 365 CBS 3 Columbus, GA.  
908)
#link="https://livestream.com/accounts/7942874/live"
link="$( curl "https://livestream.com/accounts/7942874/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WRBL News 365 CBS 3 Columbus, GA" ;;
# 909) WGCL CBS46 Atlanta Georgia
909)
#link="https://livestream.com/accounts/6140931/live"
link="$( curl "https://livestream.com/accounts/6140931/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WGCL CBS46 Atlanta Georgia" ;;
# 910) WALB NBC 10 Albany Southwestern Georgia
910)
#link="https://livestream.com/accounts/11279058/live"
link="$( curl "https://livestream.com/accounts/11279058/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WALB NBC 10 Albany Southwestern Georgia" ;;
####################Mississippi##################  
# 911) WDAM 7 Hattiesburg Mississippi USA
911)
#link="https://livestream.com/accounts/11595552/live"
link="$( curl "https://livestream.com/accounts/11595552/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WDAM 7 Hattiesburg Mississippi USA" ;;
# 912) WLOX ABC 13  Mississippi USA
912)
#link="https://livestream.com/accounts/11595500/live"
link="$( curl "https://livestream.com/accounts/11595500/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WLOX ABC 13  Mississippi USA" ;;
# 913) WJTV CBS 12 Jackson Mississippi
913)
#link="https://livestream.com/accounts/8374496/live"
link="$( curl "https://livestream.com/accounts/8374496/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WJTV CBS 12 Jackson Mississippi" ;;
# 914) WLBT FOX 40 Jackson Mississippi 
914)
#link="https://livestream.com/accounts/11595602/live"
link="$( curl "https://livestream.com/accounts/11595602/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WLBT FOX 40 Jackson Mississippi" ;;
# 915) WHLT Hattiesburg, Mississippi USA 
915)
#link="https://livestream.com/accounts/8383566/live"
link="$( curl "https://livestream.com/accounts/8383566/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WHLT Hattiesburg, Mississippi USA" ;;
####################Alabama######################
# 916)  WSFA 12 Montgomory Alabama USA 
916)
#link="https://livestream.com/accounts/11981705/live"
link="$( curl "https://livestream.com/accounts/11981705/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WSFA 12 Montgomory Alabama USA" ;;
# 917)  WBRC FOX6 News Birmingham, Alabama USA
917)
#link="https://livestream.com/WBRC/live"
link="$( curl "https://livestream.com/WBRC/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBRC FOX6 News Birmingham, Alabama USA" ;;
# 918) WAKA CBS 8 ABC 32 Alabama
918)
#link="https://livestream.com/accounts/9486828/live"
link="$( curl "https://livestream.com/accounts/9486828/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WAKA CBS 8 ABC 32 Alabama " ;;
# 919) WAAY News ABC 31 Huntsville Alabama
919)
#link="https://livestream.com/accounts/26511741/live"
link="$( curl "https://livestream.com/accounts/26511741/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WAAY News ABC 31 Huntsville Alabama" ;;
# 920) CBS 42 Birmingham Alabama 
920)
#link="https://livestream.com/accounts/1848160/live"
link="$( curl "https://livestream.com/accounts/1848160/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CBS 42 Birmingham Alabama" ;;
# 921) WKRG CBS 5 Mobile, Alabama
921)
#link="https://livestream.com/accounts/7546695/live"
link="$( curl "https://livestream.com/accounts/7546695/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WKRG CBS 5 Mobile, Alabama" ;;
# 922) WALA FOX10 News 24/7 Mobile, Alabama
922)
#link="https://livestream.com/accounts/1859803/live"
link="$( curl "https://livestream.com/accounts/1859803/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WALA FOX10 News 24/7 Mobile, Alabama" ;;
# 923) WBRC FOX 6 Birmingham, Alabama
923)
#link="https://livestream.com/accounts/12446860/live"
link="$( curl "https://livestream.com/accounts/12446860/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBRC FOX 6 Birmingham, Alabama" ;;
# 924) OUBN - Oakwood University Huntsville Alabama  
924)
#link="https://livestream.com/accounts/5329025/events/7079597"
link="$( curl "https://livestream.com/accounts/5329025/events/7079597"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="OUBN - Oakwood University Huntsville Alabama " ;;

#####################North Carolina##############   
# 925) WJZY FOX 46 Charlotte NC
925)
#link="https://livestream.com/accounts/6370805/live"
link="$( curl "https://livestream.com/accounts/6370805/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WJZY FOX 46 Charlotte NC" ;;
# 926) WCCB Charlotte CW NC
926)
#link="https://livestream.com/accounts/8522553/live"
link="$( curl "https://livestream.com/accounts/8522553/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WCCB Charlotte CW NC" ;;
# 927) WYCW CW 62 Carolinas
927)
#link="https://livestream.com/accounts/8366412/live"
link="$( curl "https://livestream.com/accounts/8366412/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WYCW CW 62 Carolinas" ;;
# 928) WNCT CBS 9 Greenville NC
928)
#link="https://livestream.com/accounts/7601533/live"
link="$( curl "https://livestream.com/accounts/7601533/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WNCT CBS 9 Greenville NC" ;;
# 929) WCBD NBC 2 Charleston North Carolina 
929)
#link="https://livestream.com/accounts/8360295/live"
link="$( curl "https://livestream.com/accounts/8360295/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WCBD NBC 2 Charleston NC" ;;
# 930) WWAY News ABC CBS CW 3 Cape Fear Willmington NC 
930)
#link="https://livestream.com/accounts/26965546/live"
link="$( curl "https://livestream.com/accounts/26965546/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WWAY News ABC CBS CW 3 Cape Fear Willmington NC" ;;
# 931) WBTV CBS 3 Charlotte, North Carolina
931)
#link="https://livestream.com/accounts/10950088/live"
link="$( curl "https://livestream.com/accounts/10950088/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBTV CBS 3 Charlotte, North Carolina" ;;
# 932) CBS 17 Rahliegh NC
932)
#link="https://livestream.com/accounts/7158447/live"
link="$( curl "https://livestream.com/accounts/7158447/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CBS 17 Rahliegh NC" ;;
######################South Carolina#############
# 933) WCSC CBS 5 Charleston South Carolina USA
933)
#link="https://livestream.com/accounts/11016888/live"
link="$( curl "https://livestream.com/accounts/11016888/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WCSC CBS 5 Charleston South Carolina USA" ;;
# 934) WSPA CBS 7 WSPA Spartanberg SC
934)
#link="https://livestream.com/accounts/7592531/live"
link="$( curl "https://livestream.com/accounts/7592531/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WSPA CBS 7 WSPA Spartanberg SC" ;;
# 935)WMBF Myrtle Beach, South Carolina
935)
#link="https://livestream.com/accounts/11214123/live"
link="$( curl "https://livestream.com/accounts/11214123/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WMBF Myrtle Beach, South Carolina" ;;
# 936) WIS NBC 10 Columbia South Carolina 
936)
#link="https://livestream.com/accounts/11327981/live"
link="$( curl "https://livestream.com/accounts/11327981/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WIS NBC 10 Columbia South Carolina" ;;
####################Tennessee#################### 
# 937) WSMV NBC 4 Nashville Tennessee
937)
#link="https://livestream.com/accounts/6396556/LIVE"
link="$( curl "https://livestream.com/accounts/6396556/LIVE"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WSMV NBC 4 Nashville Tennessee" ;;
# 938)WBBJ ABC 7 West Tennesee 
938)
#link="https://livestream.com/accounts/27132443/live"
link="$( curl "https://livestream.com/accounts/27132443/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WBBJ ABC 7 West Tennesee" ;;
# 939) WDEF News CBS 12 Now Chattanooga Tennessee
939)
#link="https://livestream.com/accounts/21596942/live"
link="$( curl "https://livestream.com/accounts/21596942/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WDEF News CBS 12 Now Chattanooga Tennesse " ;;
# 940) WMC NBC 5 Memphis Tennessee 
940)
#link="https://livestream.com/accounts/10894063/live"
link="$( curl "https://livestream.com/accounts/10894063/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WMC NBC 5 Memphis Tennessee" ;;
# 941) Second Presbyterian Church Sunday Worship Memphis Tennessee 
941)
#link="https://livestream.com/accounts/15713152/sunday-worship"
link="$( curl "https://livestream.com/accounts/15713152/sunday-worship"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Second Presbyterian Church Sunday Worship Memphis Tennessee" ;;
# 942) ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse 
942)
#link="https://livestream.com/accounts/17402222/FineArts"
link="$( curl "https://livestream.com/accounts/17402222/FineArts"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse" ;;
# 943) EPlusTV6 Jackson Tennessee 
943)
#link="https://livestream.com/accounts/726212/events/4481510"
link="$( curl "https://livestream.com/accounts/726212/events/4481510"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="EPlusTV6 Jackson Tennessee" ;;
########################################################################### NORTH MIDDLE ########################

####################North Dakota##################  
# 944) KELO Live Keloland (Dakota, Minisota, Iowa) USA  
944)
#link="https://livestream.com/kelo/live"
link="$( curl "https://livestream.com/kelo/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KELO Live Keloland USA" ;;
# 945) KVRR Fargo North Dakota  
945)
#link="https://livestream.com/accounts/21298478/live"
link="$( curl "https://livestream.com/accounts/21298478/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVRR Fargo North Dakota" ;;
#####################South Dakota##################  
# 946) KDLT Sioux Falls South Dakota
946)
#link="https://livestream.com/accounts/21277277/live"
link="$( curl "https://livestream.com/accounts/21277277/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KDLT Sioux Falls South Dakota" ;;
# 947) GovTV Watertown, South Dakota
947)
#link="https://livestream.com/accounts/21042766/events/6254925"
link="$( curl "https://livestream.com/accounts/21042766/events/6254925"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="GovTV Watertown, South Dakota" ;;
# 948) KELO CBS Sioux Falls, South Dakota
948)
#link="https://livestream.com/accounts/8522446/live"
link="$( curl "https://livestream.com/accounts/8522446/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KELO CBS Sioux Falls, South Dakota" ;;
######################Iowa##########################
# 949) KIMT 3 Mason City, Iowa
949)
#link="https://livestream.com/accounts/1859647/live"
link="$( curl "https://livestream.com/accounts/1859647/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KIMT 3 Mason City, Iowa" ;;
####################Minnesota########################  
# 950) WDIO ABC 10/13 Duluth Minnesota
950)
#link="https://livestream.com/accounts/12241516/live"
link="$( curl "https://livestream.com/accounts/12241516/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WDIO  ABC 10/13 Duluth Minnesota" ;;
# 951) KAAL ABC 6 Rochester Minnesota
951)
#link="https://livestream.com/accounts/12240964/live"
link="$( curl "https://livestream.com/accounts/12240964/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KAAL ABC 6 Rochester Minnesota" ;;
# 952) KQDS - FOX 21 Duluth Minnesota USA 
952)
#link="https://livestream.com/accounts/21146230/live"
link="$( curl"https://livestream.com/accounts/21146230/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KQDS - FOX 21 Duluth Minnesota USA " ;;
# 953) KSTP ABC 5 St. Paul, Minnesota
953)
#link="https://livestream.com/accounts/12150160/live"
link="$( curl "https://livestream.com/accounts/12150160/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSTP ABC 5 St. Paul, Minnesota" ;;
# 954) KMSP FOX 9 Minneapolis Minnesota 
954)
#link="https://livestream.com/accounts/6396280/live"
link="$( curl "https://livestream.com/accounts/6396280/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KMSP FOX 9 Minneapolis Minnesota" ;;
# 955) St. Cloud Times UTVS Minnesota 
955)
#link="https://livestream.com/accounts/11549400/UTVS"
link="$( curl "https://livestream.com/accounts/11549400/UTVS"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="St. Cloud Times UTVS Minnesota " ;;
#####################Nebraska######################### 

#######################Wisconsin#####################  

# 956) WHLT 12 Whitehall, Wisconsin
956)
#link="https://livestream.com/accounts/8383566/live"
link="$( curl "https://livestream.com/accounts/8383566/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WHLT 12 Whitehall, Wisconsin" ;;

#########################Illinois#######################
# 957) WFLD / Fox 32 Chicago, Illinois USA
957)
#link="https://livestream.com/accounts/6370732/live"
link="$( curl "https://livestream.com/accounts/6370732/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago, Illinois USA" ;;
# 958) WAND NBC 17 Decatur Illinois
958)
#link="https://livestream.com/accounts/15004678/live"
link="$( curl "https://livestream.com/accounts/15004678/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WAND NBC 17 Decatur Illinois" ;;
# 959) WFLD Fox 32 Chicago IL
959)
#link="https://livestream.com/accounts/6370732/events/4249677"
link="$( curl "https://livestream.com/accounts/6370732/events/4249677"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago IL" ;;
##################################################################### SOUTH MIDDLE #########################

########################Texas##################### 
# 960)  KRIV FOX 26 News Houston Texas USA
960)
#link="https://livestream.com/accounts/6396012/live"
link="$( curl "https://livestream.com/accounts/6396012/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name=" KRIV FOX 26 News Houston, Texas, USA" ;;
# 961) KLTV ABC 7 Tyler TX USA
961)
#link="https://livestream.com/accounts/11816721/live"
link="$( curl "https://livestream.com/accounts/11816721/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KLTV ABC 7 Tyler TX USA" ;;
# 962) KTXS 12 ABC Abilene Texas 
962)
#link="https://livestream.com/accounts/9960439/live"
link="$( curl "https://livestream.com/accounts/9960439/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KTXS 12 ABC Abilene TX" ;;
# 963) KFDA CBS 10 Amarillo TX USA
963)
#link="https://livestream.com/accounts/17606146/live"
link="$( curl "https://livestream.com/accounts/17606146/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KFDA CBS 10 Amarillo TX USA" ;;
# 964) KZTV CBS 10 Corpus Christi TX USA 
964)
#link="https://livestream.com/accounts/16030806/live"
link="$( curl "https://livestream.com/accounts/16030806/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KZTV CBS 10 Corpus Christi TX USA" ;;
# 965) KFDX NBC 3 Witchita Falls Texas USA
965)
#link="https://livestream.com/accounts/21184359/live"
link="$( curl "https://livestream.com/accounts/21184359/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KFDX NBC 3 Witchita Falls, Texas USA" ;;
# 966) Galveston County Gulf Freeway Cams Tour Houston Texas USA 
966)
#link="https://livestream.com/accounts/21068106/events/6228235"
link="$( curl "https://livestream.com/accounts/21068106/events/6228235"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Galveston County Gulf Freeway Cams Tour Houston Texas USA" ;;
# 967) KAUZ CBS 6 Winters Texas 
967)
#link="https://livestream.com/accounts/16991125/live"
link="$( curl "https://livestream.com/accounts/16991125/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KAUZ CBS 6 Winters Texas" ;;
# 968) KXXV ABC 25 Waco Texas 
968)
#link="https://livestream.com/accounts/16936343/live"
link="$( curl "https://livestream.com/accounts/16936343/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KXXV ABC 25 Waco Texas" ;;
# 969) KVIA ABC-7 El Paso Texas 
969)
#link="https://livestream.com/accounts/18241891/live"
link="$( curl "https://livestream.com/accounts/18241891/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVIA ABC-7 El Paso Texas" ;;
# 970)  KCBD NBC 11 Lubbock, Texas
970)
#link="https://livestream.com/accounts/11816946/live"
link="$( curl "https://livestream.com/accounts/11816946/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KCBD NBC 11 Lubbock, Texas" ;;
# 971) Lex & Terry Lufkin Texas 
971)
#link="https://livestream.com/accounts/16950775/live"
link="$( curl "https://livestream.com/accounts/16950775/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Lex & Terry Lufkin Texas" ;;
# 972) KSWO ABC 7 Winters Texas 
972)
#link="https://livestream.com/accounts/16991045/live"
link="$( curl "https://livestream.com/accounts/16991045/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSWO ABC 7 Winters Texas" ;;

# 973) ------

# 974) ESPN 97.5 Houston Texas 
974)
#link="https://livestream.com/accounts/26800104/live"
link="$( curl "https://livestream.com/accounts/26800104/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ESPN 97.5 Houston Texas" ;;
# 975) Granbury Media Granbury, TX Tower Camera Live Stream 
975)
#link="https://livestream.com/accounts/13120617/TowerCamera"
link="$( curl "https://livestream.com/accounts/13120617/TowerCamera"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Granbury Media Granbury, TX Tower Camera Live Stream" ;;
# 976) KCOH TV Houston Texas 
976)
#link="https://livestream.com/accounts/12299560/events/3892224"
link="$( curl "https://livestream.com/accounts/12299560/events/3892224"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KCOH TV Houston Texas" ;;
# 977)KXAN NBC Austin Texas
977)
#link="https://livestream.com/accounts/1506296/live"
link="$( curl "https://livestream.com/accounts/1506296/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KXAN NBC Austin Texas" ;;

#######################Louisiana###################
# 978)  KSLA News 12 Shreveport Louisiana USA 
978)
#link="https://livestream.com/KSLA/live"
link="$( curl "https://livestream.com/KSLA/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSLA News 12 Shreveport Louisianna USA  " ;;
# 979) WAFB 9 CBS Baton Rouge Louisiana USA
979)
#link="https://livestream.com/accounts/11595706/live"
link="$( curl "https://livestream.com/accounts/11595706/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WAFB 9 CBS Baton Rouge Louisiana USA" ;;
# 980) WVUE FOX 8 New Orleans LA USA
980)
#link="https://livestream.com/accounts/10891792/live"
link="$( curl "https://livestream.com/accounts/10891792/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WVUE FOX 8 New Orleans LA USA" ;;
# 981) KLFY News 10 Acadiana Lafayette, Louisiana
981)
#link="https://livestream.com/accounts/7520488/live"
link="$( curl "https://livestream.com/accounts/7520488/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KLFY News 10 Acadiana Lafayette, Louisiana" ;;
# 982) WDFL 18 South Carolina, Alabama, Louisiana 
982)
#link="https://livestream.com/accounts/26473976/events/7937669"
link="$( curl "https://livestream.com/accounts/26473976/events/7937669"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WDFL 18 South Carolina, Alabama, Louisiana" ;;
# 983) KSLA News CBS 12 Shreveport, Louisiana
983)
#link="https://livestream.com/accounts/11816591/live"
link="$( curl "https://livestream.com/accounts/11816591/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSLA News CBS 12 Shreveport, Louisiana" ;;
# 984) HTV10 Houma Louisiana 
984)
#link="https://livestream.com/accounts/1362675/events/3147474"
link="$( curl "https://livestream.com/accounts/1362675/events/3147474"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="HTV10 Houma Louisiana" ;;
# 985) KPLC NBC 7 Lake Charles Louisiana  
985)
#link="https://livestream.com/accounts/11595658/live"
link="$( curl "https://livestream.com/accounts/11595658/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KPLC NBC 7 Lake Charles Louisiana" ;;
# 986) KATC Lafayette ABC 3 Louisiana 
986)
#link="https://livestream.com/accounts/15228189/live"
link="$( curl "https://livestream.com/accounts/15228189/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KATC Lafayette ABC 3 Louisiana" ;;

#####################Arkansas######################### 
# 987)HU16 Harding Sercy Arkansas  USA
987)
#link="https://livestream.com/accounts/8522446/live"
link="$( curl "https://livestream.com/accounts/8522446/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="HU16 Harding Sercy Arkansas  USA" ;;
######################Kansas#########################
# 988) KSNT Weather Wichita Kansas
988)
#link="https://livestream.com/accounts/1866369/live"
link="$( curl "https://livestream.com/accounts/1866369/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSNT Weather Wichita Kansas" ;;
# 989) WPS-TV Wichita Public Schools Kansas
989)
#link="https://livestream.com/accounts/12013978/events/3835724"
link="$( curl "https://livestream.com/accounts/12013978/events/3835724"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WPS-TV Wichita Public Schools, Kansas" ;;
# 990) KSNW NBC 3 Witchita Kansas
990)
#link="https://livestream.com/accounts/1866980/live"
link="$( curl "https://livestream.com/accounts/1866980/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSNW NBC 3 Witchita Kansas" ;;
#####################Oklahoma#########################  
# 991) KSNT Kansas OK USA
991)
#link="https://livestream.com/accounts/1866369/live"
link="$( curl "https://livestream.com/accounts/1866369/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KSNT Kansas OK USA" ;;
# 992) Enid Television Network Oklahoma
992)
#link="https://livestream.com/accounts/13638122/events/4063586"
link="$( curl "https://livestream.com/accounts/13638122/events/4063586"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Enid Television Network Oklahoma" ;;
####################Missouri###########################
# 993) KMOV CBS 4 St. Louis Missouri MO USA
993)
#link="https://livestream.com/accounts/12654794/live"
link="$( curl "https://livestream.com/accounts/12654794/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KMOV CBS 4 St. Louis Missouri MO USA" ;;
# 994) KMIZ ABC 17 Missouri
994)
#link="https://livestream.com/accounts/18240993/live"
link="$( curl "https://livestream.com/accounts/18240993/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KMIZ ABC 17 Missouri" ;;
# 995) Polk County Channel 44 Bolivar Missouri USA
995)
#link="https://livestream.com/accounts/15079831/Channel44"
link="$( curl "https://livestream.com/accounts/15079831/Channel44"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Polk County Channel 44 Bolivar Missouri USA" ;;
# 996) KOLR CBS 10 Springfield Missouri
996)
#link="https://livestream.com/accounts/21145355/live"
link="$( curl "https://livestream.com/accounts/21145355/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KOLR CBS 10 Springfield Missouri" ;;
# 997) Branson Visitor TV Branson Misouri 
997)
#link="https://livestream.com/accounts/21384612/BVTV"
link="$( curl "https://livestream.com/accounts/21384612/BVTV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Branson Visitor TV Branson Misouri" ;;
# 998) EUTV - Evangel University EUTV Channel Live Springfield Missouri
998)
#link="https://livestream.com/accounts/10735484/events/3837393"
link="$( curl "https://livestream.com/accounts/10735484/events/3837393"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name=" EUTV Evangelical University, Springfield Missouri" ;;
# 999) KY3 Springfield Missouri 
999)
#link="https://livestream.com/accounts/4699618/live"
link="$( curl "https://livestream.com/accounts/4699618/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KY3 Springfield Missouri" ;;
# 1000) KQTV 2 St. Joseph, Missouri
1000)
#link="https://livestream.com/accounts/26511737/live"
link="$( curl "https://livestream.com/accounts/26511737/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KQTV 2 St. Joseph, Missouri" ;;
# 1001) News-Press NOW Fox 26 KNPN Saint Joseph Missouri 
1001)
#link="https://livestream.com/accounts/18241682/live"
link="$( curl "https://livestream.com/accounts/18241682/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="News-Press NOW Fox 26 KNPN Saint Joseph Missouri" ;;
# 1002) KCTV CBS 5 Kansas City Missouri  
1002)
#link="https://livestream.com/accounts/6370696/live"
link="$( curl "https://livestream.com/accounts/6370696/live" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KCTV CBS 5 Kansas City Missouri" ;;

######################################################################## TERITORIES #########################

###################Hawaii########################## 
# 1003) KHNL Honolulu Hawaii News Now
1003)
#link="https://livestream.com/accounts/12139043/live"
link="$( curl "https://livestream.com/accounts/12139043/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KHNL Honolulu Hawaii News Now" ;;
# 1004) ThinkTech Hawaii Honolulu USA
1004)
#link="https://livestream.com/accounts/12650986/events/3950350"
link="$( curl "https://livestream.com/accounts/12650986/events/3950350"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ThinkTech Hawaii Honolulu USA" ;; 
# 1005) KFVE 9 Honolulu Hawaii
1005)
#link="https://livestream.com/accounts/14598737/live"
link="$( curl "https://livestream.com/accounts/14598737/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KFVE Honolulu Hawaii" ;; 
# 1006) KHON CBS 2 Ala Mona Honolulu Hawaii 
1006)
#link="https://livestream.com/accounts/1858266/live"
link="$( curl "https://livestream.com/accounts/1858266/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KHON CBS 2 Ala Mona Honolulu Hawaii " ;;
####################Alaska##########################

#################### Amerrican Samoa ########################
# 1007) KVZK TV CHANNEL 2 American Samoa 
1007)
#link="https://livestream.com/accounts/8956070/events/4561731"
link="$( curl "https://livestream.com/accounts/8956070/events/4561731"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="KVZK TV CHANNEL 2 American Samoa" ;;
########## Guam ##################
# 1008) PNC News First Newstalk K57 Fox 6 Guam 
1008)
#link="https://livestream.com/accounts/10612724/newstalk57"
link="$( curl "https://livestream.com/accounts/10612724/newstalk57"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="PNC News First Newstalk K57 Fox 6 Guam " ;;
##################################################################################################


###################### UN SORTED USA ###################################################################
# 1009)  Joe Pags Show
1009)
#link="https://livestream.com/accounts/26896512/events/8077273"
link="$( curl "https://livestream.com/accounts/26896512/events/8077273"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Joe Pags Show" ;;
# 1010) CGTN America Live
1010)
#link="https://livestream.com/accounts/7082210/livenews"
link="$( curl "https://livestream.com/accounts/7082210/livenews"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CGTN America Live" ;;
# 1011) BlabTV
1011)
#link="https://livestream.com/accounts/22779635/events/7675406"
link="$( curl "https://livestream.com/accounts/22779635/events/7675406"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="BlabTV" ;;
# 1012) Mike Malloy Show
1012)
#link="https://livestream.com/accounts/8522627/live"
link="$( curl "https://livestream.com/accounts/8522627/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Mike Malloy Show" ;;
# 1013) Nasdaq Bell Ceremonies New York City 
1013)
#link="https://livestream.com/accounts/888332/live"
link="$( curl "https://livestream.com/accounts/888332/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Nasdaq Bell Ceremonies New York City" ;;
# 1014)Westerville.TV 543 Production Studio 
1014)
#link="https://livestream.com/accounts/26666947/events/8163419"
link="$( curl "https://livestream.com/accounts/26666947/events/8163419"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Westerville.TV 543 Production Studio " ;;

###################### Municipal ##################################################
# 1015) Kingdom Access Television Channel 192 LIVE
1015)
#link="https://livestream.com/accounts/4209066/events/8159063"
link="$( curl "https://livestream.com/accounts/4209066/events/8159063"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Kingdom Access Television Channel 192 LIVE" ;;
# 1016) Plaistow Access New Hampshire
1016)
#link="https://livestream.com/accounts/11298895/meetings"
link="$( curl "https://livestream.com/accounts/11298895/meetings"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Plaistow Access New Hampshire" ;;
# 1017) City of Topeka City Kansas
1017)
#link="https://livestream.com/accounts/25008807/events/7970645"
link="$( curl "https://livestream.com/accounts/25008807/events/7970645"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="City of Topeka City Kansas" ;;
# 1018) Shelby County Schools C19TV & 88.5FM Memphis Tennessee 
1018)
#link="https://livestream.com/accounts/25133520/c19tv"
link="$( curl "https://livestream.com/accounts/25133520/c19tv"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shelby County Schools C19TV & 88.5FM Memphis Tennessee " ;;
# 1019) Provincetown Community TV Provincetown Government Meetings  Provincetown, Massachusetts
1019)
#link="https://livestream.com/accounts/6011038/events/6712043"
link="$( curl "https://livestream.com/accounts/6011038/events/6712043"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Provincetown Community TV, Massachusetts" ;;
# 1020) Bermuda Government (CITV) Hamilton, Bermuda 
1020)
#link="https://livestream.com/accounts/19270406/events/5372984"
link="$( curl "https://livestream.com/accounts/19270406/events/5372984"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Bermuda Government (CITV) Hamilton, Bermuda " ;;
#################################### RELIGIOUS / FAITH #################################################
# 1021) Shalom Media Catholic KIDS
1021)
#link="https://livestream.com/shalomworld/events/7987357"
link="$( curl "https://livestream.com/shalomworld/events/7987357"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Shalom Media Catholic KIDS" ;;
# 1022) Faith Lutheran Church - Penfield, NY
1022)
#link="https://livestream.com/accounts/4440983/events/6827954"
link="$( curl "https://livestream.com/accounts/4440983/events/6827954" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Faith Lutheran Church - Penfield, NY" ;;
# 1023) Whole Life Ministries SKMNetwork Augusta Georgia
1023)
#link="https://livestream.com/accounts/16502349/SKMNetwork"
link="$( curl "https://livestream.com/accounts/16502349/SKMNetwork"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Whole Life Ministries SKMNetwork Augusta Georgia" ;;
# 1024) St. Catharine Church, Spring Lake, New Jersey 
1024)
#link="https://livestream.com/accounts/11714562/events/3786245"
link="$( curl "https://livestream.com/accounts/11714562/events/3786245"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="St. Catharine Church, Spring Lake, New Jersey " ;;
# 1025) Glory to God Ministries International Love of God Classics 
1025)
#link="https://livestream.com/accounts/3240767/events/8008064"
link="$( curl "https://livestream.com/accounts/3240767/events/8008064"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Glory to God Ministries" ;;
# 1026) St. Helena Chapel
1026)
#link="https://livestream.com/accounts/25372681/events/7581060"
link="$( curl "https://livestream.com/accounts/25372681/events/7581060"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="St. Helena Chapel" ;;
# 1027) St Patrick's Dumbarton
1027)
#link="https://livestream.com/accounts/10499782/events/7601596"
link="$( curl "https://livestream.com/accounts/10499782/events/7601596"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="St Patrick's Dumbarton" ;;
# 1028) VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas
1028)
#link="https://livestream.com/accounts/15669040/events/4554297"
link="$( curl "https://livestream.com/accounts/15669040/events/4554297"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas" ;;
# 1029) TMN WORD TV Into All the Earth 24/7/365
1029)
#link="https://livestream.com/accounts/16242586/TMN"
link="$( curl "https://livestream.com/accounts/16242586/TMN"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TMN WORD TV Into All the Earth 24/7/365" ;;
# 1030) Parkside Radio Show / BROOKLYNSTATION.COM
1030)
#link="https://livestream.com/knqradio/events/8191094"
link="$( curl "https://livestream.com/knqradio/events/8191094"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Parkside Radio Show / BROOKLYNSTATION.COM" ;;
# 1031) FGTV Frequencies of Glory LIVE Jacksonville Florida 
1031)
#link="https://livestream.com/accounts/3107466/events/3858711"
link="$( curl "https://livestream.com/accounts/3107466/events/3858711"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="FGTV Frequencies of Glory LIVE Jacksonville Florida" ;;
# 1032) HJTV online Healing Jesus TV London England 
1032)
#link="https://livestream.com/accounts/15754877/events/4470314"
link="$( curl "https://livestream.com/accounts/15754877/events/4470314"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="HJTV online Healing Jesus TV London England" ;;
# 1033) Apocalypse Channel APTV Live Polaski Tennessse 
1033)
#link="https://livestream.com/accounts/5057242/events/4312291"
link="$( curl "https://livestream.com/accounts/5057242/events/4312291"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Apocalypse Channel APTV Live Polaski Tennessse" ;;
# 1034) Marytown Chapel Marytown Online Adoration Chapel Illinois
1034)
#link="https://livestream.com/accounts/15529184/events/4408765"
link="$( curl "https://livestream.com/accounts/15529184/events/4408765"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Marytown Chapel Illinois" ;;
# 1035) Guaranty Media Baton Rouge Louisiana 
1035)
#link="https://livestream.com/accounts/25649901/live"
link="$( curl "https://livestream.com/accounts/25649901/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Guaranty Media Baton Rouge Louisiana" ;;
# 1036) Pro Football Hall of Fame Hall of Fame Channel Stream
1036)
#link="https://livestream.com/accounts/24957552/events/8006439"
link="$( curl "https://livestream.com/accounts/24957552/events/8006439"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Pro Football Hall of Fame" ;;
# 1037) Lance Hope RSL FEED
1037)
#link="https://livestream.com/accounts/22999173/events/8078810"
link="$( curl "https://livestream.com/accounts/22999173/events/8078810"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Lance Hope RSL FEED" ;;
# 1038)XBTV Rosecroft Raceway Live Maryland 
1038)
#link="https://livestream.com/accounts/9869799/events/6772185"
link="$( curl "https://livestream.com/accounts/9869799/events/6772185"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="XBTV Rosecroft Raceway Live Maryland" ;;
# 1039) Park City Television PCTV Livestream Utah 
1039)
#link="https://livestream.com/accounts/11728043/events/3779731"
link="$( curl "https://livestream.com/accounts/11728043/events/3779731"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Park City Television PCTV Livestream Utah" ;;
# 1040) AAA Guayama
1040)
#link="https://livestream.com/accounts/3185486/guayama"
link="$( curl "https://livestream.com/accounts/3185486/guayama"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="AAA Guayama" ;;
# 1041) AWCATV - Education/Government Channel Ashburnham 
1041)
#link="https://livestream.com/accounts/22393363/events/6651528"
link="$( curl "https://livestream.com/accounts/22393363/events/6651528"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="AWCATV - Education/Government Channel Ashburnham " ;;
# 1042)FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA
1042)
#link="https://livestream.com/accounts/11135493/events/5339279"
link="$( curl "https://livestream.com/accounts/11135493/events/5339279"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA" ;;
# 1043) Essex County College Newark New Jersey 
1043)
#link="https://livestream.com/accounts/5109696/events/7607762"
link="$( curl "https://livestream.com/accounts/5109696/events/7607762"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Essex County College Newark New Jersey" ;;
# 1044) CNPTV Live Caribbean Television.
1044)
#link="https://livestream.com/accounts/22462981/Live"
link="$( curl "https://livestream.com/accounts/22462981/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="CNPTV Live Caribbean Television." ;;
# 1045)  LOBO STATION
1045)
#link="https://livestream.com/accounts/14558256/events/7412168"
link="$( curl "https://livestream.com/accounts/14558256/events/7412168"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="LOBO STATION" ;;
# 1046) Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona
1046)
#link="https://livestream.com/accounts/24714287/Live"
link="$( curl "https://livestream.com/accounts/24714287/Live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona" ;;
# 1047) WLTH AM 1370 Radio
1047)
#link="https://livestream.com/accounts/26670176/events/8011646"
link="$( curl "https://livestream.com/accounts/26670176/events/8011646"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="WLTH AM 1370 Radio" ;;
# 1048) Lake Tahoe TV California
1048)
#link="https://livestream.com/accounts/21822229/events/6450069"
link="$( curl "https://livestream.com/accounts/21822229/events/6450069"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Lake Tahoe TV California" ;;
# 1049) Florida Gaming Sorteo
1049)
#link="https://livestream.com/accounts/25552923/events/7909255"
link="$( curl "https://livestream.com/accounts/25552923/events/7909255"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Florida Gaming Sorteo" ;;
# 1050) Kidd Kraddick Morning Show 
1050)
#link="https://livestream.com/accounts/16936513/live"
link="$( curl "https://livestream.com/accounts/16936513/live"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Kidd Kraddick Morning Show " ;;
# 1051) Rover's Morning Glory RMG-TV Cleavland Ohio
1051)
#link="https://livestream.com/accounts/242049/events/1978582"
link="$( curl "https://livestream.com/accounts/242049/events/1978582"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Rover's Morning Glory RMG-TV Cleavland Ohio" ;;
# 1052) ICOinvestor.tv USA
1052)
#link="https://livestream.com/accounts/26548600/events/8201689"
link="$( curl link="https://livestream.com/accounts/26548600/events/8201689"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="ICOinvestor.tv USA" ;;
# 1053) Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy 
1053)
#link="https://livestream.com/accounts/25077919/diretta"
link="$( curl "https://livestream.com/accounts/25077919/diretta"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy " ;;

############################### DAILY MOTION OVERFLOW   ######################################
# 1054) Bengu Turk TK 
1054)
link="https://www.dailymotion.com/video/x6ikc4m"
use_cookies="no"
chan_name="Bengu Turk TK" ;;
# 1055) i24 News Israel
1055) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-4.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-3.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-2.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-1.m3u8
#format=hls-1080
#format=hls-720
#format=hls-480 
#format=hls-380 
#format=hls-240
use_cookies="no"
chan_name="i24 News Israel English" ;;


################### MENU 5 ########################################
###############    SPACE       ######################### 
# 1361) NASA ISS 1
1361) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
################## LOCATIONS #############################    
# 1362) Venice Italy Bridge Cam Live
1362) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 1363) Jackson Hole Town Square
1363) 
keyword="Square"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEpDjqeFIGTqHwk-uULx72Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 1364) Jackson Hole Rustic Inn
1364) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 1365) Aosta Sarre Italy
1365)
keyword="Aosta Sarre Italy"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/camillimarco/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Aosta Sarre Italy" ;;
# 1366) Buenos Aires Four Seasons
1366)
keyword="Buenos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCkRwmztPEvut3gpsgmCmzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Buenos Aires Four Seasons" ;;
# 1367) Netherlands Amsterdam
1367) 
keyword="amsterdam"
link=http://www.amsterdam-dam.com/webcam.html
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;; 
# 1368) Shibua Japan Community Crosswalk 
1368) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 1369) Akiba Japan Live
1369) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 1370) Yahoo Weather Japan
1370) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 1371) Yahoo Weather Steamy Mountains
1371)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 1372) Naman Seoul Tower South Korea  
1372) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 
# 1373) Shizuoka Bridge Japan
1373) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 1374) Yokohama Port Japan
856) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 1375) Hokkido Weather Cams
1375) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 1376) Mount Fuji Japan
1376) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 1377) Netherlands Hart Beach
1377) 
keyword="hartbeach"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Hart Beach Netherlands" ;; 
# 1378)  Port du Quebec
1378) 
keyword="Port"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/portqc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Port du Quebec" ;; 
# 1379) Durango Colorado USA
1379) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 1380)Star Dot Cam 1
1380) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;  
# 1381) Youing Japan Route 10
1381) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 1382) Star Dot Cam 4
1382) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 1383) Star Dot Cam 5
1383) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 1384) Star Dot Cam 6
1384) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 1385) Fine Cine London 1
1385) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 1386) Fine Cine London 2
1386) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 1387) Fine Cine London 3
1387) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 1388) Berlin Airport 
1388) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 1389) Port of Los Angeles  
1389) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 1390)  ITS COM STUDIO Japan  
1390) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 1391)  China Shoreline 
1391) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;;

esac
}

dump_channels()
{
channel_counter=1
while [ "$channel_counter" -lt 1400 ]
do
 channel_select "$channel_counter"
 echo "Channel #"$channel_counter" "$chan_name""
 sleep 1  
 ## pipe this into more once the channel link get is supressed
 channel_counter=$( expr "$channel_counter" + 1 )
done
}


cmat_ng()
{
clear
echo "========================================="$product"  "$version"  ========================================================"
echo "||  ENGLISH  ||  ENGLISHII  ||  FRANCAIS  ||   ESPANOL   ||   E.EUROPE   ||   S.EUROPE   ||   ARABIC   ||"
echo "================================================================================================================" 
  
channel_counter=1
while [ "$channel_counter" -lt 41 ]
do
 channel_select "$channel_counter"
 Column1=""$channel_counter") "$TAG""
 channel_select $( expr "$channel_counter" + 40 )
 Column2=""$( expr "$channel_counter" + 40 )")"$TAG""
 channel_select $( expr "$channel_counter" + 80 )
 Column3=""$( expr "$channel_counter" + 80 )")"$TAG""
 channel_select $( expr "$channel_counter" + 120 )
 Column4=""$( expr "$channel_counter" + 120 )")"$TAG""
 channel_select $( expr "$channel_counter" + 160 )
 Column5=""$( expr "$channel_counter" + 160 )")"$TAG""
 channel_select $( expr "$channel_counter" + 200 )
 Column6=""$( expr "$channel_counter" + 200 )")"$TAG""
 channel_select $( expr "$channel_counter" + 200 )
 Column7=""$( expr "$channel_counter" + 240 )")"$TAG""
 echo ""$Column1" "$Column2" "$Column3" "$Column4" "$Column5" "$Column6" "$Column7" "
 ## pipe this into more once the channel link get is supressed
 channel_counter=$( expr "$channel_counter" + 1 )
done
}

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
elif [ "$input" = "n" ]
then 
menstat="yes"
menu="n"
elif [ "$input" = "m" ]
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
elif [ "$input" = "--" ]
then
menstat="no"
chan_state="-"
elif [ "$input" -lt 1401 ]
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
q) echo "Type endtv to restart program. Bye."
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
men_num=$(expr "$men_num" % 5)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + or ] to increment, - or [ to decrement, m for the main menu, n for the next menu, or q to quit:" ;;
esac
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

################################# Function to select the user agent
select_agent()
{
if [ "$uamode" = "on" ]
 then
   if [ "$uastate" = "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$uastate" = "ranstr" ]
   then 
     # make a random string as the user agent 
     bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')" 
   elif [ "$uastate" = "tor" ] 
   then
     UA="$UA_torbrowser" 
   elif [ "$uastate" = "row1" ] 
   then
     UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
     UA=""
   fi 
 fi
}


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
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link"  
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link"  
    else
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" = "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link"  
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link"  
    else
    mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
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

### Some more commands to add 
# mpv --http-header-fields='Field1: value1','Field2: value2' 
# --tls-verify
# --referrer=<string>
# --cache-secs=<seconds>
# --cache-file-size=<kBytes>
# --cache-pause  --cache=<kBytes|yes|no|auto>
# https://mpv.io/manual/master/
################################################ MAIN PROGRAM #####################################################################


######################### Deal with shell arguments ################################################
for arg in $@
do 
 if [ "$arg" = "--help" ]
 then
   echo "ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl and mpv"
   echo "Type in the terminal $ endstream "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endstream --help         # usage messages"
   echo "$ endstream --version      # print version information"
   echo "$ endstream --list-matrix  # channel list in matrix format"
   echo "$ endstream --list-all     # channel list in column format"
   echo "$ endstream --ua-tor       # use tor-browser user-agent"
   echo "$ endstream --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endstream --ua-ranstr    # use a random string as the user agent"
   echo "$ endstream  55            # use channel number in command line"  
   echo "$ endstream  "
   shift
   exit 0
   elif [ "$arg" = "--version" ]
   then
   echo "ENDSTREAM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" = "--list-matrix" ]
   then
   clear
   channel_matrix_0
   sleep 2
   clear
   channel_matrix_1
   sleep 2
   clear
   channel_matrix_2
   sleep 2
   clear
   channel_matrix_3
   sleep 2
   clear
   channel_matrix_4
   exit 0
   elif [ "$arg" = "--list-all" ]
   then
   # more "$chan_columns"
   getlink=0
   dump_channels
   exit 0
   elif [ "$arg" = "--testmat" ]
   then
   getlink=0
   cmat_ng
   exit 0
   elif [ "$arg" = "--ua-rand" ]
   then
   uastate="rand"
   uamode="on"
   shift
   elif [ "$arg" = "--ua-ranstr" ]
   then
   uastate="ranstr"
   uamode="on"
   shift
   elif [ "$arg" = "--ua-tor" ]
   then
   uastate="tor"
   uamode="on"
   shift
   elif [ "$arg" = "--ua-row1" ]
   then
   uastate="row1"
   uamode="on"
   shift
   elif [ "$arg" = "--no-agent" ]
   then
   uamode="off"
   shift 
   elif [ "$arg" = "--no-header" ]
   then
   headmode="off"
   shift   
 fi
done

########################################### FIRST RUN  ####################################################################
clear

## select the user agent
select_agent

# initialize menu and channels
menu="s"
men_num=0
entry=1
num=1
format="best"

running=1

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

### DECIDE WHAT THE USER INPUT IS
menu_status $entry

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

### Select the channel number to play
set_channel $chan_state
### Play the media stream
play_channel

## return to base level
format=""
method=""

############################# MENU LOOP  #######################################################3
## While loop to keep menu up after each stream
while [ "$entry" != q ]
do
  ## select the user agent
  select_agent
  ### Check the user input and decide what it is
  menu_status $entry
  ### Set the channel number 
  set_channel "$chan_state"
  #### Call function to play the channel
  play_channel
done
############################## END OF MENU LOOP #################################################

echo "Type endstream to open a new stream."

### Remove any existing cookies
if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

############################################     END OF PROGRAM      ############################################################