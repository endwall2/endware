#! /bin/bash
######################################################################
# Title: endstream_deb.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team, 
# All Rights Reserved
# Creation Date: February 22, 2017
# Version: 0.622
# Revision Date: July 21, 2018
#
# Recent Changes: - Use shell functions to reduce redundancy
#####################################################################
# Dependencies: youtube-dl, mpv, read , firejail, curl, streamlink
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
version="0.622"
rev_date="22/07/2018"
branch="gnu/linux"
product="ENDSTREAM"
##################################################
temp_pl="$HOME/tmp/master.m3u8"
USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="100000"
cache_secs="20"
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

socks_ip=127.0.0.1
socks_port=9050

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{ 
   echo "============================================================    "$product"  "$version"   =========================================================================="
   echo "||     ENGLISH      ||   ENGLISH EXTRA   ||     FRANCAIS      ||      ESPANOL     ||   NORTH EUROPE    ||     SOUTH EUROPE/TURK      ||   ARABIC/FARSI/Pashtun/||"
   echo "=============================================================================================================================================================" 
   echo "1)SKY News London UK 41)Made in Leeds     81)France 24 FR      121)RT Espanol       161)WDR DE            201)RSI CH                    241)RT Arabic"    
   echo "2)RT UK              42)Made in Tyne      82)BFM TV FR         122)DW Espanol       162)DW Deutsch        202)SkyTG 24 IT               242)France 24 Arabic" 
   echo "3)France 24 English  43)Made in Cardiff   83)BFM Business FR   123)CGTN Espanol     163)ZDK InfoKanal     203)Telecolor Lombardia IT    243)BBC Arabic"
   echo "4)DW English         44)BBC News London UK84)RT France         124)France24 Espanol 164)Tagesschau/MOMA DE204)Teletutto Brescia IT      244)DW Arabic"             
   echo "5)Russia Today       45)BBC Parliament UK 85)France Info TV    125)Euronews ES      165)Euronews DE       205)QVC Italian               245)CGTN Arabic"  
   echo "6)CBSN USA           46)CNN PH            86)TV5 Monde FR      126)Hispan TV IR     166)QVC DE            206)Italia channel            246)Al Jazeera QA"  
   echo "7)MSNBC USA          47)CNN Live USA      87)CGTN Francais     127)Magala TV ES     167)ADR Alpha DE      207)Mediaon BergamoTV IT      247)Al Jazeera Doc QA"
   echo "8)Bloomberg USA      48)Fox News          88)Euronews FR       128)Guada TV ES      168)Radio 21 DE       208)News24.city Milan IT      248)Saudi Green"
   echo "9)RT America         49)Fox News Talk     89)Africa News       129)GRANADA TV ES    169)DW Deutsch + DE   209)Radio TV Rome IT          249)Saudi Blue"
   echo "10)Newsy USA         50)Infowars RealNews 90)TVA CA            130)C5N AR           170)W24 Wein AT       210)Udinews TV Udine IT       250)Saudi Red"
   echo "11)ABC News USA      51)Infowars WarRoom  91)RTS UN CH         131)AcequiaMendozaAR 171)Tirol TV AT       211)DiTV Canale 89 Lucchese IT251)Saudi Orange"
   echo "12)TRT World TK      52)Infowars Event    92)France 2          132)Todo Noticias AR 172)Auftanken AT      212)RTM Arcevia IT            252)Saudi Gold "
   echo "13)Al Jazeera        53)RTE News NOW IE   93)France 3          133)La Nacion AR     173)SRF CH CH         213)50NewsVersiliaViareggio IT253)Saudi Silver"
   echo "14)India Today       54)Press TV Iran     94)ARTE Francais     134)TV5 AR           174)Musig24 TV CH     214)50 Canale Pisa IT         254)Saudi Kids"
   echo "15)CGTN Beijing      55)TWIT USA          95)France O          135)KZO AR           175)TV OOST BE        215)Telelibertà Piacenza IT   255)Al Arabiya AE"  
   echo "16)NHK World JP      56)Jupiter Broadcast 96)Bidtween FR       136)Canal 2 AR       176)AT5 NL ***        216)ONE TV NBC 112 Milan IT   256)Al Mayadeen LB"
   echo "17)ABC AU            57)Fiji One          97)TV 7 FR           137)Canal 6 AR       177)Euronews Russian  217)Euronews IT               257)Belqees TV YE"
   echo "18)Arise News NG     58)QVC USA           98)IL TV FR          138)Canal 7 AR       178)POCCNR 24         218)ONE MT                    258)Sky Arabic AE"	
   echo "19)VOA USA           59)TSC CA            99)TLM Lyon FR       139)Canal 13 AR      179)RBC TV Russia     219)Z1 Televizija HR          259)Alghad EG"
   echo "20)NEWSMAX USA       60)Gem Shopping USA  100)BFM Paris FR     140)SuperCanal 3 AR  180)CGTN Russian      220)RTV Posavina HR           260)Extra News EG"  
   echo "21)Free Speech TV USA61)Lake Tahoe TV     101)Alsace 20 FR     141)CN23 AR          181)Vesti FM Russia   221)OsjeckaTV HR              261)CBC Sofra EG"
   echo "22)Infowars USA      62)New Orleans TV    102)Mosaik TV FR     142)Telemax AR       182)Current Time VOA  222)Tomix Wein HR             262)CBC Drama EG"       
   echo "23)United Nations TV 63)Atlanta TV        103)Journal TVLandes 143)Vorterix AR      183)RTR Planeta       223)Euronews HU               263)DMC Live EG"  
   echo "24)C-SPAN 1 USA      64)TVW Washington    104)QVC Francais     144)TV Publica AR    184)Perviy RU         224)SKY Folk MK               264)Al-Fallujah IQ"
   echo "25)C-SPAN 2 USA      65)DC Network        105)8 Monte Blanc FR 145)Bolivia TV BO    185)Music Box RU      225)Star Lamia GR             265)AFAQ TV IQ" 
   echo "26)C-SPAN 3 USA      66)MNN 1 NY USA      106)Azur TV Nice FR  146)Cosmovision TV BO186)MOCKBA 24 RU      226)Action 24 GR              266)Karbarla IQ"
   echo "27)CPAC 1 CA         67)Laurel TV         107)RTS DEUX CH      147)Mega CL          187)1TV HD RU         227)Euronews GR               267)Euronews Arabic"
   echo "28)Oireachtas TV IE  68)Buzzr Gameshows   108)LCP FR           148)CNN CL           188)Planeta 4 RU      228)TRT Haber TR              268)ANB Sat USA"
   echo "29)WGN 9 Chicago     69)RIDE TV USA       109)Public Senate FR 149)Telemedeline CO  189)Planeta 6 RU      229)NTV TR                    269)Suryoyo Sat SE"
   echo "30)News12 Brooklyn   70)Geek and Sundry   110)CPAC 1 CA        150)CTV CO           190)TPEANEP TV RU     230)HaberTurk TV              270)Safeer TV UK"    
   echo "31)FiOS1 Long Island 71)Buffalo TV        111)Assemblee QC CA  151)Teleantioquia CO 191)5 Live RU         231)Star TV TR                271)Euronews Persian"
   echo "32)News12 LongIsland 72)Beach TV          112)Canal Savoir CA  152)TeleSUR VE       192)POCCNR 1 HD RU    232)CNN Turk TR               272)BBC Persian "
   echo "33)Weather Nation    73)Texas State TV    113)Gong Cinema      153)Globovision VE   193)News 24 UA        233)KRT Kulture TR            273)Iran Aryaee " 
   echo "34)Weather Channel   74)FiOS1 New Jersey  114)GONG MAX         154)NTN24 VE         194)UA TV UA          234)La Legul TV TR            274)DidgahNew TV IR  "  
   echo "35)BYUTV USA         75)FiOS1 HudsonValley115)BX1 BE           155)Conciencia VE    195)Thromadske UA     235)TGRT Haber TR             275)Aryen TV IR "
   echo "36)Wisconsin Channel 76)EBS EU            116)France Info Radio156)VPItv VE         196)Espresso UA       236)TVNET Canali TR           276)PTN PARS TV USA  "
   echo "37)DC Knowledge      77)EBS Plus EU       117)Europe 1 FR      157)Guatevision GT   197)News 1 UA         237)Show TV TR                277)Ariana TV AF"
   echo "38)MNN 5 NY USA      78)Euronews English  118)RFI FR           158)Excelsior MX     198)ZIK UA            238)Euronews Turk             278)TOLO NEWS AF"	
   echo "39)RT Documentary    79)NASA TV Media     119)RTL FR           159)Telesur Yucatan  199)Ukraine 5 UA      239)------------              279)------------- "
   echo "40)CGTN Documentary  80)NASA Public Educ  120)France Inter     160)Azteca Uno MX    200)TV Publica Moldova240)-------------             280)-------------  "
   echo "=========================================================================================================================================================="
   
}  	                            
  
channel_matrix_1()	
{
   echo "============================================================    "$product"  "$version"   ======================================================================"
   echo "||      INDIAN      ||     ASIA        || SOUTH ASIA / AFRICA||      EXTRA         ||    ENTERTAINMENT    ||    RELIGIOUS     ||      REL/ GOV      ||"
   echo "============================================================================================================================================================"
   echo "281)Aaj Tak PK       321)CCTV 4 China   361)DZRH Philippeans  401)RSBN Auburn USA     441)Heart TV         481)Vatican Media     521)Vatican Media Eng"    
   echo "282)DIN News PK      322)ECB 51 TW      362)DZMM ABS-CBN      402)FOX 12 Phoenix AZ   442)Capital TV       482)EWTN Americas     522)EnjoySt.Moritz " 
   echo "283)Minhaj PK        323)ECB Finance TW 363)PTV Philippines   403)Seminole TV         443)Music Choice Play483)EWTN Ireland      523)Quaran English"  
   echo "284)Barkat PK        324)TTV TW         364)Net TV Jakarta ID 404)CBS 4 Boston        444)M2O Music Channel484)EWTN Africa       524)TTB Network"             
   echo "285)Geo News PK      325)CTV TW         365)MNTV MM           405)WVIT 30 Hartford    445)Radio Monte Carlo485)EWTN Asia         525)Vatican Deutsch"  
   echo "286)SAMAA PK         326)FTV TW         366)Buddha MM         406)NBC 10 Philadelphia 446)Virgin Radio     486)Salt&Light TV     526)Vatican Italiano"  
   echo "287)Shaski India     327)CTS World TW   367)Up to Date MM     407)CBS 5               447)H!T Music        487)Catholic TV       527)Temple Institute"
   echo "288)SunNews          328)SET News TW    368)HLUTTAW MM        408)NBC 11 Bay Area     448)Now Music TV     488)CTND Detroit      528)ABC News 1  "
   echo "289)TV9 India        329)CTI TW         369)VietTV VN         409)CBS 13 Stockton     449)California Music 489)Shalom USA        529)ABC News 2"
   echo "290)Rajya Sabha      330)SET iNews TW   370)VietSky USA       410)KCAL 9              450)NRJ Hits FR      490)Shalom World      530)ABC News 3  "
   echo "291)TV9 Gujarat      331)Formosa TW     371)ABHPTV Vietnamese 411)WXXV25              451)Pitchoun         491)Shalom Europe     531)ABC News 4 "
   echo "292)News 7 Tamil     332)TzuChi DaAi TW 372)Earthquake 24     412)NBC 13 Albany NY    452)O!2 TV RU        492)EWTN Espanol      532)ABC News 5 "
   echo "293)News 18 India    333)DaAiVideo TW   373)Arirang News TV   413)NBC 2 Florida       453)SONG TV AM       493)EWTN Deutsch      533)ABC News 6"
   echo "294)Aaj Tak          334)DaAi Live TW   374)Arirang TV KR     414)WCCB Charlotte      454)Rockland Radio   494)KtO Catholique    534)ABC News 7 "
   echo "295)NTV Telugu       335)TLTV TW        375)OnTV HK           415)WSJ Live            455)KPOP Idol KR     495)CBN               535)ABC News 8" 
   echo "296)ABN Telugu       336)Sinda TV       376)Channels 24 NG    416)CTV Event CA        456)Adult Swim       496)CBN News          536)ABC News 9  "
   echo "297)Vanitha TV       337)Cheng Sin TV   377)TVC News NG       417)CNN Event 1         457)Smile of a Child 497)NRB               537)ABC News 10  "
   echo "298)HMT Telugu       338)CTS 2 TW       378)TVC Continental   418)CNN Event 2         458)PJ Masks         498)Church Channel    538)KY3 Springfield IL"	
   echo "299)India TV IN      339)SJTV TW        379)NTV Uganda        419)CNN Event 3         459)Talking Tom      499)TBN               539)KNBC 4 News"
   echo "300)Survana News     340)Da Li TW       380)KTN Kenya         420)NBC News Event      460)Talking Tom Mini 500)God TV            540)Planeta 2 RU"  
   echo "301)i News Telugu    341)SDTV TW        381)Joy News Ghana    421)------------        461)Fashion Europe   501)Amazing Facts     541)Planeta 3 RU "
   echo "302)PTTV Tamil IN    342)FANS TV TW     382)ADOM Ghana        422)Panama City         462)Fashion 1 TV ES  502)It's Supernatural 542)UN Trustship"       
   echo "303)DD News          343)Hong Kong TV   383)Bukedde TV        423)Pawleys Island      463)Jasmin TV USA    503)Shepherd's Chapel 543)UN EOSOC"  
   echo "304)REPORTER LIVE    344)GET TV USA     384)Qaranka Somalia   424)America Thinks      464)TYT USA          504)IHOP              544)Dail Eireann IE"
   echo "305)AsiaNet News     345)Arirang Korea  385)EBC Ethiopia      425)Bloomberg Europe    465)MLB Network      505)BVOVN             545)Senad Eireann IE"  
   echo "306)V6 News          346)TBS KR         386)SPARK Uganda      426)Bloomberg Asia      466)NFL Now          506)3ABN              546)Oireachtas CR 1 IE"
   echo "307)Aaj Tak IN       347)YTN DMB KR     387)Walf Senegal      427)BYUTV Int           467)RED BULL TV      507)3ABN Latino       547)Oireachtas CR 2 IE"
   echo "308)ETV AndhraPradesh348)YTN Sci KR     388)EriTV Eritrea     428)Arirang Radio       468)STADIUM          508)3ABN Francais     548)Oireachtas CR 3 IE"
   echo "309)News 18 Tamil    349)Channel 23 KR  389)EbruTV Kenya      429)HSN                 469)Lifestyle AZ USA 509)LLBN TV           549)Oireachtas CR 4 IE"
   echo "310)Aaj News IN      350)KBS World24 KR 390)KTN Home          430)HSN 2               470)Allkey Shop      510)Hillsong          550)CPAC Event 1"    
   echo "311)Jaya Plus        351)YTN 27 KR      391)SABC ZA           431)Bloomberg Australia 471)Sorgatronmedia   511)JUCE TV           551)CPAC Event 2"
   echo "312)TEZ TV           352)CGNTV          392)Africa News       432)Bloomberg USPoli    472)Amouranth        512)Salt and Light    552)CPAC Event 3"
   echo "313)Dili Aaj Tak     353)YTV USA        393)Afro Worldview    433)Bloomberg Live      473)-----------      513)Harbor Light      553)CPAC Event 4" 
   echo "314)Sagarmatha Nepal 354)Atlanta AM790  394)Africa24          434)Bloomberg EU Live   474)-----------      514)St. Mary's Coptic 554)CPAC Event 5"  
   echo "315)Derana LK        355)ANN24 JP       395)SIKKA Afrique     435)Bloomberg Asia Live 475)-----------      515)Word of God Greek 555)CPAC Event 6"
   echo "316)Swarnavahini LK  356)Sol!ve 24 JP   396)K24 Nairobi KE    436)Weather Network CA  476)-----------      516)Shalom America    556)CPAC Event 7"
   echo "317)Kaliagnar News   357)KBS 24 JP      397)ITV ZA            437)PBS NewsHour        477)-----------      517)Shalom India      557)CPAC Event 8"
   echo "318)--------------   358)QVC Japan      398)Parliament ZA     438)CBC The National    478)-----------      518)Powervision TV    558)CPAC Orig Lang"	 
   echo "319)--------------   359)BSC 24 1 JP    399)--------------    439)AP Top Stories      479)-----------      519)-------------     559)------------- "
   echo "320)--------------   360)BSC 24 2 JP    400)--------------    440)Democracy Now       480)-----------      520)-------------     560)------------- "
   echo "================================================================================================================================================================="
}    
#  
 
channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ====================================================================="
   echo "||      FREE       ||    Latino Extra   ||   Latino Mucho Mas   || Portugues/French Extra||     USA Local 2    ||     USA Local 3   ||   LiveStream 1   ||"
   echo "======================================================================================================================================================"
   echo "561)------------    601)VIVE VE            641)Azteca 7 MX       681)Euronews PT         721)FOX News Preview   761)News 12 KTVZ7     801)Sangat Birmingham "    
   echo "562)------------    602)Vatican Media ES   642)------------      682)TV Assemblelia BR   722)Capital City       762)NewsWest 9 KWES DC802)Sikh Channel " 
   echo "563)------------    603)Televen VE         643)EsteCanal TV      683)TV Canaco Nova      723)Daytona Beach      763)Orange TV         803)Dashmesh  "  
   echo "564)------------    604)Impacto USA        644)Cinevision DR     684)Igreja de Graca     724)Shepard Smith      764)PGCPS             804)Iberia TV  "             
   echo "565)------------    605)UCVTV CL           645)Nuevolaredo MX    685)Assemblelia Ales    725)WUSA9 Breaking     765)RyeTV             805)Obieqtivi TV   "  
   echo "566)------------    606)UCVTV 2 CL         646)Sinart CR         686)Boas Nova           726)WCNC Breaking      766)Seattle Channel   806)ortonville   "  
   echo "567)------------    607)Univision MX       647)Bethel Panamá     687)Fundacao Nazzare    727)WCCB News          767)Southeastern      807)Holiday & Cruise  "
   echo "568)------------    608)Cablenet AR        648)Poder de Dios BO  688)STF Brazil          728)UGA TV             768)Temple TV         808)------------"
   echo "569)------------    609)Telpintv AR        649)TVDIÁRIO MX       689)TV Estúdio Brasil   729)TVW2 Washington    769)Vienna HQ         809)Vision Cruise AU "
   echo "570)------------    610)Canal8 MarPlataAR  650)BoliviaTV BO      690)Rádio Justiça       730)Action News KNVN   770)Escambia          810)Vision Cruise UK "
   echo "571)------------    611)Univision USA      651)GUATEVISION GT    691)EXA FM Brasil       731)Alaska ASD         771)CBS Sports        811)------------"
   echo "572)------------    612)Canal 2 AR         652)RTV ES            692)RIT TV BR           732)Bowie TV           772)WYCW Carolinas    812)WHLT USA  "
   echo "573)------------    613)ABC Paraguay       653)Medios Públicos   693)Gott24.TV           733)Escambia TV        773)FOX 10 News       813)LRPATV CH25 NH USA "
   echo "574)------------    614)Abya Yala BO       654)Tele Bahia DR     694)TV Fátima Paróquia  734)FOX 5 DC (WTTG)    774)WHO 13            814)Santa Fe NM USA  "
   echo "575)------------    615)UFROVision CL      655)Iglesia Advent USA695)You Content 98      735)Garland TV         775)Erie News         815)------------" 
   echo "576)------------    616)Campo Abierto CL   656)Expande Puebla MX 696)Rede Gênesis PT     736)Greenbelt TV       776)WISTV             816)------------"
   echo "577)------------    617)UNITV AR           657)Ayuda Universal MX697)MEIO Teresina BR    737)House Represent    777)------------      817)------------"
   echo "578)------------    618)TelePacifico CO    658)Canal 27 Esperanza698)Medalhão Persa BR   738)KRBC-TV            778)------------      818)102.3 NOW! TV CA   "	
   echo "579)------------    619)Venevision VE      659)TELEAMIGA         699)Talenu TV TPA       739)KBVR TV            779)------------      819)TourbusTV USA  "
   echo "580)------------    620)Telediario AR      660)Poli tv Bogota CO 700)TV Miramar BR       740)KTVB               780)------------      820)Ezekiel TV"  
   echo "581)------------    621)TVeo Cordoba AR    661)UNTREF UN3 AR     701)TV Zimbo AO         741)Key TV             781)------------      821)KVZK TV AS "
   echo "582)------------    622)PSN Tijuana MX     662)RUAV Univalle CO  702)TV RAIAR AO         742)KOB4 News          782)------------      822)------------"       
   echo "583)------------    623)CNN Espanol        663)JesusTV GT        703)SescTV SaoPaulo BR  743)KPNX Breaking      783)------------      823)----------"  
   echo "584)------------    624)Paraguay Noticias  664)FGTV USA          704)Rede Super BeloBR   744)KXAN News          784)------------      824)Native Media NM USA"
   echo "585)------------    625)Canal Tr3ce CO     665)Evangelio Eterno  705)Talenu Luanda AO    745)Miami TV           785)------------      825)------------"  
   echo "586)------------    626)Cali TV            666)BoliviaTV La Paz  706)Vatican Media PT    746)KNTV-TV            786)------------      826)------------"
   echo "587)------------    627)Canal 12 CO        667)Cosmovision TV    707)ACTION              747)KNTV Telemundo     787)------------      827)Emmanuel TV  "
   echo "588)------------    628)Imagen Radio MX    668)Libre Cali CO     708)CNEWS FR            748)NBC2 News KTUU     788)------------      828)Shalom World "
   echo "589)------------    629)Euronews ES        669)MONARCA Hidalgo MX709)TV7 Bordeaux FR     749)News2 WCBD         789)------------      829)WDIO Duluth "
   echo "590)------------    630)Teleamazonas       670)Yuma CO           710)i24 News IL         750)News4 WRC          790)------------      830)KHNL Honolulu "    
   echo "591)------------    631)TV Camara PY       671)Dominio MX        711)SYTRAL Rhone FR     751)News4 White House  791)------------      831)WBNS Columbus "
   echo "592)------------    632)Tu Canal Panama    672)Señal UNTREF      712)Vedia BE            752)News5 WCYB         792)------------      832)WTTG Fox 5 DC "
   echo "593)------------    633)Colosal TV 1       673)NRT 4 monclova    713)MABI CA             753)NewsWest 9 KWES    793)------------      833)WJBK FOX 2 Detroit " 
   echo "594)------------    634)A24 AR             674)Este Canal        714)Vatican Media FR    754)NBC4 WNBC          794)------------      834)KSL NOW Salt Lake "  
   echo "595)------------    635)Canal 8 AR         675)Telecafé Bogota   715)TVM Paris FR        755)NBC4 WNBC Traffic  795)------------      835)KSLA News 12 "
   echo "596)------------    636)CanalShowsport AR  676)TVUNAM 20         716)RMC INFO FR         756)NBC5 WMAQ          796)------------      836)WSFA 12 Montgomory"
   echo "597)------------    637)WIPR Puerto Rico   677)EVTV Miami        717)C-Star              757)NBC 10 KTEN        797)------------      837)Fox 8 Cleveland "
   echo "598)------------    638)La Mega Bogotá CO  678)Enlacetv Espanol  718)-------------       758)NBC 12 WWBT        798)------------      838)KELO Keloland "	
   echo "599)------------    639)TV UNAM MX         679)------------      719)-------------       759)NBC 29 WVIR        799)------------      839)HU16 Harding   "
   echo "600)------------    640)Telecafé CO        680)------------      720)-------------       760)NBC 13 WNYT        800)------------      840)KTVK 3TV AZ  "
   echo "==================================================================================================================================================="
}	                     
                       
channel_matrix_3()	
{
   echo "============================================================    "$product"  "$version"   ============================================================================="
   echo "||      LiveStream 2      ||    LiveStream 3   ||      LiveStream 4     ||     LiveStream 5     ||       LiveStream 6      ||    LiveStream 7      ||   Livestream 8  ||"
   echo "====================================================================================================================================================================="
   echo "841)FOX 26 Houston        881)WAND Decatur IL    921)KAUZ CBS6 Winters   961)KVIA ABC-7 El Paso 1 1001)WFLD Fox32 Chicago     1041)St Patrick's Dumbarton1081)Maricopa MCTV"    
   echo "842)WAFB 9 CBS Baton Rouge882)KOAAColoradoSpring 922)KXXV ABC 25 Waco    962)KCBD NBC 11 Lubbock  1002)KTVK 3 Pheonix         1042)VTNTV VICTORY         1082)CharmTV Baltimore" 
   echo "843)WCSC Charleston       883)Enid OK            923)KATC Lafayette      963)WALB NBC 10 Albany   1003)KRIV FOX26 Houston     1043)MNN Channel 3 NY      1083)KVVB CH.33"  
   echo "844)WTXF FOX 29           884)ThinkTech Hawaii   924)WFLD Fox32 Chicago  964)KFVE 9 Honolulu      1004)WVUE FOX8 NewOrleans   1044)TMN WORD TV           1084)WLTH AM 1370 "             
   echo "845)WFLA NBC 8 Tampa Bay  885)WFLX FOX 29        925)KPLC NBC7LkCharles  965)WWBT NBC12 Richmond  1005)KPTV FOX12 Portland    1045)Parkside Radio        1085)KCOH TV Houston  "  
   echo "846)WFIE NBC 14           886)WPS-TV Wichita     926)KOIN 6 Portland     966)WJTV CBS12 Jackson   1006)KIRO Seattle           1046)FGTV Jacksonville     1086)Lake Tahoe TV "  
   echo "847)KOIN Portland OR      887)KAAL Rochester MN  927)WCCB Charlotte      967)WWLP 22 Springfield  1007)KUSI San Diego         1047)HJTV Healing Jesus    1087)KVZK A. Samoa "
   echo "848)WTVT FOX 13 Tampa     888)KRCR Redding CA    928)WDAM 7 Hattiesburg  968)CBS 42 Birmingham    1008)Fox 8 Cleveland        1048)Apocalypse APTV       1088)Florida Gaming "
   echo "849)KUSI San Diego        889)KION Salinas CA    929)WLOX Mississippi    969)WNYT NBC13 Sandusky  1009)KSLA CBS12Shreveport   1049)Marytown Chapel       1089)Kidd Kraddick"
   echo "850)Joe Pags Show         890)KMVP Phoenix AZ    930)WTVM Columbus       970)KEYT ABC3 StBarbara  1010)KELO CBS Sioux Falls   1050)ESPN 97.5 Houston     1090)RMG-TV Cleavland"
   echo "851)WBRC FOX6 Mobil       891)KTAR Phoenix AZ    931)WRBL CBS3 Columbus  971)WLBT FOX40 Jackson   1011)KSL Salt Lake City     1051)Football Hall of Fame 1091)WFSB 3 Hartford "
   echo "852)WNYW Fox 5 New York   892)WPSD Paducah KT    932)WJHL CBS11 Johnson  972)WSMV NBC4 Nashville  1012)WTTG Fox5 Wash DC      1052)Lance Hope RSL        1092)ICOinvestor"
   echo "853)KMOV 4St. Louis       893)KVRR Fargo ND      933)KCTV CBS5 Kansas    973)DayTraderRockStar    1013)WCSC CBS5 Charleston   1053)XBTV Rosecroft        1093)WISH8 Indianapolis"
   echo "854)WFLD Fox 32 Chicago   894)KDLT SiouxFallsSD  934)WTHI 10TerreHaute   974)WALA FOX10 Mobile    1014)WBNS 10 Columbus       1054)VSiN Vegas Stats      1094)Luigi PellegriniIT"
   echo "855)KHSL Action           895)GovTV Watertown SD 935)WBBJ ABC7 Tennesee  975)KMOV CBS4 St.Louis   1015)WJBK FOX2 Detroit      1055)Guaranty Media        1095)Bengu TK"
   echo "856)WVUE FOX8 New Orleans 896)KFDXWitchita Falls 936)KTVZ 21 BendOregon  976)Lex & Terry Lufkin   1016)WAFB CBS9 BatonRouge   1056)Park City PCTV        1096)i24News IL"
   echo "857)KLTV 7 Tyler TX       897)Freeway Cams TX    937)KEZI ABC9 Eugene    977)KVOA NBC4 Tuscon     1017)WFMZ 69 TrafficAllen   1057)WHLT 12 Whitehall     1097)------------"
   echo "858)KEYT ABC 3 StBarbara  898)KQDS Duluth MN     938)WDEF 12Chattanooga  978)Mike Malloy Show     1018)KY3 Springfield        1058)OUBN - Oakwood        1098)------------"	
   echo "859)WAKA ALABAMA          899)KOLR Springfield MO939)KCOY CBS12 StMaria  979)KHSL CBS12 Redding   1019)710 ESPN Seattle       1059)Nasdaq Bell           1099)------------ "
   echo "860)WJZY Charlotte NC     900)WROC Rochester NY  940)WTOL CBS11 Toledo   980)KSTP ABC5 St.Paul    1020)NYXT Manhattan         1060)AAA Guayama           1100)------------ "  
   echo "861)WCCB Charlotte NC     901)WBRE WilkesBarrePA 941)WIS NBC10 Columbia  981)KSWO ABC7 Winters    1021)KingCountyPreston      1061)AWCATV - Education    1101)------------ "
   echo "862)WCYB NBC 5 VA         902)Cumulus NYC        942)WMC NBC5 Memphis    982)WBTV CBS3 Charlotte  1022)Westerville.TV         1062)Branson Visitor       1102)------------ "       
   echo "863)WYCW 62 Carolinas     903)KTVQ Lexington KY  943)HTV10 Houma         983)KPHO CBS5 Pheonix    1023)Kingdom Access         1063)TMN Hays Kansas       1103)------------ "  
   echo "864)WNCT CBS9 Greenville  904)WFFT FOX 55 IN     944)WRIC ABC8 Peters    984)WDIO ABC 13 Duluth   1024)KCLV FOX2 Las Vegas    1064)MNN Channel 5         1104)------------ "
   echo "865)WJBF Augusta          905)WAAY News ABC 31   945)Western Chicopee    985)KMSP FOX9Minneapolis 1025)Plaistow Access        1065)TV39 WIVM Canton      1105)------------ "  
   echo "866)KLFY 10 Acadiana      906)SPC-TV S.Petrberg  946)KIMT 3 Mason        986)KSBY NBC6 St Barbara 1026)Topeka City Kansas     1066)EPlusTV6 Jackson      1106)------------ "
   echo "867)MNN Channel 1         907)WWTV 9             947)KXAN NBC Austin     987)KOLD 13 Tucson       1027)Shelby County          1067)St.CloudTimes UTVS    1107)------------ "
   echo "868)MNN Channel 4         908)WPHL TV ABC 6      948)WKRG CBS5 Mobile    988)KLTV ABC7 Tyler      1028)Provincetown           1068)Milford TV            1108)------------"
   echo "869)WWOR Secaucus         909)WCCB Charlotte     949)Lex 18 Lexington    989)WBRC FOX6 Birmingham 1029)MNN-FSTV Manhattan     1069)EKBTV Pikeville       1109)------------ "
   echo "870)KSNT                  910)WCBD NBC2 Charles  950)WBNS 10 Radar       990)K57 Fox 6 Guam       1030)Brunswick TV3          1070)Milford Education     1110)------------ "    
   echo "871)WANE Ft. Wayne        911)WSAV NBC3 Savannah 951)WBNS 10 Columbus    991)WTVT FOX13 Tampa     1031)Bermuda Government     1071)Native Media          1111)------------ "
   echo "872)KTXS 12 ABC           912)WSPA CBS7 Spartan  952)KYMA NBC11 Yuma     992)WFLA NBC8 Tampa      1032)Freedom Solar TV       1072)Evangel EUTV          1112)------------ "
   echo "873)Island TV             913)WCMH NBC4 Columbus 953)WOIO CBS19Clevland  993)WTNH 8 New Haven     1033)Shalom Media KIDS      1073)Granbury Media        1113)------------" 
   echo "874)KSNT Kansas           914)CBS 17 Rahliegh    954)KESQ Palm Springs   994)WMBF Myrtle Beach    1034)Faith LutheranChurch   1074)ETSU Fine Arts        1114)------------ "  
   echo "875)KMIZ Missouri         915)Channel5+Las Vegas 955)KRDO Colorado Spr   995)WSFA NBC12Montgomery 1035)Whole Life Ministry    1075)WDFL 18 SC            1115)------------"
   echo "876)KFDA Amarillo TX      916)KSNW NBC3 Witchita 956)WFMZ 69 Allen Town  996)WNYW Fox5 New York   1036)Second Presbyterian    1076)MCAET Salinas         1116)------------"
   echo "877)KZTVCorpusChristi TX  917)WPRIFox12Providen  957)WTOC 11 Savannah    997)KVVU FOX5 Las Vegas  1037)St. Catharine          1077)BlabTV                1117)------------ "
   echo "878)Tampa TV FL           918)WWAY Willmington   958)WGCL CBS46 Atlanta  998)KHON CBS2 Ala Mona   1038)Glory to God           1078)Essex County          1118)------------ "	
   echo "879)WMGT Macon Georgia    919)KIFI ABC 8 Idaho   959)KQTV 2 St.Joseph    999)WFIE NBC14Evansville 1039)WYKE TV 47 Hormosassa  1079)CNPTV Caribbean       1119)------------ "
   echo "880)44 Bolivar MI         920)Fox26 KNPN SJoseph 960)CGTN America        1000)WTXF FOX29 Philli   1040)St. Helena Chapel      1080)LOBO STATION          1120)------------ "
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
   echo "$ endstream --ua-tor       # use tor-browser user-agent"
   echo "$ endstream --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endstream --ua-ranstr    # use a random string as the user agent"
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
   channel_matrix_0
   sleep 2
   channel_matrix_1
   sleep 2
   channel_matrix_2
   sleep 2
   channel_matrix_3
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

############################  FUNCTIONS ##################################################################

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    ENGLISH     ##################################
################      EUROPE    #################################
# 1) Sky News
1)
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/07.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/06.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/05.m3u8
###link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/03.m3u8
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/02.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/01.m3u8
#method="Tor"
#method="Proxychains"
keyword="Sky"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCd6knJkq4XBNHZATKWFNmGQ/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky News" ;;
# 2) RT UK
2)
#link=https://www.rt.com/on-air/rt-uk-air/ 
#link=https://secure-streams.akamaized.net/rt-uk/index.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index1600.m3u8
###link=https://secure-streams.akamaized.net/rt-uk/index800.m3u8
link=https://secure-streams.akamaized.net/rt-uk/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
#link=https://www.filmon.com/tv/russia-today-2

#method="Proxychains"
#method="Tor"
#method="Proxychains"
use_cookies="no"
chan_name="RT UK" ;;
# 3) France 24 Anglais 
3) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
# link=http://www.dailymotion.com/video/xigc8z
#method="Tor"
use_cookies="no"
chan_name="France 24 English";;
# 4) DW English
4) 
keyword="DW"
#link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-p.m3u8?sd=10&rebase=on"
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
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-b.m3u8?sd=10&rebase=on"
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelleenglish/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#method="Tor"
use_cookies="no"
chan_name="DW English" ;;
# 5) Russia Today
5)
#link=https://www.rt.com/on-air/ 
#link=https://secure-streams.akamaized.net/rt/index.m3u8
#link=https://secure-streams.akamaized.net/rt/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt/index1600.m3u8
######link=https://secure-streams.akamaized.net/rt/index800.m3u8
link=https://secure-streams.akamaized.net/rt/index400.m3u8
#link=https://secure-streams.akamaized.net/rt/indexaudio.m3u8
## link=https://www.filmon.com/tv/russia-today-1
#method="Tor"
use_cookies="no"
chan_name="Russia Today" ;;
########################## USA MAINSTREAM ###################################################
# 6) CBSN 
6)
keyword="LIVE"
#link="https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8"
#link=$( curl "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 )?BANDWIDTH=1689600
####link="$(curl --socks5 "$socks_ip":"$socks_port" -A "$UA" $( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 1029600.m3u8 | tail -n 1 ) "
link="$(curl -A "$UA" $( curl -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 580800.m3u8 | tail -n 1 ) "

# BANDWIDTHS: 3009600 2481600 1689600 1029600 580800 264000 

#link=https://www.cbsnews.com/common/video/dai_prod.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
#
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/CBSNewsOnline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
# method="Tor"
use_cookies="no"
chan_name="CBSN" ;;
# 7) # MSNBC
7)
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/master.m3u8"
#link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x234,CODECS="avc1.64001f, mp4a.40.2"
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x234,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x234,CODECS="avc1.64001f, mp4a.40.2"
####link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x234,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=796000,RESOLUTION=640x360,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_796_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-b.m3u8?sd=10&rebase=on"
#method="Tor"
use_cookies="no"
chan_name="MSNBC";;  

# 8) Bloomberg Business USA
8) 
keyword="Bloomberg"
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://liveproduseast.akamaized.net/us/Channel-USTV-AWS-virginia-1/Source-USTV-1000-1_live.m3u8
#method="Tor"
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 9) RT America
9)
#link=https://www.rt.com/on-air/rt-america-air/
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
link=https://secure-streams.akamaized.net/rt-usa/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index1600.m3u8
####link=https://secure-streams.akamaized.net/rt-usa/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8
#method="Tor"
use_cookies="no"
chan_name="RT America" ;;
# 10) Newsy
10) 
#link=http://www.newsy.com/live/
link="https://content.jwplatform.com/players/hBmO7M6k"
#link=https://www.filmon.com/tv/newsy
#method="Tor"
use_cookies="no"
chan_name="Newsy" ;;
# 11)ABC News USA 
11)
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
#link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_4000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4000000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/index_4000_av-b.m3u8?sd=10&rebase=on"
#method="Tor"
use_cookies="no"
chan_name="ABC News USA" ;;

############################# MIDDLE EAST ##############################################################
# 12) TRT World
12) 
keyword="TRT"
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
#method="Tor"
use_cookies="no"
chan_name="TRT World";;   
# 13) Al Jazeera
13) 
keyword="Al Jazeera English - Live" 
#link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
link=https://english.streaming.aljazeera.net/aljazeera/english2/index4147.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index2073.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index1296.m3u8
#####link=https://english.streaming.aljazeera.net/aljazeera/english2/index783.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index576.m3u8
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index255.m3u8
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/160audio.m3u8
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
##method="Tor"
use_cookies="no"
chan_name="Al Jazeera English" ;;  
################### INDIA  ########################################
# 14) India TODAY
14)
keyword="IndiaToday Live TV"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link="https://feeds.intoday.in/hltapps/api/master.m3u8"
#link="$( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 896000p | tail -n 1 )"
link="$( curl -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 2128000pb | tail -n 1 )"
# BANDWIDTH=2128000pb.m3u8 896000pb.m3u8 428000pb.m3u8
use_cookies="no"
#method="Tor"
chan_name="India TODAY English" ;;  
###########################  ASIA-OCEANIA   ############################################
# 15) CGTN China English
15) 
keyword="Live"
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
####method="Tor"
use_cookies="no"
chan_name="CGTN China English" ;;
# 16)NHK World Japan 
16)
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
###method="Tor"
use_cookies="no"
chan_name="NHK World Japan" ;;
########################## AUSTRALIA ###########################################
# 17)  ABC News Australia 
17) 
keyword="ABC" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#link=https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=306000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_250_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=514000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
####link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_450_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=730000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_650_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=846000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_750_av-p.m3u8?sd=10&rebase=on"
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
####method="Tor"
use_cookies="no"
chan_name="ABC News Australia" ;;
########################### AFRICA ############################################
# 18) Arise News Nigeria/London
18) 
keyword="Arise"
link=http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
#method="Tor"
use_cookies="no"
chan_name="Arise News Nigeria/London";; 
##################    DOCUMENTARY   ##################################################
# 19)VOA
19)
#link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=857000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613000,RESOLUTION=524x288,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0288_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1589000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0404_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2078000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=734x404,CODECS="avc1.77.30, mp4a.40.2"
#link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0540_av-b.m3u8?sd=10&rebase=on"
#link=https://www.filmon.com/tv/voa-english
##method="Tor"
use_cookies="no"
chan_name="VOA" ;;
##################    ALTERNATIVE MEDIA   ##################################################
# 20) NEWSMAX USA
20) 
keyword="Newsmax"
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_720.m3u8
##link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_480.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_360.m3u8
# "http://www.newsmaxtv.com/"
# link=https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8
#link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
##method="Tor"
use_cookies="no"
chan_name="NEWSMAX USA";;
# 21)Free Speech TV
21)
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1691748,RESOLUTION=848x480,CODECS="avc1.4D401F,mp4a.40.5"
link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1191784,RESOLUTION=640x360,CODECS="avc1.4D401F,mp4a.40.5"
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_4.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=792410,RESOLUTION=512x288,CODECS="avc1.42C01E,mp4a.40.5"
#####link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_5.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=192148,CODECS="mp4a.40.5"
#link=https://edge.free-speech-tv-live.top.comcast.net/out/u/27153_6.m3u8
#method="Tor"
use_cookies="no"
chan_name="Free Speech TV" ;;   
# 22)  Infowars
22)
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
chan_name="Infowars" ;; 
############################# GOVERNMENT#####################################################
############### UNITED NATIONS #################################################
# 23) United Nations UN Web TV
23) 
keyword="LIVE"
### UN WEB TV
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001
#link=https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=828000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.5"
####link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_828_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=828000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_828_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.5"
link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-b.m3u8?sd=10&rebase=on"
#format="best"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"
##Trustship Chamber
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701485575001
##ECOSOC 
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5701459952001
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/unitednations/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
####method="Tor"
use_cookies="no"
chan_name="United Nations UN Web TV" ;; 
########################## AMERICAN GOVERNMENT ####################################################
# 24) C-SPAN 1 HD
24)
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
# 25) C-SPAN 2 HD
25)
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
# 26) C-SPAN 3 HD
26)

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
########################## CANADIAN GOVERNMENT ###################################################
# 27) CPAC 1 Canada  
27)
#link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001

#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=612417,RESOLUTION=640x360,CODECS="avc1.77.31,mp4a.40.5"
###link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1530106220217/Layer1_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=919415,RESOLUTION=720x404,CODECS="avc1.77.31,mp4a.40.5"
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1530106220217/Layer2_master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3169893,RESOLUTION=1280x720,CODECS="avc1.77.31,mp4a.40.5"
link=http://bcoveliveios-i.akamaihd.net/hls/live/248519/1242843915001_1//Assets_1530106220217/Layer3_master.m3u8

# Original Language
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3/master.m3u8
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248521/1242843915001_3//Assets_1518231308621/Layer1_master.m3u8
# French
#link=http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8
####method="Tor"
use_cookies="no"1
chan_name="CPAC 1 Canada" ;;
########################## IRELAND ##############################################
# 28) OIreachtas TV IE
28)  
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1338000,CODECS="avc1.66.32,mp4a.40.2",RESOLUTION=854x480
link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1063000,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=640x360
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b978000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=513000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=426x240
####link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b478000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=128000,CODECS="mp4a.40.2"q
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b128000.m3u8

####method="Tor"
use_cookies="no"
chan_name="Oireachtas TV IE" ;; 

########################## LOCAL USA NEWS ##################################################
# 29) WGN 9 Chicago 
29) 
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8"
#http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=878000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_750_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/index_2500_av-b.m3u8?sd=10&rebase=on"

####method="Tor"
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
# 30)News 12 Brooklyn 
30) 
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
####method="Tor"
use_cookies="no"
chan_name="News 12 Brooklyn" ;;
# 31) FiOS1 News Long Island
31)
#link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_b159ee77/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
link="https://urtmpkal-f.akamaihd.net/i/1b159ee77_1@192104/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1b159ee77_1@192104/index_1_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="FiOS1 News Long Island" ;;
# 32) News 12 Long Island 
32) 
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12LI_WEST
####method="Tor"
use_cookies="no"
chan_name="News 12 Long Island" ;;

#################### NATIONAL / LOCAL Weather #####################################################
# 33) Weather Nation
33) 
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2128000,RESOLUTION=1280x720
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b2128000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=504000,RESOLUTION=480x270
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b464000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=724000,RESOLUTION=640x360
#link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b664000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1054000,RESOLUTION=640x360
#####link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b964000.m3u8

#####method="Tor"
use_cookies="no"
chan_name="Weather Nation" ;; 
# 34) The Weather Channel
34)
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
#####method="Tor" 
use_cookies="no"
chan_name="The Weather Channel" ;;
# 35) Bringham Young University TV BYUTV Mormon 
35)
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
#####method="Tor"
use_cookies="no"
chan_name="Bringham Young University BYU TV USA" ;;
# 36) Wisconsin Public Television The Wisconsin Channel
36)
#link="https://livestream.com/accounts/13897710/events/4153577"
#link=https://api.new.livestream.com/accounts/13897710/events/4153577/broadcasts/178023398.secure.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=678000,RESOLUTION=768x432,CODECS="avc1.77.30, mp4a.40.2"
#link="https://livestream-f.akamaihd.net/i/13897710_4153577_4d623e71_1@329465/index_678_av-p.m3u8?sd=4&dw=80&set-segment-duration=responsive&rebase=on&hdntl=exp=1532380358~acl=%2fi%2f13897710_4153577_4d623e71_1%40329465%2f*~data=hdntl~hmac=80091d79cdcaabfd2d1c6b86b7e4157f3a01265fa1f1103b5832ad3b2b836bf5"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=198000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://livestream-f.akamaihd.net/i/13897710_4153577_4d623e71_1@329465/index_198_av-p.m3u8?sd=4&dw=80&set-segment-duration=responsive&rebase=on&hdntl=exp=1532380358~acl=%2fi%2f13897710_4153577_4d623e71_1%40329465%2f*~data=hdntl~hmac=80091d79cdcaabfd2d1c6b86b7e4157f3a01265fa1f1103b5832ad3b2b836bf5"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2320000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://livestream-f.akamaihd.net/i/13897710_4153577_4d623e71_1@329465/index_2320_av-p.m3u8?sd=4&dw=80&set-segment-duration=responsive&rebase=on&hdntl=exp=1532380358~acl=%2fi%2f13897710_4153577_4d623e71_1%40329465%2f*~data=hdntl~hmac=80091d79cdcaabfd2d1c6b86b7e4157f3a01265fa1f1103b5832ad3b2b836bf5"
use_cookies="no"
chan_name="Wisconsin Public Television The Wisconsin Channel" ;;
# 37) District Knowledge Network
37)
link=http://video.oct.dc.gov/out/u/96_4.m3u8
#link=http://video.oct.dc.gov/out/u/96_3.m3u8
#link=http://video.oct.dc.gov/out/u/96_2.m3u8
#link=http://video.oct.dc.gov/out/u/96_1.m3u8
use_cookies="no"
chan_name="District Knowledge Network" ;;
# 38)MNN Channel 5 New York USA
38)
#link="https://livestream.com/accounts/17251372/events/4846282"
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.m3u8
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.smil
#link=https://livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.smil
#link="https://api.new.livestream.com/accounts/17251372/events/4846282/videos/166329962.secure.m3u8"
#link="https://api.new.livestream.com/accounts/17251372/events/4846282/broadcasts/177074802.secure.m3u8?dw=80&hdnea=st=1532293615~exp=1532295415~acl=/i/17251372_4846282_30365919_1@366744/*~hmac=92b057f3489b8a12fa6cedaf1a40a1ca83cc45c749db34277bf30e0ba027c63b"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4596000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
link="https://livestream-f.akamaihd.net/i/17251372_4846282_30365919_1@366744/index_4596_av-p.m3u8?sd=4&dw=80&set-segment-duration=responsive&rebase=on&hdntl=exp=1532381695~acl=%2fi%2f17251372_4846282_30365919_1%40366744%2f*~data=hdntl~hmac=8f1ac7464fc4173fd08be722ca5f28cc4af1cd75920f7d3a3b3817ee40f1429d"
use_cookies="no"
chan_name="MNN Channel 5 New York USA" ;;
########################### EASTERN DOCUMENTARIES ##############################################
# 39) RT Documentary
39) 
#link=https://rtd.rt.com/on-air/
#link="https://secure-streams.akamaized.net/rt-doc/index.m3u8"
link="https://secure-streams.akamaized.net/rt-doc/index2500.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index1600.m3u8"
#####link="https://secure-streams.akamaized.net/rt-doc/index800.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index400.m3u8"
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8

#####method="Tor"
use_cookies="no"
chan_name="RT Documentary" ;;
# 40) CGTN Documentary
40)
#link=https://live.cgtn.com/cctv-d.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=http://livedoc.cgtn.com/1000d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=http://livedoc.cgtn.com/500d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
###link=http://livedoc.cgtn.com/200d/prog_index.m3u8

###method="Tor"
use_cookies="no"
chan_name="CGTN Documentary" ;;

#############################  ENGLISH EXTRA #############################################

######################  GREAT BRITAIN ############################################
# 41) Made in Leeds
41)
link=http://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240

##method="Tor"
chan_name="Made in Leeds" ;;
# 42) Made in Tyne & Wear
42)
link=http://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
###method="Tor"
chan_name="Made in Tyne & Wear" ;;
# 43) Made in Cardiff
43)
link=http://www.dailymotion.com/video/x5ev9xg
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
###method="Tor"
chan_name="Made in Cardiff" ;;
# 44) BBC News London
44) 
keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
method="Tor"
chan_name="BBC News London" ;; 
# 45) BBC Parliamnet 
45) 
#keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-parliament
use_cookies="yes"
####method="Tor"
chan_name="BBC Parliament" ;; 
# 46) CNN PHILIPPINES
46)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
####method="Tor"
chan_name="CNN PHILIPPINES";;
# 47) CNN Live  
47)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
#link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
####link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
####method="Tor"
chan_name="CNN Live" ;;  
# 48) Fox News 
48)
#link=http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=214000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_150000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=214000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_150000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=256x144,CODECS="avc1.77.30, mp4a.40.2"
link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_300000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=256x144,CODECS="avc1.77.30, mp4a.40.2"
#link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_300000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_150000_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="http://foxnewsuni-f.akamaihd.net/i/FNCGOPREV_40220@40220/index_150000_a-b.m3u8?sd=10&rebase=on"

#http://fnurtmp-f.akamaihd.net/i/1502368494075_01@335695/master.m3u8
#http://fncgohls-i.akamaihd.net/hls/live/263399/FNCGOHLS/master.m3u8

#link=https://players.brightcove.net/694940094001/SkrZHHcl_default/index.html?videoId=5270285052001
#link=https://players.brightcove.net/694940094001/SkrZHHcl_default/index.html?videoId=5614615980001
#http://video.foxnews.com/v/5614615980001/?#sp=watch-live

use_cookies="no"
####method="Tor"
chan_name="Fox News" ;;  
# 49) Fox News Talk
49)  
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/master.m3u8"
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
link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=66000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=66000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-b.m3u8?sd=10&rebase=on"

use_cookies="no"
chan_name="Fox News Talk" ;; 

########################### INFOWARS EXTRAS #######################################################
# 50)Infowars RealNews
50)
#link=https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=955000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=125000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/RealNews_1@561924/index_800_a-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Infowars RealNews" ;;
# 51)Infowars WarRoom 
51)
#link=https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=955000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=125000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_a-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Infowars WarRoom " ;;
# 52)Infowars Event 
52)
#link=https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=720x406,CODECS="avc1.77.30, mp4a.40.2"
link="https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/infowarsevent_1@366809/index_800_a-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Infowars Event" ;;
######################################################################################################

############### IRELAND ###########################################################
# 53)# RTE News NOW  
53)    
#link=http://wmsrtsp1.rte.ie/live/android.sdp/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2089682,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=1024x576
link=http://wmsrtsp1.rte.ie/live/android.sdp/chunklist_w203521911.m3u8
#method="Tor"
use_cookies="no"
chan_name="RTE News NOW" ;;
############################## IRAN ##########################################
# 54) Press TV
54)
link=https://www.filmon.com/tv/press-tv
#link=http://107.189.40.49:1935/live/ptven/playlist.m3u8
#link=http://107.189.40.49:1935/live/ngrp:ptven_all/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1380059,CODECS="avc1.66.40,mp4a.40.2",RESOLUTION=1280x720
#link=http://107.189.40.49:1935/live/ptven/chunklist_w1092714967.m3u8
use_cookies="no"
chan_name="Press TV" ;;  

################################### TECHNOLOGY ##############################
# 55)  TWiT USA
55) 
keyword="TWiT Live"
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

#####method="Tor"
use_cookies="no"
chan_name="TWiT USA" ;;

##################################
# 56) Juptier Broadcasting USA
56) 
link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8	
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
### USTREAM ####
#link=http://www.ustream.tv/channel/JupiterBroadcasting
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
chan_name="Jupiter Broadcasting USA" ;;
#############################################################
# 57)Fiji One
57)
#link="https://livestream.com/accounts/19514369/fijitvstream"
#link="https://api.new.livestream.com/accounts/19514369/events/6947821/broadcasts/178003819.secure.m3u8?dw=80&hdnea=st=1532300156~exp=1532301956~acl=/i/19514369_6947821_lsij45kqt9nyyt15htt_1@356040/*~hmac=7bd7f4119ce7cfff884af05d0c80144ce702a3286ba1ca17619fa00c53cce643"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1628000,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=856x480
link="https://secure-playlist.livestream.com/streams/19514369_6947821_lsij45kqt9nyyt15htt_1/media/19514369_6947821_lsij45kqt9nyyt15htt_1@1628000pb.m3u8?dw=80&token=1532473173_75f7f9fa2b3331fb47f8cf81defa7993dc34e380&ts=1532296800"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1628000,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=856x480
#link="https://secure-playlist.livestream.com/streams/19514369_6947821_lsij45kqt9nyyt15htt_1/media/19514369_6947821_lsij45kqt9nyyt15htt_1@1628000p.m3u8?dw=80&token=1532473173_59e9e6991069b4127db610f63dcdd4d04f456795&ts=1532296800"
use_cookies="no"
chan_name="Fiji One" ;;

############################### SHOPPING ##########################################################
# 58)  QVC 
58) 
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
#####method="Tor"
use_cookies="no"
chan_name="QVC English" ;;
# 59) The Shopping Channel TSC
59)
#link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4000000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.2"
#link="http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_4_av-p.m3u8?sd=10&rebase=on"
#####method="Tor"
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 60) Gem Shopping Network USA
60)
#link="https://livestream.com/accounts/3486453/events/7709515"
#link="https://api.new.livestream.com/accounts/3486453/events/7709515/broadcasts/178029298.secure.m3u8?dw=80&hdnea=st=1532300554~exp=1532302354~acl=/i/3486453_7709515_lsiyxtcjcjke84h65gz_1@413907/*~hmac=61ae26efc1a2dc5876fb4f8434b3c0eb869b3e80eed1ef4e9c792e189bb8a359"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=198000,CODECS="avc1.42e020,mp4a.40.2",RESOLUTION=480x270
#link="https://playback.akamaized.net/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media/3486453_7709515_lsiyxtcjcjke84h65gz_1@198000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474039~acl=/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media*~hmac=b411b1d363a846e5e8ce90190cfcfe71425b0b2dd3d52c5be12fc6390ebeeab6"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=678000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=768x432
#link="https://playback.akamaized.net/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media/3486453_7709515_lsiyxtcjcjke84h65gz_1@678000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474039~acl=/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media*~hmac=b411b1d363a846e5e8ce90190cfcfe71425b0b2dd3d52c5be12fc6390ebeeab6"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=198000,CODECS="avc1.42e020,mp4a.40.2",RESOLUTION=480x270
#link="https://playback.akamaized.net/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media/3486453_7709515_lsiyxtcjcjke84h65gz_1@198000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474039~acl=/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media*~hmac=b411b1d363a846e5e8ce90190cfcfe71425b0b2dd3d52c5be12fc6390ebeeab6"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=678000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=768x432
link="https://playback.akamaized.net/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media/3486453_7709515_lsiyxtcjcjke84h65gz_1@678000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474039~acl=/streams/3486453_7709515_lsiyxtcjcjke84h65gz_1/media*~hmac=b411b1d363a846e5e8ce90190cfcfe71425b0b2dd3d52c5be12fc6390ebeeab6"
use_cookies="no"
chan_name="Gem Shopping Network USA" ;;
# 61) Lake Tahoe TV
61)
#link="https://livestream.com/accounts/21822229/events/6450069"
#link="https://api.new.livestream.com/accounts/21822229/events/6450069/broadcasts/178000980.secure.m3u8?dw=80&hdnea=st=1532301508~exp=1532303308~acl=/i/21822229_6450069_lsiirpz18wgyydwgi7p_1@365241/*~hmac=048f8ea81a7baa44423cf7c59797079549df1ca87c44288cc37b4f79515fd24a"

#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=198000,CODECS="avc1.42e020,mp4a.40.2",RESOLUTION=480x270
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@198000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=198000,CODECS="avc1.42e020,mp4a.40.2",RESOLUTION=480x270
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@198000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=2320000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=1280x720
link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@2320000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1756000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=864x486
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@1756000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=678000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=768x432
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@678000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=1756000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=864x486
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@1756000p.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=2320000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=1280x720
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@2320000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=678000,CODECS="avc1.4d0029,mp4a.40.2",RESOLUTION=768x432
#link="https://playback.akamaized.net/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media/21822229_6450069_lsiirpz18wgyydwgi7p_1@678000pb.m3u8?dw=80&ts=1532300400&hdnts=exp=1532474523~acl=/streams/21822229_6450069_lsiirpz18wgyydwgi7p_1/media*~hmac=74cf9456863e44042954daaade7b144e2bc72768d95dd3f847e20ff4b4184217"

use_cookies="no"
chan_name="Lake Tahoe TV" ;;
# 62)New Orleans TV2
62)
#link=http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3382572,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/chunklist_w1797542626.m3u8"
use_cookies="no"
chan_name="New Orleans TV" ;;
# 63) Atlanta Channel
63)
#link=http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3418933,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/chunklist_w2098604614.m3u8"
use_cookies="no"
chan_name="Atlanta Channel" ;; 
# 64)  TVW Washington State TV
64)
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1257472,CODECS="avc1.77.32,mp4a.40.2",RESOLUTION=1280x720
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b1155072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1066072,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=640x360
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b981072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=516072,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=426x240
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b481072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=351072,CODECS="avc1.66.21,mp4a.40.2",RESOLUTION=284x160
#link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_b331072.m3u8

use_cookies="no"
chan_name="TVW Washington State TV" ;; 

# 65) District of Columbia Network
65)
#link=http://video.oct.dc.gov/out/u/DCN.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=364035,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_5.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=664059,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_6.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864061,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=http://video.oct.dc.gov/out/u/21_7.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1064061,RESOLUTION=960x540,CODECS="avc1.4D401F,mp4a.40.2"
link=http://video.oct.dc.gov/out/u/21_8.m3u8
use_cookies="no"
chan_name="District of Columbia Network" ;;
# 66) MNN New York, USA
66)
#link="https://livestream.com/accounts/6478976/events/2616018"
#link="http://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.smil"
#link="https://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.secure.smil"
#link="http://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.m3u8?dw=80&hdnea=st=1532302872~exp=1532304672~acl=/i/6478976_2616018_lsijmgxu5lc98vrv9py_1@447454/*~hmac=4b08011d98f184c3a97ec486fc168bb0fa185dd7cfc0864c5f648785a949270b"

#link="https://api.new.livestream.com/accounts/6478976/events/2616018/broadcasts/178028951.secure.m3u8?dw=80&hdnea=st=1532302872~exp=1532304672~acl=/i/6478976_2616018_lsijmgxu5lc98vrv9py_1@447454/*~hmac=4b08011d98f184c3a97ec486fc168bb0fa185dd7cfc0864c5f648785a949270b"

#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=816000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x480
#link="https://secure-playlist.livestream.com/streams/6478976_2616018_lsijmgxu5lc98vrv9py_1/media/6478976_2616018_lsijmgxu5lc98vrv9py_1@816000pb.m3u8?dw=80&token=1532475954_8814f0f016db16c14d0af4f1710a3b824a6fc8ae&ts=1532300400"
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=816000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x480
link="https://secure-playlist.livestream.com/streams/6478976_2616018_lsijmgxu5lc98vrv9py_1/media/6478976_2616018_lsijmgxu5lc98vrv9py_1@816000p.m3u8?dw=80&token=1532475954_54f777b540ecfe39b78784999b0c987b56545cef&ts=1532300400"

use_cookies="no"
chan_name="MNN New York, USA" ;;
# 67) Laurel TV
67)
#link=https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=600000
link="https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist_w1745375646_b600000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=300000
#link="https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist_w1745375646_b300000.m3u8"
use_cookies="no"
chan_name="Laurel TV" ;;
# 68) Buzzr Game Shows
68)
link=https://www.twitch.tv/buzzr
#####method="Tor"
use_cookies="no"
chan_name="Buzzr (Game Shows)";;
# 69) RIDE TV Fort Worth TX USA
69)
link="https://livestream.com/accounts/21743165/events/6446017"
use_cookies="no"
chan_name="RIDE TV Fort Worth TX USA" ;;
# 70) Geek and Sundry
70)
link=https://www.twitch.tv/geekandsundry
use_cookies="no"
####method="Tor"
chan_name="Geek and Sundry";;
# 71) Buffalo TV
71)
#link=http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=607551,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=491x360
link="http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/chunklist_w1047718971.m3u8"
use_cookies="no"
chan_name="Buffalo TV" ;;
# 72) Beach TV DTVHD
72)
#link=http://media4.tripsmarter.com:1935/LiveTV/DTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3472194,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/DTVHD/chunklist_w1668636762.m3u8"
use_cookies="no"
chan_name="Beach TV -DTVHD" ;;

# 73) TSTV  Texas State University TV
73)
link=http://tstv-stream.tsm.utexas.edu/hls/livestream_hi/index.m3u8
#link=http://tstv-stream.tsm.utexas.edu/hls/livestream_low/index.m3u8
use_cookies="no"
chan_name="TSTV Texas State University TV" ;;

################################### FIOS1 ########################################### 
# 74) FiOS1 News New Jersey 
74)
#link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_if6bcg01/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
#link="https://urtmpkal-f.akamaihd.net/i/1if6bcg01_1@394073/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2096000,RESOLUTION=1920x1080,CODECS="avc1.66.30, mp4a.40.34"
link="https://urtmpkal-f.akamaihd.net/i/1if6bcg01_1@394073/index_1_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="FiOS1 News New Jersey" ;;

# 75) FiOS1 News Lower Hudson Valley
75)
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
use_cookies="no"
chan_name="FiOS1 News Lower Hudson Valley" ;;

###################### EUROPEAN UNION #################################
# 76) EBS European Commision
76)
link=https://ott.ec.streamcloud.be/live/disk1/EBS/hls_or/EBS-audio_AACL_qaa_66400_201=66400-video=800000.m3u8
use_cookies="no"
##method="Tor"
chan_name="EBS European Commision" ;;
# 77) EBS European Commision
77)
link=https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_or/EBSplus-audio_AACL_qaa_66400_401=66400-video=800000.m3u8
use_cookies="no"
##method="Tor"
chan_name="EBS Plus European Commision" ;;

############################### USTREAM  ##################################################
# 78) EuroNews English
78) 
keyword="euronews"
method="Tor-Streamlink"
link="http://www.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
#format=hls-1080
#format=hls-720
#format=hls-480 
#format=hls-380 
#format=hls-240
#link=http://www.dailymotion.com/video/x2j4h4m
#link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | grep "$keyword" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8
use_cookies="no"
chan_name="Euronews English" ;; 
# 79) NASA TV Media
79) 
keyword="Media"
link=http://www.ustream.tv/channel/nasa-media-channel
method="Streamlink"
format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 80) NASA TV Public Education
80) 
keyword="NASA TV Public-Education"
link=http://www.ustream.tv/nasahdtv
method="Streamlink"
format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Public-Education" ;; 

################################################    FRENCH   ###################################
# 81) France 24 
81)
keyword="FRANCE 24 en Direct" 
#link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master_900.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="France 24" ;;                                               
# 82) BFM TV
82) 
link=https://players.brightcove.net/876450610001/HJeY2afE_default/index.html?videoId=5615950982001
#link=https://bfmtvalive1-a.akamaihd.net/8a3483ffeb9d40f0a738c1392f2bcc14/eu-central-1/876450610001/profile_1/87cd96eea0644453bd913833950774b0/chunklist_ssaiM.m3u8
#link=http://csm-e.dai.bfmtv.com/csm/live/109797390.m3u8
#link=https://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
#link=link=https://www.filmon.com/tv/bfm-tv
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
#link="https://players.brightcove.net/876450612001/HycrnmXI_default/index.html?videoId=1920204345001"
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_0_fra/audio_0_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_0/video_0.m3u8
## link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_4_fra/audio_4_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_19/video_19.m3u8
link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-4.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-3.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-2.m3u8"
#link="http://bfmlive-i.akamaihd.net/hls/live/254438/876450612001/DVMR_BFMBusiness2/master-1.m3u8"
format=""
use_cookies="no"
method="Tor"
chan_name="BFM Busineess France" ;;
# 84) RT Francais
84)
#link=https://secure-streams.akamaized.net/rt-fr/index.m3u8
link=https://secure-streams.akamaized.net/rt-fr/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/indexaudio.m3u8
use_cookies="no"
#method="Tor"
chan_name="RT France" ;;
# 85) France Info TV
85) 
keyword="franceinfo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
#link=https://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
#link=https://livefrancetv.akamaized.net/simulcast/France_Info/dash_monde/ZXhwPTE1MjUxODIxMzZ+YWNsPSUyZnNpbXVsY2FzdCUyZkZyYW5jZV9JbmZvJTJmZGFzaF9tb25kZSp+aG1hYz1mZDU1NmM2NmE5ODExZWNlOGI5YjQ1MDc3ZDA2ZTQ4YTg1Y2FmNTkyNTdiY2Q4MWI1YzU4YjRiMWE0M2MxYmUw/France_Info.mpd
link="http://videos.francetv.fr/video/SIM_Franceinfo"
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
use_cookies="no"
#method="Tor"
chan_name="TV5 Monde Info FR" ;;
# 87) CGTN Francais 
87)
#link=https://live.cgtn.com/cctv-f.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=http://livefr.cgtn.com/1000f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=http://livefr.cgtn.com/500f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://livefr.cgtn.com/200f/prog_index.m3u8
use_cookies="no"
#method="Tor"
chan_name="CGTN Francais" ;; 
# 88) Euronews Francais
88) 
keyword="euronews"
method="Tor-Streamlink"
link="http://fr.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Francais" ;;  
# 89) Africa News Francais
89) 
keyword="DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
#method="Tor"
chan_name="Africa News Francais" ;;
# 90) TVA CA
90) 
link="https://players.brightcove.net/5481942443001/r1t0JFRjG_default/index.html?videoId=5536901934001"
use_cookies="no"
#method="Tor"
chan_name="TVA CA";;
# 91) RTS UN
91) 
#link=http://par-3.firstone.tv/hls/22797bb2-c681-91ce-2f29-fd5690f82b91.m3u8
link=https://www.filmon.com/tv/rts-un
use_cookies="no" 
#method="Tor"
chan_name="RTS UN" ;;
# 92) FRANCE 2
92) 
#link=http://par-4.firstone.tv/hls/1f181ce3-b1d5-70a2-8cc7-9f6ef5df7d89.m3u8
link=https://www.filmon.com/tv/france-2
use_cookies="no"
#method="Tor"
chan_name="France 2" ;;
# 93) France 3 
93) 
#link=http://par-4.firstone.tv/hls/f5d676d6-692f-eb8c-8c3c-34f741a0f7b3.m3u8
link=https://www.filmon.com/tv/france-3-rhone-alpes
use_cookies="no"
#method="Tor"
chan_name="France 3" ;;
# 94) ARTE FRANCAIS
94) 
link=https://www.filmon.com/tv/arte-francais
use_cookies="yes" 
#method="Tor"
chan_name="ARTE Francais" ;;
# 95) France O
95) 
link=https://www.filmon.com/tv/france-0
use_cookies="yes"
chan_name="France O" ;;
# 96) Bidtween La chaîne TV des Enchères FR
96)
link="https://livestream.com/accounts/25334545/events/7803598"
use_cookies="no"
chan_name="Bidtween La chaîne TV des Enchères FR" ;;
# 97) TV 7 Francais
97)  
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TV 7 Francais" ;;  
# 98) IL TV France
98)
link=rtmp://str81.creacast.com:80/iltv/high
use_cookies="no"
#method="Tor"
chan_name="IL TV" ;;
# 99) TLM Lyon Metro
99) 
keyword="TLM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 100) BFM Paris Francais
100)   
link=https://players.brightcove.net/5132998232001/H1bPo8t6_default/index.html?videoId=5152968636001
#link=http://bfmparishdslive-lh.akamaihd.net/i/DVMR_PARIS@429747/master.m3u8
use_cookies="no"
#method="Tor"
chan_name="BFM Paris Francais" ;;
# 101) Alsace 20 France
101)
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
use_cookies="no"
#method="Tor"
chan_name="Alsace 20 France" ;;
# 102) Mosaik TV Francais
102)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 103) Direct Journal TVLandes    
103) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Direct Journal Tvlandes"  ;;    
## 104)QVC Francais
104) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;  
# 105) 8 Mont Blanc FR
105)
link="http://www.dailymotion.com/video/x3wqv8b"
use_cookies="no"
#method="Tor"
chan_name="8 Mont Blanc FR" ;;
# 106) Azur TV Nice
106)
link=http://www.dailymotion.com/video/x13x1q2 
use_cookies="no"
#method="Tor"
chan_name="Azur TV Nice" ;;
# 107) RTS DEUX
107) 
#link=http://par-4.firstone.tv/hls/f1074899-4ce9-5908-4f1f-25aee6dc0ef7.m3u8
link=https://www.filmon.com/tv/rts-deux
use_cookies="no" 
#method="Tor"
chan_name="RTS DEUX" ;;
# 108) LCP Assemblee National France
108)
link=http://www.dailymotion.com/video/xji3qy
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="LCP Assemblee National France" ;;
# 109) Public Senate France
109)
link=http://www.dailymotion.com/video/xkxbzc
use_cookies="no"
#format=hls-720
format=hls-480	
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Public Senate France" ;;
# 110) CPAC 1 Francais
110)
#link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
link=http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8
use_cookies="no"
#method="Tor"
chan_name="CPAC 1 Francais Canada" ;;
# 111) Assemblee Nationale du Quebec Francais
111)
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="Assemblee Nationale du Quebec Francais Canada" ;;
# 112)Canal Savoir Francais
112)
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
use_cookies="no"
#method="Tor"
chan_name="Canal Savoir Canada" ;;
# 113) GONG Asian Cinema Francais
113)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="GONG Asian Cinema Francais" ;;
# 114) GONG MAX
114)
link=http://51.254.215.79/appflux/gongmax/GONGMAX/gongmax_1280/chunks.m3u8 
use_cookies="no"
#method="Tor"
chan_name="GONG MAX" ;;
# 115) BX1 BE
115)
#link=http://149.202.81.107:1935/stream/live/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1638908,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=960x540
link=http://149.202.81.107:1935/stream/live/chunklist_w635316941.m3u8
#link=http://149.202.81.107:1935/stream/live/chunklist_w1279780159.m3u8 
use_cookies="no"
#method="Tor"
chan_name="BX1 BE" ;;
# 116) France Info Radio
116) link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
format=hls-380
use_cookies="no"
#method="Tor"
chan_name="France Info Radio" ;;
# 117) Europe 1
117) link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Europe 1" ;;
# 118) RFI
118) 
keyword="RFI en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 119) RTL En direct
119) link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
# link=http://www.dailymotion.com/video/xl1km0
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#method="Tor"
chan_name="RTL En Direct" ;;
# 120) France Inter
120) 
keyword="France Inter en direct"
#link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#format=hls-720
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;; 

###################  SPANISH  #################################
# 121) RT Espanol
121) 
keyword="EN VIVO"
#link=https://secure-streams.akamaized.net/rt-esp/index.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index2500.m3u8
link=https://secure-streams.akamaized.net/rt-esp/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index800.m3u8
#####link=https://secure-streams.akamaized.net/rt-esp/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/indexaudio.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEIhICHOQOonjE6V0SLdrHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://actualidad.rt.com/en_vivo2
use_cookies="no"
method="Tor"
chan_name="RT Espanol" ;;
# 122) DW Espanol
122) 
keyword="DW Español en VIVO"
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
use_cookies="no"
#method="Tor"
chan_name="DW Espanol" ;;
# 123) CGTN Espanol
123)
#link=https://live.cgtn.com/cctv-e.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link="http://livees.cgtn.com/1000e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link="http://livees.cgtn.com/500e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
###link="http://livees.cgtn.com/200e/prog_index.m3u8"
use_cookies="no"
#method="Tor"
chan_name="CGTN Espanol" ;;
###################### FRANCIA ##########################################
# 124) France 24 Espanol
124) 
keyword="Vivo"
#link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_ES_LO_HLS/live_web.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master_900.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUdOoVWuWmgo1wByzcsyKDQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#method="Tor"
chan_name="France 24 Espanol" ;;
# 125) Euronews Espanol
125) 
keyword="euronews"
method="Tor-Streamlink"
link="http://es.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Espanol" ;;  
# 126) Hispan TV Iran
126) 
keyword="HispanTV"
#link=http://107.189.40.49:1935/live/hispantv/playlist.m3u8
#link=http://107.189.40.49:1935/live/hispantv/chunklist_w593385812.m3u8
#link=http://178.32.255.199:1935/live/hispantv/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV Iran" ;;
############## ESPANIA ######################################
# 127) Magala TV Spain  Malaga,Andalusia,Spain
127)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Magala TV Spain" ;;  
# 128)  GUADA TV Guadalajara (España)
128) 
keyword="Guada"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oPWmhiUTekfM5vcWsORLg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Guada TV Spain" ;; 
# 129) GRANADA TV ES
129)  
keyword="GRANADA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Steadycamline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="GRANADA TV ES" ;; 
######################### ARGENTINA ##############################################
# 130) c5n Argentina
130) 
keyword="C5N"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
# link=http://www.c5n.com/
use_cookies="no"
chan_name="c5n Argentina" ;;
# 131) Canal Acequia Mendoza AR
131)
link="https://livestream.com/accounts/6450028/events/5813077"
use_cookies="no"
chan_name="Canal Acequia Mendoza AR" ;;
# 132) Todo Noticias Argentina
132) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 133) La Nacion TV Argentina
133) 
keyword="LN+"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 134)TV5 Argentina
134)
link="https://livestream.com/accounts/20819504/events/6036256"
use_cookies="no"
chan_name="TV5 Argentina" ;;
# 135) KZO En Vivo Canal 30
135) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;; 
# 136)  Canal 2 Argentina
136)
link="https://livestream.com/accounts/679322/Canal2Jujuy"
use_cookies="no"
chan_name="Canal 2 Argentina" ;;
# 137) Canal 6 San Rafael Argentina 
137) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 138) Canal 7 Mendoza Argentina
138) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 139) Canal 13 San Juan Argentina  
139)  
keyword="Juan"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;; 
# 140) Canal 3 SuperCanal Argentina
140)  
keyword="SuperCanal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/supercanal3oeste/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 3 SuperCanal Argentina" ;;  
# 141) CN23 Argentina
141)  
keyword="CN23"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CN23 Argentina" ;;   
# 142) Telemax Argentina
142)
#link="http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=364000,RESOLUTION=320x180
#link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b364000_sleng.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864000,RESOLUTION=640x360
#link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b864000_sleng.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1828000,RESOLUTION=1280x720
link=http://live-edge01.telecentro.net.ar/live/smil:tlx.smil/chunklist_w813342727_b1828000_sleng.m3u8
use_cookies="no"
chan_name="Telemax Argentina" ;; 
# 143) VORTERIX AR
143)  
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="VORTERIX AR" ;;
# 144) TV Publica Argentina
144)  
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TV Publica Argentina" ;;

################ BOLIVIA ##################################
## 145) Bolivia TV BO
145)
link=https://livestream.com/accounts/10468276/boliviatv
use_cookies="no"
chan_name="Bolivia TV BO" ;; 
# 146) Cosmovision TV BO
146)
link="https://livestream.com/accounts/16628908/cosmovisionhd"
use_cookies="no"
chan_name="Cosmovision BO" ;;
######################       CHILE       #################################
# 147)Senal Internacional Mega Chile
147)  
keyword="en vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/programasmega/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
# 148)  CNN Chile CNN Chile
148)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
################## Colombia ###################
# 149)Telemedellin CO
149)  
keyword="Telemedellin"
link=https://livestream.com/accounts/4608897/events/7111788/
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCW_16ow2scNATL0NSxlBtPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telemedellin CO" ;; 
# 150) CTV Barranquilla Colombia
150) 
keyword="CTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJWpMkOWNk3wlj565Q0lpzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTV Barranquilla Colombia" ;;
# 151) Teleantioquia Espanol  Canal de televisión pública del Departamento de Antioquia. Colombia
151)
link="https://livestream.com/accounts/9427524/al-aire"
use_cookies="no"
chan_name="Teleantioquia CO" ;;
################# VENEZUELA
# 152) TeleSUR Venezuela
152) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
# link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 153) Globovision Venezeula
153) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 154) NTN24 Venezuela
154) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 155) CONSCIENCIA TV
155)  
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClUdUKaJ6qBoqe4o8qN9Bdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CONCIENCIA TV" ;;
# 156) VPItv Venezuela
156) 
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VPItv Venezuela" ;;
#################### CENTRAL AMERICA    ########################
## 157) Guatevision GT
157)
link=https://livestream.com/accounts/25697071/en-vivo
use_cookies="no"
chan_name="Guatevision GT" ;; 
#################### MEXICO #########################################################
# 158) Excelsior TV Mexico
158) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
## 159) Telesur Yucatan 
159)
link=https://livestream.com/accounts/1003100/events/4130805
use_cookies="no"
chan_name="Telesur Yucatan" ;; 
# 160) Azteca Uno MX
160)  
#link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_1_av-p.m3u8?sd=10&rebase=on"
#link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_2_av-p.m3u8?sd=10&rebase=on"
#link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_3_av-p.m3u8?sd=10&rebase=on"
#link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_1_av-b.m3u8?sd=10&rebase=on"
link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_2_av-b.m3u8?sd=10&rebase=on"
#link="http://aztecalive-lh.akamaihd.net/i/0qm7cjvop_1@502476/index_3_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Azteca Uno MX" ;;

 
####################################### NORTHERN EUROPE ##############################################################
################  GERMAN   #######################################
# 161) WDR Germany
161)
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
use_cookies="no"
chan_name="WDR Germany" ;;
# 162)DW Deutsch Welle 
162)
keyword="DW"
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
use_cookies="no"
chan_name="DW Deutsch Welle";;
# 163) ZDK InfoKanal
163)
link=http://www.filmon.com/tv/zdf-infokanal
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
# 164)  Tagessschau 24 Germany
164)
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
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 165) Euronews Deutsch
165) 
method="Tor-Streamlink"
link="http://de.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Deutsch" ;;
# 166)QVC DE 
166)
link="http://llnw.live.qvc.simplestream.com/hera/remote/qvcde_primary_sdi7/2/prog_index.m3u8"
use_cookies="no"
chan_name="QVC DE " ;;  
# 167) ADR Alpha Live DE
167)  
link="https://br-i.akamaihd.net/i/tafeln/br-fernsehen/br-fernsehen-tafel_,0,A,B,E,C,X,.mp4.csmil/index_2_av.m3u8?null=0"
use_cookies="no"
chan_name="ADR Alpha Live DE" ;;  
# 168) Radio 21 Nachreichten DE Germany 
168)
link="https://livestream.com/accounts/22300508/events/6675945"
use_cookies="no"
chan_name="Radio 21 Nachreichten DE" ;;
# 169)  DW Deutsch +     GEOregion blocked
169) 
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
method="Tor"
use_cookies="no"
chan_name="DW Deutsch + DE" ;;

################  Austria
# 170) W24 Wein Austria
170)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein, Austria" ;; 
# 171) Tirol TV Austria
171)
#link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
link=http://lb.hd-livestream.de:1935/live/TirolTV/chunklist_w1916857628.m3u8
use_cookies="no"
chan_name="Tirol TV Austria" ;;
# 172) auftanken.tv Austria
172)
link="https://livestream.com/accounts/26170820/events/7915290"
use_cookies="no"
chan_name="auftanken.tv Austria" ;;
############################### Switzerland###############################################
# 173) SRF CH
173)
link=http://www.filmon.com/tv/srf-1
use_cookies="yes"
chan_name="SRF CH" ;;
# 174) Musig24 TV Switzerland Deutsche
174)
link="https://livestream.com/accounts/16598383/events/6923855"
use_cookies="no"
chan_name="musig24 TV Switzerland Deutsche" ;;
################## DUTCH
########## BELGIUM 
# 175)TV OOST BE Dutch
175)
link="https://urtmpkal-f.akamaihd.net/i/156m2vpg5_1@322941/index_1_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="TV OOST BE Dutch" ;;  
########## NETHERLANDS
# 176)AT5 NETHERLANDS
176)
link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2628000,RESOLUTION=1280x720
#link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/chunklist_w806203331_b2628000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1628000,RESOLUTION=768x432
#link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/chunklist_w806203331_b1628000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=878000,RESOLUTION=640x360
#link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/chunklist_w806203331_b878000.m3u8
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;
#######################   EASTERN EUROPE ############################################
############### RUSSIAN ################################
# 177)  Euronews Russian
177)
#method="Tor-Streamlink"
#link="http://ru.euronews.com/live"
#format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist.m3u8
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_2m.m3u8
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_1m.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 178) Россия 24
178) 
keyword="24"
link=http://live.russia.tv/index/index/channel_id/3
#link=http://www.filmon.com/tv/rossiya-24
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 179) RBC TV RUSSIA
179)
link=http://online.video.rbc.ru/online/rbctv_480p/index.m3u8
#link=http://online.video.rbc.ru/online/rbctv_360p/index.m3u8
use_cookies="no"
chan_name="RBC TV Russia" ;;
# 180) CGTN Russian
180)
#link=https://live.cgtn.com/cctv-r.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
#link=http://liveru.cgtn.com/1000r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
link=http://liveru.cgtn.com/500r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://liveru.cgtn.com/200r/prog_index.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
# 181) Vesti FM Russia
181) 
keyword="Вести ФМ"
link=http://live.russia.tv/index/index/channel_id/199
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 182)  Current Time VOA
182)
keyword="НАСТОЯЩЕЕ ВРЕМЯ"
link=http://www.filmon.com/tv/current-time-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/currenttimetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Current Time VOA" ;;
# 183) RTR Planeta
183)
link=http://live.russia.tv/index/index/channel_id/82
#link=http://www.filmon.com/tv/rtr-planeta
use_cookies="no"
chan_name="RTR Planeta" ;;
# 184) Perviy Kanal Europa
184)
link=http://www.filmon.com/tv/perviy-kanal-europa
use_cookies="yes"
chan_name="Perviy Kanal Europa" ;;
# 185) Music Box Russia
185)
link=http://www.filmon.com/tv/music-box-russia
use_cookies="yes"
chan_name="Music Box Russia" ;;
# 186) MOSCKVA 24 RU
186)
link=http://live.russia.tv/index/index/channel_id/76
#link=http://www.ontvtime.ru/live/moskva24.html
use_cookies="no"
chan_name="MOSCKVA 24 RU" ;; 
# 187) 1TV HD RU
187)
link=https://edge1.1internet.tv/dash-live11/streams/1tv/1tvdash.mpd
#link=https://edge1.1internet.tv/hls-live/livepkgr/_definst_/1tv.m3u8
use_cookies="no"
chan_name="1TV HD RU" ;; 
# 188) Planeta Channel 4 Russia
188)
link=http://wse.planeta-online.tv:1935/live/channel_4/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 4 Russia" ;;
# 189) Planeta Channel 6 Russia
189)
link=http://wse.planeta-online.tv:1935/live/channel_6/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 6 Russia" ;;
# 190) ТВ-ТРЕЙЛЕР Russia
190)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="TPEYNEP TV RU" ;;
# 191) 5 RU
191)
keyword="Пятого канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGM8ZTtduKll7X8RiGe6N8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.ontvtime.ru/general/channel5.html
use_cookies="no"
chan_name="5 Live RU" ;;
# 192) POCCNR 1 HD RU
192)
#link=http://live.russia.tv/index/index/channel_id/86
link=http://live.russia.tv/index/index/channel_id/1
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news24ru/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="24 TV UA" ;;
# 194) UA TV Ukraine 
194) 
keyword="UATV"
link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_mid/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_hi/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_low/index.m3u8
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 195) Thromadske Ukraine
195) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 196) Еспресо Ukraine
196) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 197) News 1 Ukraine
197) 
keyword="NEWSONE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 198) ZIK UA
198)
keyword="ZIK"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUOsDBuiB_1zkRixc33TgSg/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ZIK UA" ;;
# 199) Ukraine Channel 5 
199) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
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
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;

########################### SOUTHERN EUROPE ################################################

##########################  Italian  ####################################################### 
# 201) RSI LA CH
201)
link=http://www.filmon.com/tv/rsi-la-1
use_cookies="yes"
chan_name="RSI LA CH" ;;
# 202) SkyTG 24 Italian
202)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 203) Telecolor Lombardia Italy
203)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 204) Teletutto Brescia Italy
204)
link="https://livestream.com/accounts/701633/events/4147166"
use_cookies="no"
chan_name="Teletutto Brescia Italy" ;;
# 205) QVC Itallian
205) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
# 206) Italia channel
206)
link="https://livestream.com/accounts/277367/events/7379093"
use_cookies="no"
chan_name="Italia channel" ;;
# 207) Mediaon BergamoTV Italian
207)
link="https://livestream.com/accounts/245066/events/3063596"
use_cookies="no"
chan_name="Mediaon BergamoTV Italian" ;;
# 208) news24.city Milan Italy 
208)
link="https://livestream.com/accounts/16586959/events/7803832"
use_cookies="no"
chan_name="news24.city Milan Italy " ;;
# 209) Radio Radio TV Rome Italy 
209)
link="https://livestream.com/accounts/11463451/tvlive"
use_cookies="no"
chan_name="Radio Radio TV Rome Italy" ;;
# 210) Udinews TV Udine Italy
210)
link="https://livestream.com/accounts/11217196/Udinese"
use_cookies="no"
chan_name="Udinews TV Udine Italy" ;;
# 211) DiTV Canale 89 Lucchese Channel Italy 
211)
link="https://livestream.com/accounts/21477830/events/7298093"
use_cookies="no"
chan_name="DiTV Canale 89 Lucchese Channel Italy " ;;
# 212) RTM TV Arcevia Italy
212)
link="https://livestream.com/accounts/10831729/events/3759913"
use_cookies="no"
chan_name="RTM TV Arcevia Italy" ;;
# 213) 50 News Versilia Viareggio Italy  
213)
link="https://livestream.com/accounts/25529830/events/7893732"
use_cookies="no"
chan_name="50 News Versilia Viareggio Italy" ;;
# 214) 50 Canale Pisa Italy 
214)
link="https://livestream.com/accounts/19968830/events/7801416"
use_cookies="no"
chan_name="50 Canale Pisa Italy" ;;
# 215) Telelibertà Piacenza Italy 
215)
link="https://livestream.com/accounts/17114188/events/4902226"
use_cookies="no"
chan_name="Telelibertà Piacenza Italy" ;;
# 216) ONE TV NBC 112 LIVE Milan Italy 
216)
link="https://livestream.com/accounts/1326279/events/8235236"
use_cookies="no"
chan_name="ONE TV NBC 112 LIVE Milan Italy" ;;
# 217) Euronews Italian 
217) 
method="Tor-Streamlink"
link="http://it.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Italian" ;;
################# MALTA #######################################
# 218)ONE Malta MT
218)
link="https://livestream.com/accounts/18398100/ONELive"
use_cookies="no"
chan_name="ONE Malta MT" ;;
###################  CROATIA   ##########################
# 219) Z1 Televizija Zagreb, Croatia 
219)
link="https://livestream.com/accounts/26764475/events/8122530"
use_cookies="no"
chan_name="Z1 Televizija Zagreb, Croatia " ;;
# 220) RTV Posavina TV Zagreb Croatia
220)
link="https://livestream.com/accounts/20748106/events/7596004"
use_cookies="no"
chan_name="RTV Posavina TV Zagreb Croatia" ;;
# 221) OsjeckaTV Zagreb Croatia 
221)
link="https://livestream.com/accounts/20748093/events/6049691"
use_cookies="no"
chan_name="OsjeckaTV Zagreb Croatia " ;;
# 222) Tomix TV Wein AT Croatian 
222)
link="https://livestream.com/accounts/12156095/events/3802250"
use_cookies="no"
chan_name="Tomix TV Wein AT Croatian" ;;

########################### HUNGARIAN ####################################
# 223) Euronews Hungarian
223) 
method="Tor-Streamlink"
link="http://hu.euronews.com/live"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCz69ZZjQ_9TnZPCgfVUQjxQ/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky TV Folk Skopje, Macedonia MK";;
## 225) Star Lamia
225) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 226) Action 24 Greece HD
226) 
link=http://www.dailymotion.com/video/x61fbhs
use_cookies="no"
chan_name="Action 24 Greece HD" ;;
# 227) Euronews Greek
227) 
method="Tor-Streamlink"
link="http://gr.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsgr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Greek" ;;

################### TURKEY  ########################  
## 228) TRT Haber Turkey 
228) 
keyword="TRT"
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
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 229) NTV Turkey
229) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 230) HaberTurk TV
230) 
keyword="Habertürk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 231) Star TV  Turkish
231)
keyword="Star"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 232) CNN Turk 
232) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 233) KRT Kulture TV
233) 
keyword="KRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 234) La Legul TV
234) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 235) TGRT Haber TV
235) 
keyword="TGRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 236) TVNET Canali Yayin
236) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 237) Show TV Turkey
237) 
keyword="Show"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Show TV Turkey" ;;
# 238) Euronews Turkish
238) 
method="Tor-Streamlink"
link="http://tr.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="LIVE" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsgr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Turkish" ;;



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
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
#link=https://secure-streams.akamaized.net/rt-arab/index.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index2500.m3u8
link=https://secure-streams.akamaized.net/rt-arab/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-arab/indexaudio.m3u8
use_cookies="no"
chan_name="RT Arabic" ;;
# 242) France 24 Arabic
242) 
keyword="الأخبار "
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://static.france24.com/live/F24_AR_LO_HLS/live_web.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1095600,AVERAGE-BANDWIDTH=1095600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000,AUDIO="program_audio"
link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master_900.m3u8
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_1",AUTOSELECT=YES,DEFAULT=YES,URI="master_96.m3u8"
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 243) BBC Arabic
243) 
keyword="BBC Arabic Live"
#link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_192_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
link="http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_800_av-p.m3u8?sd=10&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 244)  DW Arabic
244) 
keyword="DW عربية مباشر"
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
use_cookies="no"
chan_name="DW Arabic" ;;
# 245) CGTN Arabic
245)
#link=https://live.cgtn.com/cctv-a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=http://livear.cgtn.com/1000a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=http://livear.cgtn.com/500a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=http://livear.cgtn.com/200a/prog_index.m3u8
use_cookies="no"
chan_name="CGTN Arabic" ;;

####################################################################################
# 246) Al Jazeera Arabic Qatar
246) 
keyword="Live Stream"
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/appleman.m3u8
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/300.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/160.m3u8
#link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/160audio.m3u8
#link=http://www.aljazeera.net/broadcastschedule
#link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 247) Al Jazeera Documentary Arabic 
247) 
link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/1600kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/1200kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/800kStream.m3u8
#link=http://aljazeera-doc-apple-live.adaptive.level3.net/apple/aljazeera/hq-doc/600kStream.m3u8
use_cookies="no"
chan_name="Al Jazeera Documentary Arabic " ;;  
############################## SAUDI TV   #########################################
# 248) Saudi Channel 1 Green 
248) 
keyword="القناة"
#link=https://www.filmon.com/tv/saudi-arabian-tv-1
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/index.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/Index1400.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Saudi Channel 1 Green" ;;
# 249) Saudi Channel 3 Blue
249) 
keyword="القناة" 
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/index.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1669967,CODECS="avc1.4d401e,mp4a.40.2",PROGRAM-ID=1,RESOLUTION=854x480
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/Index1400.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 3 Blue" ;;  
# 250) Saudi Sports Channel 4 Red
250) 
keyword="القنوات"
#link=https://www.filmon.com/tv/saudi-arabian-tv-sports
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/index.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/Index1400.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Sports Channel 4 Red" ;;
# 251) Saudi Cultural Channel 6 Orange
251) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/Index1400.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/3.m3u8
use_cookies="no"
chan_name="Saudi Cultural Channel 6 Orange" ;;
# 252) Saudi TV Channel 7 Gold  Mecca Kabba
252) 
keyword="Live Stream"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/Index1400.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/3.m3u8
use_cookies="no"
chan_name="Saudi Channel 7 Gold" ;; 
# 253) Saudi Sliver Educational Channel 8
253) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/Index1400.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/3.m3u8
use_cookies="no"
chan_name="Saudi Silver Channel 8" ;; 
# 254) Saudi Ajyal Kids TV Channel 9
254) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/Index1400.m3u8
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/3.m3u8
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv Channel 9" ;; 

# 255) Al Arabiya, Dubai, United Arab Emirates 
255) 
keyword="قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya, Dubai, UAE " ;;
# 256) Al Mayadeen,  Beirut, Lebanon
256) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen, Beirut, Lebanon" ;;  
# 257) Belqees TV Yemen Arabic
257)
keyword="قناة بلقيس "
#link="https://livestream.com/accounts/12233888/events/3819374"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belqees TV Yemen Arabic" ;;
# 258) SKY Arabic, Abu Dhabi, UAE
258) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic, Abu Dhabi, UAE" ;;
# 259)Alghad TV Cairo Egypt
259)  
keyword="Alghad"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaJykDM6rs776xPgzVvLkzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="AlGhad, Cairo, Egypt" ;; 
# 260) eXtra News Egypt Arabic
260) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 261) CBC Egypt Sofra Arabic
261) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 262) CBC Egypt Arabic Drama 
262) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 263) DMC Live EG
263) 
keyword="dmc"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE EG" ;;
# 264) Al-Fallujah Tv Channel IRAQ
264)
link="https://livestream.com/accounts/4671269/falluajh"
#link=https://livestream.com/karbala-tv/events/7672592
use_cookies="no"
chan_name="Al-Fallujah Tv Channel IRAQ" ;; 
# 265) AFAQ TV IRAQ
265) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/afaqiraq/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="AFAQ TV IRAQ" ;; 
# 266) Karbarla Satellite Channel IRAQ
266)
#link="https://livestream.com/accounts/11436227/events/3998452"
link="https://livestream.com/karbala-tv/events/3998452"
use_cookies="no"
chan_name="Karbarla Satellite Channel IRAQ" ;;
# 267) Euronews Arabic
267) 
keyword="euronews"
method="Tor-Streamlink"
link="http://arabic.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Arabic" ;;  
# 268) ANB TV ANBSAT Assyrian National Broadcasting, San Jose California USA
268)
link="https://livestream.com/accounts/933317/events/2295471"
use_cookies="no"
chan_name="ANB TV Assyrian National Broadcasting, San Jose California USA" ;;
# 269)Suryoyo Sat Södertälje, Sweden  Syrian Turoyo
269)
link="https://livestream.com/accounts/10187302/events/6785118"
use_cookies="no"
chan_name="Suryoyo Sat Södertälje, Sweden Syrian Turoyo " ;;
# 270) Safeer TV UK Islamic
270)
link="https://livestream.com/karbala-tv/events/7672592"
use_cookies="no"
chan_name="Safeer TV UK Islamic" ;;
################################## FARSI / PERSIAN  ###########################################################
# 271)  BBC Persian
271) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
# 272)  Iran Aryaee San Bernadino California 
272)
link="https://livestream.com/accounts/11825802/events/3752117"
use_cookies="no"
chan_name="Iran Aryaee San Bernadino California" ;;
# 273) DidgahNew TV Iranian 
273)
link="https://livestream.com/accounts/27146356/events/8147101"
use_cookies="no"
chan_name="DidgahNew TV Iranian" ;;
# 274) Aryen TV Iran Kurdish
274)
link="https://livestream.com/accounts/22902829/events/7609059"
use_cookies="no"
chan_name="Aryen TV Iran Kurdish" ;;
# 275) PTN Pars TV USA Persian
275)
link="https://livestream.com/accounts/5901056/events/4455330"
use_cookies="no"
chan_name="PTN Pars TV USA Persian" ;;
# 276)Euronews Farsi (Persian)
276) 
keyword="euronews"
method="Tor-Streamlink"
link="http://fa.euronews.com/live"
format="720p"
## Formats 90p (worst), 180p, 224p, 360p, 540p, 720p (best)
keyword="direct"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
#method="Tor"
chan_name="Euronews Farsi Persian" ;;  
################# AFGHANISTAN ######################################
# 277) Ariana TV Afghanistan
277) 
link="https://livestream.com/accounts/9180830/events/6727975"
use_cookies="no"
chan_name="Ariana TV Afghanistan" ;;
## 278) TOLO NEWS AFGHANISTAN
278) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";;

# 279)
# 280)
 
###########################################################  PAGE 2  ###############################################################


##################### PAKISTAN  ############################
# 281)Aaj News PK
281) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdHy-hnyIEZBHkPJecz9RtA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
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
link="https://livestream.com/accounts/23191280/events/8122971"
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
link="https://livestream.com/accounts/13207573/cgntv"
use_cookies="no"
chan_name="CGNTV America Korean Los Angeles California " ;;
# 353) YTV America Live Korean LA CA USA
353)
link="https://livestream.com/accounts/15217951/events/4355473"
use_cookies="no"
chan_name="YTV America Live Korean LA CA USA" ;;
# 354) Atlanta Radio Korea AM790
354)
link="https://livestream.com/accounts/19465449/events/6357808"
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

########### TOO SLOW Find Substitutes
#CHC高清电影,http://ivi.bupt.edu.cn/hls/chchd.m3u8
#CCTV-1HD,http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8
#CCTV-1,http://ivi.bupt.edu.cn/hls/cctv1.m3u8
#CCTV-2,http://ivi.bupt.edu.cn/hls/cctv2.m3u8
#CCTV-3HD,http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8
#CCTV-3,http://ivi.bupt.edu.cn/hls/cctv3.m3u8
#CCTV-4,http://ivi.bupt.edu.cn/hls/cctv4.m3u8
#CCTV-5HD,http://ivi.bupt.edu.cn/hls/cctv5hd.m3u8
#CCTV-5,http://ivi.bupt.edu.cn/hls/cctv5.m3u8
#CCTV-5+HD,http://ivi.bupt.edu.cn/hls/cctv5phd.m3u8
#CCTV-6HD,http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8
#CCTV-6,http://ivi.bupt.edu.cn/hls/cctv6.m3u8
#CCTV-7,http://ivi.bupt.edu.cn/hls/cctv7.m3u8
#CCTV-8HD,http://ivi.bupt.edu.cn/hls/cctv8hd.m3u8
#CCTV-8,http://ivi.bupt.edu.cn/hls/cctv8.m3u8
#CCTV-9,http://ivi.bupt.edu.cn/hls/cctv9.m3u8
#CCTV-10,http://ivi.bupt.edu.cn/hls/cctv10.m3u8
#CCTV-11,http://ivi.bupt.edu.cn/hls/cctv11.m3u8
#CCTV-12,http://ivi.bupt.edu.cn/hls/cctv12.m3u8
#CCTV-13,http://ivi.bupt.edu.cn/hls/cctv13.m3u8
#CCTV-14,http://ivi.bupt.edu.cn/hls/cctv14.m3u8
#CCTV-15,http://ivi.bupt.edu.cn/hls/cctv15.m3u8

####################################### SOUTH ASIAN ####################################################################
################# TAGALOG FILIPINO #############################       
# 361) DZMM ABS-CBN Philippeans Radio
361) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 362) DZRH Philippeans
362) 
keyword="DZRH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 363) PTV Philippines
363)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;

################ Indonesia  #########################################
# 364) Net TV Jakarta Indonesia
364) 
keyword="Net" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Net TV Jakarta Indonesia" ;;
##################### Southeast Asian #########################################
# 365) skynet MNTV Myanmar
365)
link="https://livestream.com/accounts/7228455/events/3875913"
use_cookies="no"
chan_name="MNTV Myanmar MM" ;;
# 366) skynet Buddha Myanmar
366)
link="https://livestream.com/accounts/7228455/events/3875181"
use_cookies="no"
chan_name="Buddha Myanmar MM" ;;
# 367) skynet Up To Date Myanmar
367)
link="https://livestream.com/accounts/7228455/events/3875178"
use_cookies="no"
chan_name="skynet Up To Date Myanmar MM" ;;
# 368) skynet HLUTTAW Myanmar
368)
link="https://livestream.com/accounts/7228455/events/4442869"
use_cookies="no"
chan_name="skynet HLUTTAW Myanmar MM" ;;
############### Viet Nam  #####################################
# 369) VietTV VN
369)
link=http://www.filmon.com/tv/vtc-10
use_cookies="yes"
chan_name="VietTV VN" ;;
# 370) Viet Sky TV Anaheim California
370)
link="https://livestream.com/accounts/27136431/events/8142772"
use_cookies="no"
chan_name="Viet Sky TV Anaheim California" ;;
# 371) ABHPTV Daily Broadcast Vietnamese  An Bình Hạnh Phúc
371)
link="https://livestream.com/accounts/13311218/events/7250967"
use_cookies="no"
chan_name="ABHPTV Daily Broadcast An Bình Hạnh Phúc Vietnamese " ;;
#####################################
# 372) Earthquake 24  
372) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 373) Arirang News 
373) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang News TV" ;; 
# 374) Arirang TV Korean 
374) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangkorean/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang TV Korean" ;; 
# 375) OnTV Hong Kong
375) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
#########################################   AFRICA    ##############################################
# 376) Channels 24 Nigeria
376) 
keyword="Channels Television"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
#link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;
# 377)TVC News Nigeria
377) 
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 378) TVC Continental Nigeria
378) 
keyword="TVC Continental Nigeria"
link=http://77.92.76.135:1935/tvce/livestream/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC Continental Nigeria";;
# 379) NTV Uganda
379) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 380)  KTN Kenya
380) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 381) Joy News Ghana
381) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 382)  ADOM TV 
382) 
keyword="Adom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV Ghana" ;;    
# 383) Bukedde TV
383) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bukedde TV";;
# 384)Telefishinka Qaranka Somalia
384) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCi5fZhV7tPitSjnhEHJirGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Telefishinka Qaranka Somalia";;
# 385) EBC Ethiopia 
385) 
keyword="live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="EBC Ethiopia";;
# 386) SPARK TV Uganda
386)
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SPARK TV Uganda" ;;  
# 387) Walf TV Senegal
387)  
link=http://www.dailymotion.com/video/x5s5vw3
use_cookies="no"
chan_name="Walf TV Senegal" ;; 
# 388) EriTV Eritrea
388)
link=http://www.filmon.com/tv/eri-tv
use_cookies="yes"
chan_name="EriTV Eritrea" ;;  
# 389) EbruTV Kenya  
389)
link=http://www.dailymotion.com/video/x67n3k1
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
format=hls-240
chan_name="EbruTV Kenya" ;;
# 390)KTN Home Kenya
390)
link=http://www.dailymotion.com/video/x67ck0p
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="KTN Home Kenya" ;;
# 391)SABC Digital News South Africa
391) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;;  
# 392) Africa News Live
392)
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 393)Afro World View South Africa ZA
393) 
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
# 394) Africa24
394) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;; 
# 395) SIKKA TV Afrique
395) 
keyword="en Direct "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SIKKA TV Afrique" ;; 
# 396) K24 Nairobi Kenya
396)
link="https://livestream.com/accounts/17606245/events/4832042"
use_cookies="no"
chan_name="K24 Nairobi Kenya" ;;
# 397) iTV Networks South Africa 
397)
link="https://livestream.com/accounts/7079896/events/4406003"
use_cookies="no"
chan_name="iTV Networks South Africa" ;;
# 398) Parliament of the Republic of South Africa ZA
398) 
keyword="Plenary"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ParliamentofRSA/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Parliament of the Republic of South Africa ZA" ;; 

# 399)
# 400)

##################################### LOCAL NEWS USA #################################################################### 
# 401) RSBN Auburn Alabama USA
401) 
keyword="RSBN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA" ;; 
# 402) Fox News 10 Phoenix Arizona USA 
402) 
keyword="FNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";;    
############################ LOCAL NEWS USA############################################# 
# 403) Seminole TV Florida
403) 
link=http://video.seminolecountyfl.gov:1935/live/SGTV/chunklist.m3u8
use_cookies="no"
chan_name="Seminole TV (Florida)" ;;

############################  TRANSIENT BROADCAST NEWS #############################################
# 404) CBS 4 News Boston
404) 
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
#link=http://54.163.107.81/server/play/cbslocal-wbzx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 4 News, WBZ, Boston, Massachusetts" ;;
# 405) WVIT 30 News Hartford
405) 
link=http://wvitlive-f.akamaihd.net/i/wvitb2_1@71164/master.m3u8
use_cookies="no"
chan_name="WVIT 30 News Hartford" ;;
# 406) NBC 10 News (Philadelphia)
406) 
link=http://wcaulive-f.akamaihd.net/i/wcaua1_1@13991/master.m3u8
use_cookies="no"
chan_name="NBC 10 News Philadelphia" ;;
# 407) CBS 5 News Colorado/ FOX 4 Kansas 
407) 
link=http://krex-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 5 Colorado" ;;
# 408) NBC 11 Bay Area
408) 
link=http://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/index_1286_av-p.m3u8
use_cookies="no"
chan_name="NBC 11 Bay Area" ;;
# 409) CBS 13 News Stockton California USA
409) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kovrx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 13 News Stockton California USA" ;;
# 410) KCAL 9 News Los Angeles
410) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kcal-dfp/master.m3u8
use_cookies="no"
chan_name="KCAL 9 News Los Angeles" ;;
# 411) WXXV25 24/7 Mississippi
411)
link=http://api.new.livestream.com/accounts/22998687/events/6864865/live.m3u8
use_cookies="no"
chan_name="WXXV25 24/7 Mississippi" ;; 
# 412) NBC News Channel 13 (WNYT-TV)
412)
link=http://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 WNYT-TV";;
# 413) NBC2 South West Florida
413)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NBC2swfl/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="NBC2 South West Florida" ;;  
# 414) WCCB Charlotte, South Carolina
414)
link=http://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB Charlotte, South Carolina" ;;

########################### NEWS FEEDS #########################################
# 415) WSJ Live
415)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 416)  CTV NEWS Canada
416)
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
# 417) CNN Event 1
417)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 1" ;;
# 418) CNN Event 2
418)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 2" ;;
# 419) CNN Event 3
419)
link=http://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/master.m3u8
#https://cnn-i.akamaihd.net/hls/live/253955/dotcomlive_3/v2/master.m3u8
use_cookies="no"
####method="Tor"
chan_name="CNN Event 3" ;;
# 420) NBC News Live Event
420)
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


# 422) Beach TV - Panama City
422)
#link=http://media4.tripsmarter.com:1935/LiveTV/BTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3361387,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/BTVHD/chunklist_w1613239205.m3u8"
use_cookies="no"
chan_name="Beach TV - Panama City" ;; 
# 423) Beach TV - Pawleys Island
423)
#link=http://media4.tripsmarter.com:1935/LiveTV/MTVHD/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3363641,CODECS="avc1.100.40,mp4a.40.2",RESOLUTION=1280x720
link="http://media4.tripsmarter.com:1935/LiveTV/MTVHD/chunklist_w1433596674.m3u8"
use_cookies="no"
chan_name="Beach TV - Pawleys Island" ;;

# 424)What America Thinks
424) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 425) Bloomberg Europe
425)
#link=https://www.bloomberg.com/live/europe
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_live.m3u8
#link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/master.m3u8
#link=http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 426) Bloomberg Asia
426)
#link=https://www.bloomberg.com/live/asia
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_live.m3u8
use_cookies="no"
chan_name="Bloomberg Asia" ;;
# 427) BYUTV International
427)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
# 428) Arirang Radio English 
428) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
# 429) HSN
429) 
keyword="Live Stream"
#link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
link=https://www.youtube.com"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | awk ' BEGIN { RS= ":"}{ print}' | grep "watch?v=" | head -n 1 | cut -d \" -f 2)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 430) HSN 2
430) 
keyword="HSN2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 431)Bloomberg Australia
431)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/aus_live.m3u8
use_cookies="no"
chan_name="Bloomberg Australia" ;;
#################### TRANSIENT ######################################## 
# 432) Bloomberg US Politics
432)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_politics.m3u8
use_cookies="no"
chan_name="Bloomberg US Politics" ;;
# 433) Bloomberg Live Event
433)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_event.m3u8
use_cookies="no"
chan_name="Bloomberg US Live Event" ;;
# 434) Bloomberg EU Live Event
434)
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_event.m3u8
use_cookies="no"
chan_name="Bloomberg EU Live Event" ;;
# 435) Bloomberg Asia Live Event
435)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_event.m3u8
use_cookies="no"
chan_name="Bloomberg Asia Live Event" ;;
# 436) Weather Network Canada
436) 
link="https://players.brightcove.net/1942203455001/SkHslaO1M_default/index.html?videoId=5536901934001"
use_cookies="no"
chan_name="Weather Network CA";;
######################## PODCAST ###########################################
# 437) PBS NewsHour Video
437) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 438)  CBC The National
438) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 439) AP Top Stories
439) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 440) Democracy Now Headlines 
440) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;   
################### Entertainment #############################
# 441) Heart TV
441)
#link=http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=398000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_398_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=398000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_398_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_656_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_656_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_1500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_1500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=48000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_398_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=48000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/index_398_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Heart TV" ;;
# 442) Capital TV
442)
#link=http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=382000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_382_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=382000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_382_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_664_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_664_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_2628_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_2628_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4756000,RESOLUTION=1920x1080,CODECS="avc1.64001f, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_4756_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4756000,RESOLUTION=1920x1080,CODECS="avc1.64001f, mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_4756_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_382_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_382_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Capital TV" ;;
# 443) Music Choice Play HD
443)
#link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/playlist.m3u8
link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/chunklist.m3u8
use_cookies="no"
chan_name="Music Choice Play HD" ;;
# 444)M2O Music
444) 
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
# 445) Radio Monte Carlo RMC
445)
#link=http://wow01.105.net/live/rmc1/playlist.m3u8  
#EXT-X-STREAM-INF:BANDWIDTH=1009334,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=720x432
link=http://wow01.105.net/live/rmc1/chunklist_w1187407711.m3u8
#link=rtmp://fms.105.net:1935/live/rmc1
use_cookies="no"
chan_name="Radio Monte Carlo" ;; 
# 446) Virgin Radio
446) 
#link=http://wow01.105.net/live/virgin1/playlist.m3u8  
#EXT-X-STREAM-INF:BANDWIDTH=1026811,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=720x432
link=http://wow01.105.net/live/virgin1/chunklist_w1964894926.m3u8
# link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Radio" ;;
# 447) H!T Music Channel
447)
link=http://1mstream.digicable.hu/hitmusic/hitmusic.m3u8
use_cookies="no"
chan_name="H!T Music Channel" ;;
# 448) Now Music TV
448)
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
# 449) California Music Channel
449)
link=http://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMCUSA/CCURstream0.m3u8
use_cookies="no"
chan_name="California Music Channel" ;;
# 450) NRJ Hits Francais
450)
link=http://5.196.138.6:1935/live/nrjbelgique/chunklist_w1339281553.m3u8   
use_cookies="no"
chan_name="NRJ Hits Francais" ;;
# 451) Pitchoun FR
451)
link=https://www.dailymotion.com/video/x5zaibr 
use_cookies="no"
chan_name="Pitchoun FR" ;;
# 452) О2 ТV RU
452)
#link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1861651,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=854x480
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/chunklist.m3u8
use_cookies="no"
chan_name="O!2 TV RU" ;;
# 453) SONG TV Armenia AM
453) 
#link=http://mtvam.ru/hlsam/playlist.m3u8
#BANDWIDTH=350000
#link=http://91.232.135.156/hlsam/low/playlist.m3u8
#BANDWIDTH=650000
link=http://91.232.135.156/hlsam/med/playlist.m3u8
#BANDWIDTH=950000
#link=http://91.232.135.156/hlsam/high/playlist.m3u8
#BANDWIDTH=1800000
#link=http://91.232.135.156/hlsam/lhigh/playlist.m3u8
#BANDWIDTH=3800000
#link=http://91.232.135.156/hlsam/hd/playlist.m3u8
use_cookies="no"
chan_name="SONG TV Armenia AM" ;; 
# 454) Rockland Radio TV
454)
link="https://livestream.com/accounts/22300522/events/6680139"
use_cookies="no"
chan_name="Rockland Radio TV" ;;
# 455) KPOP IDOL
455) 
keyword="KPOP" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/imbcevery1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KPOP IDOL" ;;




#################### REALITY / LIVE ACTION #########################
#  456) Adult Swim 
456) 
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
# 457) Smile of a Child
457)
#link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_282_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=282000,RESOLUTION=192x144,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_282_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_564_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=384x288,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_564_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1164000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1728_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1728_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_282_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=32000,CODECS="mp4a.40.2"
#link="http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_282_a-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="Smile of a Child" ;;
################################################################################
##################### ANIMATION ############################## 
# 458) PJ Masks
458) 
keyword="PJ" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCY2jUnU118sVkdj2xafiJ0g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PJ Masks" ;;
# 459) Talking Tom and Friends
459) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 460) Talking Tom and Friends Minis
460) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
# 461) Fashion TV Europe
461)  
link=http://www.dailymotion.com/video/x3m6nld
use_cookies="no"
chan_name="Fashion TV Europe" ;; 
# 462) Fashion 1 Spain
462) 
link=http://www.dailymotion.com/video/x2t9nsf
use_cookies="no"
chan_name="Fashion 1 Spain" ;; 
# 463) Jasmin TV
463) 
#link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8 
link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/chunklist_w1121252134.m3u8
use_cookies="no"
chan_name="Jasmin TV" ;;  
# 464) The Young Turks
464)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
#############################################################
###############################   SPORTS   ######################################################
# 465) MLB Network
465)
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
# 466) NFL Now Live
466)
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
# 467) RED BULL TV 
467)
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
# 468) STADIUM
468)
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
# 469) Smart Lifestyle TV Pheonix AZ USA
469)
link="https://livestream.com/accounts/6553551/events/7989257"
use_cookies="no"
chan_name="Smart Lifestyle TV Pheonix AZ USA" ;;
######################### TWITCH  ##############################################
# 470) All Key shop
470)
link=https://www.twitch.tv/allkeyshop_tv
use_cookies="no"
####method="Tor"
chan_name="All Key Shop";;
# 471) Sorgatronmedia
471)
link=https://www.twitch.tv/sorgatronmedia
use_cookies="no"
####method="Tor"
chan_name="Sorgatronmedia";;
# 472) Amouranth
472)
link=https://www.twitch.tv/amouranth
use_cookies="no"
####method="Tor"
chan_name="Amouranth";;



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
link="https://livestream.com/accounts/19963560/events/5721749"
use_cookies="no"
chan_name="CTND Catholic Television Network Detroit" ;;
# 489) Shalom Media Catholic USA 
489)
link="https://livestream.com/shalomworld/events/7359508"
use_cookies="no"
chan_name="Shalom Media Catholic USA" ;;
# 490) Shalom Media Catholic Australia
490)
link="https://livestream.com/shalomworld/events/7551704"
use_cookies="no"
chan_name="Shalom Media Catholic Auastralia" ;;
# 491) Shalom Media Catholic Europe
491)
link="https://livestream.com/accounts/25038049/events/7358643"
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
link="https://livestream.com/shalomworld/events/7511845"
use_cookies="no"
chan_name="Shalom Media Catholic America"  ;;
# 517) Shalom Media Catholic India
517)
link="https://livestream.com/shalomworld/events/7483919"
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
link="https://livestream.com/accounts/2090099/events/7221364"
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
link=https://livestream.com/accounts/4699618/live
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

# 540) Planeta Channel 2 Russia
540)
link=http://wse.planeta-online.tv:1935/live/channel_2/chunklist.m3u8
use_cookies="no"
chan_name="TBTYP TV Planeta Channel 2 Russia" ;;
# 541) Planeta Channel 3 Russia
541)
link=http://wse.planeta-online.tv:1935/live/channel_3/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 3 Russia" ;;
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

# 560
################## MENU 3   ##################
#561

#600
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
link="http://unlimited1-us.dps.live/ucvtv/ucvtv.smil/ucvtv/livestream2/chunks.m3u8?nimblesessionid=14582063"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
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
link=https://livestream.com/accounts/25680986/events/7856569
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
link=https://livestream.com/accounts/1359588/Noticiero24Horas
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
link="https://livestream.com/accounts/16550960/events/8077197"
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
link="https://livestream.com/accounts/13907141/lamegabogota"
use_cookies="no"
chan_name="La Mega Bogotá 90.9 FM CO" ;;
# 639)TV UNAM MX
639)
link="https://livestream.com/accounts/27177136/events/8157904"
use_cookies="no"
chan_name="TV UNAM MX" ;;
# 640)Canal Telecafé CO
640)
link="https://livestream.com/accounts/1015476/events/7158511"
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
link="https://livestream.com/accounts/8817409/events/7051352"
use_cookies="no"
chan_name="EsteCanal TV" ;;
# 643) Cinevision Canal 19 Dominican Republic 
643)
link="https://livestream.com/accounts/9430235/canal19"
use_cookies="no"
chan_name="Cinevision Canal 19 Dominican Republic" ;;
# 644) Nuevolaredo.tv Flujo de Puentes Internacionales nuevo laredo MX
644)
link="https://livestream.com/accounts/13480210/events/4837379"
use_cookies="no"
chan_name="Neuvo Larado TV MX" ;;
# 645) Sinart Digital Señal Canal 13 CR 
645)
link="https://livestream.com/accounts/1532727/events/8158158"
use_cookies="no"
chan_name="Sinart Digital Señal Canal 13 CR " ;;
# 646) BethelTV Bethel Panamá
646)
link="https://livestream.com/accounts/16567960/events/7963429"
use_cookies="no"
chan_name="BethelTV Bethel Panamá" ;;
# 647) Poder de Dios TV La Paz Bolivia
647)
link="https://livestream.com/accounts/25268891/TV"
use_cookies="no"
chan_name="Poder de Dios TV La Paz Bolivia" ;;
# 648) TVDIÁRIO 145 Mexico 
648)
link="https://livestream.com/accounts/7328757/events/7373344"
use_cookies="no"
chan_name="TVDIÁRIO 145 Mexico" ;;
# 649) BoliviaTV La Paz Bolivia
649)
link="https://livestream.com/accounts/10468276/boliviatv"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 650) GUATEVISION Guatemala
650)
link="https://livestream.com/accounts/25697071/en-vivo"
use_cookies="no"
chan_name="GUATEVISION Guatemala" ;;
# 651) Onda Cádiz RTV Spain
651)
link="https://livestream.com/accounts/22727797/directo"
use_cookies="no"
chan_name="Onda Cádiz RTV Spain" ;;
# 652) Streaming Medios Públicos Señal Nacional
652)
link="https://livestream.com/accounts/27228685/events/8175786"
use_cookies="no"
chan_name="Streaming Medios Públicos Señal Nacional" ;;
# 653) Tele Bahia Santo Domingo ,Dominican Republic
653)
link="https://livestream.com/accounts/18988261/events/7725211"
use_cookies="no"
chan_name="Tele Bahia Santo Domingo ,Dominican Republic" ;;
# 654)Iglesia Advenimiento del Séptimo Día Advenimiento TV Dallas Texas
654)
link="https://livestream.com/accounts/13655021/events/4355864"
use_cookies="no"
chan_name="Advenimiento TV Dallas Texas" ;;
# 655) Expande TV Puebla Mexico 
655)
link="https://livestream.com/accounts/7277442/envivo"
use_cookies="no"
chan_name="Expande TV Puebla Mexico" ;;
# 656) Tv Universal Centro de Ayuda Universal Mexico
656)
link="https://livestream.com/accounts/4486152/oracionmedianoche"
use_cookies="no"
chan_name="Tv Universal Centro de Ayuda Universal Mexico" ;;
# 657) Canal 27, El Canal de la Esperanza.
657)
link="https://livestream.com/accounts/13639189/events/6356013"
use_cookies="no"
chan_name="Canal 27, El Canal de la Esperanza." ;;
# 658) teleamiga TELEAMIGA INTERNACIONAL 
658)
link="https://livestream.com/accounts/18971084/events/6841479"
use_cookies="no"
chan_name="TELEAMIGA INTERNACIONAL" ;;
# 659) Politv Poli tv Bogota Colombia 
659)
link="https://livestream.com/accounts/12256908/events/6185792"
use_cookies="no"
chan_name="Poli tv Bogota Colombia" ;;
# 660) UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina 
660)
link="https://livestream.com/accounts/5198918/events/3229548"
use_cookies="no"
chan_name="UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina " ;;
# 661) Asociación RUAV Univalle - Canal Universitario Cali Colombia
661)
link="https://livestream.com/accounts/2541970/events/1932032"
use_cookies="no"
chan_name="Asociación RUAV Univalle - Canal Universitario Cali Colombia" ;;
# 662) Canal JesusTV Guatemala 
662)
link="https://livestream.com/accounts/17608437/events/4834657"
use_cookies="no"
chan_name="Canal JesusTV Guatemala " ;;
# 663) FGTV Frecuencias de Gloria Jacksonville Florida 
663)
link="https://livestream.com/accounts/3107466/events/3858724"
use_cookies="no"
chan_name="FGTV Frecuencias de Gloria Jacksonville Florida" ;;
# 664) El Evangelio Eterno EEE Network en Los Angeles Canal 63.5
664)
link="https://livestream.com/accounts/116136/EEENet"
use_cookies="no"
chan_name="El Evangelio Eterno EEE Network en Los Angeles Canal 63.5" ;;
# 665) BoliviaTV La Paz Bolivia
665)
link="https://livestream.com/accounts/10468276/BtvDeportes"
use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
# 666) Cosmovision TV Cosmovision HD
666)
link="https://livestream.com/accounts/16628908/cosmovisionhd"
use_cookies="no"
chan_name="Cosmovision TV" ;;
# 667) Emisora Virtual Onda Libre Cali CO 
667)
link="https://livestream.com/accounts/2541970/events/5178171"
use_cookies="no"
chan_name="Emisora Virtual Onda Libre Cali CO " ;;
# 668) TV MONARCA Ciudad Hidalgo, Michoacán, Mexico
668)
link="https://livestream.com/accounts/17594956/events/5033533"
use_cookies="no"
chan_name="TV MONARCA Ciudad Hidalgo, Michoacán, Mexico" ;;
# 669) Yuma Virtual TV Barrancabermeja CO
669)
link="https://livestream.com/accounts/17972814/events/6311476"
use_cookies="no"
chan_name="Yuma Virtual TV Barrancabermeja CO" ;;
# 670) Dominio Radio: En Vivo Mexico
670)
link="https://livestream.com/accounts/26841641/events/8163521"
use_cookies="no"
chan_name="Dominio Radio: En Vivo Mexico" ;;
# 671) Señal UNTREF
671)
link="https://livestream.com/accounts/16129323/events/7659666"
use_cookies="no"
chan_name="Señal UNTREF" ;;
# 672)NRT Canal 4 monclova
672)
link="https://livestream.com/accounts/24089527/events/7172314"
use_cookies="no"
chan_name="NRT Canal 4 monclova" ;;
# 673) Este Canal Tv
673)
link="https://livestream.com/accounts/8817409/events/7051352"
use_cookies="no"
chan_name="Este Canal Tv" ;;
# 674) Canal Telecafé Bogota Colombia
674)
link="https://livestream.com/accounts/1015476/events/7158511"
use_cookies="no"
chan_name="Canal Telecafé Bogota Colombia" ;;
# 675) TVUNAM 20 Transmisión de la Dirección General de Televisión Universitaria
675)
link="https://livestream.com/accounts/27177136/events/8157904"
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
link="https://livestream.com/accounts/2675843/enlace"
use_cookies="no"
chan_name="Enlacetv Espanol Irving Texas" ;;

######################## Portuguese #########################
# 681) Euronews Portugues
681)
keyword="euronews em"
method="Tor-Streamlink"
link="http://pt.euronews.com/live"
format="720p"
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
link="https://livestream.com/accounts/1106752/events/6785217"
use_cookies="no"
chan_name="Gott24.TV International" ;;
# 694) TV Fátima Paróquia de Fátima em Direto
694)
link="https://livestream.com/accounts/22203883/events/6579475"
use_cookies="no"
chan_name="TV Fátima Paróquia de Fátima em Direto" ;;
# 695) You Content 98 Live Belo Horizonte Brasil 
695)
link="https://livestream.com/accounts/15418920/98livebh"
use_cookies="no"
chan_name="98 Live Belo Horizonte Brasil" ;;
# 696) Rede Gênesis Europa TV Gênesis Europa Lisbon Portugal
696)
link="https://livestream.com/accounts/6602768/events/3378204"
use_cookies="no"
chan_name="TV Gênesis Europa Lisbon Portugal" ;;
# 697) SISTEMA MEIO NORTE DE COMUNICAÇÃO TV MEIO Teresina Brasil
697)
link="https://livestream.com/accounts/3332377/tvmeionortehd"
use_cookies="no"
chan_name="TV MEIO Teresina Brasil" ;;
# 698)SescTV HD Sao Paulo BR
698)
link="https://livestream.com/accounts/16991778/NoAr"
use_cookies="no"
chan_name="SescTV HD Sao Paulo BR" ;;
# 699) Medalhão Persa BR
699)
link="https://livestream.com/accounts/7533066/tvmedalhao"
use_cookies="no"
chan_name="Medalhão Persa BR" ;;
# 700)Talenu TV TPA Online Portuguese
700)
link="https://livestream.com/accounts/1181452/events/5141181"
use_cookies="no"
chan_name="Talenu TV TPA Luanda Angola" ;;
# 701)TV Miramar Mozambique Portuguese
701)
link="https://livestream.com/accounts/21076186/events/6180705"
use_cookies="no"
chan_name="TV Miramar Mozambique Portuguese" ;;
# 702)TV Zimbo Online Angola Portuguese
702)
link="https://livestream.com/accounts/19766999/events/5548210"
use_cookies="no"
chan_name="TV Zimbo Online Angola Portuguese" ;;
# 703) TV RAIAR Angola Portuguese 
703)
link="https://livestream.com/accounts/26069467/tv-raiar"
use_cookies="no"
chan_name="TV RAIAR Angola Portuguese" ;;
# 704)Rede Super Belo Horizonte BR
704)
link="https://livestream.com/accounts/10205943/events/3429501"
use_cookies="no"
chan_name="Rede Super Belo Horizonte BR" ;;
# 705)  SescTV Sao Paulo Brasil  
705)
link="https://livestream.com/accounts/16991778/NoAr"
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

# 710) i24 News en Direct
710) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="i24 Francais";; 
# 711)SYTRAL Rhone FR
711) 
keyword="DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SytralTCL/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="SYTRAL Rhone FR" ;;
# 712) Vedia BE
712)
# https://www.vedia.be/www/live
link=https://5a0b00d270652.streamlock.net/live/vedia-live/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1785849,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=1280x720
#link=https://5a0b00d270652.streamlock.net/live/vedia-live/chunklist_w1404141724.m3u8
use_cookies="no"
#method="Tor"
chan_name="Vedia BE" ;;
# 713) MABI TV Canada
713) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="MABI TV Canada" ;;
# 714) Vatican Media  
714) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Vatican Media" ;;  
# 715) RMC INFO TALK SPORT RADIO FRANCE
715)  
link=https://players.brightcove.net/876630703001/SkKvZlxI_default/index.html?videoId=2623007265001
use_cookies="no"
chan_name="RMC INFO TALK SPORT France" ;;
# 104) TV7 Bordeaux
104)
link=http://62.210.204.108:1935/livtv7vo/myStream.smil/playlist.m3u8
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b828000_slfra.m3u8
#link=http://62.210.204.108:1935/livtv7vo/myStream.smil/chunklist_w126434099_b328000_slfra.m3u8
use_cookies="no"
#method="Tor"
chan_name="TV7 Bordeaux" ;;
# 716) TVM FR
716)
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist_w1158771188.m3u8
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist.m3u8
link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TVM FR" ;;
# 717) C-Star 
717)
link=http://www.dailymotion.com/video/x5idxor
#link=https://stream-07.dc3.dailymotion.com/41/dm/3/x5idxor/live-2.m3u8
use_cookies="no"
chan_name="C-Star" ;;
################################################################################## 

#################################   COLUMN 4 ############################################
# 721) FOX News Channel Preview (No Audio)
721)  
link="https://fnurtmp-f.akamaihd.net/i/FNCPREV_1@143121/master.m3u8"
use_cookies="no"
chan_name="FOX News Channel Preview Preview (No Audio)" ;; 
# 722) Capital City Connection
722)
#link=http://na-us-se13.secdn.net/pegstream3-live/play/5f0d9ca5-4e85-4c01-a426-9ec8d44c2c9c/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=585523,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=491x360
link="http://na-us-se13.secdn.net/pegstream3-live/play/5f0d9ca5-4e85-4c01-a426-9ec8d44c2c9c/chunklist_w1994511665.m3u8"
use_cookies="no"
chan_name="Capital City Connection" ;;
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
# 739) KBVR TV
739)
link=http://klive-a.akamaihd.net/dc-0/live/hls/p/391241/e/0_bthpnu1j/sd/10000/t/YwqLo1YivB_aumq-LxAuWg/master.m3u8
use_cookies="no"
chan_name="KBVR TV" ;;
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
# 767) Southeastern Channel
767)
link=http://147.174.13.196/live/WIFI-1296k-540p/WIFI-1296k-540p.m3u8
use_cookies="no"
chan_name="Southeastern Channel" ;;
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
link="https://livestream.com/accounts/8366412/live"
use_cookies="no"
chan_name="WYCW Carolinas" ;;
# 773) FOX 10 News 
773)
link="https://livestream.com/accounts/1859803/live"
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


################################################ Live Stream #########################################################
# 801) Sangat Television Birmingham England 
801)
link="https://livestream.com/accounts/6986636/sangattv"
use_cookies="no"
chan_name="Sangat Television Birmingham England" ;;
# 802) Sikh Channel Sikh Channel (Global Broadcast) Aston England 
802)
link="https://livestream.com/accounts/5296919/live"
use_cookies="no"
chan_name="Sikh Channel Aston England" ;;
# 803) Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada
803)
link="https://livestream.com/accounts/472363/events/3109892"
use_cookies="no"
chan_name="Dashmesh Culture Centre- Daily Broadcast Sikh Calgary Alberta Canada" ;;
################## GEORGIAN ##############################################
# 804) Iberia TV Live Georgia 
804)
link="https://livestream.com/accounts/19735751/events/7830877"
use_cookies="no"
chan_name="Iberia TV Georgia" ;;
# 805) Obieqtivi TV Georgia 
805)
link="https://livestream.com/accounts/2064453/events/1886556"
use_cookies="no"
chan_name="Obieqtivi TV Georgia" ;;
##################### ENGLISH ###########################
# 806) ortonvilletelevision
806)
link="https://livestream.com/accounts/17285258/events/7143508"
use_cookies="no"
chan_name="ortonvilletelevision" ;;
# 807) Holiday & Cruise TV
807)
link="https://livestream.com/accounts/22779659/events/6788901"
use_cookies="no"
chan_name="Holiday & Cruise TV" ;;

# 809) Vision Cruise AU
809)
link="https://livestream.com/accounts/22779659/events/8027429"
use_cookies="no"
chan_name="Vision Cruise AU" ;;
# 810) Vision Cruise UK
810)
link="https://livestream.com/accounts/22779659/events/8027222"
use_cookies="no"
chan_name="Vision Cruise UK" ;;

# 812) WHLT USA 
812)
link="https://livestream.com/accounts/8383566/live"
use_cookies="no"
chan_name="WHLT USA" ;;
# 813) LRPATV CH25 New Hampshire USA
813)
link="https://livestream.com/accounts/3480937/channel25"
use_cookies="no"
chan_name="LRPATV CH25 New Hampshire USA" ;;
# 814) Santa Fe Media Network New Mexico USA
814)
link="https://livestream.com/accounts/13196214/events/5972197"
use_cookies="no"
chan_name="Santa Fe Media Network New Mexico USA" ;;
# 815) 




# 818) 102.3 NOW! TV Edmonton AB,CA
818)
link="https://livestream.com/accounts/4683311/events/3747538"
use_cookies="no"
chan_name="102.3 NOW! TV Edmonton AB,CA" ;;
# 819)TourbusTV USA
819)
link="https://livestream.com/accounts/22843174/TourbusTV"
use_cookies="no"
chan_name="TourbusTV USA" ;;
# 820)Ezekiel TV Channel
820)
link="https://livestream.com/accounts/19491040/events/6866917"
use_cookies="no"
chan_name="Ezekiel TV" ;;
# 821)KVZK TV CHANNEL 2 American SAMOA
821)
link="https://livestream.com/accounts/8956070/events/4561731"
use_cookies="no"
chan_name="KVZK TV CHANNEL 2 American SAMOA" ;;


# 823) 
# 824) Native Media Network Sante Fe New Mexico USA
824)
link="https://livestream.com/accounts/13196214/events/3994033"
use_cookies="no"
chan_name="Native Media Network Sante Fe New Mexico USA" ;;






# 827) Emmanuel TV
827)
link="https://livestream.com/accounts/23202872/events/7200883"
use_cookies="no"
chan_name="Emmanuel TV" ;;
# 828) Shalom World Australia
828)
link="https://livestream.com/accounts/25038049/events/7551704"
use_cookies="no"
chan_name="Shalom World Australia" ;;
# 829) WDIO Duluth Minnesota
829)
link="https://livestream.com/accounts/12241516/live"
use_cookies="no"
chan_name="WDIO Duluth Minnesota" ;;
# 830) KHNL Honolulu Hawaii News Now
830)
link="https://livestream.com/accounts/12139043/live"
use_cookies="no"
chan_name="KHNL Honolulu Hawaii News Now" ;;
# 831) WBNS Columbus OHIO USA
831)
link="https://livestream.com/accounts/18624165/live"
use_cookies="no"
chan_name="WBNS Columbus OHIO USA" ;;
# 832) WTTG Washington DC Fox 5 Washington DC USA
832)
link="https://livestream.com/accounts/2363281/live"
use_cookies="no"
chan_name="WTTG Washington DC Fox 5 Washington DC USA" ;;
# 833) WJBK FOX 2 Detroit Michigan USA 
833)
link="https://livestream.com/accounts/6396566/live"
use_cookies="no"
chan_name="WJBK FOX 2 Detroit Michigan USA" ;;
# 834) KSL NOW Salt Lake City Utah USA 
834)
link="https://livestream.com/accounts/22711876/live"
use_cookies="no"
chan_name="KSL NOW Salt Lake City Utah USA " ;;
# 835)  KSLA News 12 Shreveport Louisiana USA 
835)
link="https://livestream.com/KSLA/live"
use_cookies="no"
chan_name="KSLA News 12 Shreveport Louisianna USA  " ;;
# 836)  WSFA 12 Montgomory Alabama USA 
836)
link="https://livestream.com/accounts/11981705/live"
use_cookies="no"
chan_name="WSFA 12 Montgomory Alabama USA" ;;
# 837)  Fox 8 Cleveland Ohio USA 
837)
link="https://livestream.com/accounts/57501/live"
use_cookies="no"
chan_name="Fox 8 Cleveland Ohio USA" ;;
# 838) KELO Live Keloland USA 
838)
link="https://livestream.com/kelo/live"
use_cookies="no"
chan_name="KELO Live Keloland USA" ;;
# 839)HU16 Harding Sercy Arkansas  USA
839)
link="https://livestream.com/accounts/8522446/live"
use_cookies="no"
chan_name="HU16 Harding Sercy Arkansas  USA" ;;
# 840) KTVK 3TV Arizona USA
840)
link="https://livestream.com/accounts/12643960/live"
use_cookies="no"
chan_name="KTVK 3TV Arizona USA" ;;
# 841) FOX 26 News Houston USA
841)
link="https://livestream.com/accounts/6396012/live"
use_cookies="no"
chan_name="FOX 26 News Houston USA" ;;
# 842) WAFB 9 CBSN Baton Rouge Louisiana USA
842)
link="https://livestream.com/accounts/11595706/live"
use_cookies="no"
chan_name="WAFB 9 CBSN Baton Rouge Louisiana USA" ;;
# 843) WCSC Charleston South Carolina USA
843)
link="https://livestream.com/accounts/11016888/live"
use_cookies="no"
chan_name="WCSC Charleston South Carolina USA" ;;
# 844) WTXF FOX 29 News Philadelphia USA
844)
link="https://livestream.com/accounts/6370754/live"
use_cookies="no"
chan_name="WTXF FOX 29 News Philadelphia USA" ;;
# 845) WFLA NBC 8 Tampa Bay Florida USA
845)
link="https://livestream.com/accounts/6140981/live"
use_cookies="no"
chan_name="WFLA NBC 8 Tampa Bay Florida USA" ;;
# 846)  WFIE NBC 14 USA
846)
link="https://livestream.com/accounts/11981465/live"
use_cookies="no"
chan_name="WFIE NBC 14 USA" ;;
# 847)  KOIN CBS 6 Portland Oregon USA
847)
link="https://livestream.com/accounts/1864610/live"
use_cookies="no"
chan_name="KOIN CBS 6 Portland Oregon USA" ;;
# 848)  WTVT / FOX 13 Tampa Bay USA
848)
link="https://livestream.com/accounts/6180769/live"
use_cookies="no"
chan_name="WTVT / FOX 13 Tampa Bay USA" ;;
# 849)  KUSI 24/7 San Diego California USA
849)
link="https://livestream.com/accounts/25082096/live"
use_cookies="no"
chan_name="KUSI 24/7 San Diego California USA" ;;
# 850)  Joe Pags Show
850)
link="https://livestream.com/accounts/26896512/events/8077273"
use_cookies="no"
chan_name="Joe Pags Show" ;;
# 851)  WBRC FOX6 News Mobil USA
851)
link="https://livestream.com/WBRC/live"
use_cookies="no"
chan_name="WBRC FOX6 News Mobil USA" ;;
# 852)  WNYW Fox 5 New York USA
852)
link="https://livestream.com/accounts/6372917/live"
use_cookies="no"
chan_name="WNYW Fox 5 New York USA" ;;
# 853) KMOV 4 St. Louis MO USA
853)
link="https://livestream.com/accounts/12654794/live"
use_cookies="no"
chan_name="KMOV 4 St. Louis MO USA" ;;
# 854) WFLD / Fox 32 Chicago USA
854)
link="https://livestream.com/accounts/6370732/live"
use_cookies="no"
chan_name="WFLD / Fox 32 Chicago USA" ;;
# 855) KHSL Action News NOW KHSL Live USA
855)
link="https://livestream.com/accounts/26511688/live"
use_cookies="no"
chan_name="KHSL Action News NOW KHSL Live USA" ;;
# 856) WVUE FOX 8 Batton Rouge LA USA
856)
link="https://livestream.com/accounts/10891792/live"
use_cookies="no"
chan_name=" WVUE FOX 8 Batton Rouge LA USA" ;;
# 857) KLTV 7 Tyler TX USA
857)
link="https://livestream.com/accounts/11816721/live"
use_cookies="no"
chan_name="KLTV 7 Tyler TX USA" ;;
# 858) KEYT ABC 3 Santa Barbara CA USA
858)
link="https://livestream.com/accounts/19285506/live"
use_cookies="no"
chan_name="KEYT ABC 3 Santa Barbara CA USA" ;;
# 859) WAKA CBS 8 ABC 32 ALABAMA 
859)
link="https://livestream.com/accounts/9486828/live"
use_cookies="no"
chan_name="WAKA CBS 8 ABC 32 ALABAMA " ;;
# 860) WJZY FOX 46 Charlotte NC
860)
link="https://livestream.com/accounts/6370805/live"
use_cookies="no"
chan_name="WJZY FOX 46 Charlotte NC" ;;
# 861) WCCB Charlotte CW NC
861)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name="WCCB Charlotte CW NC" ;;
# 862) WCYB NBC 5 VA
862)
link="https://livestream.com/accounts/8522497/live"
use_cookies="no"
chan_name="WCYB NBC 5 VA" ;;
# 863) WYCW CW 62 Carolinas
863)
link="https://livestream.com/accounts/8366412/live"
use_cookies="no"
chan_name="WYCW CW 62 Carolinas" ;;
# 864) WNCT CBS 9 Greenville NC
864)
link="https://livestream.com/accounts/7601533/live"
use_cookies="no"
chan_name="WNCT CBS 9 Greenville NC" ;;
# 865) WJBF Augusta Georgia 
865)
link="https://livestream.com/accounts/7601347/live"
use_cookies="no"
chan_name="WJBF Augusta Georgia" ;;
# 866) KLFY News 10 Acadiana
866)
link="https://livestream.com/accounts/7520488/live"
use_cookies="no"
chan_name="KLFY News 10 Acadiana" ;;
# 867) MNN Channel 1
867)
link="https://livestream.com/accounts/6480540/events/2616259"
use_cookies="no"
chan_name="MNN Channel 1" ;;
# 868) MNN Channel 4
868)
link="https://livestream.com/accounts/6478935/events/2616010"
use_cookies="no"
chan_name="MNN Channel 4" ;;
# 869) WWOR Secaucus
869)
link="https://livestream.com/accounts/6372957/live"
use_cookies="no"
chan_name="WWOR Secaucus" ;;
# 870) KSNT Weather Wichita Kansas
870)
link="https://livestream.com/accounts/1866369/live"
use_cookies="no"
chan_name="KSNT Weather Wichita Kansas" ;;
# 871) WANE Ft. Wayne Indiana
871)
link="https://livestream.com/accounts/1849716/live"
use_cookies="no"
chan_name="WANE Ft. Wayne Indiana" ;;
# 872) KTXS 12 ABC Abilene Texas 
872)
link="https://livestream.com/accounts/9960439/live"
use_cookies="no"
chan_name="KTXS 12 ABC Abilene TX" ;;
# 873) Island TV Live Broadcast Miami FL USA
873)
link="https://livestream.com/accounts/1420/Islandtvlive"
use_cookies="no"
chan_name="Island TV Live Broadcast Miami FL USA" ;;
# 874) KSNT Kansas OK USA
874)
link="https://livestream.com/accounts/1866369/live"
use_cookies="no"
chan_name="KSNT Kansas OK USA" ;;
# 875) KMIZ ABC 17 Missouri
875)
link="https://livestream.com/accounts/18240993/live"
use_cookies="no"
chan_name="KMIZ ABC 17 Missouri" ;;
# 876) KFDA CBS 10 Amarillo TX USA
876)
link="https://livestream.com/accounts/17606146/live"
use_cookies="no"
chan_name="KFDA CBS 10 Amarillo TX USA" ;;
# 877) KZTV CBS 10 Corpus Christi TX USA 
877)
link="https://livestream.com/accounts/16030806/live"
use_cookies="no"
chan_name="KZTV CBS 10 Corpus Christi TX USA" ;;
# 878) City of Tampa Television FL, USA
878)
link="https://livestream.com/accounts/12251681/CTTV"
use_cookies="no"
chan_name="City of Tampa Television FL, USA" ;;
# 879)WMGT 41 NBC Macon Georgia USA
879)
link="https://livestream.com/accounts/15227391/live"
use_cookies="no"
chan_name="WMGT 41 NBC Macon Georgia USA" ;;
# 880) Polk County Channel 44 Bolivar Missouri USA
880)
link="https://livestream.com/accounts/15079831/Channel44"
use_cookies="no"
chan_name="Polk County Channel 44 Bolivar Missouri USA" ;;
# 881) WAND NBC 17 Decatur Illinois
881)
link="https://livestream.com/accounts/15004678/live"
use_cookies="no"
chan_name="WAND NBC 17 Decatur Illinois" ;;
# 882) KOAA NBC 5 Colorado Springs Colorado, USA
882)
link="https://livestream.com/accounts/13725886/live"
use_cookies="no"
chan_name="KOAA NBC 5 Colorado Springs Colorado, USA" ;;
# 883) Enid Television Network Oklahoma
883)
link="https://livestream.com/accounts/13638122/events/4063586"
use_cookies="no"
chan_name="Enid Television Network Oklahoma" ;;
# 884) ThinkTech Hawaii Honolulu USA
884)
link="https://livestream.com/accounts/12650986/events/3950350"
use_cookies="no"
chan_name="ThinkTech Hawaii Honolulu USA" ;;
# 885) WFLX FOX 29
885)
link="https://livestream.com/accounts/12755354/live"
use_cookies="no"
chan_name="WFLX FOX 29" ;;
# 886) WPS-TV Wichita Public Schools
886)
link="https://livestream.com/accounts/12013978/events/3835724"
use_cookies="no"
chan_name="WPS-TV Wichita Public Schools" ;;
# 887) KAAL ABC 6 Rochester Minnesota
887)
link="https://livestream.com/accounts/12240964/live"
use_cookies="no"
chan_name="KAAL ABC 6 Rochester Minnesota" ;;
# 888) KRCR ABC 7 Redding California USA
888)
link="https://livestream.com/accounts/10262876/events/3724366"
use_cookies="no"
chan_name="KRCR ABC 7 Redding California USA" ;;
# 889) KION CBS 5/46 Salinas California USA
889)
link="https://livestream.com/accounts/19128738/events/7300156"
use_cookies="no"
chan_name="KION CBS 5/46 Salinas California USA" ;;
# 890) KMVP 24/7 Phoenix Arizona Sports 98.7 FM 
890)
link="https://livestream.com/accounts/24089066/live"
use_cookies="no"
chan_name="KMVP 24/7 Phoenix Arizona Sports 98.7 FM " ;;
# 891) KTAR News Phoenix Arizona 
891)
link="https://livestream.com/accounts/24088937/live"
use_cookies="no"
chan_name="KTAR News Phoenix Arizona " ;;
# 892) WPSD-TV Paducah Kentucky 
892)
link="https://livestream.com/accounts/21317942/live"
use_cookies="no"
chan_name="WPSD-TV Paducah Kentucky" ;;
# 893) KVRR Fargo North Dakota  
893)
link="https://livestream.com/accounts/21298478/live"
use_cookies="no"
chan_name="KVRR Fargo North Dakota" ;;
# 894) KDLT Sioux Falls South Dakota
894)
link="https://livestream.com/accounts/21277277/live"
use_cookies="no"
chan_name="KDLT Sioux Falls South Dakota" ;;
# 895) GovTV Watertown, South Dakota
895)
link="https://livestream.com/accounts/21042766/events/6254925"
use_cookies="no"
chan_name="GovTV Watertown, South Dakota" ;;
# 896) KFDX NBC 3 Witchita Falls USA
896)
link="https://livestream.com/accounts/21184359/live"
use_cookies="no"
chan_name="KFDX NBC 3 Witchita Falls USA" ;;
# 897) Galveston County Gulf Freeway Cams Tour Houston Texas USA 
897)
link="https://livestream.com/accounts/21068106/events/6228235"
use_cookies="no"
chan_name="Galveston County Gulf Freeway Cams Tour Houston Texas USA" ;;
# 898) KQDS - FOX 21 Duluth Minnesota USA 
898)
link="https://livestream.com/accounts/21146230/live"
use_cookies="no"
chan_name="KQDS - FOX 21 Duluth Minnesota USA " ;;
# 899) KOLR CBS 10 Springfield Missouri
899)
link="https://livestream.com/accounts/21145355/live"
use_cookies="no"
chan_name="KOLR CBS 10 Springfield Missouri" ;;
# 900) WROC CBS 8 Rochester NY USA
900)
link="https://livestream.com/accounts/21078314/live"
use_cookies="no"
chan_name="WROC CBS 8 Rochester NY USA" ;;
# 901)WBRE NBC Wilkes Barre Pennslyvannia USA
901)
link="https://livestream.com/accounts/21077947/live"
use_cookies="no"
chan_name="WBRE NBC Wilkes Barre Pennslyvannia USA" ;;
# 902) Cumulus NYC 77 WABC New York USA
902)
link="https://livestream.com/cumulusnyc/live"
use_cookies="no"
chan_name="Cumulus NYC 77 WABC New York USA" ;;
# 903) WTVQ ABC 36 Lexington Kentucky USA
903)
link="https://livestream.com/accounts/19871819/live"
use_cookies="no"
chan_name="WTVQ ABC 36 Lexington Kentucky USA" ;;
# 904) WFFT FOX 55 Indiana USA
904)
link="https://livestream.com/accounts/26511747/live"
use_cookies="no"
chan_name="WFFT FOX 55 Indiana USA" ;;
# 905) WAAY News ABC 31 Huntsville Alabama
905)
link="https://livestream.com/accounts/26511741/live"
use_cookies="no"
chan_name="WAAY News ABC 31 Huntsville Alabama" ;;
# 906) St. Petersburg College SPC-TV 
906)
link="https://livestream.com/accounts/15226456/events/7703617"
use_cookies="no"
chan_name="St. Petersburg College SPC-TV " ;;
# 907) WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan  
907)
link="https://livestream.com/accounts/25637691/live"
use_cookies="no"
chan_name="WWTV 9 & 10 News 24/7 Mt. Pleasent Michigan" ;;
# 908) WPHL TV ABC 6 Philladelphia
908)
link="https://livestream.com/accounts/25565610/live"
use_cookies="no"
chan_name="WPHL TV ABC 6 Philladelphia" ;;
# 909) WCCB Charlotte's CW NC
909)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name=" WCCB Charlotte's CW NC" ;;
# 910) WCBD NBC 2 Charleston North Carolina 
910)
link="https://livestream.com/accounts/8360295/live"
use_cookies="no"
chan_name="WCBD NBC 2 Charleston NC" ;;
# 911) WSAV NBC 3 Savannah, Georgia
911)
link="https://livestream.com/accounts/7682273/live"
use_cookies="no"
chan_name="WSAV NBC 3 Savannah, Georgia" ;;
# 912) WSPA CBS 7 WSPA Spartanberg SC
912)
link="https://livestream.com/accounts/7592531/live"
use_cookies="no"
chan_name="WSPA CBS 7 WSPA Spartanberg SC" ;;
# 913) WCMH NBC 4 Columbus Ohio
913)
link="https://livestream.com/accounts/7338206/live"
use_cookies="no"
chan_name="WCMH NBC 4 Columbus Ohio" ;;
# 914) CBS 17 Rahliegh NC
914)
link="https://livestream.com/accounts/7158447/live"
use_cookies="no"
chan_name="CBS 17 Rahliegh NC" ;;
# 915) NewsChannel5+ Las Vegas, Nevada
915)
link="https://livestream.com/accounts/3827561/live"
use_cookies="no"
chan_name="NewsChannel5+ Las Vegas, Nevada" ;;
# 916) KSNW NBC 3 Witchita Kansas
916)
link="https://livestream.com/accounts/1866980/live"
use_cookies="no"
chan_name="KSNW NBC 3 Witchita Kansas" ;;
# 917) WPRI Fox 12 Providence New England 
917)
link="https://livestream.com/accounts/1864876/live"
use_cookies="no"
chan_name="WPRI Fox 12 Providence New England" ;;
# 918) WWAY News ABC CBS CW 3 Cape Fear Willmington NC 
918)
link="https://livestream.com/accounts/26965546/live"
use_cookies="no"
chan_name="WWAY News ABC CBS CW 3 Cape Fear Willmington NC" ;;
# 919) KIFI ABC 8 Idaho Falls Idaho 
919)
link="https://livestream.com/accounts/18796284/Live"
use_cookies="no"
chan_name="KIFI ABC 8 Idaho Falls Idaho " ;;
# 920) News-Press NOW Fox 26 KNPN Saint Joseph Missouri 
920)
link="https://livestream.com/accounts/18241682/live"
use_cookies="no"
chan_name="News-Press NOW Fox 26 KNPN Saint Joseph Missouri" ;;
# 921) KAUZ CBS 6 Winters Texas 
921)
link="https://livestream.com/accounts/16991125/live"
use_cookies="no"
chan_name="KAUZ CBS 6 Winters Texas" ;;
# 922) KXXV ABC 25 Waco Texas 
922)
link="https://livestream.com/accounts/16936343/live"
use_cookies="no"
chan_name="KXXV ABC 25 Waco Texas" ;;
# 923) KATC Lafayette ABC 3 Louisiana 
923)
link="https://livestream.com/accounts/15228189/live"
use_cookies="no"
chan_name="KATC Lafayette ABC 3 Louisiana" ;;
# 924) WFLD Fox 32 Chicago IL
924)
link="https://livestream.com/accounts/6370732/events/4249677"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago IL" ;;
# 925) KPLC NBC 7 Lake Charles Louisiana  
925)
link="https://livestream.com/accounts/11595658/live"
use_cookies="no"
chan_name="KPLC NBC 7 Lake Charles Louisiana" ;;
# 926) KOIN 6 Extras Portland Oregon
926)
link="https://livestream.com/accounts/1864610/events/3314050"
use_cookies="no"
chan_name="KOIN 6 Extras Portland Oregon" ;;
# 927) WCCB Charlotte's CW NC
927)
link="https://livestream.com/accounts/8522553/live"
use_cookies="no"
chan_name="WCCB Charlotte's CW NC" ;;
# 928) WDAM 7 Hattiesburg Mississippi USA
928)
link="https://livestream.com/accounts/11595552/live"
use_cookies="no"
chan_name="WDAM 7 Hattiesburg Mississippi USA" ;;
# 929) WLOX ABC 13  Mississippi USA
929)
link="https://livestream.com/accounts/11595500/live"
use_cookies="no"
chan_name="WLOX ABC 13  Mississippi USA" ;;
# 930) WTVM ABC 9 Columbus Georgia 
930)
link="https://livestream.com/accounts/11379799/live"
use_cookies="no"
chan_name="WTVM ABC 9 Columbus Georgia " ;;
# 931) WRBL News 365 CBS 3 Columbus, GA.  
931)
link="https://livestream.com/accounts/7942874/live"
use_cookies="no"
chan_name="WRBL News 365 CBS 3 Columbus, GA" ;;
# 932) WJHL CBS 11 Johnson City, New York 
932)
link="https://livestream.com/accounts/7264167/live"
use_cookies="no"
chan_name="WJHL CBS 11 Johnson City, New York" ;;
# 933) KCTV CBS 5 Kansas City Missouri  
933)
link="https://livestream.com/accounts/6370696/live"
use_cookies="no"
chan_name="KCTV CBS 5 Kansas City Missouri" ;;
# 934) WTHI 10 Terre Haute Indiana
934)
link="https://livestream.com/accounts/1866274/live"
use_cookies="no"
chan_name="WTHI 10 Terre Haute Indiana" ;;
# 935)WBBJ ABC 7 West Tennesee 
935)
link="https://livestream.com/accounts/27132443/live"
use_cookies="no"
chan_name="WBBJ ABC 7 West Tennesee" ;;
# 936) KTVZ 21 Bend Oregon 
936)
link="https://livestream.com/accounts/19128364/Live"
use_cookies="no"
chan_name="KTVZ 21 Bend Oregon" ;;
# 937) KEZI ABC 9 Eugene, Oregon
937)
link="https://livestream.com/accounts/26511759/live"
use_cookies="no"
chan_name="KEZI ABC 9 Eugene, Oregon" ;;
# 938) WDEF News CBS 12 Now Chattanooga Tennessee
938)
link="https://livestream.com/accounts/21596942/live"
use_cookies="no"
chan_name="WDEF News CBS 12 Now Chattanooga Tennesse " ;;
# 939) KCOY CBS 12 Santa Maria California USA 
939)
link="https://livestream.com/accounts/19128628/live"
use_cookies="no"
chan_name="KCOY CBS 12 Santa Maria California USA" ;;
# 940) WTOL CBS 11 Toledo Ohio 
940)
link="https://livestream.com/accounts/12003465/live"
use_cookies="no"
chan_name="WTOL CBS 11 Toledo Ohio" ;;
# 941) WIS NBC 10 Columbia South Carolina 
941)
link="https://livestream.com/accounts/11327981/live"
use_cookies="no"
chan_name="WIS NBC 10 Columbia South Carolina" ;;
# 942) WMC NBC 5 Memphis Tennessee 
942)
link="https://livestream.com/accounts/10894063/live"
use_cookies="no"
chan_name="WMC NBC 5 Memphis Tennessee" ;;
# 943) HTV10 Houma Louisiana 
943)
link="https://livestream.com/accounts/1362675/events/3147474"
use_cookies="no"
chan_name="HTV10 Houma Louisiana" ;;
# 944) WRIC ABC 8 Petersburg, Virginia
944)
link="https://livestream.com/accounts/7425298/live"
use_cookies="no"
chan_name="WRIC ABC 8 Petersburg, Virginia" ;;
# 945) Western Mass News Chicopee Massachusetts
945)
link="https://livestream.com/accounts/6140816/live"
use_cookies="no"
chan_name="Western Mass News Chicopee Massachusetts" ;;
# 946) KIMT 3 Mason City, Iowa
946)
link="https://livestream.com/accounts/1859647/live"
use_cookies="no"
chan_name="KIMT 3 Mason City, Iowa" ;;
# 947)KXAN NBC Austin Texas
947)
link="https://livestream.com/accounts/1506296/live"
use_cookies="no"
chan_name="KXAN NBC Austin Texas" ;;
# 948) WKRG CBS 5 Mobile, Alabama
948)
link="https://livestream.com/accounts/7546695/live"
use_cookies="no"
chan_name="WKRG CBS 5 Mobile, Alabama" ;;
# 949) Lex 18 Lexington Kentucky
949)
link="https://livestream.com/accounts/1493287/live"
use_cookies="no"
chan_name="Lex 18 Lexington Kentucky" ;;
# 950) WBNS 10 Breaking News Radar Columbus, Ohio
950)
link="https://livestream.com/accounts/26237278/events/8075621"
use_cookies="no"
chan_name="WBNS 10 Breaking News Radar Columbus, Ohio " ;;
# 951) WBNS 10 Breaking News Columbus, Ohio
951)
link="https://livestream.com/WBNSbreakingnews/live"
use_cookies="no"
chan_name="WBNS 10 Breaking News Columbus, Ohio " ;;
# 952) KYMA NBC 11 Yuma Arizona 
952)
link="https://livestream.com/accounts/20242841/live"
use_cookies="no"
chan_name="KYMA NBC 11 Yuma Arizona" ;;
# 953) WOIO CBS 19 Clevland Ohio 
953)
link="https://livestream.com/accounts/11017897/live"
use_cookies="no"
chan_name="WOIO CBS 19 Clevland Ohio" ;;
# 954) KESQ ABC 3 FOX 11 Palm Springs, California
954)
link="https://livestream.com/accounts/20847880/live"
use_cookies="no"
chan_name="KESQ ABC 3 FOX 11 Palm Springs, California" ;;
# 955) KRDO ABC 13 Colorado Springs Colorado 
955)
link="https://livestream.com/accounts/17592934/live"
use_cookies="no"
chan_name="KRDO ABC 13 Colorado Springs Colorado" ;;
# 956) WFMZ 69 Allen Town Pennslyvania 
956)
link="https://livestream.com/accounts/14384745/live"
use_cookies="no"
chan_name="WFMZ 69 Allen Town Pennslyvania" ;;
# 957) WTOC 11 Savannah, Georgia
957)
link="https://livestream.com/accounts/11006691/live"
use_cookies="no"
chan_name="WTOC 11 Savannah, Georgia" ;;
# 958) WGCL CBS46 Atlanta Georgia
958)
link="https://livestream.com/accounts/6140931/live"
use_cookies="no"
chan_name="WGCL CBS46 Atlanta Georgia" ;;
# 959) KQTV 2 St. Joseph, Missouri
959)
link="https://livestream.com/accounts/26511737/live"
use_cookies="no"
chan_name="KQTV 2 St. Joseph, Missouri" ;;
# 960) CGTN America Live
960)
link="https://livestream.com/accounts/7082210/livenews"
use_cookies="no"
chan_name="CGTN America Live" ;;
# 961) KVIA ABC-7 El Paso Texas 
961)
link="https://livestream.com/accounts/18241891/live"
use_cookies="no"
chan_name="KVIA ABC-7 El Paso Texas" ;;
# 962)  KCBD NBC 11 Lubbock, Texas
962)
link="https://livestream.com/accounts/11816946/live"
use_cookies="no"
chan_name="KCBD NBC 11 Lubbock, Texas" ;;
# 963) WALB NBC 10 Albany Southwestern Georgia
963)
link="https://livestream.com/accounts/11279058/live"
use_cookies="no"
chan_name="WALB NBC 10 Albany Southwestern Georgia" ;;
# 964) KFVE 9 Honolulu Hawaii
964)
link="https://livestream.com/accounts/14598737/live"
use_cookies="no"
chan_name="KFVE Honolulu Hawaii" ;;
# 965) WWBT NBC 12 Richmond Virginia 
965)
link="https://livestream.com/accounts/11203782/live"
use_cookies="no"
chan_name="WWBT NBC 12 Richmond Virginia" ;;
# 966) WJTV CBS 12 Jackson Mississippi
966)
link="https://livestream.com/accounts/8374496/live"
use_cookies="no"
chan_name="WJTV CBS 12 Jackson Mississippi" ;;
# 967) WWLP 22 Springfield Massachusetts
967)
link="https://livestream.com/accounts/1866220/live"
use_cookies="no"
chan_name="WWLP 22 Springfield Massachusetts" ;;
# 968) CBS 42 Birmingham Alabama 
968)
link="https://livestream.com/accounts/1848160/live"
use_cookies="no"
chan_name="CBS 42 Birmingham Alabama" ;;
# 969) WNYT NBC 13 Upper Sandusky, Ohio
969)
link="https://livestream.com/accounts/12240447/live"
use_cookies="no"
chan_name="WNYT NBC 13 Upper Sandusky, Ohio" ;;
# 970) KEYT ABC 3 Santa Barbara California 
970)
link="https://livestream.com/accounts/19285506/live"
use_cookies="no"
chan_name="KEYT ABC 3 Santa Barbara California" ;;
# 971) WLBT FOX 40 Jackson Mississippi 
971)
link="https://livestream.com/accounts/11595602/live"
use_cookies="no"
chan_name="WLBT FOX 40 Jackson Mississippi" ;;
# 972) WSMV NBC 4 Nashville Tennessee
972)
link="https://livestream.com/accounts/6396556/LIVE"
use_cookies="no"
chan_name="WSMV NBC 4 Nashville Tennessee" ;;
# 973) DayTraderRockStar Show New York City New York 
973)
link="https://livestream.com/accounts/4878/events/2540723"
use_cookies="no"
chan_name="DayTraderRockStar Show New York City" ;;
# 974) WALA FOX10 News 24/7 Mobile, Alabama
974)
link="https://livestream.com/accounts/1859803/live"
use_cookies="no"
chan_name="WALA FOX10 News 24/7 Mobile, Alabama" ;;
# 975) KMOV CBS 4 St. Louis, Missouri
975)
link="https://livestream.com/accounts/12654794/live"
use_cookies="no"
chan_name="UNKNOWN" ;;
# 976) Lex & Terry Lufkin Texas 
976)
link="https://livestream.com/accounts/16950775/live"
use_cookies="no"
chan_name="Lex & Terry Lufkin Texas" ;;
# 977) KVOA NBC 4 Tuscon Arizona
977)
link="https://livestream.com/accounts/15512011/live"
use_cookies="no"
chan_name="KVOA NBC 4 Tuscon Arizona" ;;
# 978) Mike Malloy Show
978)
link="https://livestream.com/accounts/8522627/live"
use_cookies="no"
chan_name="Mike Malloy Show" ;;
# 979)KHSL CBS 12 Chico Redding California 
979)
link="https://livestream.com/accounts/26511688/live"
use_cookies="no"
chan_name="KHSL CBS 12 Chico Redding California" ;;
# 980) KSTP ABC 5 St. Paul, Minnesota
980)
link="https://livestream.com/accounts/12150160/live"
use_cookies="no"
chan_name="KSTP ABC 5 St. Paul, Minnesota" ;;
# 981) KSWO ABC 7 Winters Texas 
981)
link="https://livestream.com/accounts/16991045/live"
use_cookies="no"
chan_name="KSWO ABC 7 Winters Texas" ;;
# 982) WBTV CBS 3 Charlotte, North Carolina
982)
link="https://livestream.com/accounts/10950088/live"
use_cookies="no"
chan_name="WBTV CBS 3 Charlotte, North Carolina" ;;
# 983) KPHO CBS 5 Pheonix Arizona 
983)
link="https://livestream.com/accounts/6907826/LIVE"
use_cookies="no"
chan_name="KPHO CBS 5 Pheonix Arizona " ;;
# 984)  WDIO ABC 10/13 Duluth Minnesota 
984)
link="https://livestream.com/accounts/12241516/live"
use_cookies="no"
chan_name="WDIO ABC 10/13 Duluth Minnesota " ;;
# 985) KMSP FOX 9 Minneapolis Minnesota 
985)
link="https://livestream.com/accounts/6396280/live"
use_cookies="no"
chan_name="KMSP FOX 9 Minneapolis Minnesota" ;;
# 986) KSBY NBC 6 Santa Barbara California 
986)
link="https://livestream.com/accounts/15512095/live"
use_cookies="no"
chan_name="KSBY NBC 6 Santa Barbara California" ;;
# 987) KOLD 13 Tucson, Arizona
987)
link="https://livestream.com/accounts/11042990/live"
use_cookies="no"
chan_name="KOLD 13 Tucson, Arizona" ;;
# 988) KLTV ABC 7 Tyler, Texas
988)
link="https://livestream.com/accounts/11816721/live"
use_cookies="no"
chan_name="KLTV ABC 7 Tyler, Texas" ;;
# 989) WBRC FOX 6 Birmingham, Alabama
989)
link="https://livestream.com/accounts/12446860/live"
use_cookies="no"
chan_name="WBRC FOX 6 Birmingham, Alabama" ;;
# 990) PNC News First Newstalk K57 Fox 6 Guam 
990)
link="https://livestream.com/accounts/10612724/newstalk57"
use_cookies="no"
chan_name="PNC News First Newstalk K57 Fox 6 Guam " ;;
# 991) WTVT FOX 13 Tampa Bay Florida 
991)
link="https://livestream.com/accounts/6180769/live"
use_cookies="no"
chan_name="WTVT FOX 13 Tampa Bay Florida" ;;
# 992) WFLA NBC 8 Tampa, Florida
992)
link="https://livestream.com/accounts/6140981/live"
use_cookies="no"
chan_name="WFLA NBC 8 Tampa, Florida" ;;
# 993)WTNH 8 New Haven CT 
993)
link="https://livestream.com/accounts/1864656/live"
use_cookies="no"
chan_name="WTNH 8 New Haven CT" ;;
# 994)WMBF Myrtle Beach, South Carolina
994)
link="https://livestream.com/accounts/11214123/live"
use_cookies="no"
chan_name="WMBF Myrtle Beach, South Carolina" ;;
# 995) WSFA NBC 12 Montgomery Alabama 
995)
link="https://livestream.com/accounts/11981705/live"
use_cookies="no"
chan_name="WSFA NBC 12 Montgomery Alabama" ;;
# 996) WNYW Fox 5 New York
996)
link="https://livestream.com/accounts/6372917/live"
use_cookies="no"
chan_name="WNYW Fox 5 New York" ;;
# 997)KVVU FOX 5 Las Vegas Nevada  
997)
link="https://livestream.com/accounts/6910894/Live"
use_cookies="no"
chan_name="KVVU FOX 5 Las Vegas Nevada " ;;
# 998) KHON CBS 2 Ala Mona Honolulu Hawaii 
998)
link="https://livestream.com/accounts/1858266/live"
use_cookies="no"
chan_name="KHON CBS 2 Ala Mona Honolulu Hawaii " ;;
# 999)WFIE NBC 14 Evansville, Indiana
999)
link="https://livestream.com/accounts/11981465/live"
use_cookies="no"
chan_name="WFIE NBC 14 Evansville, Indiana" ;;
# 1000) WTXF FOX 29 News Philadelphia
1000)
link="https://livestream.com/accounts/6370754/live"
use_cookies="no"
chan_name="WTXF FOX 29 News Philadelphia" ;;
# 1001) WFLD Fox 32 Chicago Illinois 
1001)
link="https://livestream.com/accounts/6370732/live"
use_cookies="no"
chan_name="WFLD Fox 32 Chicago Illinois" ;;
# 1002) KTVK 3 Pheonix Arizona
1002)
link="https://livestream.com/accounts/12643960/live"
use_cookies="no"
chan_name="KTVK 3 Pheonix Arizona" ;;
# 1003) KRIV FOX 26 Houston Texas 
1003)
link="https://livestream.com/accounts/6396012/live"
use_cookies="no"
chan_name="KRIV FOX 26 Houston Texas " ;;
# 1004) WVUE FOX 8 New Orleans Louisiana 
1004)
link="https://livestream.com/accounts/10891792/live"
use_cookies="no"
chan_name="WVUE FOX 8 New Orleans Louisiana" ;;
# 1005)KPTV FOX 12 Portland Oregon 
1005)
link="https://livestream.com/accounts/6908462/Live"
use_cookies="no"
chan_name="KPTV FOX 12 Portland Oregon" ;;
# 1006) KIRO Radio Seattle Washington 
1006)
link="https://livestream.com/accounts/21148570/live"
use_cookies="no"
chan_name="KIRO Radio Seattle Washington" ;;
# 1007) KUSI San Diego California
1007)
link="https://livestream.com/accounts/25082096/live"
use_cookies="no"
chan_name="KUSI NEWS San Diego California" ;;
# 1008) Fox 8 Cleveland Ohio
1008)
link="https://livestream.com/accounts/57501/live"
use_cookies="no"
chan_name="Fox 8 Cleveland Ohio" ;;
# 1009) KSLA News CBS 12 Shreveport, Louisiana
1009)
link="https://livestream.com/accounts/11816591/live"
use_cookies="no"
chan_name="KSLA News CBS 12 Shreveport, Louisiana" ;;
# 1010) KELO CBS Sioux Falls, South Dakota
1010)
link="https://livestream.com/accounts/8522446/live"
use_cookies="no"
chan_name="KELO CBS Sioux Falls, South Dakota" ;;
# 1011) KSL NOW Salt Lake City Utah 
1011)
link="https://livestream.com/accounts/22711876/live"
use_cookies="no"
chan_name="KSL NOW Salt Lake City Utah" ;;
# 1012) WTTG Fox 5 Washington DC
1012)
link="https://livestream.com/accounts/2363281/live"
use_cookies="no"
chan_name="WTTG Fox 5 Washington DC" ;;
# 1013) WCSC CBS 5 Charleston South Carolina 
1013)
link="https://livestream.com/accounts/11016888/live"
use_cookies="no"
chan_name="WCSC CBS 5 Charleston South Carolina" ;;
# 1014) WBNS 10 Columbus Ohio
1014)
link="https://livestream.com/accounts/18624165/live"
use_cookies="no"
chan_name="WBNS 10 Columbus Ohio" ;;
# 1015) WJBK FOX 2 Detroit Michagan 
1015)
link="https://livestream.com/accounts/6396566/live"
use_cookies="no"
chan_name="WJBK FOX 2 Detroit Michagan" ;;
# 1016) WAFB CBS 9 Baton Rouge Louisiana 
1016)
link="https://livestream.com/accounts/11595706/live"
use_cookies="no"
chan_name="WAFB CBS 9 Baton Rouge Louisiana" ;;
# 1017) WFMZ 69 Traffic Allen Town Penslyvania 
1017)
link="https://livestream.com/accounts/14384745/traffic"
use_cookies="no"
chan_name="WFMZ 69 Traffic Allen Town Penslyvania " ;;
# 1018) KY3 Springfield Missouri 
1018)
link="https://livestream.com/accounts/4699618/live"
use_cookies="no"
chan_name="KY3 Springfield Missouri" ;;
# 1019) 710 ESPN Seattle Washington
1019)
link="https://livestream.com/accounts/21148436/live"
use_cookies="no"
chan_name="710 ESPN Seattle Washington" ;;
# 1020) NYXT Manhattan NYC New York USA
1020)
link="https://livestream.com/accounts/19770665/events/5522162"
use_cookies="no"
chan_name="NYXT Manhattan NYC New York USA" ;;
# 1021) King County TV Preston, Washington USA 
1021)
link="https://livestream.com/accounts/15175343/events/4485487"
use_cookies="no"
chan_name=" King County TV Preston, Washington USA " ;;
# 1022)Westerville.TV 543 Production Studio 
1022)
link="https://livestream.com/accounts/26666947/events/8163419"
use_cookies="no"
chan_name="Westerville.TV 543 Production Studio " ;;
# 1023) Kingdom Access Television Channel 192 LIVE
1023)
link="https://livestream.com/accounts/4209066/events/8159063"
use_cookies="no"
chan_name="Kingdom Access Television Channel 192 LIVE" ;;
# 1024) City of Las Vegas KCLV FOX 2 Nevada 
1024)
link="https://livestream.com/accounts/11449855/events/8026296"
use_cookies="no"
chan_name="City of Las Vegas KCLV FOX 2 Nevada" ;;
# 1025) Plaistow Access New Hampshire
1025)
link="https://livestream.com/accounts/11298895/meetings"
use_cookies="no"
chan_name="Plaistow Access New Hampshire" ;;
# 1026) City of Topeka City Kansas
1026)
link="https://livestream.com/accounts/25008807/events/7970645"
use_cookies="no"
chan_name="City of Topeka City Kansas" ;;
# 1027) Shelby County Schools C19TV & 88.5FM Memphis Tennessee 
1027)
link="https://livestream.com/accounts/25133520/c19tv"
use_cookies="no"
chan_name="Shelby County Schools C19TV & 88.5FM Memphis Tennessee " ;;
# 1028) Provincetown Community TV Provincetown Government Meetings  Provincetown, Massachusetts
1028)
link="https://livestream.com/accounts/6011038/events/6712043"
use_cookies="no"
chan_name="Provincetown Community TV, Massachusetts" ;;
# 1029) Manhattan Neighborhood Network MNN-FSTV
1029)
link="https://livestream.com/accounts/17251237/events/6391580"
use_cookies="no"
chan_name="Manhattan Neighborhood Network MNN-FSTV" ;;
# 1030) Brunswick TV3 New Hampshire
1030)
link="https://livestream.com/accounts/13788599/events/6330198"
use_cookies="no"
chan_name="Brunswick TV3 New Hampshire" ;;
# 1031) Bermuda Government (CITV) Hamilton, Bermuda 
1031)
link="https://livestream.com/accounts/19270406/events/5372984"
use_cookies="no"
chan_name="Bermuda Government (CITV) Hamilton, Bermuda " ;;
# 1032) GalaxyUniverseTV Freedom Solar TV Kersey, CO, USA
1032)
link="https://livestream.com/accounts/12141749/events/7685294"
use_cookies="no"
chan_name="Freedom Solar TV Kersey, CO, USA" ;;
# 1033) Shalom Media Catholic KIDS
1033)
link="https://livestream.com/shalomworld/events/7987357"
use_cookies="no"
chan_name="Shalom Media Catholic KIDS" ;;
# 1034) Faith Lutheran Church - Penfield, NY
1034)
link="https://livestream.com/accounts/4440983/events/6827954"
use_cookies="no"
chan_name="Faith Lutheran Church - Penfield, NY" ;;
# 1035) Whole Life Ministries SKMNetwork Augusta Georgia
1035)
link="https://livestream.com/accounts/16502349/SKMNetwork"
use_cookies="no"
chan_name="Whole Life Ministries SKMNetwork Augusta Georgia" ;;
# 1036) Second Presbyterian Church Sunday Worship Memphis Tennessee 
1036)
link="https://livestream.com/accounts/15713152/sunday-worship"
use_cookies="no"
chan_name="Second Presbyterian Church Sunday Worship Memphis Tennessee" ;;
# 1037) St. Catharine Church, Spring Lake, New Jersey 
1037)
link="https://livestream.com/accounts/11714562/events/3786245"
use_cookies="no"
chan_name="St. Catharine Church, Spring Lake, New Jersey " ;;
# 1038) Glory to God Ministries International Love of God Classics 
1038)
link="https://livestream.com/accounts/3240767/events/8008064"
use_cookies="no"
chan_name="Glory to God Ministries" ;;
# 1039)  WYKE TV 47 Hormosassa Springs Florida
1039)
link="https://livestream.com/accounts/9261275/events/7602204"
use_cookies="no"
chan_name="WYKE TV 47 Hormosassa Springs Florida" ;;
# 1040) St. Helena Chapel
1040)
link="https://livestream.com/accounts/25372681/events/7581060"
use_cookies="no"
chan_name="St. Helena Chapel" ;;
# 1041) St Patrick's Dumbarton
1041)
link="https://livestream.com/accounts/10499782/events/7601596"
use_cookies="no"
chan_name="St Patrick's Dumbarton" ;;
# 1042) VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas
1042)
link="https://livestream.com/accounts/15669040/events/4554297"
use_cookies="no"
chan_name="VTNTV VICTORY TELEVISION NETWORK KVTN KVTH KVTJ Little Rock Arkansas" ;;
# 1043) MNN Channel 3 New York 
1043)
link="https://livestream.com/accounts/6312590/events/2611503"
use_cookies="no"
chan_name="MNN Channel 3 New York" ;;
# 1044) TMN WORD TV Into All the Earth 24/7/365
1044)
link="https://livestream.com/accounts/16242586/TMN"
use_cookies="no"
chan_name="TMN WORD TV Into All the Earth 24/7/365" ;;
# 1045) Parkside Radio Show / BROOKLYNSTATION.COM
1045)
link="https://livestream.com/knqradio/events/8191094"
use_cookies="no"
chan_name="Parkside Radio Show / BROOKLYNSTATION.COM" ;;
# 1046) FGTV Frequencies of Glory LIVE Jacksonville Florida 
1046)
link="https://livestream.com/accounts/3107466/events/3858711"
use_cookies="no"
chan_name="FGTV Frequencies of Glory LIVE Jacksonville Florida" ;;
# 1047) HJTV online Healing Jesus TV London England 
1047)
link="https://livestream.com/accounts/15754877/events/4470314"
use_cookies="no"
chan_name="HJTV online Healing Jesus TV London England" ;;
# 1048) Apocalypse Channel APTV Live Polaski Tennessse 
1048)
link="https://livestream.com/accounts/5057242/events/4312291"
use_cookies="no"
chan_name="Apocalypse Channel APTV Live Polaski Tennessse" ;;
# 1049) Marytown Chapel Marytown Online Adoration Chapel Illinois
1049)
link="https://livestream.com/accounts/15529184/events/4408765"
use_cookies="no"
chan_name="Marytown Chapel Illinois" ;;
# 1050) VSiN - Vegas Stats & Information Network Las Vegas Nevada 
1050)
link="https://livestream.com/accounts/22774234/events/6897936"
use_cookies="no"
chan_name="VSiN - Vegas Stats & Information Network Las Vegas Nevada " ;;
# 1051) Guaranty Media Baton Rouge Louisiana 
1051)
link="https://livestream.com/accounts/25649901/live"
use_cookies="no"
chan_name="Guaranty Media Baton Rouge Louisiana" ;;
# 1052) ESPN 97.5 Houston Texas 
1052)
link="https://livestream.com/accounts/26800104/live"
use_cookies="no"
chan_name="ESPN 97.5 Houston Texas" ;;
# 1053) Pro Football Hall of Fame Hall of Fame Channel Stream
1053)
link="https://livestream.com/accounts/24957552/events/8006439"
use_cookies="no"
chan_name="Pro Football Hall of Fame" ;;
# 1054) Lance Hope RSL FEED
1054)
link="https://livestream.com/accounts/22999173/events/8078810"
use_cookies="no"
chan_name="Lance Hope RSL FEED" ;;
# 1055)XBTV Rosecroft Raceway Live Maryland 
1055)
link="https://livestream.com/accounts/9869799/events/6772185"
use_cookies="no"
chan_name="XBTV Rosecroft Raceway Live Maryland" ;;
# 1056) Park City Television PCTV Livestream Utah 
1056)
link="https://livestream.com/accounts/11728043/events/3779731"
use_cookies="no"
chan_name="Park City Television PCTV Livestream Utah" ;;
# 1057) WHLT 12 Whitehall, Wisconsin
1057)
link="https://livestream.com/accounts/8383566/live"
use_cookies="no"
chan_name="WHLT 12 Whitehall, Wisconsin" ;;
# 1058) OUBN - Oakwood University Huntsville Alabama  
1058)
link="https://livestream.com/accounts/5329025/events/7079597"
use_cookies="no"
chan_name="OUBN - Oakwood University Huntsville Alabama " ;;
# 1059) Nasdaq Bell Ceremonies New York City 
1059)
link="https://livestream.com/accounts/888332/live"
use_cookies="no"
chan_name="Nasdaq Bell Ceremonies New York City" ;;
# 1060) AAA Guayama
1060)
link="https://livestream.com/accounts/3185486/guayama"
use_cookies="no"
chan_name="AAA Guayama" ;;
# 1061) AWCATV - Education/Government Channel Ashburnham 
1061)
link="https://livestream.com/accounts/22393363/events/6651528"
use_cookies="no"
chan_name="AWCATV - Education/Government Channel Ashburnham " ;;
# 1062) Branson Visitor TV Branson Misouri 
1062)
link="https://livestream.com/accounts/21384612/BVTV"
use_cookies="no"
chan_name="Branson Visitor TV Branson Misouri" ;;
# 1063)FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA
1063)
link="https://livestream.com/accounts/11135493/events/5339279"
use_cookies="no"
chan_name="FHSU TIGER MEDIA NETWORK TMN TV Livestream Hays Kansas USA" ;;
# 1064) MNN Channel 5 (HD) New York City New York, USA 
1064)
link="https://livestream.com/accounts/17251372/events/4846282"
use_cookies="no"
chan_name="MNN Channel 5 (HD) New York City" ;;
# 1065) WIVM TV39 WIVM Local TV Canton Ohio 
1065)
link="https://livestream.com/accounts/17488475/events/4802826"
use_cookies="no"
chan_name="WIVM TV39 WIVM Local TV Canton Ohio" ;;
# 1066) EPlusTV6 Jackson Tennessee 
1066)
link="https://livestream.com/accounts/726212/events/4481510"
use_cookies="no"
chan_name="EPlusTV6 Jackson Tennessee" ;;
# 1067) St. Cloud Times UTVS Minnesota 
1067)
link="https://livestream.com/accounts/11549400/UTVS"
use_cookies="no"
chan_name="St. Cloud Times UTVS Minnesota " ;;
# 1068) Milford TV - Milford, MA Massachusetts 
1068)
link="https://livestream.com/accounts/13918823/MilfordTV"
use_cookies="no"
chan_name="Milford TV - Milford, MA Massachusetts" ;;
# 1069) EKB- TV EKBTV Live Pikeville Kentucky 
1069)
link="https://livestream.com/accounts/6461963/events/4113877"
use_cookies="no"
chan_name="EKB- TV EKBTV Live Pikeville Kentucky" ;;
# 1070) Milford TV Educational Channel - Milford, MA
1070)
link="https://livestream.com/accounts/13568947/MilfordTVEducational"
use_cookies="no"
chan_name="Milford TV Educational Channel - Milford, MA" ;;
# 1071)Native Media Network - NDN1.com NMN Live Santa Fe New Mexico
1071)
link="https://livestream.com/accounts/13196214/events/3994033"
use_cookies="no"
chan_name="Native Media Network, Santa Fe New Mexico" ;;
# 1072) EUTV - Evangel University EUTV Channel Live Springfield Missouri
1072)
link="https://livestream.com/accounts/10735484/events/3837393"
use_cookies="no"
chan_name=" EUTV Evangelical University, Springfield Missouri" ;;
# 1073) Granbury Media Granbury, TX Tower Camera Live Stream 
1073)
link="https://livestream.com/accounts/13120617/TowerCamera"
use_cookies="no"
chan_name="Granbury Media Granbury, TX Tower Camera Live Stream" ;;
# 1074) ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse 
1074)
link="https://livestream.com/accounts/17402222/FineArts"
use_cookies="no"
chan_name="ETSU New Construction Camera ETSU Fine Arts Classroom Building Johnson City Tennesse" ;;
# 1075) WDFL 18 South Carolina, Alabama, Louisiana 
1075)
link="https://livestream.com/accounts/26473976/events/7937669"
use_cookies="no"
chan_name="WDFL 18 South Carolina, Alabama, Louisiana" ;;
# 1076) MCAET Salinas California 
1076)
link="https://livestream.com/accounts/7781243/events/7871771"
use_cookies="no"
chan_name="MCAET Salinas California" ;;
# 1077) BlabTV
1077)
link="https://livestream.com/accounts/22779635/events/7675406"
use_cookies="no"
chan_name="BlabTV" ;;
# 1078) Essex County College Newark New Jersey 
1078)
link="https://livestream.com/accounts/5109696/events/7607762"
use_cookies="no"
chan_name="Essex County College Newark New Jersey" ;;
# 1079) CNPTV Live Caribbean Television.
1079)
link="https://livestream.com/accounts/22462981/Live"
use_cookies="no"
chan_name="CNPTV Live Caribbean Television." ;;
# 1080)  LOBO STATION
1080)
link="https://livestream.com/accounts/14558256/events/7412168"
use_cookies="no"
chan_name="LOBO STATION" ;;
# 1081) Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona
1081)
link="https://livestream.com/accounts/24714287/Live"
use_cookies="no"
chan_name="Maricopa Colleges Television MCTV Live Feed 115 Phoenix Arizona" ;;
# 1082) CharmTV Baltimore Maryland
1082)
link="https://livestream.com/accounts/13988426/events/4134572"
use_cookies="no"
chan_name="CharmTV Baltimore Maryland" ;;
# 1083) KVVB.TV CH.33 Victorville,California KVVB.TV | Ch 33.1 
1083)
link="https://livestream.com/accounts/9450048/events/3542162"
use_cookies="no"
chan_name="KVVB.TV CH.33 Victorville,CA" ;;
# 1084) WLTH AM 1370 Radio
1084)
link="https://livestream.com/accounts/26670176/events/8011646"
use_cookies="no"
chan_name="WLTH AM 1370 Radio" ;;
# 1085) KCOH TV Houston Texas 
1085)
link="https://livestream.com/accounts/12299560/events/3892224"
use_cookies="no"
chan_name="KCOH TV Houston Texas" ;;
# 1086) Lake Tahoe TV California
1086)
link="https://livestream.com/accounts/21822229/events/6450069"
use_cookies="no"
chan_name="Lake Tahoe TV California" ;;
# 1087) KVZK TV CHANNEL 2 American Samoa 
1087)
link="https://livestream.com/accounts/8956070/events/4561731"
use_cookies="no"
chan_name="KVZK TV CHANNEL 2 American Samoa" ;;
# 1088) Florida Gaming Sorteo
1088)
link="https://livestream.com/accounts/25552923/events/7909255"
use_cookies="no"
chan_name="Florida Gaming Sorteo" ;;
# 1089) Kidd Kraddick Morning Show 
1089)
link="https://livestream.com/accounts/16936513/live"
use_cookies="no"
chan_name="Kidd Kraddick Morning Show " ;;
# 1090) Rover's Morning Glory RMG-TV Cleavland Ohio
1090)
link="https://livestream.com/accounts/242049/events/1978582"
use_cookies="no"
chan_name="Rover's Morning Glory RMG-TV Cleavland Ohio" ;;
# 1091) WFSB 3 Hartford Connecticut USA
1091)
link="https://livestream.com/accounts/6372985/live"
use_cookies="no"
chan_name="WFSB 3 Hartford Connecticut USA" ;;
# 1092) ICOinvestor.tv USA
1092)
link="https://livestream.com/accounts/26548600/events/8201689"
use_cookies="no"
chan_name="ICOinvestor.tv USA" ;;
# 1093) WISH 8 Indianapolis USA
1093)
link="https://livestream.com/accounts/1858612/live"
use_cookies="no"
chan_name="WISH 8 Indianapolis USA" ;; 
# 1094) Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy 
1094)
link="https://livestream.com/accounts/25077919/diretta"
use_cookies="no"
chan_name="Luigi Pellegrini Parrocchia Santa Rita Via Reggio Italy " ;;


############################### DAILY MOTION OVERFLOW   ######################################
# 1095) Bengu Turk TK 
1095)
link="https://www.dailymotion.com/video/x6ikc4m"
use_cookies="no"
chan_name="Bengu Turk TK" ;;
# 1096) i24 News Israel
1096) 
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

######################### Function to check the menu status and deal with user input ###################################################
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
elif [ "$input" == "]" ]
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
elif [ "$input" == "[" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == "--" ]
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
}

################################# Function to select the user agent
select_agent()
{
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


######################## FUNCTION FOR PLAYING MEDIA STREAM CHANNELS #############################
play_channel()
{
if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name Channel $num" 
  
  if [ "$uamode" == "on" ]
  then 
  echo "$UA"
   
    if [ "$use_cookies" == "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl -A "$UA" --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --user-agent="$UA" --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" == "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen" "$link"  "$format"
    elif [ "$method" == "Tor" ]
    then
    torsocks -a "$socks_ip" -P "$socks_port" -i mpv --user-agent="$UA" --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen "$link"  
    elif [ "$method" == "Tor-Streamlink" ]
    then
    torsocks -a "$socks_ip" -P "$socks_port" -i livestreamer --player "mpv --user-agent="$UA" --no-resume-playback  --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen" "$link"  "$format"
    elif [ "$method" == "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen "$link"  
    else
    mpv --user-agent="$UA" --no-resume-playback  --cache-default="$cache_size" --cach-secs="$cache_secs" --loop=inf --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" == "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --fullscreen --loop=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" == "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen" "$link"  "$format"
    elif [ "$method" == "Tor" ]
    then
    torsocks -a "$socks_ip" -P "$socks_port" -i mpv --user-agent="$UA"  --no-resume-playback  --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen "$link"  
    elif [ "$method" == "Tor-Streamlink" ]
    then
    torsocks -a "$socks_ip" -P "$socks_port" -i livestreamer --player "mpv --user-agent="$UA" --no-resume-playback  --cache-default="$cache_size" --cache-secs=="$cache_secs" --loop=inf --fullscreen" "$link"  "$format"
    elif [ "$method" == "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --no-resume-playback  --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen "$link"  
    else
    mpv  --no-resume-playback --loop=inf --cache-default="$cache_size" --cache-secs="$cache_secs" --loop=inf --fullscreen "$link" 
    fi
     
  fi
#clear
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
format=""
method=""
read entry
else 
#clear
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

########################################### FIRST RUN  ####################################################################
clear

## select the user agent
select_agent

# initialize menu and channels
menu="s"
men_num=0
entry=1
num=1
format=""

############## USER INPUT FIRST RUN  ###################################
##  If input is non empty display and select
if [ "$1" != "" ]
then
  echo "$1"
  # take channel input from command line
  entry="$1" 
elif [ "$1" == "" ]  # else redisplay the channel matrix at previous page and ask for user input
then
  channel_matrix_"$men_num"
  echo "Please Select a Number corresponding to a Media Live Stream:"
  read entry
  if [ "$entry" == "q" ]
  then 
   echo "Type endstream to open a new stream."
   exit "$?"
  elif [ "$entry" == "" ]
  then
   entry=1
   num=1
  fi
fi

### DECIDE WHAT THE USER INPUT IS
menu_status $entry

### Case to remove void input on channel +/- at first selection 
if [ "$chan_state" == "+" ]
then 
chan_state="return"
entry=1
num=1
elif [ "$chan_state" == "-" ]
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
 
  
----------- 
