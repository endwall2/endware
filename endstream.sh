#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017-2019, The Endware Development Team,
# All Rights Reserved
# Creation Date: February 22, 2017
# Version: 0.63550
# Revision Date: November 1, 2020
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
version="0.63550"
rev_date="01/11/2020"
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

#torsocks_ip=127.0.0.1
#torsocks_port=9050
torsocks_ip=192.168.1.103
torsocks_port=9050

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{
   echo "============================================================    "$product"  "$version"   =========================================================================="
   echo "||     ENGLISH      ||    ENGLISH II   ||     FRANCAIS      ||      ESPANOL     ||      EAST EUROPE      ||   SOUTH EUROPE/TURK      ||  ARABIC/FARSI/Pashtun/||"
   echo "============================================================================================================================================================="
   echo "1)France 24 English   41)QVC UK          81)France 24 FR      121)RT Espanol       161)WDR DE            201)-------------             241)RT Arabic"
   echo "2)RT UK               42)QVC 1 USA       82)BFM TV FR         122)DW Espanol       162)DW Deutsch        202)-------------             242)France 24 Arabic"
   echo "3)DW English          43)TSC CA          83)BFM Business FR   123)CGTN Espanol     163)ZDK InfoKanal     203)-------------             243)BBC Arabic"
   echo "4)Russia Today        44)QVC 2 USA       84)RT France         124)France24 Espanol 164)Tagesschau/MOMA DE204)Teletutto Brescia IT      244)DW Arabic"
   echo "5)CBSN USA            45)QVC 3 USA       85)France Info TV    125)TeleSUR VE       165)Euronews DE       205)QVC Italian               245)CGTN Arabic"
   echo "6)Bloomberg USA       46)QVC 4 USA       86)TV5 Monde FR      126)Hispan TV IR     166)QVC DE            206)Italia channel            246)Al Jazeera QA"
   echo "7)RT America          47)TWIT USA        87)CGTN Francais     127)Magala TV ES     167)ADR Alpha DE      207)Mediaon BergamoTV IT      247)Al Jazeera Mubasher QA"
   echo "8)Newsy USA           48)TVW Washington  88)Euronews FR       128)GRANADA TV ES    168)Radio 21 DE       208)News24.city Milan IT      248)KSA 1 SA"
   echo "9)ABC News USA        49)DC Network      89)Africa News       129)C5N AR           169)DW Deutsch + DE   209)Radio TV Rome IT          249)KSA Sports SA"
   echo "10)Cheddar News       50)DC Capitol      90)TVA CA            130)AcequiaMendozaAR 170)Baden TV DE       210)Udinews TV Udine IT       250)Al Arabiya AE"
   echo "11)TRT World TK       51)DC Knowledge    91)RDI ICI CA        131)Todo Noticias AR 171)W24 Wein AT       211)DiTV 89 Lucchese IT       251)Al Mayadeen LB"
   echo "12)Al Jazeera         52)Southeastern TV 92)France 2          132)La Nacion AR     172)Tirol TV AT       212)RTM Arcevia IT            252)Belqees TV YE"
   echo "13)Press TV Iran      53)Texas State TV  93)France 3          133)TV5 AR           173)Auftanken AT      213)50NewsVersiliaViareggio IT253)Sky Arabic AE"
   echo "14)India Today        54)Temple U TUTV   94)ARTE Francais     134)KZO AR           174)Musig24 CH        214)50 Canale Pisa IT         254)Alghad EG"
   echo "15)CGTN Beijing       55)MNN 5 NY USA    95)France O          135)Canal 2 AR       175)TV OOST BE        215)Teleliberta Piacenza IT   255)Extra News EG"
   echo "16)NHK World JP       56)MNN 1 NY USA    96)Bidtween FR       136)Canal 6 AR       176)RTV OOST NL       216)ONE MT                    256)CBC Sofra EG"
   echo "17)Arirang KR         57)MNN 2 NY USA    97)Azur TV Nice FR   137)Canal 7 AR       177)AT5 NL            217)Z1 Televizija HR          257)CBC Drama EG"
   echo "18)CNA SG             58)MNN 3 NY USA    98)IL TV FR          138)Canal 13 AR      178)Euronews Russian  218)OsjeckaTV HR              258)DMC Live EG"
   echo "19)ABC AU             59)MNN 4 NY USA    99)BFM Paris FR      139)CN23 AR          179)POCCNR 24 RU      219)Tomix Wein HR             259)Al-Fallujah IQ"
   echo "20)Arise News NG      60)BronxNet NY USA 100)Alsace 20 FR     140)Telemax AR       180)RBC TV RU         220)Sky Folk MK               260)AFAQ TV IQ"
   echo "21)TeleSUR Eng VE     61)BronxNet Omni   101)Mosaik TV FR     141)Vorterix AR      181)CGTN Russian      221)Top News Albania          261)Karbarla IQ"
   echo "22)NEWSMAX USA        62)BronxNet Culture102)La Vendee        142)TV Publica AR    182)Vesti FM RU       222)Star Lamia GR             262)Safeer TV UK"
   echo "23)Free Speech TV     63)BronxNet Life   103)8 Monte Blanc FR 143)Mega CL          183)Perviy RU         223)Action 24 GR              263)BBC Persian"
   echo "24)Infowars Live      64)CBSN NY USA     104)TV7 Bordeaux FR  144)Telemedeline CO  184)Current Time VOA  224)TRT Haber TR              264)Iran Aryaee"
   echo "25)Infowars RealNews  65)CBSN LA USA     105)Var Azur         145)Teleantioquia CO 185)5 Live RU         225)NTV TR                    265)DidgahNew TV IR"
   echo "26)Infowars WarRoom   66)CBSN Bay Area   106)teleGrenoble     146)Globovision VE   186)News 24 UA        226)HaberTurk TV              266)Aryen TV IR"
   echo "27)United Nations TV  67)CBSN Boston     107)LCP FR           147)NTN24 VE         187)UA TV UA          227)Star TV TR                267)PTN PARS TV USA"
   echo "28)Weather Nation     68)CBSN Chicago    108)Public Senate FR 148)VPItv VE         188)Thromadske UA     228)CNN Turk TR               268)Ariana TV AF"
   echo "29)Weather Channel    69)CBSN Dallas     109)CPAC 1 CA        149)Guatevision GT   189)Espresso UA       229)KRT Kulture TR            269)TOLO NEWS AF"
   echo "30)VOA USA            70)CBSN Denver     110)Assemblee QC CA  150)Excelsior MX     190)News 1 UA         230)TGRT Haber TR             270)------------"
   echo "31)RT Documentary     71)CBSN Minnesota  111)MB TV Monte Blanc151)3/24 ES          191)Ukraine 5 UA      231)TVNET Canali TR           271)------------"
   echo "32)CGTN Documentary   72)CBSN Philli     112)Gong Cinema      152)Promar TV VE     192)TV Publica Moldova232)Show TV TR                272)------------"
   echo "33)CBC CA             73)CBSN Pittsburgh 113)GONG MAX         153)TVO VE           193)RT Docs RU        233)-------------             273)------------"
   echo "34)CBC NewsNet CA     74)NDTV IN         114)BX1 BE           154)TeleSUR VE       194)-------------     234)-------------             274)------------"
   echo "35)CPAC 1 CA          75)Times IN        115)France Info Radio155)Telecafe CO      195)-------------     235)-------------             275)------------"
   echo "36)Oireachtas TV IE   76)ET Now IN       116)Europe 1 FR      156)EsteCanal TV     196)-------------     236)-------------             276)------------"
   echo "37)RTE News NOW IE    77)NewsX IN        117)OUATCH TV        157)A24 AR           197)-------------     237)-------------             277)------------"
   echo "38)SKY News UK        78)NewsX NE        118)RTL BE           158)TeleDiario MX    198)-------------     238)-------------             278)------------"
   echo "39)Africa News Eng    79)NDTV Profit     119)France Inter     159)BoliviaTV        199)-------------     239)-------------             279)------------"
   echo "40)Euronews Eng       80)-------------   120)RMC INFO FR      160)MONARCA MX       200)-------------     240)-------------             280)------------"
   echo "=========================================================================================================================================================="

}    

channel_matrix_1()
{
   echo "============================================================    "$product"  "$version"   ======================================================================"
   echo "||      INDIAN      ||     ASIA        || SOUTH ASIA / AFRICA ||        EXTRA       ||     ENTERTAINMENT    ||    RELIGIOUS  I    ||      RELIGIOUS II     ||"
   echo "============================================================================================================================================================"
   echo "281)Aaj Tak PK       321)CCTV 4 China   361)DZMM ABS-CBN      401)RSBN Auburn USA    441)Music Choice Play  481)Vatican Media     521)Vatican Media Eng"
   echo "282)DIN News PK      322)ECB 51 TW      362)PTV Philippines   402)Seminole TV        442)M2O Music Channel  482)EWTN Americas     522)Vatican Deutsch"
   echo "283)Minhaj PK        323)ECB Finance TW 363)NET TV Jakarta ID 403)WVIT 30 Hartford   443)Radio Monte Carlo  483)EWTN Ireland      523)Vatican Italiano"
   echo "284)Barkat PK        324)TTV TW         364)NET LIVE ID       404)NBC 11 Bay Area    444)V2Beats TV         484)EWTN Africa       524)Temple Institute"
   echo "285)Geo News PK      325)CTV TW         365)NET Comedy ID     405)WXXV25             445)DanceStart TV      485)EWTN Asia         525)TBN "
   echo "286)SAMAA PK         326)FTV TW         366)Buddha MM         406)NBC 2 Florida      446)BritAsia TV        486)Salt&Light TV     526)TBN UK "
   echo "287)Shaski India     327)CTS World TW   367)VietTV VN         407)WCCB Charlotte     447)H!T Music          487)Catholic TV       527)Hillsong TV "
   echo "288)SunNews          328)SET News TW    368)VietSky USA       408)WSJ Live           448)California Music   488)CTND Detroit      528)TCI Italian   "
   echo "289)TV9 India        329)CTI TW         369)ABHPTV VN         409)CTV Event CA       449)Country Network    489)Shalom USA        529)Enlace Latino "
   echo "290)Rajya Sabha      330)SET iNews TW   370)Earthquake 24 JP  410)RUPTLY             450)Ditty TV           490)Shalom World      530)Salsa "
   echo "291)TV9 Gujarat      331)Formosa TW     371)Arirang News TV   411)--------------     451)Rockland Radio     491)Shalom Europe     531)SMILE  "
   echo "292)News 7 Tamil     332)TzuChi DaAi TW 372)Arirang TV KR     412)--------------     452)Classic ARTS       492)EWTN Espanol      532)JUCE TV  "
   echo "293)News 18 India    333)DaAiVideo TW   373)BSC 24 1 JP       413)NBC News Event     453)Fashion Europe     493)EWTN Deutsch      533)Nejat "
   echo "294)Aaj Tak          334)DaAi Live TW   374)--------------    414)Buffalo TV         454)Jasmin TV USA      494)KtO Catholique    534)Al Horreya "
   echo "295)NTV Telugu       335)Sinda TV       375)--------------    415)Panama City        455)MLB Network        495)TRWAM PL          535)EJTV "
   echo "296)ABN Telugu       336)CTS 2 TW       376)--------------    416)Pawleys Island     456)RED BULL TV        496)CBN               536)BYUTV "
   echo "297)Vanitha TV       337)SJTV TW        377)--------------    417)America Thinks     457)CBS Sports HQ      497)CBN News          537)------------"
   echo "298)HMT Telugu       338)LLBN Chinese   378)Africa News       418)Bloomberg Europe   458)11 Sports          498)NRB               538)------------"
   echo "299)India TV IN      339)SDTV TW        379)Africa24          419)Bloomberg Asia     459)Sorgatronmedia     499)Trinity Channel   539)------------"
   echo "300)Survana News     340)FANS TV TW     380)SIKKA Afrique     420)HSN                460)Adult Swim         500)IHOP              540)------------"
   echo "301)i News Telugu    341)Hong Kong TV   381)Channels 24 NG    421)HSN 2              461)Geek and Sundry    501)Amazing Facts     541)------------"
   echo "302)PTTV Tamil IN    342)OnTV HK CN     382)TVC News NG       422)Bloomberg Australia462)CON TV             502)It's Supernatural 542)-------------"
   echo "303)DD News          343)GET TV USA     383)NTV Uganda UG     423)Bloomberg USPoli   463)Shout Factory      503)Shepherd's Chapel 543)-------------"
   echo "304)REPORTER LIVE    344)KCTV KP        384)SPARK UG          424)Bloomberg Live     464)RetroTV            504)BVOVN             544)------------"
   echo "305)AsiaNet News     345)Arirang Korea  385)EbruTV KE         425)Bloomberg EU Live  465)RobotChicken       505)3ABN              545)------------"
   echo "306)V6 News          346)TBS KR         386)KTN Kenya KE      426)Bloomberg Asia Live466)POP TV             506)3ABN Latino       546)------------"
   echo "307)Aaj Tak IN       347)YTN DMB KR     387)KTN Home KE       427)PBS NewsHour       467)ET Live            507)3ABN Francais     547)------------"
   echo "308)ETV AndhraPradesh348)YTN Sci KR     388)Joy News GH       428)CBC The National   468)Amouranth          508)LLBN SmartLife    548)------------"
   echo "309)News 18 Tamil    349)Channel 23 KR  389)ADOM GH           429)AP Top Stories     469)Allkey Shop        509)LLBN His Word     549)------------"
   echo "310)Jaya Plus        350)KBS World24 KR 390)Bukedde TV GH     430)Democracy Now      470)Talking Tom        510)LLBN His Light    550)-------------"
   echo "311)TEZ TV           351)YTN 27 KR      391)EBC ET            431)CNN PH             471)Talking Tom Mini   511)LLBN Latino TV    551)-------------"
   echo "312)Dili Aaj Tak     352)CGNTV          392)Walf SN           432)CNN Live USA       472)PJ Masks           512)Salt and Light    552)-------------"
   echo "313)Derana LK        353)LLBN Korean TV 393)EriTV ER          433)Lake Tahoe TV      473)-------------      513)Harbor Light      553)-------------"
   echo "314)Swarnavahini LK  354)YTV USA        394)SABC ZA           434)HLN                474)-------------      514)St. Mary's Coptic 554)-------------"
   echo "315)Kaliagnar News   355)Atlanta AM790  395)ITV ZA            435)----------         475)-------------      515)Word of God Greek 555)-------------"
   echo "316)Sangat UK        356)ANN24 JP       396)Parliament ZA     436)Jupiter Broadcast  476)-------------      516)Shalom America    556)-------------"
   echo "317)Sikh Channel     357)Sol!ve 24 JP   397)D24               437)News12TW CT        477)-------------      517)Shalom India      557)-------------"
   echo "318)NTV Bangladesh   358)KBS 24 JP      398)Afrique Media     438)TG4 Gaelic IE      478)-------------      518)Powervision TV    558)-------------"
   echo "319)ATN Bangladesh   359)QVC Japan      399)DMB               439)CNBC               479)NASA Public Media  519)LLBN Arabic       559)-------------"
   echo "320)Channel 24 IN    360)BSC 24 1 JP    400)--------------    440)Euronews English   480)NASA Education     520)LLBN SouthAsia    560)-------------"
   echo "================================================================================================================================================================="
}
#

channel_matrix_2()
{
   echo "============================================================    "$product"  "$version"   ====================================================================="
   echo "||     CANADA        ||      LATINO II     ||     LATINO III     ||      Portugues        ||     USA Local 2     ||     USA Local 3   ||   LiveStream 1   ||"
   echo "============================================================================================================================================================"
   echo "561)CBC News Net CA  601)VIVE VE            641)Nuevolaredo MX    681)Euronews PT         721)FOX News Preview   761)News 12 KTVZ7     801)------------"
   echo "562)CBC Vancouver    602)Vatican Media ES   642)Sinart CR         682)TV Assemblelia BR   722)Beach TV           762)NewsWest 9 KWES DC802)------------"
   echo "563)CBC Yellowknife  603)Televen VE         643)Bethel Panama     683)TV Canaco Nova      723)Daytona Beach      763)Orange TV         803)Dashmesh  "
   echo "564)CBC Edmonton     604)Impacto USA        644)Poder de Dios BO  684)Igreja de Graca     724)Shepard Smith      764)PGCPS             804)Iberia TV  "
   echo "565)CBC Calgary      605)UCVTV CL           645)GUATEVISION GT    685)Assemblelia Ales    725)WUSA9 Breaking     765)RyeTV             805)Obieqtivi TV   "
   echo "566)CBC Regina       606)UCVTV 2 CL         646)RTV ES            686)Boas Nova           726)WCNC Breaking      766)Seattle Channel   806)ortonville   "
   echo "567)CBC Winnepeg     607)Univision MX       647)Medios Publicos   687)Fundacao Nazzare    727)WCCB News          767)Atlanta TV        807)Holiday & Cruise  "
   echo "568)CBC Windsor      608)Cablenet AR        648)Tele Bahia DR     688)STF Brazil          728)UGA TV             768)----------        808)Vision Cruise AU "
   echo "569)CBC Toronto      609)Telpintv AR        649)Iglesia Advent USA689)TV Estudio Brasil   729)TVW2 Washington    769)Vienna HQ         809)Vision Cruise UK"
   echo "570)CBC Ottawa       610)Canal8 MarPlataAR  650)Expande Puebla MX 690)Radio Justica       730)Action News KNVN   770)Escambia          810)102.3 NOW! TV CA "
   echo "571)CBC Montreal     611)Univision USA      651)Ayuda Universal MX691)EXA FM Brasil       731)Alaska ASD         771)----------        811)TourbusTV USA "
   echo "572)CBC Frederickton 612)Canal 2 AR         652)Canal 27 Esperanza692)RIT TV BR           732)Bowie TV           772)WYCW Carolinas    812)Ezekiel TV"
   echo "573)CBC Charlottetown613)ABC Paraguay       653)TELEAMIGA         693)Gott24.TV           733)Escambia TV        773)FOX 10 News       813)Emmanuel TV "
   echo "574)CBC Halifax      614)Abya Yala BO       654)Poli tv Bogota CO 694)TV Fatima Paroquia  734)FOX 5 DC (WTTG)    774)WHO 13            814)Shalom World"
   echo "575)CBC St. John's   615)UFROVision CL      655)UNTREF UN3 AR     695)You Content 98      735)Garland TV         775)Erie News         815)KIFI ABC 8 Idaho Falls"
   echo "576)Global Vancouver 616)Campo Abierto CL   656)RUAV Univalle CO  696)Rede Genesis PT     736)Greenbelt TV       776)WISTV             816)ESPN Seattle"
   echo "577)Global Calgary   617)UNITV AR           657)JesusTV GT        697)MEIO Teresina BR    737)House Represent    777)Gem Shopping USA  817)King County TV Preston"
   echo "578)Global Edmonton  618)TelePacifico CO    658)FGTV USA          698)Medalhao Persa BR   738)KRBC-TV            778)C-SPAN 1 USA      818)KIRO Radio Seattle"
   echo "579)Global Toronto   619)Venevision VE      659)Evangelio Eterno  699)Talenu TV TPA       739)New Orleans TV     779)C-SPAN 2 USA      819)KOIN CBS 6 Portland"
   echo "580)Global Halifax   620)Telediario AR      660)Cosmovision TV    700)TV Miramar BR       740)KTVB               780)C-SPAN 3 USA      820)KPTV FOX 12 Portland"
   echo "581)NTV Newfoundland 621)TVeo Cordoba AR    661)Libre Cali CO     701)TV Zimbo AO         741)Key TV             781)Fox News Talk     821)KTVZ 21 Bend Oregon"
   echo "582)Tele Quebec      622)PSN Tijuana MX     662)Yuma CO           702)TV RAIAR AO         742)KOB4 News          782)KNBC 4 LA USA     822)KEZI ABC 9 Eugene"
   echo "583)Tele V           623)CNN Espanol        663)Dominio MX        703)SescTV SaoPaulo BR  743)KPNX Breaking      783)ABC News 1        823)KOIN 6 Extra Portland"
   echo "584)ICI CB-Yukon Tele624)Paraguay Noticias  664)Senal UNTREF      704)Rede Super BeloBR   744)KXAN News          784)ABC News 2        824)KSL NOW Salt Lake "
   echo "585)ICI Alberta      625)Canal Tr3ce CO     665)NRT 4 monclova    705)Talenu Luanda AO    745)Miami TV           785)ABC News 3        825)KUSI San Diego"
   echo "586)ICI Saskatchewan 626)Cali TV            666)TVUNAM 20         706)Vatican Media PT    746)KNTV-TV            786)ABC News 4        826)KEYT ABC 3 Santa Barbara"
   echo "587)ICI Manitoba     627)Canal 12 CO        667)EVTV Miami        707)-------------       747)KNTV Telemundo     787)ABC News 5        827)KHSL CBS 12 Redding"
   echo "588)ICI Ontario      628)Imagen Radio MX    668)Cosmovision TV BO 708)-------------       748)NBC2 News KTUU     788)ABC News 6        828)KRCR ABC 7 Redding "
   echo "589)ICI Ottawa       629)Euronews ES        669)-------------     709)-------------       749)News2 WCBD         789)ABC News 7        829)KION CBS 5/46 Salinas"
   echo "590)ICI Acadie       630)Teleamazonas       670)-------------     710)-------------       750)News4 WRC Wash D.C.790)ABC News 8        830)KSBY NBC 6 Santa Barbara"
   echo "591)ICI Estrie       631)TV Camara PY       671)-------------     711)-------------       751)News4 White House  791)ABC News 9        831)KESQ ABC 3 Palm Springs  "
   echo "592)ICI Maurice      632)Tu Canal Panama    672)-------------     712)-------------       752)News5 WCYB         792)ABC News 10       832)KCOY CBS 12 Santa Maria "
   echo "593)ICI Montreal     633)Colosal TV 1       673)-------------     713)-------------       753)NewsWest 9 KWES    793)ABC News 11       833)MCAET Salinas "
   echo "594)ICI Saguenay     634)Canal 8 AR         674)-------------     714)-------------       754)NBC4 WNBC          794)------------      834)KVVB CH.33 Victorville"
   echo "595)ICI Quebec       635)CanalShowsport AR  675)-------------     715)-------------       755)NBC4 WNBC Traffic  795)------------      835)KOAA NBC 5 Colorado"
   echo "596)ICI Est-Quebec   636)WIPR Puerto Rico   676)-------------     716)-------------       756)NBC5 WMAQ          796)------------      836)KRDO ABC 13 Colorado"
   echo "597)CityLine         637)La Mega Bogota CO  677)-------------     717)-------------       757)NBC 10 KTEN        797)------------      837)Freedom Solar TV Kersey"
   echo "598)CBC News Montreal638)TV UNAM MX         678)-------------     718)-------------       758)NBC 12 WWBT        798)------------      838)KTVK 3 TV Arizona"
   echo "599)------------     639)Azteca 7 MX        679)-------------     719)-------------       759)NBC 29 WVIR        799)------------      839)KMVP 24/7 Phoenix"
   echo "600)------------     640)Cinevision DR      680)-------------     720)-------------       760)NBC 13 WNYT        800)------------      840)KTAR News Phoenix"
   echo "============================================================================================================================================================="
}

channel_matrix_3()
{
   echo "============================================================    "$product"  "$version"   ============================================================================="
   echo "||      LiveStream 2      ||    LiveStream 3       ||      LiveStream 4     ||     LiveStream 5     ||       LiveStream 6      ||    LiveStream 7      ||   Livestream 8  ||"
   echo "============================================================================================================================================================================"
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
   echo "852)WFSB 3 Hartford       892)WISH 8 Indianapolis   932)CBS 17 Rahliegh NC    972)KSWO ABC 7 Winters TX 1012)Mike Malloy Show     1052)------------    1092)------------"
   echo "853)CharmTV Baltimore     893)EKBTV Pikeville KY    933)WCSC CBS 5 Charleston 973)------------          1013)Nasdaq Bell          1053)------------    1093)------------"
   echo "854)WTTG Fox 5 DC         894)WTVQ ABC 36 Lexington 934)WSPA CBS 7 Spartanberg974)ESPN 97.5 Houston TX  1014)Westerville.TV 543   1054)------------    1094)------------"
   echo "855)WWLP 22 Springfield   895)WPSD-TV Paducah       935)WMBF Myrtle Beach     975)Granbury Media TX     1015)Kingdom Access       1055)------------    1095)------------"
   echo "856)WestMass News Chicopee896)Lex 18 Lexington      936)WIS NBC 10 Columbia   976)KCOH TV Houston TX    1016)Plaistow Access      1056)------------    1096)------------"
   echo "857)Milford TV            897)WFLA NBC 8 Tampa Bay  937)WSMV NBC 4 Nashville  977)KXAN NBC Austin       1017)Topeka City          1057)------------    1097)------------"
   echo "858)Milford TV Educate    898)WTVT FOX 13 Tampa Bay 938)WBBJ ABC 7 Tennesee   978)KSLA 12 Shreveport    1018)Shelby County        1058)------------    1098)------------"
   echo "859)WWOR Secaucus NJ      899)Island TV Miami       939)WDEF CBS12 Chattanooga979)WAFB CBS9 BatonRouge  1019)Provincetown         1059)------------    1099)------------"
   echo "860)WNYW Fox 5 New York   900)City of Tampa         940)WMC NBC 5 Memphis     980)WVUE FOX8 NewOrleans  1020)CITV Hamilton Bermuda1060)------------    1100)------------"
   echo "861)WROC CBS 8 Rochester  901)WFLX FOX 29 Palm Beach941)2nd Presbyter Memphis 981)KLFY 10 Lafayette     1021)Shalom Media KIDS    1061)------------    1101)------------"
   echo "862)WABC 77 New York      902)WYKE TV 47 Hormosassa 942)ETSU Fine Arts Johnson982)WDFL 18 SC/LA         1022)Lutheran Penfield    1062)------------    1102)------------"
   echo "863)WJHL CBS 11 Johnson   903)WJBF Augusta GA       943)EPlusTV6 Jackson      983)KSLA CBS12 Shreveport 1023)Whole Life Ministries1063)------------    1103)------------"
   echo "864)DayTraderRockStar     904)WMGT 41 NBC Macon GA  944)KELO Keloland ND/SD   984)HTV10 Houma LA        1024)St. Catharine Church 1064)------------    1104)------------"
   echo "865)NYXT Manhattan NYC    905)WSAV NBC 3 Savannah   945)KVRR Fargo ND         985)KPLC NBC7 LakeCharles 1025)Glory to God         1065)------------    1105)------------"
   echo "866)MNN-FSTV              906)WTOC 11 Savannah      946)KDLT Sioux Falls SD   986)KATC ABC3 Lafayette   1026)St. Helena Chapel    1066)------------    1106)------------"
   echo "867)Fox 8 Cleveland       907)WTVM ABC 9 Columbus   947)GovTV Watertown SD    987)HU16 Harding Sercy    1027)St Patrick Dumbarton 1067)------------    1107)------------"
   echo "868)WIVM TV39 Canton      908)WRBL CBS 3 Columbus   948)KELO CBS Sioux Falls  988)KSNT Weather Wichita  1028)VTNTV VICTORY        1068)------------    1108)------------"
   echo "869)WBNS 10 Columbus      909)WGCL CBS46 Atlanta    949)KIMT 3 Mason City     989)WPS-TV Wichita Public 1029)TMN WORD TV          1069)------------    1109)------------"
   echo "870)WNYT NBC 13 Sandusky  910)WALB NBC 10 Albany    950)WDIO ABC 10/13 Duluth 990)KSNW NBC 3 Witchita   1030)Parkside Radio       1070)------------    1110)------------"
   echo "871)WBNS 10 Radar Columbus911)WDAM 7 Hattiesburg    951)KAAL ABC 6 Rochester  991)KSNT Kansas OK        1031)FGTV FreqGlory       1071)------------    1111)------------"
   echo "872)WBNS 10 Columbus      912)WLOX ABC13 Mississippi952)KQDS FOX 21 Duluth    992)Enid TV OK 1          1032)HJTV Healing Jesus   1072)------------    1112)------------"
   echo "873)WOIO CBS 19 Clevland  913)WJTV CBS 12 Jackson   953)KSTP ABC 5 St. Paul   993)KMOV CBS4 St. Louis   1033)APTV Apocalypse      1073)------------    1113)------------"
   echo "874)WTOL CBS 11 Toledo    914)WLBT FOX 40 Jackson   954)KMSP FOX 9 Minneapolis994)KMIZ ABC 17 Missouri  1034)Marytown Chapel      1074)------------    1114)------------"
   echo "875)WCMH NBC 4 Columbus   915)WHLT Hattiesburg      955)St. Cloud Times UTVS  995)PolkCounty BolivarMO  1035)Guaranty Media       1075)------------    1115)------------"
   echo "876)WTXF FOX 29 Philli    916)WSFA 12 Montgomory    956)WHLT 12 Whitehall     996)KOLR CBS10 Springfield1036)Pro Football Hall    1076)------------    1116)------------"
   echo "877)WBRE NBC Wilkes Barre 917)WBRC FOX6 Birmingham  957)WFLD Fox 32 Chicago   997)Branson TV MO         1037)Lance Hope RSL       1077)------------    1117)------------"
   echo "878)WPHL TV ABC 6 Philli  918)WAKA CBS 8 Alabama    958)WAND NBC 17 Decatur   998)EUTV Springfield MO   1038)XBTV RosecroftRaceway1078)------------    1118)------------"
   echo "879)WFMZ 69 Allen Town    919)WAAY ABC 31 Huntsville959)WFLD Fox 32 Chicago   999)KY3 Springfield MO    1039)Park City TV PCTV    1079)------------    1119)------------"
   echo "880)WPRI Fox 12 Providence920)CBS 42 Birmingham     960)KRIV FOX 26 Houston   1000)KQTV 2 St. Joseph MO 1040)AAA Guayama          1080)------------    1120)------------"
   echo "================================================================================================================================================================="
}

channel_matrix_4()
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||     FRANCAIS II     ||     GOVERNMENT     ||     AUS/NZ          ||   TWITCH         ||  Column 5         ||    Column 6        ||   Locations    ||"
   echo "============================================================================================================================================================"
   echo "1121)Generations TV   1161)EBS EU            1201)2UE Sydney        1241)CAT LIKE MEOW    1281)------------      1321)------------     1361)NASA ISS 1 "
   echo "1122)Telesud          1162)EBS Plus EU       1202)3AW Melbourne     1242)BAD BUNNY        1282)------------      1322)------------     1362)Venice Bridge "
   echo "1123)VL               1163)Dail Eireann IE   1203)4BC Brisbane      1243)hasanabi         1283)------------      1323)------------     1363)JacksonHole Sq "
   echo "1124)BFM TV           1164)Senad Eireann IE  1204)3 News NZ         1244)DizzyKitten      1284)------------      1324)------------     1364)JacksonHole Rust"
   echo "1125)TV 7 Bordeaux    1165)Oireachtas CR 1 IE1205)------------      1245)intraventus      1285)------------      1325)------------     1365)Aosta Sarre Italy"
   echo "1126)8 Monte Blacnc 2 1166)Oireachtas CR 2 IE1206)------------      1246)kneecoleslaw     1286)------------      1326)------------     1366)Buenos Aires  "
   echo "1127)RTL 2            1167)Oireachtas CR 3 IE1207)------------      1247)nanerboots       1287)------------      1327)------------     1367)Amsterdam NL "
   echo "1128)OUI FM           1168)Oireachtas CR 4 IE1208)------------      1248)IgotTheJoos      1288)------------      1328)------------     1368)Shibua Japan"
   echo "1129)D24TV            1169)------------      1209)------------      1249)courtneyysmoke   1289)------------      1329)------------     1369)Akiba Japan"
   echo "1130)Canal Savoir CA  1170)------------      1210)------------      1250)taylor_jevaux    1290)------------      1330)------------     1370)Yahoo Japan "
   echo "1131)RFI FR           1171)------------      1211)------------      1251)ninjastarasmr    1291)------------      1331)------------     1371)Steamy Mountain"
   echo "1132)CNEWS FR         1172)------------      1212)------------      1252)smidjen          1292)------------      1332)------------     1372)Naman Seoul "
   echo "1133)SYTRAL Rhone FR  1173)------------      1213)------------      1253)jadethejaguar    1293)------------      1333)------------     1373)Shizuoka Japan"
   echo "1134)Vedia BE         1174)------------      1214)------------      1254)keelyvalentine   1294)------------      1334)------------     1374)Yokohama Japan "
   echo "1135)MABI CA          1175)------------      1215)------------      1255)blondiewondie    1295)------------      1335)------------     1375)Mount Fuji Japan"
   echo "1136)Vatican Media FR 1176)------------      1216)------------      1256)missypwns        1296)------------      1336)------------     1376)Hart Beach NL"
   echo "1137)TVM Paris FR     1177)------------      1217)------------      1257)------------     1297)------------      1337)------------     1377)Port Du Quebec "
   echo "1138)C-Star           1178)------------      1218)------------      1258)------------     1298)------------      1338)------------     1378)Durango Colorado"
   echo "1139)Journal TVLandes 1179)------------      1219)------------      1259)------------     1299)------------      1339)------------     1379)StarDot 1"
   echo "1140)TV 7 FR          1180)------------      1220)------------      1260)------------     1300)------------      1340)------------     1380)Youing Japan "
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

################## FRANCE ###############################################
# 1) France 24 Anglais
1)
keyword="FRANCE 24 Live"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"

#link=http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=655600,AVERAGE-BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=25.000
#link=http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=875600,AVERAGE-BANDWIDTH=875600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000
#link=http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1095600,AVERAGE-BANDWIDTH=1095600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000
#link=http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1425600,AVERAGE-BANDWIDTH=1425600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000
#link=http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2305600,AVERAGE-BANDWIDTH=2305600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000
link="http://f24hls-i.akamaihd.net/hls/live/221147/F24_EN_HI_HLS/master_2000.m3u8"

#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master.m3u8
#link="http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master_900.m3u8"
# audio only
#link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master_96.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
# link=http://www.dailymotion.com/video/xigc8z

#EXTINF:-1,France24 France
#http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#EXTINF:-1,France24 Arabic
#http://static.france24.com/live/F24_AR_LO_HLS/live_ios.m3u8
#EXTINF:-1,France24 English
#http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
#EXTINF:-1,France24 English
#http://static.france24.com/live/F24_ES_LO_HLS/live_ios.m3u8

fi

#method="Tor"
use_cookies="no"
TAG=" FRANCE24___"
chan_name="France 24 English" ;;

# 2) RT UK
2)
if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/rt-uk-air/
#link=https://rt-uk.secure.footprint.net/1106.m3u8
################EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-uk.secure.footprint.net/1106_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-uk.secure.footprint.net/1106_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-uk.secure.footprint.net/1106_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-uk.secure.footprint.net/1106_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-uk.secure.footprint.net/1106_64Kb.m3u8
########
#link=https://www.filmon.com/tv/russia-today-2
fi
#method="Proxychains"
#method="Tor"
use_cookies="no"
TAG="RTUK_______"
chan_name="RT UK" ;;

################## GERMANY ########
# 3) DW English
3)
keyword="DW"

if [ "$getlink" = 1 ]
then

#link=https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/index_5_a-b.m3u8?sd=10&rebase=on"
#link= https://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelleenglish/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"

fi
#method="Tor"
use_cookies="no"
TAG=" DWENG______"
chan_name="DW English" ;;

#################### RUSSIA  ################################
# 4) Russia Today
4)

if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/
#link=https://rt-news.secure.footprint.net/1103.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-news.secure.footprint.net/1103_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-news.secure.footprint.net/1103_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-news.secure.footprint.net/1103_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-news.secure.footprint.net/1103_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-news.secure.footprint.net/1103_64Kb.m3u8
## link=https://www.filmon.com/tv/russia-today-1

fi
#method="Tor"
use_cookies="no"
TAG=" RT_________"
chan_name="Russia Today" ;;
########################## USA MAINSTREAM ###################################################
# 5) CBSN
5)
keyword="LIVE"
if [ "$getlink" = 1 ]
then

#link=https://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8

#link="https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8"
#link=$( curl "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 )?BANDWIDTH=1689600
####link="$(curl --socks5 "$socks_ip":"$socks_port" -A "$UA" $( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 1029600.m3u8 | tail -n 1 ) "
#link="$(curl -A "$UA" $( curl -A "$UA" "https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8" | cut -d \" -f 2 | cut -d \" -f 1 ) | grep 2808256.m3u8 | tail -n 1 ) "
# BANDWIDTHS: 2808256.m3u8 3394688.m3u8 1928608.m3u8 1195537.m3u8 697100.m3u8 345241.m3u8

#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2808256,AVERAGE-BANDWIDTH=2191641,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_7.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3394688,AVERAGE-BANDWIDTH=2631641,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_8.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1928608,AVERAGE-BANDWIDTH=1531641,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_9.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1195537,AVERAGE-BANDWIDTH=981605,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_10.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=697100,AVERAGE-BANDWIDTH=607641,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_11.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=345241,AVERAGE-BANDWIDTH=343641,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-us-cedexis.cbsnstream.cbsnews.com/out/v1/55a8648e8f134e82a470f83d562deeca/master_12.m3u8"

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

# 6) Bloomberg Business USA
6)
keyword="Bloomberg"
if [ "$getlink" = 1 ]
then
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
link="https://liveproduseast.akamaized.net/us/Channel-USTV-AWS-virginia-1/Source-USTV-1000-1_live.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG=" BLMBRG_____"
chan_name="Bloomberg Business USA";;

# 7) RT America
7)
if [ "$getlink" = 1 ]
then
#link=https://www.rt.com/on-air/rt-america-air/
#link=https://rt-usa.secure.footprint.net/1105.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link="https://rt-usa.secure.footprint.net/1105_2500Kb.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-usa.secure.footprint.net/1105_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-usa.secure.footprint.net/1105_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-usa.secure.footprint.net/1105_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-usa.secure.footprint.net/1105_64Kb.m3u8

fi

#method="Tor"
use_cookies="no"
TAG="RT_AMR____"
chan_name="RT America" ;;

# 8) Newsy
8)

if [ "$getlink" = 1 ]
then
#link=http://www.newsy.com/live/
#link="https://content.jwplatform.com/players/hBmO7M6k"

#link="https://content.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37.m3u8"
link="$(curl -A "$UA" "https://content.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37.m3u8"| grep h.m3u8 | head -n 1 ) "

#link="https://content-auso3.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37/h.m3u8"

#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="aac",NAME="unspecified",LANGUAGE="en",AUTOSELECT=YES,DEFAULT=YES
#UPLYNK-MEDIA0:416x234x30,baseline-13,2x48000
#EXT-X-STREAM-INF:PROGRAM-ID=1,RESOLUTION=416x234,BANDWIDTH=471244,CODECS="mp4a.40.5,avc1.42000d",FRAME-RATE=30.000,AUDIO="aac",AVERAGE-BANDWIDTH=422701
#link="https://content-ause5.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37/d.m3u8?pbs=88f6df2cbf4844c488de5cf552b4a402"
#UPLYNK-MEDIA0:704x396x30,main-30,2x48000
#EXT-X-STREAM-INF:PROGRAM-ID=1,RESOLUTION=704x396,BANDWIDTH=873267,CODECS="mp4a.40.5,avc1.4d001e",FRAME-RATE=30.000,AUDIO="aac",AVERAGE-BANDWIDTH=716145
#link="https://content-ause5.uplynk.com/channel/4bb4901b934c4e029fd4c1abfc766c37/e.m3u8?pbs=88f6df2cbf4844c488de5cf552b4a402"
#link=https://www.filmon.com/tv/newsy
fi
#method="Tor"
use_cookies="no"
TAG="NEWSY-----"
chan_name="Newsy" ;;

# 9)ABC News USA
9)

if [ "$getlink" = 1 ]
then
#https://abcnews.go.com/Live
#https://abcnews.go.com/live/video/special-live-11

link="$(curl -A "$UA" "https://content.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be.m3u8"| grep g.m3u8 | head -n 1 ) "

#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/a.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/b.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/c.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/d.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/e.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/f.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/g.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/h.m3u8?pbs=962b38e9054e487aa50a6e07bfb15c14"
fi
#method="Tor"
use_cookies="no"
TAG="ABC_NEWS_USA"
chan_name="ABC News USA" ;;


# 10)Cheddar News 
10)
if [ "$getlink" = 1 ]
then
#link="https://live.chdrstatic.com/cheddar/index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5310812,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
link="https://live.chdrstatic.com/cheddar/primary/1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5310812,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
#link="https://live.chdrstatic.com/cheddar/backup/1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3267324,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720
#link="https://live.chdrstatic.com/cheddar/primary/2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3267324,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720
#link="https://live.chdrstatic.com/cheddar/backup/2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2245596,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540
#link="https://live.chdrstatic.com/cheddar/primary/3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2245596,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540
#link="https://live.chdrstatic.com/cheddar/backup/3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1326012,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=768x432
#link="https://live.chdrstatic.com/cheddar/primary/4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1326012,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=768x432
#link="https://live.chdrstatic.com/cheddar/backup/4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=872780,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=640x360
#link="https://live.chdrstatic.com/cheddar/primary/5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=872780,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=640x360
#link="https://live.chdrstatic.com/cheddar/backup/5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=499844,CODECS="avc1.4d4015,mp4a.40.5",RESOLUTION=480x270
#link="https://live.chdrstatic.com/cheddar/primary/6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=499844,CODECS="avc1.4d4015,mp4a.40.5",RESOLUTION=480x270
#link="https://live.chdrstatic.com/cheddar/backup/6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=331260,CODECS="avc1.4d400d,mp4a.40.5",RESOLUTION=416x234
#link="https://live.chdrstatic.com/cheddar/primary/7.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=331260,CODECS="avc1.4d400d,mp4a.40.5",RESOLUTION=416x234
#link="https://live.chdrstatic.com/cheddar/backup/7.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cheddar/primary/8.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cheddar/primary/9.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cheddar/backup/8.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cheddar/backup/9.m3u8"

#link="https://live.chdrstatic.com/cbn/index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5310812,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
#link="https://live.chdrstatic.com/cbn/primary/1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5310812,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
#link="https://live.chdrstatic.com/cbn/backup/1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3267324,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720
#link="https://live.chdrstatic.com/cbn/primary/2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3267324,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720
#link="https://live.chdrstatic.com/cbn/backup/2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2245596,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540
#link="https://live.chdrstatic.com/cbn/primary/3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2245596,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=960x540
#link="https://live.chdrstatic.com/cbn/backup/3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1326012,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=768x432
#link="https://live.chdrstatic.com/cbn/primary/4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1326012,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=768x432
#link="https://live.chdrstatic.com/cbn/backup/4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=872780,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=640x360
#link="https://live.chdrstatic.com/cbn/primary/5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=872780,CODECS="avc1.4d401e,mp4a.40.5",RESOLUTION=640x360
#link="https://live.chdrstatic.com/cbn/backup/5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=499844,CODECS="avc1.4d4015,mp4a.40.5",RESOLUTION=480x270
#link="https://live.chdrstatic.com/cbn/primary/6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=499844,CODECS="avc1.4d4015,mp4a.40.5",RESOLUTION=480x270
#link="https://live.chdrstatic.com/cbn/backup/6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=331260,CODECS="avc1.4d400d,mp4a.40.5",RESOLUTION=416x234
#link="https://live.chdrstatic.com/cbn/primary/7.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=331260,CODECS="avc1.4d400d,mp4a.40.5",RESOLUTION=416x234
#link="https://live.chdrstatic.com/cbn/backup/7.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cbn/primary/8.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cbn/primary/9.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cbn/backup/8.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=150400,CODECS="mp4a.40.5"
#link="https://live.chdrstatic.com/cbn/backup/9.m3u8"

fi
#####method="Tor"
use_cookies="no"
chan_name="Cheddar News";;
############################# MIDDLE EAST ##############################################################
# 11) TRT World
11)
keyword="TRT"

if [ "$getlink" = 1 ]
then

#link="https://api.trtworld.com/livestream/v1/WcM3Oa2LHD9iUjWDSRUI335NkMWVTUV351H56dqC/master.m3u8"
#https://api.trtworld.com/livestream/v1/WcM3Oa2LHD9iUjWDSRUI335NkMWVTUV351H56dqC/master.m3u8?secondary=1

#link="https://tv-trtworld.live.trt.com.tr/master.m3u8"
#link="https://tv-trtworld.live.trt.com.tr/master_1080.m3u8"
link="https://tv-trtworld.live.trt.com.tr/master_720.m3u8"
#link="https://tv-trtworld.live.trt.com.tr/master_480.m3u8"
#link="https://tv-trtworld.live.trt.com.tr/master_360.m3u8"
#link=https://trtcanlitv-lh.akamaihd.net/master.m3u8

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
fi
#method="Tor"
use_cookies="no"
TAG="TRTWORLD--"
chan_name="TRT World";;

# 12) Al Jazeera
12)
keyword="Al Jazeera English - Live"

if [ "$getlink" = 1 ]
then
#  link="https://live-hls-web-aje.getaj.net/AJE/index.m3u8"
#  link="https://live-hls-web-aje.getaj.net/AJE/01.m3u8"
   link="https://live-hls-web-aje.getaj.net/AJE/02.m3u8"
#  link="https://live-hls-web-aje.getaj.net/AJE/03.m3u8"
#  link="https://live-hls-web-aje.getaj.net/AJE/04.m3u8"

#link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=https://english.streaming.aljazeera.net/aljazeera/english2/index4147.m3u8
#link="https://english.streaming.aljazeera.net/aljazeera/english2/index2073.m3u8"
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
# 13) Press TV
13)

if [ "$getlink" = 1 ]
then
#link=https://www.filmon.com/tv/press-tv
#link="https://5a61de8ed719d.streamlock.net/liveprs/smil:liveprs.smil/chunklist.m3u8"
#link="https://5a61de8ed719d.streamlock.net/liveprs/smil:liveprs.smil/playlist.m3u8"


#link="https://live.presstv.com/liveprs/smil:liveprs.smil/playlist.m3u8"
#link="https://live.presstv.com/liveprs/smil:liveprs.smil/chunklist_w507567228_b944100_slen.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=344100,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=426x240
#link="https://live.presstv.com/liveprs/smil:liveprs.smil/chunklist_w1948976758_b344100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=394100,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360
#link="https://live.presstv.com/liveprs/smil:liveprs.smil/cchunklist_w1948976758_b394100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=644100,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=854x480
#link="https://live.presstv.com/liveprs/smil:liveprs.smil/chunklist_w1948976758_b644100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=944100,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720
link="https://live.presstv.com/liveprs/smil:liveprs.smil/chunklist_w1948976758_b944100_slen.m3u8"


#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist.m3u8"
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/playlist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=344100,RESOLUTION=426x240
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist_w810122639_b344100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=394100,RESOLUTION=640x360
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist_w810122639_b394100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=644100,RESOLUTION=854x480
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist_w810122639_b644100_slen.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=944100,RESOLUTION=1280x720
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist_w810122639_b944100_slen.m3u8"
#link="https://live2.presstv.com/liveprs/smil:liveprs.smil/chunklist_w810122639_b944100_slen.m3u8"

#link=http://107.189.40.49:1935/live/ptven/playlist.m3u8
#link=http://107.189.40.49:1935/live/ngrp:ptven_all/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1380059,CODECS="avc1.66.40,mp4a.40.2",RESOLUTION=1280x720
#link=http://107.189.40.49:1935/live/ptven/chunklist_w1092714967.m3u8
fi
use_cookies="no"
TAG="PRESSTV___"
chan_name="Press TV" ;;

################### INDIA  ########################################
# 14) India TODAY
14)
keyword="IndiaToday Live TV"
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
#link="https://feeds.intoday.in/hltapps/api/master.m3u8"
#link="$( curl --socks5 "$socks_ip":"$socks_port" -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 896000p | tail -n 1 )"
#link="$( curl -A "$UA" "https://feeds.intoday.in/hltapps/api/master.m3u8" | grep 2128000pb | tail -n 1 )"
# BANDWIDTH=2128000pb.m3u8 896000pb.m3u8 428000pb.m3u8 678000  1628000  428000

#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/playlist.m3u8"
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_4/chunklist.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=255178,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_1/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=255178,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180
#link="https://indiatodaylive.akamaized.net/hls/live/2014320-b/indiatoday/indiatodaylive/indiatoday_1/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=343162,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=416x234
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_2/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=343162,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=416x234
#link="https://indiatodaylive.akamaized.net/hls/live/2014320-b/indiatoday/indiatodaylive/indiatoday_2/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=661008,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=640x360
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_3/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=661008,CODECS="avc1.4d401e,mp4a.40.2",RESOLUTION=640x360
#link="https://indiatodaylive.akamaized.net/hls/live/2014320-b/indiatoday/indiatodaylive/indiatoday_3/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=814666,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=720x404
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_4/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=814666,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=720x404
#link="https://indiatodaylive.akamaized.net/hls/live/2014320-b/indiatoday/indiatodaylive/indiatoday_4/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1442805,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720
#link="https://indiatodaylive.akamaized.net/hls/live/2014320/indiatoday/indiatodaylive/indiatoday_5/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1442805,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720
link="https://indiatodaylive.akamaized.net/hls/live/2014320-b/indiatoday/indiatodaylive/indiatoday_5/chunklist.m3u8"


fi
use_cookies="no"
#method="Tor"
TAG="INDIATODAY"
chan_name="India TODAY English" ;;
###########################  ASIA-OCEANIA   ############################################
# 15) CGTN China English
15)
keyword="Live"
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/manifest.m3u8
#https://news.cgtn.com/resource/live/english/cgtn-news.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,NAME="720p HD"
link=https://live.cgtn.com/1000/prog_index.m3u8
#link=https://128.1.78.40/1000/prog_index.m3u8
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

# 16)NHK World Japan
16)
if [ "$getlink" = 1 ]
then
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_2100.m3u8"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_2100.m3u8"

#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2032668,AVERAGE-BANDWIDTH=2340800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_2M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1086734,AVERAGE-BANDWIDTH=1240800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_1M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=708360,AVERAGE-BANDWIDTH=800800,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_600k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=294786,AVERAGE-BANDWIDTH=325600,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_200k.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,LANGUAGE="eng",NAME="Alternate Audio",AUTOSELECT=YES,DEFAULT=YES,GROUP-ID="program_audio",URI="index_audio.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3803455,AVERAGE-BANDWIDTH=4400000,CODECS="avc1.4d4029,mp4a.40.5",RESOLUTION=1920x1080,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_4M.m3u8"

#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_2100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1161261,AVERAGE-BANDWIDTH=1333200,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_1180.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=423432,AVERAGE-BANDWIDTH=475200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_900.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=612619,AVERAGE-BANDWIDTH=695200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_600.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=423432,AVERAGE-BANDWIDTH=475200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=234246,AVERAGE-BANDWIDTH=255200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_200.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=166402,AVERAGE-BANDWIDTH=176000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2032668,AVERAGE-BANDWIDTH=2340800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_2M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1086734,AVERAGE-BANDWIDTH=1240800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_1M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=708360,AVERAGE-BANDWIDTH=800800,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_600k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=294786,AVERAGE-BANDWIDTH=325600,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_200k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3992642,AVERAGE-BANDWIDTH=4620000,CODECS="avc1.4d4029,mp4a.40.2,mp4a.40.5",RESOLUTION=1920x1080,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458-b/nhkwlive-xjp/index_4200.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2032668,AVERAGE-BANDWIDTH=2340800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_2M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1086734,AVERAGE-BANDWIDTH=1240800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_1M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=708360,AVERAGE-BANDWIDTH=800800,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_600k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=294786,AVERAGE-BANDWIDTH=325600,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/ndex_200k.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,LANGUAGE="eng",NAME="Alternate Audio",AUTOSELECT=YES,DEFAULT=YES,GROUP-ID="program_audio",URI="index_audio.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3803455,AVERAGE-BANDWIDTH=4400000,CODECS="avc1.4d4029,mp4a.40.5",RESOLUTION=1920x1080,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_4M.m3u8"

#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index.m3u8"

#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_2100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1161261,AVERAGE-BANDWIDTH=1333200,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_1180.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=423432,AVERAGE-BANDWIDTH=475200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_900.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=612619,AVERAGE-BANDWIDTH=695200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_600.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=423432,AVERAGE-BANDWIDTH=475200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=234246,AVERAGE-BANDWIDTH=255200,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_200.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=166402,AVERAGE-BANDWIDTH=176000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2032668,AVERAGE-BANDWIDTH=2340800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_2M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1086734,AVERAGE-BANDWIDTH=1240800,CODECS="avc1.4d401f,mp4a.40.5",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_1M.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=708360,AVERAGE-BANDWIDTH=800800,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_600k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=294786,AVERAGE-BANDWIDTH=325600,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_200k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3992642,AVERAGE-BANDWIDTH=4620000,CODECS="avc1.4d4029,mp4a.40.2,mp4a.40.5",RESOLUTION=1920x1080,FRAME-RATE=29.970,AUDIO="program_audio"
#link="https://b-nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp/index_4200.m3u8"


fi
###method="Tor"
use_cookies="no"
TAG="NHKWORLDJP"
chan_name="NHK World Japan" ;;

# 17) Arirang TV Korea KR
17)

if [ "$getlink" = 1 ]
then

#http://vietcago.net/vstv/arirang.m3u8
#link="https://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/playlist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3256000,RESOLUTION=1920x1080
link="https://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b3256000_sleng.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2256000,RESOLUTION=1280x720
#link="https://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b2256000_sleng.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1256000,RESOLUTION=960x540
#link="https://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1256000_sleng.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=656000,RESOLUTION=640x360
#link="https://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b656000_sleng.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="ARIRANG_______"
chan_name="Arirang South Korea";;

# 18) Channel News Asia Singapore
18)

if [ "$getlink" = 1 ]
then
#link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=670208,AVERAGE-BANDWIDTH=563200,RESOLUTION=480x270,FRAME-RATE=25.000,CODECS="avc1.4D4015,mp4a.40.2"
#link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index_1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1120768,AVERAGE-BANDWIDTH=915200,RESOLUTION=640x360,FRAME-RATE=25.000,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index_2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1931776,AVERAGE-BANDWIDTH=1548800,RESOLUTION=854x480,FRAME-RATE=25.000,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=4026880,AVERAGE-BANDWIDTH=3185600,RESOLUTION=1280x720,FRAME-RATE=25.000,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index_4.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=6420449,AVERAGE-BANDWIDTH=5055564,RESOLUTION=1920x1080,FRAME-RATE=25.000,CODECS="avc1.4D4028,mp4a.40.2"
link="https://d2e1asnsl7br7b.cloudfront.net/7782e205e72f43aeb4a48ec97f66ebbe/index_5.m3u8"
fi
# method="Tor"
use_cookies="no"
TAG="CNA_SG____"
chan_name="CNA Channel News Asia Singapore" ;;

########################## AUSTRALIA ###########################################
# 19)  ABC News Australia
19)
keyword="ABC"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"

#link="https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=1910620,AVERAGE-BANDWIDTH=1826545,RESOLUTION=1024x576,FRAME-RATE=25.000,CODECS="avc1.4D401F,mp4a.40.2",SUBTITLES="subtitles"
#link="https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index_42.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=994254,AVERAGE-BANDWIDTH=967454,RESOLUTION=640x360,FRAME-RATE=25.000,CODECS="avc1.4D401E,mp4a.40.2",SUBTITLES="subtitles"
#link="https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index_43.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=737286,AVERAGE-BANDWIDTH=726545,RESOLUTION=512x288,FRAME-RATE=25.000,CODECS="avc1.4D4015,mp4a.40.2",SUBTITLES="subtitles"
#link="https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index_44.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=4806436,AVERAGE-BANDWIDTH=4541380,RESOLUTION=1280x720,FRAME-RATE=25.000,CODECS="avc1.4D401F,mp4a.40.2",SUBTITLES="subtitles"
link="https://abc-iview-mediapackagestreams-2.akamaized.net/out/v1/6e1cc6d25ec0480ea099a5399d73bc4b/index_45.m3u8"
#EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subtitles",NAME="English",DEFAULT=YES,AUTOSELECT=YES,FORCED=NO,LANGUAGE="eng",URI="index_7_0.m3u8"


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

fi
####method="Tor"
use_cookies="no"
TAG="ABC_AU____"
chan_name="ABC News Australia" ;;

########################### AFRICA ############################################
# 20) Arise News Nigeria/London
20)
if [ "$getlink" = 1 ]
then
keyword="Arise"
#link="http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
#link="http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SDq/chunklist.m3u8?ref=www.arise.tv&amp;USER=AriseNew-VideoJS&wowzasessionid=1132651454"

#https://contributionstreams.sechls01.visionip.tv/live/visiontv-contributionstreams-arise-tv-25f-16x9-SD/chunklist.m3u8?ref=www.arise.tv&amp;USER=AriseNew-VideoJS&wowzasessionid=1897072220
link="https://contributionstreams.sechls01.visionip.tv/live/visiontv-contributionstreams-arise-tv-25f-16x9-SD/chunklist.m3u8"


fi
#method="Tor"
use_cookies="no"
TAG="ARISE_NG__"
chan_name="Arise News Nigeria/London";;
######################## SOUTH AMERICA #############################################
# 21) Telesur English
21)

if [ "$getlink" = 1 ]
then


#link="https://d7g1ebft2592.cloudfront.net/mblivev3/hd/playlist.m3u8"
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/480p/playlist.m3u8"
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/360p/playlist.m3u8"
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/audio/playlist.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=4112500,CODECS="avc1.66.40,mp4a.40.2",RESOLUTION=1920x1080
link="https://d7g1ebft2592.cloudfront.net/mblivev3/hd/chunklist_w384365430.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1090588,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=640x360
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/480p/chunklist_w828236034.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=572084,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=462x260
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/360p/chunklist_w220534359.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=64160,CODECS="mp4a.40.2
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/audio/chunklist_w1221487880.m3u8"
#link="https://d7g1ebft2592.cloudfront.net/mblivev3/audio/chunklist_w637524806.m3u8"

#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/hd/playlist.m3u8"
#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/480p/playlist.m3u8"
#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/360p/playlist.m3u8"

#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/hd/chunklist_w209051470.m3u8"
#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/480p/chunklist_w654799258.m3u8"
#link="https://d3920p0ci1gkce.cloudfront.net/mblivev3_alt1/360p/chunklist_w1182587844.m3u8"

use_cookies="no"
###method="Tor"
fi
####method="Tor"
use_cookies="no"
TAG="TELESUR_ENG___"
chan_name="Telesur English" ;;

##################    ALTERNATIVE MEDIA   ##################################################
# 22) NEWSMAX USA
22)
keyword="Newsmax"

if [ "$getlink" = 1 ]
then
#link=httpS://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_720.m3u8
##link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_480.m3u8
#link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_360.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5640800,AVERAGE-BANDWIDTH=5640800,CODECS="avc1.4d4028,mp4a.40.2",RESOLUTION=1920x1080,FRAME-RATE=30.000,SUBTITLES="subs"
link=https://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_1080.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2890800,AVERAGE-BANDWIDTH=2890800,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=30.000,SUBTITLES="subs"
#link=https://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_720.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1425600,AVERAGE-BANDWIDTH=1425600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=720x404,FRAME-RATE=30.000,SUBTITLES="subs"
#link=https://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_404.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=875600,AVERAGE-BANDWIDTH=875600,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=512x288,FRAME-RATE=30.000,SUBTITLES="subs"
#link=https://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_288.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=589600,AVERAGE-BANDWIDTH=589600,CODECS="avc1.4d400d,mp4a.40.2",RESOLUTION=384x216,FRAME-RATE=30.000,SUBTITLES="subs"
#link=https://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/index_218.m3u8
#EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="subs",NAME="English",DEFAULT=YES,AUTOSELECT=YES,FORCED=NO,LANGUAGE="eng",URI="index_cc.m3u8"

# link=https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8

# "https://www.newsmaxtv.com/"
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

#EXT-X-STREAM-INF:BANDWIDTH=1861222,RESOLUTION=848x480,CODECS="avc1.4D401F,mp4a.40.5"
link="https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1311282,RESOLUTION=640x360,CODECS="avc1.4D401F,mp4a.40.5"
#link="https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=871088,RESOLUTION=512x288,CODECS="avc1.42C01E,mp4a.40.5"
#link="https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv_5.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="FREESPEECH"
chan_name="Free Speech TV" ;;

# 24)  Infowars Live
24)

if [ "$getlink" = 1 ]
then

## https://banned.video/channel/the-alex-jones-show
#link="https://freespeech.akamaized.net/hls/live/2016712/live1/playlist.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016712-b/live1/playlist.m3u8"
link="https://freespeech.akamaized.net/hls/live/2016712/live2/playlist.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016712-b/live2/playlist.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016712-b/live2/video_0/video_0.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016712-b/live2/audio_0_eng/audio_0_eng.m3u8"

fi
# method="Tor"
use_cookies="no"
TAG="INFOWARS__"
chan_name="Infowars Live" ;;
########################### INFOWARS EXTRAS #######################################################

# 25)Infowars RealNews David Knight
25)
if [ "$getlink" = 1 ]
then
#link="https://freespeech.akamaized.net/hls/live/2016873/live3/playlist.m3u8"
link="https://freespeech.akamaized.net/hls/live/2016873-b/live3/playlist.m3u8"

#link="https://freespeech.akamaized.net/hls/live/2016873/live3/video_0/video_0.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016873/live3/audio_0_eng/audio_0_eng.m3u8"


fi

TAG="INFOWARS2_"
use_cookies="no"
chan_name="Infowars RealNews" ;;

# 26)Infowars WarRoom Owen Shroyer
26)
if [ "$getlink" = 1 ]
then

#link="https://freespeech.akamaized.net/hls/live/2016873/live4/playlist.m3u8"
link="https://freespeech.akamaized.net/hls/live/2016873-b/live4/playlist.m3u8"

#link="https://freespeech.akamaized.net/hls/live/2016873/live3/playlist.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016873-b/live3/playlist.m3u8"

#link="https://freespeech.akamaized.net/hls/live/2016873-b/live4/video_0/video_0.m3u8"
#link="https://freespeech.akamaized.net/hls/live/2016873-b/live4/audio_0_eng/audio_0_eng.m3u8"

#link=https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=955000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=125000,CODECS="mp4a.40.2"
#link="https://infowarslive-lh.akamaihd.net/i/WarRoom_1@561925/index_800_a-p.m3u8?sd=10&rebase=on"

#link="https://infostream.secure.footprint.net/hls-live/infostream3-infostream3/_definst_/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=866304,RESOLUTION=640x360
#link="https://infostream.secure.footprint.net/hls-live/infostream3-infostream3/_definst_/chunklist_b866304.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1155072,RESOLUTION=854x480
#link="https://infostream.secure.footprint.net/hls-live/infostream3-infostream3/_definst_/chunklist_b1155072.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2244608,RESOLUTION=1280x720
#link="https://infostream.secure.footprint.net/hls-live/infostream3-infostream3/_definst_/chunklist_b2244608.m3u8"
#link="https://streaminfo-live.secure.footprint.net/hls-live/streamroot2-streaminfo2/_definst_/live.m3u8"
fi

TAG="INFOWARS3_"
use_cookies="no"
chan_name="Infowars WarRoom " ;;

############################# GOVERNMENT#####################################################
############### UNITED NATIONS #################################################
# 27) United Nations UN Web TV
27)
keyword="LIVE"
### UN WEB TV
if [ "$getlink" = 1 ]
then
#link=https://players.brightcove.net/1362235914001/B1J3DDQJf_default/index.html?videoId=5689257377001

#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=828000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/index_828_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=828000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/index_828_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/index_1328_av-b.m3u8?sd=10&rebase=on"

link="https://bcliveunivsecure-lh.akamaihd.net/i/un150_A1_1@575439/index_1328_av-p.m3u8?sd=10&rebase=on"

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


#################### NATIONAL / LOCAL Weather #####################################################
# 28) Weather Nation
28)

if [ "$getlink" = 1 ]
then
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2128000,RESOLUTION=1280x720
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b2128000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=504000,RESOLUTION=480x270
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b464000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=724000,RESOLUTION=640x360
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b664000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1054000,RESOLUTION=640x360
#####link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b964000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2192000,RESOLUTION=1280x720
link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b2192000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=504000,RESOLUTION=480x270
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b464000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=724000,RESOLUTION=640x360
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b664000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1054000,RESOLUTION=640x360
#link=https://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/chunklist_b964000.m3u8

fi
#####method="Tor"
use_cookies="no"
TAG="WEATHNERNA"
chan_name="Weather Nation" ;;

# 29) The Weather Channel
29)

if [ "$getlink" = 1 ]
then
#link=https://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#####link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_400_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_1200_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_2400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2528000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://weather-lh.akamaihd.net/i/twc_1@92006/index_2400_av-b.m3u8?sd=10&rebase=on"

fi
#####method="Tor"
use_cookies="no"
TAG="WEATHNERCH"
chan_name="The Weather Channel" ;;

##################    DOCUMENTARY   ##################################################
# 30)VOA
30)

if [ "$getlink" = 1 ]
then
#link=https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0240_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0240_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0360_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0360_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1589000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0480_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1589000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0480_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2859000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0720_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2859000,RESOLUTION=1280x720,CODECS="avc1.640029, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_0720_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5789000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_1080_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5789000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="https://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/index_1080_av-b.m3u8?sd=10&rebase=on"

#link=https://www.filmon.com/tv/voa-english
fi
##method="Tor"
use_cookies="no"
TAG="VOA_______"
chan_name="VOA" ;;

########################### EASTERN DOCUMENTARIES ##############################################
# 31) RT Documentary
31)

if [ "$getlink" = 1 ]
then
#link=https://rtd.rt.com/on-air/
#link=https://rt-doc.secure.footprint.net/1101.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-doc.secure.footprint.net/1101_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-doc.secure.footprint.net/1101_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-doc.secure.footprint.net/1101_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-doc.secure.footprint.net/1101_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-doc.secure.footprint.net/1101_64Kb.m3u8
fi
#####method="Tor"
use_cookies="no"
TAG="RT_DOC____"
chan_name="RT Documentary" ;;

# 32) CGTN Documentary
32)

if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-d.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=https://livedoc.cgtn.com/1000d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=https://livedoc.cgtn.com/500d/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=https://livedoc.cgtn.com/200d/prog_index.m3u8
fi
###method="Tor"
use_cookies="no"
TAG="CGTN_DOC__"
chan_name="CGTN Documentary" ;;
######################## CANADA #################################
# 33) CBC Canada
33)

if [ "$getlink" = 1 ]
then
link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master1.m3u8"
#link="https://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
fi
#####method="Tor"
use_cookies="no"
TAG="CBC_CA____"
chan_name="CBC Canada";;

# 34) CBC News Network
34)
link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master6.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master5.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master4.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master3.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master2.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master1.m3u8"
use_cookies="no"
chan_name="CBC News Network " ;;

########################## CANADIAN GOVERNMENT #########################
# 35) CPAC 1 Canada
35)

if [ "$getlink" = 1 ]
then

link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680602/1242843915001_1/master.m3u8"


#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680602/1242843915001_1/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=613469,RESOLUTION=640x360,CODECS="avc1.77.31,mp4a.40.5"
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680602/1242843915001_1//Assets_1586134027986/Layer1_master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=919077,RESOLUTION=720x404,CODECS="avc1.77.31,mp4a.40.5"
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680602/1242843915001_1//Assets_1586134027986/Layer2_master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3167564,RESOLUTION=1280x720,CODECS="avc1.77.31,mp4a.40.5"
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680602/1242843915001_1//Assets_1586134027986/Layer3_master.m3u8"


#https://bcsecurelivehls-i.akamaihd.net/hls/live/680604/1242843915001_3/master.m3u8
#https://bcsecurelivehls-i.akamaihd.net/hls/live/680604/1242843915001_3//Assets_1572351842277/Layer3_master.m3u8

fi
####method="Tor"
use_cookies="no"
TAG="CPAC_1_CA_"
chan_name="CPAC 1 Canada" ;;

########################## IRELAND ##############################################
# 36) OIreachtas TV IE
36)
if [ "$getlink" = 1 ]
then
#link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
link=https://oirlive.heanet.ie/oireachtas/ngrp:oireachtas.stream_all/chunklist_b1228000.m3u8
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

############### IRELAND ###########################################################
# 37) RTE News NOW  Ireland
37)

TAG=" SKYNEWS____"
keyword="Watch Sky News live"

if [ "$getlink" = 1 ]
then

#link="https://www.rte.ie/manifests/newsnow.f4m"
#link="https://www.rte.ie/manifests/newsnow.m3u8"
link="https://live.rte.ie/live/a/channel3/news.isml/news.m3u8"
#link="https://live.rte.ie/live/a/channel3/news.isml/news-TTML_English=64000.m3u8"
#https://live.rte.ie/live/a/channel3/news.isml/news-audio_128k=128000.m3u8
#https://live.rte.ie/live/a/channel3/news.isml/news-video=2000000.m3u8
#link=https://live.rte.ie/live/a/channel3/news.isml/news-video=4499968.m3u8
#news-video=4499968.m3u8
#https://live.rte.ie/live/a/channel3/news.isml/news-video=2000000.m3u8
#https://live.rte.ie/live/a/channel3/news.isml/news-video=4499968.m3u8
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=6000000.m3u8"

# AUDIO groups
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio-aacl-128",NAME="English",LANGUAGE="en",AUTOSELECT=YES,DEFAULT=YES,CHANNELS="2",URI="news-audio_128k=128000.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio-aach-64",NAME="English",LANGUAGE="en",AUTOSELECT=YES,DEFAULT=YES,CHANNELS="2",URI="news-audio_64k=64000.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio-aach-96",NAME="English",LANGUAGE="en",AUTOSELECT=YES,DEFAULT=YES,CHANNELS="2",URI="news-audio_96k=96000.m3u8"

# SUBTITLES groups
#EXT-X-MEDIA:TYPE=SUBTITLES,GROUP-ID="textstream",NAME="English",LANGUAGE="en",AUTOSELECT=YES,DEFAULT=YES,URI="news-TTML_English=64000.m3u8"

# variants
#EXT-X-STREAM-INF:BANDWIDTH=311000,AVERAGE-BANDWIDTH=283000,CODECS="mp4a.40.5,avc1.64000D",RESOLUTION=454x234,FRAME-RATE=25,AUDIO="audio-aach-64",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=144960.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=603000,AVERAGE-BANDWIDTH=548000,CODECS="mp4a.40.5,avc1.640015",RESOLUTION=524x270,FRAME-RATE=25,AUDIO="audio-aach-96",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=364992.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1064000,AVERAGE-BANDWIDTH=968000,CODECS="mp4a.40.2,avc1.64001E",RESOLUTION=699x360,FRAME-RATE=25,AUDIO="audio-aacl-128",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=729984.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1496000,AVERAGE-BANDWIDTH=1360000,CODECS="mp4a.40.2,avc1.64001E",RESOLUTION=839x432,FRAME-RATE=25,AUDIO="audio-aacl-128",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=1099968.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2545000,AVERAGE-BANDWIDTH=2314000,CODECS="mp4a.40.2,avc1.64001F",RESOLUTION=1048x540,FRAME-RATE=25,AUDIO="audio-aacl-128",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=2000000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=5460000,AVERAGE-BANDWIDTH=4964000,CODECS="mp4a.40.2,avc1.64001F",RESOLUTION=1398x720,FRAME-RATE=25,AUDIO="audio-aacl-128",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=4499968.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=7209000,AVERAGE-BANDWIDTH=6554000,CODECS="mp4a.40.2,avc1.640028",RESOLUTION=2097x1080,FRAME-RATE=25,AUDIO="audio-aacl-128",SUBTITLES="textstream",CLOSED-CAPTIONS=NONE
#link="https://live.rte.ie/live/a/channel3/news.isml/news-video=6000000.m3u8"

# keyframes
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=22000,CODECS="avc1.64000D",RESOLUTION=454x234,URI="keyframes/news-video=144960.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=54000,CODECS="avc1.640015",RESOLUTION=524x270,URI="keyframes/news-video=364992.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=107000,CODECS="avc1.64001E",RESOLUTION=699x360,URI="keyframes/news-video=729984.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=161000,CODECS="avc1.64001E",RESOLUTION=839x432,URI="keyframes/news-video=1099968.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=292000,CODECS="avc1.64001F",RESOLUTION=1048x540,URI="keyframes/news-video=2000000.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=656000,CODECS="avc1.64001F",RESOLUTION=1398x720,URI="keyframes/news-video=4499968.m3u8"
#EXT-X-I-FRAME-STREAM-INF:BANDWIDTH=875000,CODECS="avc1.640028",RESOLUTION=2097x1080,URI="keyframes/news-video=6000000.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG=" RTENEWS_IE_"
chan_name="RTE News NOW Ireland" ;;

################     UK    #################################
# 38) Sky News
38)
if [ "$getlink" = 1 ]
then

keyword="live"
channelURL="https://www.youtube.com/c/SkyNews/videos?view=2&live_view=501"
youTubeGrab

fi
#method="Tor"
#method="Proxychains"

use_cookies="no"
chan_name="Sky News" ;;

# 39) Africa News Live
39)
keyword="africanews Live"


# DAILYMOTION
#link=https://www.dailymotion.com/video/x6i7vf8
#YOUTUBE
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"

# SOURCE 
#https://www.africanews.com/api/watchlive.json
#radix=$ ( curl "https://www.africanews.com/api/watchlive.json" ) 

#link=$(curl  --socks5 "$torsocks_ip":"$torsocks_port" "https:$(curl "https://www.africanews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 |sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 )


radix="$(curl -A "$UA" "https:$(curl -A "$UA" "https://www.africanews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 |sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 | cut -d \/ -f 1,2,3,4,5,6,7,8 )"

#link="$radix/playlist.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3300000,RESOLUTION=1280x720
link="$radix/afrnabren_eng_720p33.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2000000,RESOLUTION=1280x720
#link="$radix/afrnabren_eng_720p20.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=900000,RESOLUTION=1024x576
#link="$radix/afrnabren_eng_576p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=500000,RESOLUTION=848x480
#link="$radix/afrnabren_eng_480p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=250000,RESOLUTION=640x360
#link="$radix/afrnabren_eng_360p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=120000,RESOLUTION=432x240
#link="$radix/afrnabren_eng_240p.m3u8"


use_cookies="no"
chan_name="Africa News English";;


# 40) EuroNews English
40)
if [ "$getlink" = 1 ]
then

keyword="Live"
channelURL="https://www.youtube.com/EuronewsUSA/videos?view=2&live_view=501"
youTubeGrab

#link="https://www.euronews.com/live"
#radix=$( curl "https://en.euronews.com/api/watchlive.json"

# endcurl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 |sed 's/[\\"]//g')" | cut -d \: -f 4,5

# endcurl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 | sed 's/[\\"]//g')"

#{"status":"ok","protocol":"hls",
#"primary":"https:\/\/euronews-en-p11-cdn.hexaglobe.net\/87f408f24e62684dbca812d9b564c36f\/5f9f5e62\/euronews\/euronews-euronews-website-web-responsive-2\/ewnsabren_eng.smil\/playlist.m3u8",
#"backup":"https:\/\/euronews-en-p12-cdn.hexaglobe.net\/87f408f24e62684dbca812d9b564c36f\/5f9f5e62\/euronews\/euronews-euronews-website-web-responsive-2\/ewnsabren_eng.smil\/playlist.m3u8"}

#link=$(endcurl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 |sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 )

#radix="$(endcurl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 | sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 | cut -d \/ -f 1,2,3,4,5,6,7,8 )"

# endcurl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 | sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 | cut -d \/ -f 1,2,3,4,5,6,7,8

#radix="$(torsocks -i -a "$torsocks_ip" -P "$torsocks_port" curl "https:$(curl "https://www.euronews.com/api/watchlive.json" | cut -d : -f 2 | cut -d \} -f 1 | sed 's/[\\"]//g')" | cut -d \: -f 4,5 | sed 's/[\\"]//g' | cut -d \, -f 1 | cut -d \/ -f 1,2,3,4,5,6,7,8 )"

#link="$radix/playlist.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3300000,RESOLUTION=1280x720
#link="$radix/ewnsabren_eng_720p33.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2000000,RESOLUTION=1280x720
#link="$radix/ewnsabren_eng_720p20.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=900000,RESOLUTION=1024x576
#link="$radix/ewnsabren_eng_576p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=500000,RESOLUTION=848x480
#link="$radix/ewnsabren_eng_480p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=250000,RESOLUTION=640x360
#link="$radix/ewnsabren_eng_360p.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=120000,RESOLUTION=432x240
#link="$radix/ewnsabren_eng_240p.m3u8"

fi

#method="Tor"
#method="Proxychains"

use_cookies="no"
chan_name="Euronews English Live" ;;




#############################  ENGLISH EXTRA #############################################


############################## SHOPPING ##########################################################
# 41) QVC UK
41)
if [ "$getlink" = 1 ]
then
link="https://d1txbbj1u9asam.cloudfront.net/live/qvcuk_main_clean/bitrate1.isml/3/prog_index.m3u8"
fi
# method="Tor"
use_cookies="no"
TAG="QVC_UK_______"
chan_name="QVC UK" ;;

# 42)  QVC
42)
if [ "$getlink" = 1 ]
then
keyword="QVC Live Stream"

#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/master.m3u8"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=354000,RESOLUTION=480x270,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=354000,RESOLUTION=480x270,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=678000,RESOLUTION=768x432,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=678000,RESOLUTION=768x432,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=768x432,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1101000,RESOLUTION=768x432,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1687000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_1600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1687000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_1600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2566000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2566000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=62000,CODECS="mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=62000,CODECS="mp4a.40.2"
#link="https://lsqvc1uscln-lh.akamaihd.net/i/lsqvc1uscln_01@809410/index_300_a-b.m3u8?sd=10&rebase=on"

#link=https://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
#####method="Tor"
use_cookies="no"
TAG="QVC_EN____"
chan_name="QVC English" ;;

# 43) The Shopping Channel TSC
43)

if [ "$getlink" = 1 ]
then

#link=https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/master.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=992000,RESOLUTION=848x480,CODECS="avc1.640029, mp4a.40.2"
link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2200000,RESOLUTION=1280x720,CODECS="avc1.640029, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2200000,RESOLUTION=1280x720,CODECS="avc1.640029, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1428000,RESOLUTION=848x480,CODECS="avc1.640029, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-b.m3u8?sd=10&rebase=on"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-b.m3u8?sd=10&rebase=on"
fi
#####method="Tor"
use_cookies="no"
TAG="TSC_______"
chan_name="The Shopping Channel TSC" ;;

# 44)  QVC 2
44)

if [ "$getlink" = 1 ]
then
keyword="QVC Live Stream"

##link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_1600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_1600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://lsqvc2us-lh.akamaihd.net/i/lsqvc2us_01@809440/index_300_a-b.m3u8?sd=10&rebase=on"

fi
#####method="Tor"
use_cookies="no"
TAG="QVC2EN____"
chan_name="QVC 2 English" ;;

# 45)  QVC 3 USA
45)

if [ "$getlink" = 1 ]
then
keyword="QVC Live Stream"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/master.m3u8"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_1600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_1600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_2500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://lsqvc3us-lh.akamaihd.net/i/lsqvc3us_01@809459/index_300_a-b.m3u8?sd=10&rebase=on"

fi
#####method="Tor"
use_cookies="no"
TAG="QVC_3_____"
chan_name="QVC 3 USA" ;;

# 46)  QVC 4
46)

if [ "$getlink" = 1 ]
then
keyword="QVC Live Stream"

#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_300_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=696000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1128000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_1000_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_1600_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1728000,RESOLUTION=960x540,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_1600_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_2500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2628000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="https://lsqvc4us-lh.akamaihd.net/i/lsqvc4us_01@802711/index_2500_av-b.m3u8?sd=10&rebase=on"
fi
#####method="Tor"
use_cookies="no"
TAG="QVC_4_BIQ__"
chan_name="QVC 4 Beauty IQ" ;;

################################## TECHNOLOGY ##############################
# 47)  TWiT USA
47)
keyword="TWiT Live"

if [ "$getlink" = 1 ]
then
####Twitch
link=https://www.twitch.tv/twit

# link="http://iphone-streaming.ustream.tv/uhls/1524/streams/live/iphone/playlist.m3u8"
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
#############################################################
# 48)  TVW Washington State TV
48)

if [ "$getlink" = 1 ]
then
#link=https://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2179072,CODECS="avc1.77.40,mp4a.40.2",RESOLUTION=1920x1080
link=https://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_w582357431_b2179072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1066072,CODECS="avc1.77.31,mp4a.40.2",RESOLUTION=640x360
#link=https://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_w582357431_b981072.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=351072,CODECS="avc1.66.21,mp4a.40.2",RESOLUTION=284x160
#link=https://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/chunklist_w582357431_b331072.m3u8
fi
use_cookies="no"
TAG="TVW_WASH_______"
chan_name="TVW Washington State TV" ;;
############# WASHINGTON DC #################################
# 49) District of Columbia Network
49)
if [ "$getlink" = 1 ]
then
#link=https://video.oct.dc.gov/out/u/DCN.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=364035,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/21_1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=664059,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/21_2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864061,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/21_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1064061,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=https://video.oct.dc.gov/out/u/21_4.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="DC_NETWORK_____"
chan_name="District of Columbia Network" ;;
# 50) District of Columnbia
50)

if [ "$getlink" = 1 ]
then
#link=https://video.oct.dc.gov/out/u/DCC.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=364063,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/15_1.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=664058,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/15_2.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=864062,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/15_3.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1064088,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=https://video.oct.dc.gov/out/u/15_12.m3u8
fi
# method="Tor"
use_cookies="no"
TAG="DCC___________"
chan_name="District of Columbia" ;;

# 51) DC Knowledge Network
51)

if [ "$getlink" = 1 ]
then
#link=https://video.oct.dc.gov/out/u/DKN.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=428009,RESOLUTION=416x234,CODECS="avc1.4D400D,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/96_7.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=728053,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/96_8.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=927908,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link=https://video.oct.dc.gov/out/u/96_9.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1127917,RESOLUTION=1920x1080,CODECS="avc1.4D4028,mp4a.40.2"
link=https://video.oct.dc.gov/out/u/96_10.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="DC_KNOWLEDGE___"
chan_name="District of Columbia DC Knowledge Network USA";;
#####################
# 52) Southeastern Channel
52)
if [ "$getlink" = 1 ]
then
#http://thesoutheasternchannel.com/live-stream/
link=http://147.174.13.196/live/WIFI-1296k-540p/WIFI-1296k-540p.m3u8
fi
#method="Tor"
use_cookies="no"
TAG="SOUTHEASTERN___"
chan_name="Southeastern Channel" ;;

# 53) TSTV  Texas State University TV
53)

if [ "$getlink" = 1 ]
then
link=http://tstv-stream.tsm.utexas.edu/hls/livestream_hi/index.m3u8
#link=http://tstv-stream.tsm.utexas.edu/hls/livestream_low/index.m3u8
fi
##method="Tor"
use_cookies="no"
TAG="TSTV_TEXAS_____"
chan_name="TSTV Texas State University TV" ;;

# 54) Temple University TV
54)
if [ "$getlink" = 1 ]
then
link="https://streaming.temple.edu/tutvlive/_definst_/mp4:8BRYCQMB/chunklist.m3u8"
fi
use_cookies="no"
TAG="TEMPLE_TV____"
chan_name="Temple University TV" ;;

################################## MNN ###########################################
################## MANHATTAN NEIGHBOURHOOD NETWORK HD
# 55)MNN Channel 5 Manhattan Neighbourhood Network HD New York USA
55)
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

# 56) MNN Channel 1 New York USA
56)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6480540/events/2616259"
link="$( curl "https://livestream.com/accounts/6480540/events/2616259" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
# method="Tor"
use_cookies="no"
TAG="MNN_1__________"
chan_name="MNN Channel 1 New York, USA" ;;

# 57) MNN 2 Lifestyle New York, USA
57)
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
# 58) MNN Channel 3 New York, USA
58)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6312590/events/2611503"
link="$( curl "https://livestream.com/accounts/6312590/events/2611503"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
## method="Tor"
use_cookies="no"
TAG="MNN_3__________"
chan_name="MNN Channel 3 New York, USA" ;;
# 59) MNN Channel 4 New York, USA
59)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6478935/events/2616010"
link="$( curl "https://livestream.com/accounts/6478935/events/2616010"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
## method="Tor"
use_cookies="no"
TAG="MNN_4__________"
chan_name="MNN Channel 4 New York, USA" ;;
# 60) BronxNet NY USA
60)
if [ "$getlink" = 1 ]
then
#link="https://reflect-stream-bronxnet.cablecast.tv/live-16/live/live.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
#link="https://reflect-stream-bronxnet.cablecast.tv/live-16/live/CELL-496k-270p/CELL-496k-270p.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
link="https://reflect-stream-bronxnet.cablecast.tv/live-16/live/WIFI-1896k-720p/WIFI-1896k-720p.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="BRONXNET_16"
chan_name="BronxNet NY USA";;

# 61) BronxNet Omni NY USA
61)
if [ "$getlink" = 1 ]
then

#link="https://reflect-stream-bronxnet.cablecast.tv/live-19/live/live.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=570400,RESOLUTION=480x270,NAME="CELL-496k-270p"
#link="https://reflect-stream-bronxnet.cablecast.tv/live-19/live/CELL-496k-270p/CELL-496k-270p.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
link="https://reflect-stream-bronxnet.cablecast.tv/live-19/live/WIFI-1896k-720p/WIFI-1896k-720p.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="BRONXNET_19"
chan_name="BronxNet Omni NY USA";;


# 62) BronxNet Culture NY USA
62)
if [ "$getlink" = 1 ]
then
#link="https://reflect-stream-bronxnet.cablecast.tv/live-7/live/live.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
#link="https://reflect-stream-bronxnet.cablecast.tv/live-7/live/CELL-496k-270p/CELL-496k-270p.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
link="https://reflect-stream-bronxnet.cablecast.tv/live-7/live/WIFI-1896k-720p/WIFI-1896k-720p.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="BRONXNET_7"
chan_name="BronxNet Culture NY USA";;

# 63) BronxNet Life NY USA
63)
if [ "$getlink" = 1 ]
then
#link="https://reflect-stream-bronxnet.cablecast.tv/live-8/live/live.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
#link="https://reflect-stream-bronxnet.cablecast.tv/live-8/live/CELL-496k-270p/CELL-496k-270p.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2180400,RESOLUTION=1280x720,NAME="WIFI-1896k-720p"
link="https://reflect-stream-bronxnet.cablecast.tv/live-8/live/WIFI-1896k-720p/WIFI-1896k-720p.m3u8"

fi
#method="Tor"
use_cookies="no"
TAG="BRONXNET_8"
chan_name="BronxNet Life NY USA";;

######################### LOCAL USA NEWS ##################################################

# 64) CBSN New York
64)
if [ "$getlink" = 1 ]
then
#link="https://www.cbsnews.com/common/video/cbsn-ny-prod.m3u8"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master.m3u8"

#link="https://www.cbsnews.com/common/video/cbsn-ny-prod.m3u8"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2209451,AVERAGE-BANDWIDTH=2196101,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_7.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2768101,AVERAGE-BANDWIDTH=2768101,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_13.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1690136,AVERAGE-BANDWIDTH=1690136,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_8.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1030136,AVERAGE-BANDWIDTH=1030136,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_9.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=581336,AVERAGE-BANDWIDTH=581336,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_10.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=264536,AVERAGE-BANDWIDTH=264536,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-ny-cedexis.cbsnstream.cbsnews.com/out/v1/ec3897d58a9b45129a77d67aa247d136/master_12.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_NY_______"
chan_name="CBSN NY" ;;

# 65) CBSN LA
65)
if [ "$getlink" = 1 ]
then
#link="https://dai.google.com/linear/hls/event/TxSbNMu4R5anKrjV02VOBg/master.m3u8"
#link="https://dai.google.com/linear/hls/pa/event/TxSbNMu4R5anKrjV02VOBg/stream/7fece08f-0ca5-4cbe-9545-0e1d733a9661:DLS/master.m3u8"

#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2544960,AVERAGE-BANDWIDTH=2191200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3072960,AVERAGE-BANDWIDTH=2631200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1752960,AVERAGE-BANDWIDTH=1531200,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1092929,AVERAGE-BANDWIDTH=981164,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=644160,AVERAGE-BANDWIDTH=607200,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=343200,AVERAGE-BANDWIDTH=343200,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-la-cedexis.cbsnstream.cbsnews.com/out/v1/57b6c4534a164accb6b1872b501e0028/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_LA_______"
chan_name="CBSN LA" ;;

# 66) CBSN Bay Area
66)
if [ "$getlink" = 1 ]
then

link="https://dai.google.com/linear/hls/event/VE8b4n-YStusEGv5Z2NmsQ/master.m3u8"

#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2544960,AVERAGE-BANDWIDTH=2191200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3072960,AVERAGE-BANDWIDTH=2631200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1752960,AVERAGE-BANDWIDTH=1531200,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1092929,AVERAGE-BANDWIDTH=981164,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=644160,AVERAGE-BANDWIDTH=607200,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=343200,AVERAGE-BANDWIDTH=343200,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-sf-cedexis.cbsnstream.cbsnews.com/out/v1/dac63c1abb3f4a2dac9f508f44bb072a/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_BAY_______"
chan_name="CBSN BAY AREA" ;;

# 67) CBSN Boston
67)
if [ "$getlink" = 1 ]
then
#link="https://dai.google.com/linear/hls/pa/event/26FJK7wRSo6RhPsK70XS_w/master.m3u8"
#link="https://dai.google.com/linear/hls/pa/event/26FJK7wRSo6RhPsK70XS_w/stream/1c87cbac-cf6f-442c-82b2-fff231ed3aa4:DLS/master.m3u8"

#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2460480,AVERAGE-BANDWIDTH=2085600,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2988480,AVERAGE-BANDWIDTH=2525600,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1668480,AVERAGE-BANDWIDTH=1425600,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1008449,AVERAGE-BANDWIDTH=875564,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=559680,AVERAGE-BANDWIDTH=501600,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=242880,AVERAGE-BANDWIDTH=237600,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-bos-cedexis.cbsnstream.cbsnews.com/out/v1/589d66ec6eb8434c96c28de0370d1326/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_Boston_______"
chan_name="CBSN Boston" ;;

# 68) CBSN Chicago
68)
if [ "$getlink" = 1 ]
then

#link="https://dai.google.com/linear/hls/pa/event/DWt8iR1YQ-OJQsxczu8KfQ/master.m3u8"
#link="https://dai.google.com/linear/hls/pa/event/DWt8iR1YQ-OJQsxczu8KfQ/stream/3e6dc6fd-ea1b-4786-a9c5-8f48bd105847:DLS/master.m3u8"

#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2808286,AVERAGE-BANDWIDTH=2191680,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_7.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3394718,AVERAGE-BANDWIDTH=2631680,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_8.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1928638,AVERAGE-BANDWIDTH=1531680,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_9.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1195572,AVERAGE-BANDWIDTH=981645,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_10.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=697131,AVERAGE-BANDWIDTH=607680,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_11.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=345272,AVERAGE-BANDWIDTH=343680,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-chi-cedexis.cbsnstream.cbsnews.com/out/v1/b2fc0d5715d54908adf07f97d2616646/master_12.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_Chicago_______"
chan_name="CBSN Chicago" ;;

# 69) CBSN Dallas Texas
69)
if [ "$getlink" = 1 ]
then

#link="https://dai.google.com/linear/hls/pa/event/o5J3g4U9T16CvYnS7Qd86Q/master.m3u8"
#link="https://dai.google.com/linear/hls/pa/event/o5J3g4U9T16CvYnS7Qd86Q/stream/29108445-1259-4926-b94c-cfb8296069f4:DLS/master.m3u8"

#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2808084,AVERAGE-BANDWIDTH=2191424,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3394516,AVERAGE-BANDWIDTH=2631424,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1928432,AVERAGE-BANDWIDTH=1531424,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1195365,AVERAGE-BANDWIDTH=981389,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=696924,AVERAGE-BANDWIDTH=607424,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=345065,AVERAGE-BANDWIDTH=343424,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-dal-cedexis.cbsnstream.cbsnews.com/out/v1/ffa98bbf7d2b4c038c229bd4d9122708/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_DAL______"
chan_name="CBSN DALLAS" ;;

# 70) CBSN Denver Colorado
70)
if [ "$getlink" = 1 ]
then
#link="https://dai.google.com/linear/hls/pa/event/EUo67MWSRh6toPi0heJKnQ/master.m3u8"
#link="https://dai.google.com/linear/hls/pa/event/EUo67MWSRh6toPi0heJKnQ/stream/d8c0a401-725c-488a-9d4b-39976b1bf679:DLS/master.m3u8"

# link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=2807978,AVERAGE-BANDWIDTH=2191294,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3394410,AVERAGE-BANDWIDTH=2631294,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1928330,AVERAGE-BANDWIDTH=1531294,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1195260,AVERAGE-BANDWIDTH=981259,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=696823,AVERAGE-BANDWIDTH=607294,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=344964,AVERAGE-BANDWIDTH=343294,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
#link="https://cbsn-den-cedexis.cbsnstream.cbsnews.com/out/v1/2e49baf2906244ecb01b07d9885fbe7a/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_DEN___"
chan_name="CBSN DENVER" ;;

# 71) CBSN Minnesota
71)
if [ "$getlink" = 1 ]
then
  #link="https://dai.google.com/linear/hls/pa/event/zcWPVCfURNSPxeidcckQLA/master.m3u8"
  #link="https://dai.google.com/linear/hls/pa/event/zcWPVCfURNSPxeidcckQLA/stream/c8d93a89-21b3-49ee-8a81-ebfae0b39fde:DLS/master.m3u8"

  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=2544960,AVERAGE-BANDWIDTH=2191200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_1.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=3072960,AVERAGE-BANDWIDTH=2631200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_7.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1752960,AVERAGE-BANDWIDTH=1531200,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_3.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1092929,AVERAGE-BANDWIDTH=981164,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_4.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=644160,AVERAGE-BANDWIDTH=607200,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_5.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=343200,AVERAGE-BANDWIDTH=343200,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
  #link="https://cbsn-min-cedexis.cbsnstream.cbsnews.com/out/v1/76518f06941246ba810c8d175600bf74/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_MIN__"
chan_name="CBSN Minnesota" ;;

# 72) CBSN Phillidelphia
72)
if [ "$getlink" = 1 ]
then

  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master.m3u8"

  #EXT-X-STREAM-INF:BANDWIDTH=2544960,AVERAGE-BANDWIDTH=2191200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_1.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=3072960,AVERAGE-BANDWIDTH=2631200,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_2.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1752960,AVERAGE-BANDWIDTH=1531200,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_3.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1092929,AVERAGE-BANDWIDTH=981164,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_4.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=644160,AVERAGE-BANDWIDTH=607200,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_5.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=343200,AVERAGE-BANDWIDTH=343200,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
  #link="https://cbsn-phi-cedexis.cbsnstream.cbsnews.com/out/v1/5c9ad3e215984b0e9ad845b335216b72/master_6.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_PHIL__"
chan_name="CBSN Phillidelphia" ;;

# 73) CBSN Pittsburgh
73)
if [ "$getlink" = 1 ]
then

  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master.m3u8"
  
  #EXT-X-STREAM-INF:BANDWIDTH=2545092,AVERAGE-BANDWIDTH=2191367,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_7.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=3073092,AVERAGE-BANDWIDTH=2631367,RESOLUTION=1280x720,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_8.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1753092,AVERAGE-BANDWIDTH=1531367,RESOLUTION=960x540,FRAME-RATE=29.970,CODECS="avc1.4D401F,mp4a.40.2"
  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_9.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=1093065,AVERAGE-BANDWIDTH=981332,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_10.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=644292,AVERAGE-BANDWIDTH=607367,RESOLUTION=640x360,FRAME-RATE=29.970,CODECS="avc1.4D401E,mp4a.40.2"
  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_11.m3u8"
  #EXT-X-STREAM-INF:BANDWIDTH=343367,AVERAGE-BANDWIDTH=343367,RESOLUTION=320x180,FRAME-RATE=29.970,CODECS="avc1.4D400D,mp4a.40.2"
  #link="https://cbsn-pit-cedexis.cbsnstream.cbsnews.com/out/v1/6966dabf8150405ab26f854e3cd6a2b8/master_12.m3u8"

fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="CBSN_PITT__"
chan_name="CBSN Pittsburgh" ;;

######################## INTERNATIONAL ENGLISH #####################################

# 74) NDTV India
74)
if [ "$getlink" = 1 ]
then

#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=242880,AVERAGE-BANDWIDTH=246400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=346368,AVERAGE-BANDWIDTH=352000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=484352,AVERAGE-BANDWIDTH=492800,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=622336,AVERAGE-BANDWIDTH=633600,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=933504,AVERAGE-BANDWIDTH=950400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=105600,AVERAGE-BANDWIDTH=105600,CODECS="mp4a.40.2"
#link="https://ndtv24x7elemarchana.akamaized.net/hls/live/2003678/ndtv24x7/masterp_480p@6.m3u8"

fi
use_cookies="no"
TAG="NDTV_IN______"
chan_name="NDTV India" ;;

# 75)  Times of India
75)
if [ "$getlink" = 1 ]
then
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=262000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_144_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=262000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_144_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=593000,RESOLUTION=424x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_240_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=593000,RESOLUTION=424x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_240_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1293000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_480_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1293000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_480_av-b.m3u8?sd=10&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2125000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_720_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3125000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://timesnow-lh.akamaihd.net/i/TNHD_1@129288/index_720_av-b.m3u8?sd=10&rebase=on"
fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="TIMES_IN__________"
chan_name="Times of India" ;;

##################################
# 76) Economic Times India Finance
76)
if [ "$getlink" = 1 ]
then
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=446000,RESOLUTION=360x288,CODECS="avc1.77.30, mp4a.40.2"
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_288_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=446000,RESOLUTION=360x288,CODECS="avc1.77.30, mp4a.40.2"
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_288_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=793000,RESOLUTION=544x432,CODECS="avc1.77.30, mp4a.40.2"
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_432_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=793000,RESOLUTION=544x432,CODECS="avc1.77.30, mp4a.40.2"
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_432_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1325000,RESOLUTION=720x576,CODECS="avc1.77.30, mp4a.40.2"
#link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_576_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1325000,RESOLUTION=720x576,CODECS="avc1.77.30, mp4a.40.2"
link="https://etnowweblive-lh.akamaihd.net/i/ETN_1@348070/index_576_av-b.m3u8?sd=10&rebase=on"
fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="ET_IN__________"
chan_name="Economic Times India" ;;

############################

# 77) NewsX India
77)
if [ "$getlink" = 1 ]
then
link="https://multitvido.c.s73cdn.net/idvo/newsx_360p/index.m3u8"
#link="https://multitvido.c.s73cdn.net/idvo/newsx_240p/index.m3u8"
fi
use_cookies="no"
TAG="NEWSX_IN_____"
chan_name="NewsX India" ;;


# 78) NewsX NE
78)
if [ "$getlink" = 1 ]
then
link="https://multitvido.c.s73cdn.net/idvo/newsxkannada_360p/index.m3u8"
#link="https://multitvido.c.s73cdn.net/idvo/newsxkannada_240p/index.m3u8"
fi
use_cookies="no"
TAG="NEWSX_NE_IN___"
chan_name="NewsX India NE News" ;;


# 79) NDTV Profit
79)
if [ "$getlink" = 1 ]
then

#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=242880,AVERAGE-BANDWIDTH=246400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=346368,AVERAGE-BANDWIDTH=352000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=484352,AVERAGE-BANDWIDTH=492800,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=622336,AVERAGE-BANDWIDTH=633600,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@4.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=933504,AVERAGE-BANDWIDTH=950400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x480,FRAME-RATE=25.000
link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@5.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=105600,AVERAGE-BANDWIDTH=105600,CODECS="mp4a.40.2"
#link="https://ndtvprofitelemarchana.akamaized.net/hls/live/2003680/ndtvprofit/masterp_480p@6.m3u8"
fi
use_cookies="no"
TAG="NDTV Profit__"
chan_name="NDTV Profit" ;;



# 80)

################################################    FRENCH   ###################################

# 81) France 24
81)
keyword="FRANCE 24 en Direct"

if [ "$getlink" = 1 ]
then

#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1095600,AVERAGE-BANDWIDTH=1095600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000,AUDIO="program_audio"
#link=http://f24hls-i.akamaihd.net/hls/live/221192/F24_FR_LO_HLS/master_900.m3u8
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_1",AUTOSELECT=YES,DEFAULT=YES,URI="master_96.m3u8"
#link=http://f24hls-i.akamaihd.net/hls/live/221192/F24_FR_LO_HLS/master_96.m3u8

#link=http://static.france24.com/live/F24_FR_HI_HLS/live_tv.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/221146-b/F24_FR_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146-b/F24_FR_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146-b/F24_FR_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146-b/F24_FR_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
link=http://f24hls-i.akamaihd.net/hls/live/221146/F24_FR_HI_HLS/master_2000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221146-b/F24_FR_HI_HLS/master_2000.m3u8

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
link="https://players.brightcove.net/876450610001/HJeY2afE_default/index.html?videoId=5615950982001"
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
#link=https://rt-france.secure.footprint.net/1107.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-france.secure.footprint.net/1107_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-france.secure.footprint.net/1107_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-france.secure.footprint.net/1107_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-france.secure.footprint.net/1107_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-france.secure.footprint.net/1107_64Kb.m3u8
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
link="https://videos.francetv.fr/video/SIM_Franceinfo"
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
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_6.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=571616,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=571616,RESOLUTION=640x360,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_5.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764771,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764771,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_4.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1088642,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1088642,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_3.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1378624,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1378624,RESOLUTION=1280x720,CODECS="mp4a.40.2,avc1.4d401f"
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_2.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2196150,RESOLUTION=1920x1080,CODECS="mp4a.40.2,avc1.4d4029"
link="https://tv5infohls-i.akamaihd.net/hls/live/631613/tv5infohls/v3plusinfo247hls_1_1.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2196150,RESOLUTION=1920x1080,CODECS="mp4a.40.2,avc1.4d4029"
#link="https://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_1.m3u8"
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
link=https://livefr.cgtn.com/1000f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=https://livefr.cgtn.com/500f/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=https://livefr.cgtn.com/200f/prog_index.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="CGTN Francais" ;;
# 88) Euronews Francais
88)
keyword="euronews"
#method="Tor"

if [ "$getlink" = 1 ]
then
#link="http://fr.euronews.com/live"

#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://fr.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d \/ -f 3,4,5 | sed 's/\\//g' )
#link="http://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrfrpri_fre.smil/ewnsabrfrpri_fre_224p.m3u8"

radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "http://fr.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link=$radix
primary=$( echo "$radix" | grep pri )

  if [ "$primary" != ""  ]
  then
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_720p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_540p/' )
  link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_360p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_224p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_180p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrpri_fre_90p/' )
  else
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_720p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_540p/' )
  link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_360p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_224p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_180p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrfrbkp_fre_90p/' )
  fi

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

# 92) FRANCE 2
92)

if [ "$getlink" = 1 ]
then
#link=http://par-4.firstone.tv/hls/1f181ce3-b1d5-70a2-8cc7-9f6ef5df7d89.m3u8
link=https://www.filmon.com/tv/france-2
fi
use_cookies="no"
#method="Tor"
chan_name="France 2" ;;
# 93) France 3
93)

if [ "$getlink" = 1 ]
then
#link=http://par-4.firstone.tv/hls/f5d676d6-692f-eb8c-8c3c-34f741a0f7b3.m3u8
link=https://www.filmon.com/tv/france-3-rhone-alpes
fi

use_cookies="no"
#method="Tor"
chan_name="France 3" ;;
# 94) ARTE FRANCAIS
94)

if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/arte-francais
fi

use_cookies="yes"
#method="Tor"
chan_name="ARTE Francais" ;;
# 95) France O
95)

if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/france-0
fi
## method="Tor"
use_cookies="yes"
chan_name="France O" ;;
# 96) Bidtween La chaîne TV des Enchères FR
96)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/25334545/events/7803598"
channelURL="https://livestream.com/accounts/25334545/events/7803598"

# set the link
liveStreamGrab

fi
## method="Tor:
use_cookies="no"
chan_name="Bidtween La chaîne TV des Enchères FR" ;;

# 97) Azur TV Nice
97)
if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x13x1q2
fi
use_cookies="no"
#method="Tor"
chan_name="Azur TV Nice" ;;


# 98) IL TV France
98)

if [ "$getlink" = 1 ]
then
link=rtmp://str81.creacast.com:80/iltv/high
fi
use_cookies="no"
#method="Tor"
chan_name="IL TV" ;;
# 99) BFM Paris Francais
99)

if [ "$getlink" = 1 ]
then
link=https://players.brightcove.net/5132998232001/H1bPo8t6_default/index.html?videoId=5152968636001
#link=http://bfmparishdslive-lh.akamaihd.net/i/DVMR_PARIS@429747/master.m3u8
fi

use_cookies="no"
#method="Tor"
chan_name="BFM Paris Francais" ;;
# 100) Alsace 20 France
100)

if [ "$getlink" = 1 ]
then
#link="https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=716736,CODECS="avc1.42801e,mp4a.40.2",RESOLUTION=640x360
#link=https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b657536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=355936,CODECS="avc1.428015,mp4a.40.2",RESOLUTION=480x270
#link=https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b329536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1550536,CODECS="avc1.428020,mp4a.40.2",RESOLUTION=1280x720
link=https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b1415536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=175536,CODECS="avc1.42800d,mp4a.40.2",RESOLUTION=416x234
#link=https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b165536.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3211264,CODECS="avc1.4d4028,mp4a.40.2",RESOLUTION=1920x1080
#link=https://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/chunklist_w357100756_b3211264.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="Alsace 20 France" ;;
# 101) Mosaik TV Francais
101)
keyword="Cristal"
channelURL="https://www.youtube.com/user/mosaiktv/videos?&view=2&live_view=501"

if [ "$getlink" = 1 ]
then

# set the link
youTubeGrab

fi

## method="Tor"
use_cookies="no"
chan_name="Mosaik TV" ;;
## 102) Tv Vendée - Le Direct
102)
if [ "$getlink" = 1 ]
then
link="https://www.dailymotion.com/video/x38yjeb"
#####method="Tor"
fi
use_cookies="no"
chan_name="Tv Vendée";;
# 103) 8 Mont Blanc FR
103)

if [ "$getlink" = 1 ]
then
link="https://www.dailymotion.com/video/x3wqv8b"
fi
use_cookies="no"
#method="Tor"
chan_name="8 Mont Blanc FR" ;;
# 104) TV7 Bordeaux
104)

if [ "$getlink" = 1 ]
then
link="https://www.dailymotion.com/video/x46ancl"
fi
use_cookies="no"
#method="Tor"
chan_name="TV7 Bordeaux" ;;

# 105) VAR AZUR
105)
link="https://www.dailymotion.com/video/x630wrb"
#####method="Tor"
use_cookies="no"
chan_name="VAR AZUR";;

# 106) TéléGrenoble Isère
106)
link="https://www.dailymotion.com/video/x128fjo"
#####method="Tor"
use_cookies="no"
chan_name="téléGrenoble Isère";;

# 107) LCP Assemblee National France
107)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/xji3qy

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
link=https://www.dailymotion.com/video/xkxbzc
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
#link=https://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
link="https://bcsecurelivehls-i.akamaihd.net/hls/live/680604/1242843915001_3//Assets_1567774466566/Layer3_master.m3u8"
#link=https://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2/master.m3u8
#link="http://bcoveliveios-i.akamaihd.net/hls/live/248520/1242843915001_2//Assets_1558616953265/Layer2_master.m3u8"
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

# 111) MB TV Monte Blanc
111)
link="https://www.dailymotion.com/video/x6142rr"
#####method="Tor"
use_cookies="no"
chan_name="MB TV Monte Blanc";;

# 112) GONG Asian Cinema Francais
112)

if [ "$getlink" = 1 ]
then
link=https://ec.playmedia.fr/gong-base/live/playlist.m3u8
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

# 117) OUATCH TV
117)
link="https://www.dailymotion.com/video/xuw47s"
#####method="Tor"
use_cookies="no"
chan_name="OUATCH TV";;

# 118) RTL BE
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
chan_name="RTL BE" ;;
# 119) France Inter
119)
keyword="France Inter en direct"

if [ "$getlink" = 1 ]
then
#link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#format=hls-720

channelURL="https://www.youtube.com/user/videofranceinter/videos?&view=2&live_view=501"
youTubeGrab

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
#link=https://rt-esp.secure.footprint.net/1102.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-esp.secure.footprint.net/1102_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-esp.secure.footprint.net/1102_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-esp.secure.footprint.net/1102_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-esp.secure.footprint.net/1102_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-esp.secure.footprint.net/1102_64Kb.m3u8

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
#link=https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#####link="http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link=https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_1_av-b.m3u8?sd=10&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/index_5_a-b.m3u8?sd=10&rebase=on"

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
link="https://livees.cgtn.com/1000e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link="https://livees.cgtn.com/500e/prog_index.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
###link="https://livees.cgtn.com/200e/prog_index.m3u8"
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
#link=http://f24hls-i.akamaihd.net/hls/live/520844/F24_ES_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/520844-b/F24_ES_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/520844-b/F24_ES_LO_HLS/master_900.m3u8

#link=http://static.france24.com/live/F24_ES_HI_HLS/live_tv.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/520845/F24_ES_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/520845-b/F24_ES_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845/F24_ES_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845-b/F24_ES_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845/F24_ES_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845-b/F24_ES_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845/F24_ES_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845-b/F24_ES_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
link=http://f24hls-i.akamaihd.net/hls/live/520845/F24_ES_HI_HLS/master_2000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/520845-b/F24_ES_HI_HLS/master_2000.m3u8

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUdOoVWuWmgo1wByzcsyKDQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
fi
use_cookies="no"
#method="Tor"
chan_name="France 24 Espanol" ;;

# 125) TeleSUR Venezuela
125)
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
link=https://d2ajt1gpdtnw25.cloudfront.net/mbliveMain/hd/playlist.m3u8
#link=https://d2ajt1gpdtnw25.cloudfront.net/mbliveMain/480p/playlist.m3u8
#link=https://d2ajt1gpdtnw25.cloudfront.net/mbliveMain/360p/playlist.m3u8

fi
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;

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

channelURL="https://www.youtube.com/user/Malaga24h/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Magala TV Spain" ;;
# 128) GRANADA TV ES
128)
keyword="GRANADA"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/Steadycamline/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="GRANADA TV ES" ;;
######################### ARGENTINA ##############################################
# 129) c5n Argentina
129)
keyword="C5N"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/c5n/videos?&view=2&live_view=501"
youTubeGrab

# link=http://www.c5n.com/
fi
use_cookies="no"
chan_name="c5n Argentina" ;;
# 130) Canal Acequia Mendoza AR
130)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/6450028/events/5813077"

channelURL="https://livestream.com/accounts/6450028/events/5813077"
liveStreamGrab

fi
use_cookies="no"
chan_name="Canal Acequia Mendoza AR" ;;
# 131) Todo Noticias Argentina
131)
keyword="vivo"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 132) La Nacion TV Argentina
132)
keyword="LN+"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/LaNacionTV/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 133)TV5 Argentina
133)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/T5SATELITAL/events/8664197"

channelURL="https://livestream.com/T5SATELITAL/events/8664197"
liveStreamGrab

fi
use_cookies="no"
chan_name="TV5 Argentina" ;;
# 134) KZO En Vivo Canal 30
134)
keyword="VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;;
# 135)  Canal 2 Argentina
135)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/679322/Canal2Jujuy"

channelURL="https://livestream.com/accounts/679322/Canal2Jujuy"
liveStreamGrab

fi
use_cookies="no"
chan_name="Canal 2 Argentina" ;;
# 136) Canal 6 San Rafael Argentina
136)
keyword="VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Canal 6 San Rafael Argentina" ;;
# 137) Canal 7 Mendoza Argentina
137)
keyword="VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/webcanal7mendoza/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 138) Canal 13 San Juan Argentina
138)
keyword="directo"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;;
# 139) CN23 Argentina
139)
keyword="CN23"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="CN23 Argentina" ;;
# 140) Telemax Argentina
140)

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
# 141) VORTERIX AR
141)
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="VORTERIX AR" ;;
# 142) TV Publica Argentina
142)
keyword="VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="TV Publica Argentina" ;;

################BOLIVIA ##################################

######################       CHILE       #################################
# 143)Senal Internacional Mega Chile
143)
keyword="Mega"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/programasmega/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
################## Colombia ###################
# 144)Telemedellin CO
144)
keyword="Telemedellin"

if [ "$getlink" = 1 ]
then
# channelURL="https://www.youtube.com/channel/UCW_16ow2scNATL0NSxlBtPg/videos?&view=2"
# youTubeGrab
channelURL="https://livestream.com/accounts/4608897/events/7111788/"
liveStreamGrab
fi
use_cookies="no"
chan_name="Telemedellin CO" ;;
# 145) Teleantioquia Espanol  Canal de televisión pública del Departamento de Antioquia. Colombia
145)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/9427524/al-aire"

channelURL="https://livestream.com/canal-teleantioquia/events/8459038"
liveStreamGrab

fi
use_cookies="no"
chan_name="Teleantioquia CO" ;;
################# VENEZUELA
# 146) Globovision Venezeula
146)
keyword="Globovisión"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2"
youTubeGrab

#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
fi
use_cookies="no"
chan_name="Globovision Venezeula" ;;
# 147) NTN24 Venezuela
147)
keyword="EN VIVO"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/canalNTN24/videos?&view=2&live_view=501"
youTubeGrab


fi
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 148) VPItv Venezuela
148)
keyword="Vivo"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="VPItv Venezuela" ;;
#################### CENTRAL AMERICA    ########################
## 149) Guatevision GT
149)

if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/guatevision/events/8716110"
liveStreamGrab

fi
use_cookies="no"
chan_name="Guatevision GT" ;;
#################### MEXICO #########################################################
# 150) Excelsior TV Mexico
150)
keyword="Transmisión en directo de Excélsior TV"

if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;

###########################  TESTING / EXTRA
## 151) 3/24 ?????
151)

if [ "$getlink" = 1 ]
then
#link=http://ccma-tva-int-abertis-live.hls.adaptive.level3.net/int/ngrp:324_mobil/playlist.m3u8
link=http://ccma-tva-int-abertis-live.hls.adaptive.level3.net/int/ngrp:324_mobil/chunklist_b548000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=378000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=320x180
#link=http://ccma-tva-int-abertis-live.hls.adaptive.level3.net/int/ngrp:324_mobil/chunklist_b348000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=98304,CODECS="mp4a.40.2"
#link=http://ccma-tva-int-abertis-live.hls.adaptive.level3.net/int/ngrp:324_mobil/chunklist_b98304.m3u8

fi
use_cookies="no"
chan_name="3/24 ES??" ;;

## 152) PROMAR TV VE
152)

if [ "$getlink" = 1 ]
then
link="http://edge.wms28.lorini.net/promar/promar/live.m3u8"
#link="http://vpn58.hdtv.lorini.net/promar/promar/playlist.m3u8"
fi
use_cookies="no"
chan_name="PROMAR TV VE" ;;

## 153) TVO VE
153)
if [ "$getlink" = 1 ]
then
#TVO
#link="http://edge.wms28.lorini.net/tvo/tvo/playlist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=488087,CODECS="avc1.77.21,mp4a.40.2",RESOLUTION=320x240
link="http://edge.wms28.lorini.net/tvo/tvo/chunklist_w1286123733.m3u8"
fi
use_cookies="no"
chan_name="TVO VE" ;;


## 154) TeleSUR VE
154)
if [ "$getlink" = 1 ]
then
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="" group-title="",TELESUR
link="http://k3.usastreams.com:1935/telesur/telesur/playlist.m3u8"
fi
use_cookies="no"
chan_name="TeleSUR VE" ;;
# 155) Canal Telecafé CO
155)

channelURL="https://livestream.com/accounts/1015476/events/7158511"
liveStreamGrab

use_cookies="no"
chan_name="Canal Telecafé CO" ;;
# 156) EsteCanal TV
156)

channelURL="https://livestream.com/accounts/8817409/events/7051352"
liveStreamGrab

use_cookies="no"
chan_name="EsteCanal TV" ;;
# 157) A24 Argentina
157)
keyword="A24"

channelURL="https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="A24 Argentina";;
# 158) TVDIÁRIO 145 Mexico
158)
#link="https://livestream.com/accounts/7328757/events/7373344"

channelURL="https://livestream.com/accounts/7328757/events/7373344"
liveStreamGrab

use_cookies="no"
chan_name="TVDIÁRIO 145 MX" ;;
# 159) BoliviaTV La Paz Bolivia
159)
#link="https://livestream.com/accounts/10468276/boliviatv"

channelURL="https://livestream.com/accounts/10468276/boliviatv"
liveStreamGrab

use_cookies="no"
chan_name="BoliviaTV La Paz Bolivia" ;;
## 160) TV MONARCA Ciudad Hidalgo, Michoacán, Mexico
160)
#link="https://livestream.com/accounts/17594956/events/5033533"
#link="$( curl "https://livestream.com/accounts/17594956/events/5033533"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"

channelURL="https://livestream.com/accounts/17594956/events/5033533"
liveStreamGrab

use_cookies="no"
chan_name="TV MONARCA Ciudad Hidalgo, Michoacán, Mexico" ;;

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
link="https://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/index_1992_av-p.m3u8?sd=10&rebase=on"
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
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/index_5_a-b.m3u8?sd=10&rebase=on"

channelURL="https://www.youtube.com/user/deutschewelle/videos?view=2&live_view=501" 
youTubeGrab

fi

use_cookies="no"
chan_name="DW Deutsch Welle";;
# 163) ZDK InfoKanal
163)

if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/zdf-infokanal
fi
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
# 164)  Tagessschau 24 Germany
164)

if [ "$getlink" = 1 ]
then
#link=https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=184000,RESOLUTION=320x180,CODECS="avc1.66.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_320_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=320000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_320_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_608_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=608000,RESOLUTION=512x288,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_608_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1152000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1152_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1152000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1152_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1992_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1992000,RESOLUTION=960x540,CODECS="avc1.77.30, mp4a.40.2"
link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_1992_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_3776_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3776000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_3776_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=56000,CODECS="mp4a.40.2"
#link="https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/index_184_a-b.m3u8?sd=10&rebase=on"
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
#link=$radix

primary=$( echo "$radix" | grep pri )

  if [ "$primary" != ""  ]
  then
  #link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_720p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_540p/' )
  link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_360p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_224p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_180p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdepri_ger_90p/' )
  else
  #link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_720p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_540p/' )
  link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_360p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_224p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_180p/' )
  #link=$( echo $radix | sed 's/playlist/ewnsabrdebkp_ger_90p/' )
  fi

channelURL="https://www.youtube.com/user/euronewsde/videos?&view=2&live_view=501" 
youTubeGrab

fi
use_cookies="no"
chan_name="Euronews Deutsch" ;;
# 166)QVC DE
166)
if [ "$getlink" = 1 ]
then
link="https://llnw.live.qvc.simplestream.com/hera/remote/qvcde_primary_sdi7/2/prog_index.m3u8"
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

channelURL="https://livestream.com/accounts/22300508/events/6675945"
liveStreamGrab

fi
use_cookies="no"
chan_name="Radio 21 Nachreichten DE" ;;

# 169)  DW Deutsch +     GEOregion blocked
169)
if [ "$getlink" = 1 ]
then
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/index_5_a-b.m3u8?sd=10&rebase=on"
fi
method="Tor"
use_cookies="no"
chan_name="DW Deutsch + DE" ;;

# 170) Baden TV DE
170)

if [ "$getlink" = 1 ]
then
#link="https://cdn.icu.de/rtplive/smil:btv.smil/chunklist.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2224000,RESOLUTION=1280x720
link="https://cdn.icu.de/rtplive/smil:btv.smil/chunklist_w1511966266_b2224000_sldeu.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=964000,RESOLUTION=864x486
#link="https://cdn.icu.de/rtplive/smil:btv.smil/chunklist_w1511966266_b964000_sldeu.m3u8"
fi
use_cookies="no"
chan_name="Baden TV " ;;

################  Austria
# 171) W24 Wein Austria
171)
if [ "$getlink" = 1 ]
then
#link=https://ms03.w24.at/W24/smil:liveevent.smil/chunklist.m3u8
#link=https://ms03.w24.at/W24/smil:liveevent.smil/chunklist_w1902571248_b1088000_slger.m3u8
#link=https://ms03.w24.at/W24/smil:liveevent.smil/chunklist_w1902571248_b448000_slger.m3u8
link=https://ms01.w24.at/W24/smil:liveevent.smil/chunklist_w1376873396_b1088000_slger.m3u8
fi
#method="Tor"
use_cookies="no"
chan_name="W24 Wein, Austria" ;;
# 172) Tirol TV Austria
172)
if [ "$getlink" = 1 ]
then
#link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
#link=http://lb.hd-livestream.de:1935/live/TirolTV/chunklist_w1916857628.m3u8
link=https://58b42f6c8c9bf.streamlock.net:8080/live/TirolTV/playlist.m3u8
fi
method="Tor"
use_cookies="no"
chan_name="Tirol TV Austria" ;;
# 173) auftanken.tv Austria
173)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/26170820/events/7915290"

channelURL="https://livestream.com/accounts/26170820/events/7915290"
liveStreamGrab

fi
#method="Tor"
use_cookies="no"
chan_name="auftanken.tv Austria" ;;
############################### Switzerland###############################################
# 174) Musig24 TV Switzerland Deutsche
174)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/16598383/events/8687407"
liveStreamGrab

fi
use_cookies="no"
chan_name="musig24 TV Switzerland Deutsche" ;;
################## DUTCH
########## BELGIUM
# 175)TV OOST BE Dutch
175)

if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/27755193/events/8511193/" "https://player-api.new.livestream.com/v3/accounts/27755193/events/8511193/"
#link="$( curl "https://livestream.com/accounts/27755193/events/8511193/" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
#link="https://new.livestream.com/v3/accounts/27755193/events/8511193/live.secure.m3u8"
#link="https://player-api.new.livestream.com/accounts/27755193/events/8511193/live.secure.m3u8"

channelURL="https://player-api.new.livestream.com/accounts/27755193/events/8511193/"
liveStreamGrab

fi
use_cookies="no"
chan_name="TV OOST BE Dutch" ;;

########## NETHERLANDS

# 176)RTV OOST NETHERLANDS
176)
if [ "$getlink" = 1 ]
then
# HIGH 720P
link="https://mediacdn.rtvoost.nl/live/rtvoost/tv-oost/46ce631a-6155-4fcc-ac24-2b2e252f4f94/index.m3u8"
# MEDIUM 480P
#link="https://mediacdn.rtvoost.nl/live/rtvoost/tv-oost/bc0f880f-dbe0-4de2-825d-ec01d960f7fc/index.m3u8"
# LOW 240P
#link="https://mediacdn.rtvoost.nl/live/rtvoost/tv-oost/e8a15a5f-a530-432e-a025-6dffc1426309/index.m3u8"

fi
use_cookies="no"
chan_name="TV OOST NL Dutch" ;;

# 177)AT5 NETHERLANDS
177)
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
# 178)  Euronews Russian
178)
#method="Tor"
if [ "$getlink" = 1 ]
then
#link="http://ru.euronews.com/live"

#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist.m3u8
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_2m.m3u8
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist_1m.m3u8
fi
use_cookies="no"
chan_name="Euronews Russian" ;;
# 179) Россия 24
179)
keyword="24"
if [ "$getlink" = 1 ]
then
#link=https://live.russia.tv/index/index/channel_id/3
#link=https://www.filmon.com/tv/rossiya-24

channelURL="https://www.youtube.com/user/Russia24TV/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 180) RBC TV RUSSIA
180)
if [ "$getlink" = 1 ]
then
link=http://online.video.rbc.ru/online/rbctv_480p/index.m3u8
#link=http://online.video.rbc.ru/online/rbctv_360p/index.m3u8
fi
use_cookies="no"
chan_name="RBC TV Russia" ;;
# 181) CGTN Russian
181)
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-r.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=https://liveru.cgtn.com/1000r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=https://liveru.cgtn.com/500r/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=https://liveru.cgtn.com/200r/prog_index.m3u8
fi
use_cookies="no"
chan_name="CGTN Russian" ;;
# 182) Vesti FM Russia
182)
keyword="Вести ФМ"
if [ "$getlink" = 1 ]
then
#link=https://live.russia.tv/index/index/channel_id/199

channelURL="https://www.youtube.com/user/vestifm/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 183) Perviy Kanal Europa
183)
if [ "$getlink" = 1 ]
then
link=https://www.filmon.com/tv/perviy-kanal-europa
#link=https://edge1.1internet.tv/dash-live11/streams/1tv/1tvdash.mpd
#link=https://cdn9.1internet.tv/dash-live11/streams/1tv/1tvdash.mpd
#link=https://edge1.1internet.tv/hls-live/livepkgr/_definst_/1tv.m3u8
#link=https://cdn9.1internet.tv/hls-live/livepkgr/_definst_/1tv.m3u8
fi
use_cookies="no"
chan_name="Perviy Kanal Europa" ;;
# 184)  Current Time VOA
184)
keyword="НАСТОЯЩЕЕ ВРЕМЯ"
if [ "$getlink" = 1 ]
then
#link=https://www.filmon.com/tv/current-time-tv

channelURL="https://www.youtube.com/user/currenttimetv/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Current Time VOA" ;;
# 185) 5 RU
185)
keyword="Пятого канала"
if [ "$getlink" = 1 ]
then
#link=http://www.ontvtime.ru/general/channel5.html

channelURL="https://www.youtube.com/channel/UCGM8ZTtduKll7X8RiGe6N8g/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="5 Live RU" ;;
######################### UKRAINE  ##################################
# 186) News 24 UA
186)
keyword="24"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/news24ru/videos?flow=grid&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="24 TV UA" ;;
# 187) UA TV Ukraine
187)
keyword="UATV"
if [ "$getlink" = 1 ]
then
link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_mid/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_hi/index.m3u8
#link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_low/index.m3u8
fi
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 188) Thromadske Ukraine
188)
keyword="LIVE"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/HromadskeTV/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 189) Еспресо Ukraine
189)
keyword="LIVE"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/espresotv/videos?&view=2"
youTubeGrab

fi
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 190) News 1 Ukraine
190)
keyword="NEWSONE"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 191) Ukraine Channel 5
191)
keyword="live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/5channel/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Ukraine 5" ;;
################# Moldova
# 192) TV Publica Moldova
192)
if [ "$getlink" = 1 ]
then
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
fi
use_cookies="no"
chan_name="TV Publica Moldova" ;;
# 193) RTDU TV Documentaries Russian
193)
if [ "$getlink" = 1 ]
then
link=https://rtmp.api.rt.com/hls/rtdru.m3u8
#link=https://rtmp.api.rt.com/hls/rtdru360.m3u8
fi
use_cookies="no"
chan_name="RTDU TV Documentaries Russia" ;;


########################### SOUTHERN EUROPE ################################################

##########################  Italian  #######################################################
# 201)
# 202)
# 203)
# 204) Teletutto Brescia Italy
204)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/701633/events/4147166"
liveStreamGrab

fi
use_cookies="no"
chan_name="Teletutto Brescia Italy" ;;
# 205) QVC Itallian
205)
keyword="QVC in diretta"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/qvcitalia/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="QVC Italian" ;;
# 206) Italia channel
206)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/277367/events/7379093"
liveStreamGrab

fi
use_cookies="no"
chan_name="Italia channel" ;;
# 207) Mediaon BergamoTV Italian
207)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/245066/events/3063596"
liveStreamGrab

fi
use_cookies="no"
chan_name="Mediaon BergamoTV Italian" ;;
# 208) news24.city Milan Italy
208)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/16586959/events/7803832"
liveStreamGrab

fi
use_cookies="no"
chan_name="news24.city Milan Italy " ;;
# 209) Radio Radio TV Rome Italy
209)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/11463451/tvlive"
liveStreamGrab

fi
use_cookies="no"
chan_name="Radio Radio TV Rome Italy" ;;
# 210) Udinews TV Udine Italy
210)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/11217196/Udinese"
liveStreamGrab

fi
use_cookies="no"
chan_name="Udinews TV Udine Italy" ;;
# 211) DiTV Canale 89 Lucchese Channel Italy
211)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/21477830/events/6611255"
liveStreamGrab

fi
use_cookies="no"
chan_name="DiTV Canale 89 Lucchese Channel Italy " ;;
# 212) RTM TV Arcevia Italy
212)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/10831729/events/3759913"
liveStreamGrab

fi
use_cookies="no"
chan_name="RTM TV Arcevia Italy" ;;
# 213) 50 News Versilia Viareggio Italy
213)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/25529830/events/7893732"
liveStreamGrab

fi
use_cookies="no"
chan_name="50 News Versilia Viareggio Italy" ;;
# 214) 50 Canale Pisa Italy
214)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/19968830/events/7801416"
liveStreamGrab

fi
use_cookies="no"
chan_name="50 Canale Pisa Italy" ;;
# 215) Telelibertà Piacenza Italy
215)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/17114188/events/4902226"
liveStreamGrab

fi
use_cookies="no"
chan_name="Telelibertà Piacenza Italy" ;;
################# MALTA #######################################
# 216)ONE Malta MT
216)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/18398100/ONELive"
liveStreamGrab

fi
use_cookies="no"
chan_name="ONE Malta MT" ;;
###################  CROATIA   ##########################
# 217) Z1 Televizija Zagreb, Croatia
217)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/26764475/events/8122530"
liveStreamGrab

fi
use_cookies="no"
chan_name="Z1 Televizija Zagreb, Croatia " ;;
# 218) OsjeckaTV Zagreb Croatia
218)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/20748093/events/6049691"
liveStreamGrab

fi
use_cookies="no"
chan_name="OsjeckaTV Zagreb Croatia " ;;
# 219) Tomix TV Wein AT Croatian
219)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/12156095/events/3802250"
liveStreamGrab

fi
use_cookies="no"
chan_name="Tomix TV Wein AT Croatian" ;;
################### Macedonia ######################################
# 220) Sky TV Folk Skopje, Macedonia
220)
keyword="LIVE"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCz69ZZjQ_9TnZPCgfVUQjxQ/videos?flow=grid&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Sky TV Folk Skopje, Macedonia MK";;
################### ALBANIA ########################################
# 221) Top News Albania
221)
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
################  GREEK #################################################
## 222) Star Lamia
222)
if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
fi
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 223) Action 24 Greece HD
223)
if [ "$getlink" = 1 ]
then
link=http://www.dailymotion.com/video/x61fbhs
fi
use_cookies="no"
chan_name="Action 24 Greece HD" ;;
################## TURKEY  ########################
## 224) TRT Haber Turkey
224)
keyword="TRT"
if [ "$getlink" = 1 ]
then
#link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=627000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_360p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=627000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_360p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=827000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_480p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=827000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_480p_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1627000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="https://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_720p_av-b.m3u8?sd=10&rebase=on"

#channelURL="https://www.youtube.com/user/trthaber/videos?&view=2" 
#youTubeGrab

fi
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 225) NTV Turkey
225)
keyword="NTV"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/ntv/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="NTV Turkey";;
## 226) HaberTurk TV
226)
keyword="Habertürk"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/TVhaberturk/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="HaberTurk TV";;
# 227) Star TV  Turkish
227)
keyword="Canlı Yayın"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/STARTVSTAR/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Star TV Turkey";;
# 228) CNN Turk
228)
keyword="CNN TÜRK CANLI YAYINI"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/cnnturk/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="CNN Turk";;
# 229) KRT Kulture TV
229)
keyword="KRT"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="KRT Kulture TV";;
# 230) TGRT Haber TV
230)
keyword="TGRT"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="TGRT Haber TV";;
# 231) TVNET Canali Yayin
231)
keyword="TVNET Canlı Yayın"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/tvnethaber/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 232) Show TV Turkey
232)
keyword="Show"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Show TV Turkey" ;;

####################################################
################## ARABIC  ##########################################
# 241) RT Arabic
241)
keyword="RT"

if [ "$getlink" = 1 ]
then
#link=https://rt-arab.secure.footprint.net/1104.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3765520,AVERAGE-BANDWIDTH=2501400,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=24.000
link=https://rt-arab.secure.footprint.net/1104_2500Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2397824,AVERAGE-BANDWIDTH=1601600,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=854x480,FRAME-RATE=24.000
#link=https://rt-arab.secure.footprint.net/1104_1600Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1181444,AVERAGE-BANDWIDTH=801350,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=24.000
#link=https://rt-arab.secure.footprint.net/1104_800Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=572000,AVERAGE-BANDWIDTH=400400,CODECS="avc1.4d4015,mp4a.40.2",RESOLUTION=428x240,FRAME-RATE=24.000
#link=https://rt-arab.secure.footprint.net/1104_400Kb.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=70400,AVERAGE-BANDWIDTH=70400,CODECS="mp4a.40.2"
#link=https://rt-arab.secure.footprint.net/1104_64Kb.m3u8


#channelURL="https://www.youtube.com/user/RTarabic/videos?&view=2"
#youTubeGrab

fi

use_cookies="no"
chan_name="RT Arabic" ;;
# 242) France 24 Arabic
242)
keyword="الأخبار "
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
#link=http://static.france24.com/live/F24_AR_LO_HLS/live_web.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1095600,AVERAGE-BANDWIDTH=1095600,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1024x576,FRAME-RATE=25.000,AUDIO="program_audio"
#link=http://f24hls-i.akamaihd.net/hls/live/221196-b/F24_AR_LO_HLS/master_900.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221196/F24_AR_LO_HLS/master_900.m3u8
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_1",AUTOSELECT=YES,DEFAULT=YES,URI="master_96.m3u8"

#link=http://static.france24.com/live/F24_AR_HI_HLS/live_tv.m3u8

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=655600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#link=http://f24hls-i.akamaihd.net/hls/live/221148-b/F24_AR_HI_HLS/master_500.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=875600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148-b/F24_AR_HI_HLS/master_700.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1095600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148-b/F24_AR_HI_HLS/master_900.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1425600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148-b/F24_AR_HI_HLS/master_1200.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
link=http://f24hls-i.akamaihd.net/hls/live/221148/F24_AR_HI_HLS/master_2000.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2305600,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1024x576
#link=http://f24hls-i.akamaihd.net/hls/live/221148-b/F24_AR_HI_HLS/master_2000.m3u8

fi
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 243) BBC Arabic
243)
keyword="BBC Arabic Live"
if [ "$getlink" = 1 ]
then
#link=https://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=256x144,CODECS="avc1.66.30, mp4a.40.2"
#link="https://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_192_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=400000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2"
#link="https://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_400_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=800000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/index_800_av-p.m3u8?sd=10&rebase=on"

channelURL="https://www.youtube.com/user/BBCArabicNews/videos?view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="BBC Arabic" ;;
# 244)  DW Arabic
244)
keyword="DW عربية مباشر"
if [ "$getlink" = 1 ]
then
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=163000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_4_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=264000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_4_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=464000,RESOLUTION=400x224,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=864000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1664000,RESOLUTION=720x400,CODECS="avc1.77.30, mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_1_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/index_5_a-b.m3u8?sd=10&rebase=on"

#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8

#channelURL="https://www.youtube.com/user/deutschewellearabic/videos?&view=2" 
#youTubeGrab

fi

use_cookies="no"
chan_name="DW Arabic" ;;
# 245) CGTN Arabic
245)
if [ "$getlink" = 1 ]
then
#link=https://live.cgtn.com/cctv-a.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1096000,RESOLUTION=1280x720,NAME="720p HD"
link=https://livear.cgtn.com/1000a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=640x360,NAME="360p SD"
#link=https://livear.cgtn.com/500a/prog_index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=192000,RESOLUTION=320x180,NAME="180p 3G"
#link=https://livear.cgtn.com/200a/prog_index.m3u8
fi
use_cookies="no"
chan_name="CGTN Arabic" ;;

####################################################################################
# 246) Al Jazeera Arabic Qatar QA
246)
keyword="Live Stream"
if [ "$getlink" = 1 ]
then
#link="https://live-hls-web-aja.getaj.net/AJA/index.m3u8"

#EXT-X-STREAM-INF:BANDWIDTH=6324320,RESOLUTION=1920x1080,CODECS="avc1.640028,mp4a.40.2"
link="https://live-hls-web-aja.getaj.net/AJA/01.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3120800,RESOLUTION=1280x720,CODECS="avc1.64001f,mp4a.40.2"
#link="https://live-hls-web-aja.getaj.net/AJA/02.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1831872,RESOLUTION=960x540,CODECS="avc1.64001f,mp4a.40.2"
#link="https://live-hls-web-aja.getaj.net/AJA/03.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1013696,RESOLUTION=746x420,CODECS="avc1.64001e,mp4a.40.2"
#link="https://live-hls-web-aja.getaj.net/AJA/04.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=813664,RESOLUTION=640x360,CODECS="avc1.64001e,mp4a.40.2"
#ink="https://live-hls-web-aja.getaj.net/AJA/05.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=428640,RESOLUTION=426x240,CODECS="avc1.640015,mp4a.40.2"
#link="https://live-hls-web-aja.getaj.net/AJA/06.m3u8"


#link=https://www.aljazeera.net/broadcastschedule

#channelURL="https://www.youtube.com/user/aljazeerachannel/videos?&view=2"
#youTubeGrab

fi
use_cookies="no"
chan_name="Al Jazeera Arabic" ;;
# 247) Al Jazeera Mubasher QA
247)
#keyword="Mubasher"
keyword="HD"
if [ "$getlink" = 1 ]
then
channelURL="https://www.youtube.com/c/ajmubasher/videos?view=2&flow=grid&live_view=501"
youTubeGrab
fi

use_cookies="no"
chan_name="Al Jazeera Mubasher QA " ;;
############################## SAUDI TV   #########################################
# 248) Saudi Channel 1 Green KSA 1
248)
keyword="القناة"
if [ "$getlink" = 1 ]
then
#link=https://www.filmon.com/tv/saudi-arabian-tv-1
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

channelURL="https://www.youtube.com/user/SaudiChannelOne/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Kingdom of Saudi Arabia Channel 1 Green" ;;
# 249) Kingdom of Saudi Arabia Sports Channel KSA Sports
249)
keyword="القنوات"
if [ "$getlink" = 1 ]
then
#link=https://www.filmon.com/tv/saudi-arabian-tv-sports
#"http://www.shashatcom.sa/assets/themes/TriTheme/libraries/bootstrap/css/bootstrap.min.css.mapno"

channelURL="https://www.youtube.com/user/AlMalabTube/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"

chan_name="Saudi Sports Channel 4 Red" ;;
# 250) Al Arabiya, Dubai, United Arab Emirates
250)
keyword="قناة"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/AlArabiya/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Al Arabiya, Dubai, UAE " ;;
# 251) Al Mayadeen,  Beirut, Lebanon
251)
keyword="Live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCuJDz6R_lHaxeGnFTnv3tjg/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Al Mayadeen, Beirut, Lebanon" ;;

# 252) Belqees TV Yemen Arabic
252)
keyword="قناة بلقيس "
if [ "$getlink" = 1 ]
then

#channelURL="https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2"
#youTubeGrab

channelURL="https://livestream.com/accounts/12233888/events/3819374"
liveStreamGrab

fi
use_cookies="no"
chan_name="Belqees TV Yemen Arabic" ;;
# 253) SKY Arabic, Abu Dhabi, UAE
253)
keyword="البث المباشر"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/skynewsarabia/videos?&view=2&live_view=501" 
youTubeGrab

fi
use_cookies="no"
chan_name="SKY Arabic, Abu Dhabi, UAE" ;;
# 254)Alghad TV Cairo Egypt
254)
keyword="Alghad"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UCH4UNKBHSNwstan99YDoCVg/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="AlGhad, Cairo, Egypt" ;;
# 255) eXtra News Egypt Arabic
255)
keyword="Live Stream"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="eXtra News Egypt" ;;
# 256) CBC Egypt Sofra Arabic
256)
keyword="Live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/CBCSofraStream/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 257) CBC Egypt Arabic Drama
257)
keyword="Live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/CBCDramaStream/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 258) DMC Live EG
258)
keyword="dmc"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="DMC LIVE EG" ;;
# 259) Al-Fallujah Tv Channel IRAQ
259)
if [ "$getlink" = 1 ]
then

#link="https://livestream.com/accounts/4671269/falluajh"
#link=https://livestream.com/karbala-tv/events/7672592

channelURL="https://livestream.com/accounts/4671269/falluajh"
liveStreamGrab

fi
use_cookies="no"
chan_name="Al-Fallujah Tv Channel IRAQ" ;;
# 260) AFAQ TV IRAQ
260)
keyword="Afaq Tv Live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/afaqiraq/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="AFAQ TV IRAQ" ;;
# 261) Karbarla Satellite Channel IRAQ
261)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/11436227/events/3998452"

channelURL="https://livestream.com/karbala-tv/events/3998452"
liveStreamGrab

fi
use_cookies="no"
chan_name="Karbarla Satellite Channel IRAQ" ;;
# 262) Safeer TV UK Islamic
262)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/karbala-tv/events/7672592"
liveStreamGrab

fi
use_cookies="no"
chan_name="Safeer TV UK Islamic" ;;
################################## FARSI / PERSIAN  ###########################################################
# 263)  BBC Persian
263)
keyword="پخش زنده"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/BBCPersian/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="BBC Persian";;
# 264)  Iran Aryaee San Bernadino California
264)

channelURL="https://livestream.com/accounts/11825802/events/3752117"
liveStreamGrab

use_cookies="no"
chan_name="Iran Aryaee San Bernadino California" ;;
# 265) DidgahNew TV Iranian
265)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/27146356/events/8147101"
liveStreamGrab

fi
use_cookies="no"
chan_name="DidgahNew TV Iranian" ;;
# 266) Aryen TV Iran Kurdish
266)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/22902829/events/7609059"
liveStreamGrab

fi
use_cookies="no"
chan_name="Aryen TV Iran Kurdish" ;;
# 267) PTN Pars TV USA Persian
267)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/5901056/events/4455330"
liveStreamGrab

fi
use_cookies="no"
chan_name="PTN Pars TV USA Persian" ;;
################# AFGHANISTAN ######################################
# 268) Ariana TV Afghanistan
268)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/9180830/events/6727975"
liveStreamGrab

fi
use_cookies="no"
chan_name="Ariana TV Afghanistan" ;;
## 269) TOLO NEWS AFGHANISTAN
269)
keyword="Live"
if [ "$getlink" = 1 ]
then

channelURL="https://www.youtube.com/user/TOLOnewsLive/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";;

# 270)
# 272)
# 273)
# 274)
# 275)
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

channelURL="https://www.youtube.com/channel/UCdHy-hnyIEZBHkPJecz9RtA/videos?&view=2&live_view=501"
youTubeGrab

fi
use_cookies="no"
chan_name="Aaj News PK" ;;


# 282)Din News PK
282)
keyword="Live"
#link=http://www.dailymotion.com/video/x5ubgo9

channelURL="https://www.youtube.com/channel/UCKh7t3sgs671fSeqsXjlN0A/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Din News PK" ;;
# 283) Minhaj TV Pakistan
283)

channelURL="https://livestream.com/accounts/547271/MinhajTV"
liveStreamGrab

use_cookies="no"
chan_name="Minhaj TV Pakistan" ;;
# 284) TV Arcana Barkat TV PK
284)

channelURL="https://livestream.com/accounts/25119151/events/7597894"
liveStreamGrab

use_cookies="no"
chan_name="TV Arcana Barkat TV" ;;
# 285) Geo News PK
285)
keyword="LIVE"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/geonews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
link="https://jk3lz82elw79-hls-live.5centscdn.com/geo/live.stream/geo/live.stream1/chunks.m3u8"
#link="https://streamer62.ebound.tv/geo/geonews_abr/geo/geonews_master/chunks.m3u8"
use_cookies="no"
chan_name="Geo News PK" ;;
# 286) SAMAA TV Pakistan
286)
keyword="SAMAA"

channelURL="https://www.youtube.com/user/samaatvnews/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="SAMAA TV Pakistan" ;;

###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 287) Shaski India
287)
keyword="Sakshi"

channelURL="https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Shaski India" ;;
# 288) SunNews
288)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SunNews" ;;
# 289) TV9 India Live
289)
keyword="TV9"

channelURL="https://www.youtube.com/user/tv9telugulive/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="TV9 Live India";;
# 290) Rajya Sabha TV
290)
keyword="Rajya"

channelURL="https://www.youtube.com/user/rajyasabhatv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Rajya Sabha" ;;
# 291) TV9 Gujarat
291)
keyword="Gujarat"

channelURL="https://www.youtube.com/user/tv9gujaratlive/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="TV 9 Gujarat" ;;
# 292) News 7 Tamil
292)
keyword="LIVE"

channelURL="https://www.youtube.com/user/news7tamil/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="News 7 Tamil" ;;
# 293) News 18 India
293)
keyword="LIVE"

channelURL="https://www.youtube.com/user/ibn7/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="News 18 India" ;;
# 294) Aaj Tak
294)
keyword="Aaj"

channelURL="https://www.youtube.com/user/aajtaktv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Aaj Tak" ;;
# 295) NTV Telugu
295)
keyword="Live"

channelURL="https://www.youtube.com/user/ntvteluguhd/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="NTV Telugu" ;;
# 296) ABN Telugu
296)
keyword="ABN"

channelURL="https://www.youtube.com/user/abntelugutv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="ABN Telugu" ;;
# 297) Vanitha TV
297)
keyword="Live"

channelURL="https://www.youtube.com/user/VanithaTvChannel/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Vanitha TV" ;;
# 298) HMT Telugu
298)
keyword="HMTV Live"

channelURL="https://www.youtube.com/user/hmtvlive/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="HMT Telugu" ;;
# 299) India TV IN
299)
#link=https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237//master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=244000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=244000,RESOLUTION=426x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_3_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_2_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_2_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=576000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=576000,RESOLUTION=854x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://indiatvnews-lh.akamaihd.net/i/ITV_1@199237/index_1_av-b.m3u8?sd=10&rebase=on"
keyword="Live"

#channelURL="https://www.youtube.com/user/IndiaTV/videos?&view=2&live_view=501"
#youTubeGrab

use_cookies="no"
chan_name="India TV IN" ;;
# 300) Suvarna News
300)
keyword="Live"

channelURL="https://www.youtube.com/user/suvarnanews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Suvarna News" ;;
# 301)i News Telugu
301)
keyword="iNews"

channelURL="https://www.youtube.com/user/inews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="iNews Telugu" ;;
# 302) Puthiyah Thalimurai Tamil Live News
302)
keyword="LIVE"

channelURL="https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Puthiyah Thalimurai Tamil Live News";;

## 303) DD News
303)
keyword="LIVE"

channelURL="https://www.youtube.com/user/DDNewsofficial/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
 chan_name="DD News" ;;
# 304) REPORTER LIVE
304)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Reporter Live" ;;
# 305) AsiaNet News
305)
keyword="Live"

channelURL="https://www.youtube.com/user/asianetnews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="AsiaNet News" ;;
# 306)V6 News
306)
keyword="LIVE"

channelURL="https://www.youtube.com/user/V6NewsTelugu/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="V6 News" ;;
# 307) Aaj Tak TV IN
307)
keyword="Aaj Tak"
# AJTAK TV

#channelURL="https://www.youtube.com/user/aajtaktv/videos?&view=2"
#youTubeGrab

channelURL= "https://player-api.new.livestream.com/accounts/13982572/events/4169984/"
liveStreamGrab

use_cookies="no"
chan_name="Aaj Tak TV IN" ;;
# 308) ETV Andhra Pradesh
308)
keyword="ETV"

channelURL="https://www.youtube.com/user/newsetv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 309) News 18 Tamilnadu
309)
keyword="News18"

channelURL="https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 310) Jaya Plus
310)
keyword="Live"

channelURL="https://www.youtube.com/user/jayapluschennai/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Jaya Plus" ;;
# 311) TEZ TV
311)
keyword="Live"
# Tez TV

#channelURL="https://www.youtube.com/user/teztvnews/videos?&view=2"
#youTubeGrab

channelURL="https://player-api.new.livestream.com/accounts/13995833/events/4198957/"
liveStreamGrab

use_cookies="no"
chan_name="TEZ TV" ;;
# 312) Dilli Aaj Tak
312)
keyword="Live"
# Dili AajTak

#channelURL="https://www.youtube.com/user/DilliAajtak/videos?view=2" 
#youTubeGrab

channelURL="https://player-api.new.livestream.com/accounts/14014394/events/4198951/"
liveStreamGrab

use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 313) Derana Sri Lanka
313)
keyword="Live"

channelURL="https://www.youtube.com/user/tvderanavideos/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Derana Sri Lanka" ;;
# 314) Swarnavahini Sri Lanka
314)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCAH7R88V7gz7RqJv78nNOzg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Swarnavahini Sri Lanka " ;;
# 315) Kalaignar News
315)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Kalaignar News" ;;
# 316) Sangat Television Birmingham England
316)

channelURL="https://livestream.com/accounts/6986636/sangattv"
liveStreamGrab

use_cookies="no"
chan_name="Sangat Television Birmingham England" ;;
# 317) Sikh Channel Sikh Channel (Global Broadcast) Aston England
317)

channelURL="https://livestream.com/accounts/5296919/live"
liveStreamGrab

use_cookies="no"
chan_name="Sikh Channel Aston England" ;;

# 318) NTV Bangladesh
318)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCYqujAD5831EywH1jldBu5w/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="NTV Bangladesh" ;;

# 319) ATN Bangladesh
319)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="ATN Bangladesh" ;;

# 320) Channel 24 IN
320)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UCBUJipGCEK09A8qlI6PkS4Q/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Channel 24 IN" ;;

# CNN 18 IN
# https://www.youtube.com/user/ibnlive/videos
# HUM News Live PK
# https://www.youtube.com/channel/UCt4pLfULsDlvIyMF5fKmtRg/videos
################## ASIA ######################################################################
################ CHINESE MANDARIN CANTONESE  ####################
# 321) CCTV 4 Chinese
321)
keyword="CCTV"

channelURL="https://www.youtube.com/user/ChineseInternatioify/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="CCTV 4 China" ;;
############## TAIWAN TAIWANESE ##############################
# 322) EBC 51 News Taiwan
322)
keyword="EBC"

channelURL="https://www.youtube.com/user/newsebc/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 323) EBC Finance Taiwan
323)
keyword="EBC"

channelURL="https://www.youtube.com/user/57ETFN/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="EBC Finance News Taiwan" ;;
# 324) TTV News Taiwan
324)
keyword="TTV"

channelURL="https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 325) CTV Taiwan
325)
keyword="中視新聞台 LIVE直播"

channelURL="https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="CTV Taiwan" ;;
# 326) FTV Taiwan
326)
keyword="live"

channelURL="https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="FTV Taiwan Live";;
# 327) CTS World News HD Taiwan
327)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="CTS World News HD" ;;
# 328) SET News Taiwan
328)
keyword="SET"

channelURL="https://www.youtube.com/user/setnews159/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SET News Taiwan" ;;
# 329) CTI Taiwan
329)
keyword="CTI"

channelURL="https://www.youtube.com/user/ctitv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="CTI Taiwan" ;;
# 330) SET iNEWS Taiwan
330)
keyword="LIVE"

channelURL="https://www.youtube.com/user/setmoney159/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SET iNEWS Taiwan" ;;
# 331) Formosa News HD Taiwan
331)
keyword="Formosa"

channelURL="https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Formosa News HD Taiwan";;
#  332) TzuChi DaAi World Taiwan
332)
keyword="大愛海外頻道"
#link=https://www.dailymotion.com/video/x5crdro

channelURL="https://www.youtube.com/user/DaAiVideo/videos?&view=2&live_view=501" 
youTubeGrab

use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;;
# 333) 大愛電視 Tzu Chi DaAiVideo
333)
keyword="全球直播"

channelURL="https://www.youtube.com/user/DaAiVideo/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Tzu Chi DaAiVideo 1" ;;
# 334) 大愛一臺HD Live 直播
334)
keyword="直播"

channelURL="https://www.youtube.com/user/DaAiVideo/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Tzu Chi DaAiVideo 2" ;;
# 335) Sinda Television
335)
keyword="信大電視台"

channelURL="https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Sinda Television" ;;
# 336) CTS World News HD 2 Taiwan
336)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="CTS World News HD 2" ;;
# 337) SJTV TW
337)
keyword="SJTV"

channelURL="https://www.youtube.com/user/SJTVonline/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SJTV TW";;
# 338) #LLBN Chinese TV
338)
keyword="Live"
#https://t01587-lh.akamaihd.net/i/t01587Chinese_1@692075/index_1250_av-p.m3u8?sd=10&set-akamai-hls-revision=5&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=414000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Chinese_1@692075/index_350_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=846000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Chinese_1@692075/index_750_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1346000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587Chinese_1@692075/index_1250_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN Chinese  TV" ;;

# 339) SDTV 04CH Taiwan
339)
keyword="04CH"

channelURL="https://www.youtube.com/channel/UCBWzi-vMywDa05QYA2jHxwQ/videos?view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SDTV 04CH TW" ;;
# 340) Fanstelevision Taiwan
340)
keyword="番薯衛星電視台現場直播"

channelURL="https://www.youtube.com/channel/UC2UCHUxTWVkSqP6MILU5Bqw/videos?view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Fans TV TW" ;;
# 341) Hong Kong TV
341)
link=rtmp://live.hkstv.hk.lxdns.com/live/hks
use_cookies="no"
chan_name="Hong Kong TV" ;;

# 342) OnTV Hong Kong
342)
keyword="ontv"

channelURL="https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="OnTV Hong Kong";;

# 343) GETV Chinese California USA
343)

channelURL="https://livestream.com/channelge/events/8122971"
liveStreamGrab

use_cookies="no"
chan_name="GETV Chinese California USA" ;;

# 344) KCTV North Korea Central Television
344)
link=https://tv.nknews.org/tvdash/stream.mpd
#link=https://tv.nknews.org/tvhls/stream.m3u8
use_cookies="no"
chan_name="KCTV North Korea Central Television";;

# 345) Arirang Culture TV Korean
345)
keyword="Arirang TV"

channelURL="https://www.youtube.com/user/arirangkorean/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Arirang Culture TV Korean" ;;


# 346) TBS Live Korea
346)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="TBS Live Korea" ;;

# 347) YTN DMB Korea
347)
keyword="LIVE"

channelURL="https://www.youtube.com/user/ytndmb/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="YTN DMB Korea" ;;

# 348) YTN Science Korea
348)
keyword="LIVE"

channelURL="https://www.youtube.com/user/ytnscience/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="YTN Science Korea" ;;

# 349) Channel 23 Korea
349)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Channel 23 Korea" ;;
# 350) KBS World 24 Korea
350)
keyword="On-Air"

channelURL="https://www.youtube.com/channel/UCWw_gejTX29Yn89LLpcINZQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="KBS World 24 News" ;;

# 351) YTN 27 Korea
351)
keyword="YTN LIVE"

channelURL="https://www.youtube.com/user/ytnnews24/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="YTN LIVE Korea" ;;

# 352) CGNTV America Korean Los Angeles California
352)

channelURL="https://livestream.com/accounts/13207573/events/8418527"
liveStreamGrab

use_cookies="no"
chan_name="CGNTV America Korean Los Angeles California " ;;

# 353) LLBN Korean TV
353)
keyword="Live"
#https://t01587-lh.akamaihd.net/i/t01587Korean_1@692076/index_1250_av-p.m3u8?sd=10&set-akamai-hls-revision=5&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=414000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Korean_1@692076/index_350_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=846000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Korean_1@692076/index_750_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1346000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587Korean_1@692076/index_1250_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN Korean TV" ;;

# 354) YTV America Live Korean LA CA USA
354)

channelURL="https://livestream.com/accounts/15217951/events/4355473"
liveStreamGrab

use_cookies="no"
chan_name="YTV America Live Korean LA CA USA" ;;
# 355) Atlanta Radio Korea AM790
355)

channelURL="https://livestream.com/ark790/events/8866824"
liveStreamGrab

use_cookies="no"
chan_name="Atlanta Radio Korea AM790" ;;

# 356) ANN JapaNews 24 Japan
356)
keyword="LIVE"

channelURL="https://www.youtube.com/user/ANNnewsCH/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="ANN News 24 Japan" ;;

# 357) Sol!ve 24 Japan
357)
keyword="LIVE"

channelURL="https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Sol!ve 24 Japan";;

# 358) KBS Live 24 Japan
358)
keyword="KBSLIVE24"

channelURL="https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="KBS Live 24 Japan" ;;

#  359) QVC JAPAN SHOPPING CHANNEL
359)
keyword="QVC"
#link="https://cdn-live1.qvc.jp/iPhone/1501/1501.m3u8"

channelURL="https://www.youtube.com/user/QVCJapan/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;

# 360) BSC 24 1
360)
keyword="BSC24-第1"

channelURL="https://www.youtube.com/user/bousaishare/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="BSC 24 1" ;;

####################################### SOUTH ASIAN ####################################################################
################# TAGALOG FILIPINO #############################
# 361) DZMM ABS-CBN Philippeans Radio
361)
keyword="DZMM Audio Streaming"

channelURL="https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 362) PTV Philippines
362)
keyword="PTV Live Stream"

channelURL="https://www.youtube.com/user/PTVPhilippines/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="PTV Philippines";;
################ Indonesia  #########################################
# 363) Net TV Jakarta Indonesia
363)
keyword="NET"

channelURL="https://www.youtube.com/user/NetTVInsight/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Net TV Jakarta Indonesia" ;;
# 364) Net TV LIVE Jakarta Indonesia
364)
keyword="LIVE"

channelURL="https://www.youtube.com/user/NetTVInsight/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Net TV Live Jakarta Indonesia" ;;
# 365) Net TV First Comedy Jakarta Indonesia
365)
keyword="COMEDY"

channelURL="https://www.youtube.com/user/NetTVInsight/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Net TV First Comedy Jakarta Indonesia" ;;
##################### Myanmar #########################################
# 366) skynet Buddha Myanmar
366)

channelURL="https://livestream.com/accounts/7228455/events/3875181"
liveStreamGrab

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

channelURL="https://livestream.com/accounts/27136431/events/8142772"
liveStreamGrab

use_cookies="no"
chan_name="Viet Sky TV Anaheim California" ;;
# 369) ABHPTV Daily Broadcast Vietnamese  An Bình Hạnh Phúc
369)

channelURL="https://livestream.com/accounts/13311218/events/7250967"
liveStreamGrab

use_cookies="no"
chan_name="ABHPTV Daily Broadcast An Bình Hạnh Phúc Vietnamese " ;;
#####################################
# 370) Earthquake 24
370)
keyword="地震監視・24時間LIVE"

channelURL="https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Earthquake 24" ;;
# 371) Arirang News
371)
keyword="Arirang TV"

channelURL="https://www.youtube.com/user/arirangnews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Arirang News TV" ;;

# 372) Arirang TV Korea English
372)
keyword="Arirang"

#link=http://www.filmon.com/tv/arirang-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
#BANDWIDTH=1728000,RESOLUTION=1280x720
link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1728000_sleng.m3u8
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


# 373) BSC 24 2
373)
keyword="BSC24-第2"

channelURL="https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="BSC 24 2" ;;

# 376)
# 377)
#########################################   AFRICA    ##############################################
# 378) Africa News Live
378)
keyword="africanews Live"
#link=https://www.dailymotion.com/video/x6i7vf8

channelURL="https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2&live_view=501"
youTubeGrab
use_cookies="no"
chan_name="Africa News English";;
# 379) Africa24 Francaise
379)
keyword="Africa24 Live"

channelURL="https://www.youtube.com/user/Africa24/videos?view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Africa24 Francais" ;;
# 380) SIKKA TV Afrique Francaise
380)
keyword="SIKKA TV"

channelURL="https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SIKKA TV Afrique Francais" ;;
# 381) Channels 24 Nigeria NG
381)
keyword="Channels Television"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
#link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8

channelURL="https://www.youtube.com/user/channelsweb/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Channels 24 Nigeria NG";;
# 382)TVC News Nigeria NG
382)
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8

channelURL="https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="TVC News Nigeria NG";;
# 383) NTV Uganda UG
383)
keyword="NTV"

channelURL="https://www.youtube.com/user/ntvuganda/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="NTV Uganda UG" ;;
# 384) SPARK TV Uganda UG
384)
keyword="SPARK TV"

channelURL="https://www.youtube.com/user/ntvuganda/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SPARK TV Uganda UG" ;;
# 385)  KTN Kenya KE
385)
keyword="Live"

channelURL="https://www.youtube.com/user/standardgroupkenya/videos?&view=2&live_view=501"
youTubeGrab

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

channelURL="https://www.youtube.com/user/myjoyonlinetube/videos?view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Joy News Ghana GH";;
# 389)  ADOM TV GH
389)
keyword="Adom"

channelURL="https://www.youtube.com/user/adomtvtube/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="ADOM TV Ghana GH" ;;
# 390) Bukedde TV GH
390)
keyword="Bukedde"

channelURL="https://www.youtube.com/user/bukeddetv/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="Bukedde TV GH";;
# 391) EBC Ethiopia
391)
keyword="\#EBC"

channelURL="https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?view=2&live_view=501"
youTubeGrab

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
keyword="2019"

channelURL="https://www.youtube.com/user/sabcdigitalnews/videos?&view=2&live_view=501"
youTubeGrab

use_cookies="no"
chan_name="SABC News South Africa ZA" ;;
# 395) iTV Networks South Africa ZA
395)

channelURL="https://livestream.com/accounts/7079896/events/4406003"
liveStreamGrab

use_cookies="no"
chan_name="iTV Networks South Africa ZA" ;;
# 396) Parliament of the Republic of South Africa ZA
396)
keyword="Plenary"

channelURL="https://www.youtube.com/user/ParliamentofRSA/videos?flow=grid&view=2"
youTubeGrab

use_cookies="no"
chan_name="Parliament of the Republic of South Africa ZA" ;;
# 397) D24
397)
link=https://www.dailymotion.com/video/x6cq41k
use_cookies="no"
chan_name="D24" ;;
# 398) Afrique Media
398)
link=https://www.dailymotion.com/video/x5dk3kj
use_cookies="no"
chan_name="Afrique Media" ;;
# 399) DBM TV
399)
link=https://www.dailymotion.com/video/x5qokx5
use_cookies="no"
chan_name="DBM TV" ;;

# 400)


##################################### LOCAL NEWS USA ####################################################################
# 401) RSBN Auburn Alabama USA
401)
keyword="RSBN"

channelURL="https://www.youtube.com/user/rightsideradio/videos?&view=2&live_view=501"
youTubeGrab

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

channelURL="https://www.youtube.com/user/NBC2swfl/videos?&view=2"
youTubeGrab

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
################## RUPTLY
# 410) RUPTLY LIVE RT
410)
link=https://hls-lw.rt.com/hls/ptr-strm.m3u8
use_cookies="no"
chan_name="RUPTLY LIVE RT" ;;

# 411)
# 412)

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

channelURL="https://www.youtube.com/user/hsntv/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 421) HSN 2
421)
keyword="HSN2"

channelURL="https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2"
youTubeGrab

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
channelURL="https://www.youtube.com/user/PBSNewsHour/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="PBS NewsHour Video" ;;
# 428)  CBC The National
428)
keyword="The National"

channelURL="https://www.youtube.com/user/CBCTheNational/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="CBC The National" ;;
# 429) AP Top Stories
429)
keyword="Top"

channelURL="https://www.youtube.com/user/AssociatedPress/videos"
youTubeGrab

use_cookies="no"
chan_name="AP Top Stories" ;;
# 430) Democracy Now Headlines
430)
keyword="Headlines"

channelURL="https://www.youtube.com/user/democracynow/videos"
youTubeGrab

use_cookies="no"
chan_name="Democracy Now Headlines" ;;


############################# CNN ###################################################
# 431) CNN PHILIPPINES
431)
if [ "$getlink" = 1 ]
then
link=rtmp://54.251.134.121/live/15273.sdp
fi
use_cookies="no"
####method="Tor"
TAG="CNN_PH______"
chan_name="CNN PHILIPPINES";;
# 432) CNN Live
432)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"

if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)"
link=https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
####link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=424000,RESOLUTION=480x270,CODECS="avc1.66.30, mp4a.40.2"
#link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=924000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_860_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://cnn-lh.akamaihd.net/i/cnndebates_1@352100/index_360_a-b.m3u8?sd=10&rebase=on"
#link="https://1861340594.rsc.cdn77.org/ls-54548-1/tracks-v1a1/mono.m3u8"
fi
use_cookies="no"
####method="Tor"
TAG="CNN_LIVE___"
chan_name="CNN Live" ;;

# 433) CNN HLN Headline News USA
433)
link="https://1161275585.rsc.cdn77.org/LS-ATL-54548-7/tracks-v4a1/mono.m3u8"
#method="Tor"
use_cookies="no"
chan_name="CNN HLN USA";;
# 434) Lake Tahoe TV
434)
if [ "$getlink" = 1 ]
then

channelURL="https://livestream.com/accounts/21822229/events/6450069"
liveStreamGrab

fi
use_cookies="no"
TAG="LAKE_TAHOE____"
chan_name="Lake Tahoe TV" ;;

# 436) Juptier Broadcasting USA
436)

if [ "$getlink" = 1 ]
then
#link=https://vse-na-us-nw17.secdn.net/jupiter-chorigin/live/jupiter/chunklist.m3u8
#link=https://vse-na-us-nw17.secdn.net/jupiter-chorigin/live/jupiter_360p/chunklist.m3u8
#link=https://vse-na-us-nw17.secdn.net/jupiter-chorigin/live/jupiter_720p/chunklist.m3u8
link=https://vse-na-us-nw17.secdn.net/jupiter-chorigin/live/jupiter_480p/chunklist.m3u8

#link=https://jupiter-hls.secdn.net/jupiter-channel/play/jupiter.smil/playlist.m3u8
#link=https://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
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

# 437) News 12 Connecticut
437)
if [ "$getlink" = 1 ]
then
link="http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12TW_CT"
fi
use_cookies="no"
TAG="NEWS12CONNECTICUT"
chan_name="News 12 Connecticut" ;;

#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (The Bronx)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12BX
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890454.1464300091!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Brooklyn)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12KN
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Long Island - Traffic)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12TW_LI
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Long Island - News)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12LI_WEST
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Connecticut)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12CT_WEST
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Connecticut - Traffic)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12TW_CT
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (New York City - Traffic)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12TW_NYC
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (New Jersey - Traffic)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12TW_NJ
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (New Jersey)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12NJ_CENTRAL
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Hudson Valley)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12HV
#EXTINF:-1 tvg-id="" tvg-name="" tvg-logo="http://cdn.news12.com/polopoly_fs/1.8890451.1464300188!/httpImage/image.jpg_gen/derivatives/display_600/image.jpg" group-title="USA LOCAL",News 12 (Westchester)
#http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12WH_WESTCHESTER

# 438) T4G Ireland
438)
link="http://csm-e.cds1.yospace.com/csm/live/74246610.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="T4G IE";;

# 439) CNBC USA
439)
if [ "$getlink" = 1 ]
then
link="https://1674331492.rsc.cdn77.org/LS-ATL-54548-14/tracks-v1a1/mono.m3u8"
fi
#method="Tor"
use_cookies="no"
TAG="CNBC______"
chan_name="CNBC USA";;


# 440) EuroNews English
440)
keyword="euronews"
method="Tor"

if [ "$getlink" = 1 ]
then
#link="https://www.euronews.com/live"
#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "https://www.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d \/ -f 3,4,5 | sed 's/\\//g' )
#link="https://$radix/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_224p.m3u8"

#radix=$(torsocks -i -a $torsocks_ip -P $torsocks_port curl -A "$UA" $(streamlink "https://www.euronews.com/live" | cut -d "'" -f 2 | cut -d : -f 3  | cut -d "?" -f 1 | cut -d / -f 3,4,5,6,7,8,9 )| cut -d \: -f 4,5 | cut -d , -f 1 | sed 's/\\//g' | sed 's/\"//g'  )
#link="$radix"
#primary=$( echo "$radix" | grep pri )
#  if [ "$primary" != ""  ]
#  then
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_720p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_540p/' )
#  link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_360p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_224p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_180p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenpri_eng_90p/' )
#  else
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_720p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_540p/' )
#  link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_360p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_224p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_180p/' )
#  #link=$( echo $radix | sed 's/playlist/ewnsabrenbkp_eng_90p/' )
#  fi

link="https://euronews-en-b11-cdn.hexaglobe.net/6b901c672349caeec3de26280869f5c9/5d326c80/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenbkp_eng.smil/ewnsabrenbkp_eng_540p.m3u8"

# http://euronews-en-b11-cdn.hexaglobe.net/5972ab92b8497cd8074974f672d75945/5b4dc7a2/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenbkp_eng.smil/playlist.m3u8

#http://euronews-en-p-api.hexaglobe.net/a3618e54b21c1c5dd38e7b36efb549fb/5c234c7f/euronews/euronews-euronews-website-web-responsive-2/en/stream_info.php
#http://euronews-en-b9-cdn.hexaglobe.net/c72edfc1e45108d5a4e00b9798951041/5c234cf7/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenbkp_eng.smil/playlist.m3u8
#http://euronews-en-p10-cdn.hexaglobe.net/f31d32ca80e7af93810eaa12ff2fb0b9/5c234cf7/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8

#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | grep "$keyword" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8


#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2000000,RESOLUTION=1280x720
#ewnsabrenbkp_eng_720p.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1200000,RESOLUTION=960x540
#ewnsabrenbkp_eng_540p.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=750000,RESOLUTION=640x360
#ewnsabrenbkp_eng_360p.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=512000,RESOLUTION=400x224
#ewnsabrenbkp_eng_224p.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=350000,RESOLUTION=320x180
#ewnsabrenbkp_eng_180p.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=200000,RESOLUTION=160x90
#ewnsabrenbkp_eng_90p.m3u8

fi
use_cookies="no"
TAG="EURONEWS_EN__"
chan_name="Euronews English" ;;


# 440)
# Reuters TV
#https://deb05f50f65540958a4bad40060cbbc7.dlvr1.net/rest/v2/playlist/assets/58197,292735,292663,292574,57445,127660,292734,127706,292661,127679,292732,127680,292741,127740,292669,127725,292712,127770,292685,127701,292575,57634/master.m3u8

################################# Entertainment ############################################################
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
# 444) V2Beat
444)
link=https://abr.de1se01.v2beat.live/live/live6/chunks.m3u8
use_cookies="no"
chan_name="V2Beat" ;;

# 445) DanceStar TV
445)
if [ "$getlink" = 1 ]
then
#link=https://vcndstv.teleosmedia.com/stream/dstv/dstv/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3686400,RESOLUTION=1280x720
link=https://vcndstv.teleosmedia.com/stream/dstv/dstv/seglist_720p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=3439489,RESOLUTION=960x540
#link=https://vcndstv.teleosmedia.com/stream/dstv/dstv/seglist_540p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=921600,RESOLUTION=640x360
#link=https://vcndstv.teleosmedia.com/stream/dstv/dstv/seglist_360p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=331776,RESOLUTION=384x216
#link=https://vcndstv.teleosmedia.com/stream/dstv/dstv/seglist_216p.m3u8

fi
####method="Tor"
use_cookies="no"
TAG="DANCESTAR____"
chan_name="DanceStar TV" ;;

# 446) BritAsia TV
446)
link=https://www.dailymotion.com/video/x6s18p8
use_cookies="no"
chan_name="BritAsia TV" ;;

# 447) H!T Music Channel
447)
link=http://1mstream.digicable.hu/hitmusic/hitmusic.m3u8
use_cookies="no"
chan_name="H!T Music Channel" ;;

# 448) California Music Channel
448)
link=https://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMC-TV/chunklist.m3u8
use_cookies="no"
chan_name="California Music Channel" ;;

# 449)  The Country Network
449)
if [ "$getlink" = 1 ]
then
link="https://dcunilive2-lh.akamaihd.net/i/dclive_1@390829/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1288000,RESOLUTION=720x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://dcunilive2-lh.akamaihd.net/i/dclive_1@390829/index_150_av-p.m3u8?sd=6&rebase=on"
fi
use_cookies="no"
TAG="COUNTRY_NETWORK__"
chan_name="The Country Network" ;;

# 450) Ditty TV
450)
if [ "$getlink" = 1 ]
then
#link="https://azroe0x-lh.akamaihd.net/i/test_1@775856/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2536000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://azroe0x-lh.akamaihd.net/i/test_1@775856/index_1000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3536000,RESOLUTION=1280x720,CODECS="avc1.66.30, mp4a.40.2"
#link="https://azroe0x-lh.akamaihd.net/i/test_1@775856/index_2000_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=5036000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
link="https://azroe0x-lh.akamaihd.net/i/test_1@775856/index_3500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1536000,CODECS="mp4a.40.2"
#link="https://azroe0x-lh.akamaihd.net/i/test_1@775856/index_1000_a-p.m3u8?sd=10&rebase=on"
fi
#method="livestreamer"
#format="best"
####method="Tor"
use_cookies="no"
TAG="DITTY______"
chan_name="Ditty TV" ;;

# 451) Rockland Radio TV
451)
channelURL="https://livestream.com/accounts/22300522/events/6680139"
liveStreamGrab

use_cookies="no"
chan_name="Rockland Radio TV" ;;

# 452) Classic ARTS
452)
if [ "$getlink" = 1 ]
then
# Classic ARTS
# link=https://classicarts.global.ssl.fastly.net/live/cas/master.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=745800,AVERAGE-BANDWIDTH=745800,CODECS="avc1.42c015,mp4a.40.2",RESOLUTION=430x240,FRAME-RATE=29.970
#link="https://classicarts.global.ssl.fastly.net/live/cas/master_550k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1240800,AVERAGE-BANDWIDTH=1240800,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970
#link="https://classicarts.global.ssl.fastly.net/live/cas/master_1000k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1790800,AVERAGE-BANDWIDTH=1790800,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970
#link="https://classicarts.global.ssl.fastly.net/live/cas/master_1500k.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3440800,AVERAGE-BANDWIDTH=3440800,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970
link="https://classicarts.global.ssl.fastly.net/live/cas/master_3000k.m3u8"
fi
#method="livestreamer"
#format="best"
####method="Tor"   Route through USA
use_cookies="no"
TAG="CLASS_ARTS__"
chan_name="Classic ARTS" ;;
################################################################################
############################# FASHION ##########################################################
# 453) Fashion TV Europe
453)
link=http://www.dailymotion.com/video/x3m6nld
use_cookies="no"
chan_name="Fashion TV Europe" ;;
# 454) Jasmin TV
454)
#link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8
#link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/chunklist_w1121252134.m3u8
link=http://109.71.162.112:1935/live/sd.jasminchannel.stream/chunklist.m3u8
use_cookies="no"
chan_name="Jasmin TV" ;;
#############################################################
###############################   SPORTS   ######################################################
# 455) MLB Network
455)
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
# 456) RED BULL TV
456)
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
#link="https://www.twitch.tv/redbull"
use_cookies="no"
chan_name="RED BULL TV" ;;
# 457) CBS Sports Desktop
457)
if [ "$getlink" = 1 ]
then
#link="https://sportshq-mediapackage-cedexis.cbsaavideo.com/out/v1/be87d7783e5c4270a5830ea5d1164850/desktop.m3u8"
link="https://sportshq-mediapackage-cedexis.cbsaavideo.com/out/v1/be87d7783e5c4270a5830ea5d1164850/desktop_3.m3u8"
#link="https://sportshq-mediapackage-cedexis.cbsaavideo.com/out/v1/be87d7783e5c4270a5830ea5d1164850/desktop_2.m3u8"
#link="https://sportshq-mediapackage-cedexis.cbsaavideo.com/out/v1/be87d7783e5c4270a5830ea5d1164850/desktop_1.m3u8"
fi
#method="livestreamer"
#format="best"
####method="Tor"   Route through USA
use_cookies="no"
TAG="CBS_SPORTS_HQ__"
chan_name="CBS Sports HQ" ;;
# 458)Eleven Sports Next
458)
link=https://www.twitch.tv/elevensportsnext
#####method="Tor"
use_cookies="no"
chan_name="Eleven Sports Next";;
# 459) Sorgatronmedia
459)
link=https://www.twitch.tv/sorgatronmedia
use_cookies="no"
####method="Tor"
chan_name="Sorgatronmedia";;

#################### REALITY / LIVE ACTION #########################
#  460) Adult Swim
460)
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
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer6.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5570400,CODECS="avc1.4d4028,mp4a.40.5",RESOLUTION=1920x1080
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer7.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=140800,CODECS="mp4a.40.2"
#link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master_Layer8.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;

# 461) Geek and Sundry
461)
link=https://www.twitch.tv/geekandsundry
use_cookies="no"
####method="Tor"
chan_name="Geek and Sundry";;

############### TV SHOWS   ######################################
# 462)CON TV
462)
link=https://www.twitch.tv/contv
#####method="Tor"
use_cookies="no"
chan_name="CON TV";;
# 463)Shout Factory TV
463)
link=https://www.twitch.tv/shoutfactorytv
#####method="Tor"
use_cookies="no"
chan_name="Shout Factory TV";;
# 464)RETRO TV
464)
link=http://247retrotv.com:1935/live/smil:247retro.smil/playlist.m3u8
#####method="Tor"
use_cookies="no"
chan_name="Retro TV";;
# 465)ROBOT CHICKEN
465)
link=https://adultswim-vodlive.cdn.turner.com/live/robot-chicken/stream.m3u8
#####method="Tor"
use_cookies="no"
chan_name="ROBOT CHICKEN";;
# 466) POP TV
466)
if [ "$getlink" = 1 ]
then
link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=5640800,AVERAGE-BANDWIDTH=5640800,CODECS="avc1.64001f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master_5000.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2890800,AVERAGE-BANDWIDTH=2890800,CODECS="avc1.64001f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master_2500.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2120800,AVERAGE-BANDWIDTH=2120800,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1390400,AVERAGE-BANDWIDTH=1390400,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master_1200.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=730400,AVERAGE-BANDWIDTH=730400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970
#link="https://bcsecurelivehls-i.akamaihd.net/hls/live/505785/5367332899001/master_600.m3u8"

fi
####method="Tor"
use_cookies="no"
TAG="POP_TV___"
chan_name="Pop TV";;

##################### CELEB NEWS ####################################
# 467)Entertainment Tonight ET Live
467)
if [ "$getlink" = 1 ]
then
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest.m3u8"

link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/$(curl "https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest.m3u8" | grep m3u8 | tail -n 1)"

#EXT-X-STREAM-INF:BANDWIDTH=497952,AVERAGE-BANDWIDTH=347440,RESOLUTION=400x224,FRAME-RATE=15.000,CODECS="avc1.4D400C,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_75.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=761965,AVERAGE-BANDWIDTH=512458,RESOLUTION=512x288,FRAME-RATE=15.000,CODECS="avc1.4D4015,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_76.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1641934,AVERAGE-BANDWIDTH=1062422,RESOLUTION=640x360,FRAME-RATE=30.000,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_77.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=3225965,AVERAGE-BANDWIDTH=2052458,RESOLUTION=960x540,FRAME-RATE=30.000,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_78.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=6217934,AVERAGE-BANDWIDTH=3922422,RESOLUTION=1280x720,FRAME-RATE=30.000,CODECS="avc1.4D401F,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_79.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=8857965,AVERAGE-BANDWIDTH=5572458,RESOLUTION=1920x1080,FRAME-RATE=30.000,CODECS="avc1.4D4028,mp4a.40.2"
#link="https://etlive-mediapackage-fastly.cbsaavideo.com/dvr/manifest_80.m3u8"

fi
#####method="Tor"
use_cookies="no"
chan_name="Entertainment Tonight ET Live";;
#########################################################################################################################################3
# 468) Amouranth
468)
link="https://www.twitch.tv/amouranth"
use_cookies="no"
####method="Tor"
chan_name="Amouranth";;

# 469) All Key shop
469)
link=https://www.twitch.tv/allkeyshop_tv
use_cookies="no"
####method="Tor"
chan_name="All Key Shop";;

#################### ANIMATION ##############################
# 470) Talking Tom and Friends
470)
keyword="LIVE"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"


channelURL="https://www.youtube.com/user/TalkingFriends/videos?&view=2"
youTubeGrab


use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 471) Talking Tom and Friends Minis
471)
keyword="LIVE"

channelURL="https://www.youtube.com/user/TalkingTomCat/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Talking Tom Minis" ;;
# 472) PJ Masks
472)
keyword="PJ"

channelURL="https://www.youtube.com/channel/UCY2jUnU118sVkdj2xafiJ0g/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="PJ Masks" ;;


# 473) TYT
473)
if [ "$getlink" = 1 ]
then
link="https://www.twitch.tv/tyt"
use_cookies="no"
fi
##method="Tor"
TAG="TYT"
chan_name="The Young Turks TYT" ;;




############################### USTREAM  ##################################################
# 479) NASA TV Media
479)
keyword="Media"
## https://www.nasa.gov/multimedia/nasatv/#media
#link="https://nasa-i.akamaihd.net/hls/live/253565/NASA-NTV1-Public/master.m3u8"
#link="https://nasa-i.akamaihd.net/hls/live/253565/NASA-NTV1-Public/master_2000.m3u8"
#link="http://hls.ums.ustream.tv/playlist/directhls/channel/6540154/playlist.m3u8"
link="http://iphone-streaming.ustream.tv/uhls/6540154/streams/live/iphone/playlist.m3u8"
#link=http://www.ustream.tv/channel/nasa-media-channel
# method="Streamlink"
#format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;;
# 480) NASA TV Public Education
480)
keyword="NASA TV Public-Education"
## https://www.nasa.gov/multimedia/nasatv/#public
#link=http://www.ustream.tv/nasahdtv
#link="https://nasa-i.akamaihd.net/hls/live/253566/NASA-NTV2-Media/master.m3u8"
#link="https://nasa-i.akamaihd.net/hls/live/253566/NASA-NTV2-Media/master_2000.m3u8"
link="http://iphone-streaming.ustream.tv/uhls/10414700/streams/live/iphone/playlist.m3u8"
#method="Streamlink"
#format="720p"
#252p (worst), 360p, 486p, 720p (best)
### YOUTUBE LINK ###
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="NASA TV Public-Education" ;;
##################################################

######################################  RELIGIOUS PROGRAMMING   ###################################################
# 481) Vatican Media
481)
keyword="Live"

channelURL="https://www.youtube.com/user/vatican/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Vatican Media" ;;
# 482) EWTN English
482)
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
#link="https://zm6gdaxeyn93-hls-live.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/index.m3u8"
link="https://zm6gdaxeyn93-hls-live.5centscdn.com/slworld/d65ce2bdd03471fde0a1dc5e01d793bb.sdp/chunks.m3u8"

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
channelURL="https://livestream.com/accounts/19963560/events/5721749"
liveStreamGrab
use_cookies="no"
chan_name="CTND Catholic Television Network Detroit" ;;
# 489) Shalom Media Catholic USA
489)
channelURL="https://livestream.com/shalomworld/events/7359508"
liveStreamGrab
use_cookies="no"
chan_name="Shalom Media Catholic USA" ;;
# 490) Shalom Media Catholic Australia
490)
channelURL="https://livestream.com/shalomworld/events/7551704"
liveStreamGrab
use_cookies="no"
chan_name="Shalom Media Catholic Australia" ;;
# 491) Shalom Media Catholic Europe
491)
channelURL="https://livestream.com/accounts/25038049/events/7358643"
liveStreamGrab
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
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_800_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
#link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1328000,RESOLUTION=720x404,CODECS="avc1.77.30, mp4a.40.2"
link="http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/index_1200_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="KtO Catholique" ;;
######################## POLAND #################################
# 495) TRWAM Poland
495)
#link="https://trwamtv.live.e57-po.insyscd.net/cl01/out/u/trwam.mpd"
#link="https://trwamtv.live.e57-po.insyscd.net/cl01/out/u/trwam.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=646449,RESOLUTION=426x240,CODECS="avc1.4D4015,mp4a.40.2"
#link="https://trwamtv.live.e57-po.insyscd.net/cl01/out/u/trwam_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1240417,RESOLUTION=640x360,CODECS="avc1.4D401E,mp4a.40.2"
#link="https://trwamtv.live.e57-po.insyscd.net/cl01/out/u/trwam_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1900417,RESOLUTION=854x480,CODECS="avc1.4D401E,mp4a.40.2"
link="https://trwamtv.live.e57-po.insyscd.net/cl01/out/u/trwam_3.m3u8"

#link=https://trwamtv.live.e55-po.insyscd.net/trwamtv2.smil/chunklist.m3u8
#link="https://trwamtv.live.e55-po.insyscd.net/trwamtv2.smil/chunklist.m3u8"
use_cookies="no"
chan_name="TRWAM TV 2 Poland" ;;

#########################  CHRISTIAN ################################################
# 496) CBN
496)
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
# 497)CBN News
497)
#link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_150_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=480x270,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_150_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=664000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_500_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_900_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=854x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/index_900_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="CBN News" ;;
# 498)NRB Network
498)
#link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/chunklist_w1520783238.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 499) Trinity Channel
499)
link=http://rtmp1.abnsat.com/hls/trinity.m3u8
use_cookies="no"
chan_name="Trinity Channel" ;;
# 500) International House of Prayer (IHOP) (Christian)
500)
keyword="Live"

link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/playlist.m3u8"

#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="aud",NAME="English",DEFAULT=YES,AUTOSELECT=YES,LANGUAGE="eng",URI="audio_0_eng.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=480x270,AUDIO="aud"
#link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/video_3.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1457843,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=848x480,AUDIO="aud"
#link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/video_2.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2368507,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1280x720,AUDIO="aud"
#link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/video_1.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=4211320,CODECS="avc1.640029,mp4a.40.2",RESOLUTION=1920x1080,AUDIO="aud"
#link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/video_0.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=260353,CODECS="mp4a.40.2",AUDIO="aud"
#link="https://storage.sardius.media/archives/-K6FGrVYzVr92SDZiDnc/events/site_68FBe1c2dE/audio_0_eng.m3u8cat: '~': Is a directory

#channelURL="https://www.youtube.com/user/IHOPkc/videos?&view=2" 
#youTubeGrab

use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 501) Amazing Facts TV (Christian
501)
keyword="AFTV"
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/master.m3u8
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1134820847.m3u8

channelURL="https://www.youtube.com/user/AmazingFacts/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 502) It's Supernatural! Network (Christian)
502)
keyword="Supernatural"

channelURL="https://www.youtube.com/user/SidRoth/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 503) Shepherd's Chapel, Gravette Arkansas
503)
keyword="Chapel"
#link="https://livestream.com/accounts/14403440/events/4227022"

channelURL="https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Shepherd's Chapel, Gravette Arkansas" ;;
# 504) Belivers Voice of Victory Network
504)
keyword="Live"

channelURL="https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 505) Three Angels BroadCasting
505)
keyword="Live"
#link=http://moiptvus-lh.akamaihd.net:80/i/3abnlive_1@328342/index_800_av-p.m3u8

channelURL="https://www.youtube.com/user/3ABNVideos/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Three Angels Broadcasting Network" ;;
# 506) 3ABN Latino
506)
keyword="Live"

channelURL="https://www.youtube.com/user/3abnlatino/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="3ABN Latino" ;;
# 507) 3ABN Francais
507)
#link="http://aos01.3abn.adaptive.level3.net/hls-live/mediaoppremux-fre_multi/_definst_/live/stream3.m3u8"
keyword="Live"

channelURL="https://www.youtube.com/channel/UCMgaz88skVo7HF6ZWlioetw/videos"
youTubeGrab

use_cookies="no"
chan_name="3ABN Francais" ;;
# 508) LLBN Smart Livestyle TV
508)
keyword="Live"
link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_1200_av-p.m3u8?sd=10&set-akamai-hls-revision=5&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_700_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXTM3U
#EXT-X-STREAM-INF:BANDWIDTH=522665,RESOLUTION=320x240,CODECS="avc1.42001e, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_300_av-p.m3u8?sd=10&rebase=on&set-akamai-hls-revision=5&rebase=on"
#EXT-X-STREAM-INF:BANDWIDTH=1102504,RESOLUTION=480x360,CODECS="avc1.42001e, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_700_av-p.m3u8?sd=10&rebase=on&set-akamai-hls-revision=5&rebase=on"
#EXT-X-STREAM-INF:BANDWIDTH=1462188,RESOLUTION=640x480,CODECS="avc1.42001e, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SmartLifeStyle_1@692079/index_1200_av-p.m3u8?sd=10&rebase=on&set-akamai-hls-revision=5&rebase=on"
#live=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="LLBN Smart Lifestyle TV" ;;

# 509) LLBN His Word TV
509)
keyword="Live"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisWord_1@692072/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisWord_1@692072/index_500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisWord_1@692072/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1496000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587HisWord_1@692072/index_1400_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN His Word TV" ;;

# 510) LLBN His Light TV
510)
keyword="Live"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisLight_1@692073/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=564000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisLight_1@692073/index_500_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587HisLight_1@692073/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1496000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587HisLight_1@692073/index_1400_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN His Light TV" ;;

# 511) #LLBN Latino TV
511)
keyword="Live"
#https://t01587-lh.akamaihd.net/i/t01587Latino_1@692077/index_1200_av-p.m3u8?sd=10&set-akamai-hls-revision=5&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Latino_1@692077/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Latino_1@692077/index_700_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587Latino_1@692077/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN Latino TV" ;;

# 512) Salt and Light TV Portage Michigan
512)
keyword="Salt"

channelURL="https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;;
# 513) Harbor Light Radio
513)
keyword="Harbour Light Radio Live Stream"

channelURL="https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Harbor Light Radio" ;;
# 514) St. Marys and St. Antonios Coptic
514)
keyword="Live"

channelURL="https://www.youtube.com/channel/UClk9kRoKydqQgZb6bG6GQ-g/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="St. Marys and St. Antonios Coptic" ;;
# 515) Word of God Greek
515)
keyword="Word"

channelURL="https://www.youtube.com/user/WordofGodGreece/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Word of God Greek" ;;
# 516) Shalom Media Catholic America
516)

channelURL="https://livestream.com/shalomworld/events/7511845"
liveStreamGrab

use_cookies="no"
chan_name="Shalom Media Catholic America"  ;;
# 517) Shalom Media Catholic India
517)

channelURL="https://livestream.com/shalomworld/events/7483919"
liveStreamGrab

use_cookies="no"
chan_name="Shalom Media Catholic India" ;;
# 518) Powervision TV
518)
keyword="POWERVISION"

channelURL="https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Powervision TV" ;;

# 519) #LLBN Arabic TV
519)
keyword="Live"
#https://t01587-lh.akamaihd.net/i/t01587Arabic_1@692074/segment1562510758_1200_av-p.ts?sd=10&rebase=on&set-akamai-hls-revision=5
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Arabic_1@692074/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=480x360,CODECS="avc1.66.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587Arabic_1@692074/index_700_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=640x480,CODECS="avc1.66.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587Arabic_1@692074/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN Arabic TV" ;;

# 520) #LLBN South Asian TV
520)
keyword="Live"
#https://t01587-lh.akamaihd.net/i/t01587SouthAsia_1@692078/index_1200_av-p.m3u8?sd=10&set-akamai-hls-revision=5&rebase=on
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=320x240,CODECS="avc1.77.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SouthAsia_1@692078/index_300_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=764000,RESOLUTION=480x360,CODECS="avc1.77.30, mp4a.40.2"
#link="https://t01587-lh.akamaihd.net/i/t01587SouthAsia_1@692078/index_700_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1264000,RESOLUTION=640x480,CODECS="avc1.77.30, mp4a.40.2"
link="https://t01587-lh.akamaihd.net/i/t01587SouthAsia_1@692078/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="LLBN South Asian TV" ;;

###################  MIXER    ###################
# 521) Vatican Media English
521)

channelURL="https://www.youtube.com/channel/UCxIsefyl9g9A5SGWA4FvGIA/videos"
youTubeGrab

use_cookies="no"
chan_name="Vatican Media English" ;;
# 522) Vatican Media Deutsch
522)
keyword="Live"

channelURL="https://www.youtube.com/user/vaticande/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Vatican Media Deutsch" ;;
# 523) Vatican Media Italiano
523)
keyword="Live"

channelURL="https://www.youtube.com/user/vaticanit/videos?&view=2"
youTubeGrab

use_cookies="no"
chan_name="Vatican Media Italiano" ;;
# 524) Temple Institute
524)

channelURL="https://www.youtube.com/user/henryporter2/videos"
youTubeGrab

use_cookies="no"
chan_name="Temple Institute" ;;

# 525) TBN Trinity Broadcasting Network
525)
if [ "$getlink" = 1 ]
then
#link="https://playback.akamaized.net/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media/27460990_8266920_lsiz3pxjnba3hks8ylj_1@5256000p.m3u8?dw=14400&ts=1567468800&hdnts=exp=1567644563~acl=/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media*~hmac=940f2be8c0349913b4d42194db82d97478d319e0212e46e7d82bc184ad4f7e5d"
#link="https://playback.akamaized.net/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media/27460990_8266920_lsiz3pxjnba3hks8ylj_1@2756000p.m3u8?dw=14400&ts=1567468800&hdnts=exp=1567644563~acl=/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media*~hmac=940f2be8c0349913b4d42194db82d97478d319e0212e46e7d82bc184ad4f7e5d"
#link="https://playback.akamaized.net/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media/27460990_8266920_lsiz3pxjnba3hks8ylj_1@1756000p.m3u8?dw=14400&ts=1567468800&hdnts=exp=1567644563~acl=/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media*~hmac=940f2be8c0349913b4d42194db82d97478d319e0212e46e7d82bc184ad4f7e5d"
#link="https://playback.akamaized.net/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media/27460990_8266920_lsiz3pxjnba3hks8ylj_1@628000p.m3u8?dw=14400&ts=1567468800&hdnts=exp=1567644563~acl=/streams/27460990_8266920_lsiz3pxjnba3hks8ylj_1/media*~hmac=940f2be8c0349913b4d42194db82d97478d319e0212e46e7d82bc184ad4f7e5d"
#link="https://playback.akamaized.net/streams/27460990_8266920_lsitwxhabuqtncqkzd7_1/media/27460990_8266920_lsitwxhabuqtncqkzd7_1@5256000p.m3u8?dw=14400&ts=1567494000&hdnts=exp=1567667255~acl=/streams/27460990_8266920_lsitwxhabuqtncqkzd7_1/media*~hmac=09e0ad290a8d37dadbf68253ba7e3f21299827c5c1b2bc1792e06f878db20a1e"

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266920/"
# set the link
liveStreamGrab


fi
use_cookies="no"
chan_name="TBN" ;;

# 526) TBN UK Trinity Broadcasting Network UK
526)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8287186/"
# set the link
liveStreamGrab


fi
use_cookies="no"
chan_name="TBN UK" ;;

# 527) Hillsong Channel
527)
if [ "$getlink" = 1 ]
then
#link="https://playback.akamaized.net/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media/27460990_8266909_lsiq50tdwb1wkk0ha08_1@5256000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646574~acl=/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media*~hmac=4978fffd3d4cc1fa4ab660d036e0365fe499e032b5353aa5aef6dcbc684290a4"
#link="https://playback.akamaized.net/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media/27460990_8266909_lsiq50tdwb1wkk0ha08_1@2756000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646574~acl=/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media*~hmac=4978fffd3d4cc1fa4ab660d036e0365fe499e032b5353aa5aef6dcbc684290a4"
#link="https://playback.akamaized.net/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media/27460990_8266909_lsiq50tdwb1wkk0ha08_1@1756000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646574~acl=/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media*~hmac=4978fffd3d4cc1fa4ab660d036e0365fe499e032b5353aa5aef6dcbc684290a4"
#link="https://playback.akamaized.net/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media/27460990_8266909_lsiq50tdwb1wkk0ha08_1@628000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646574~acl=/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/media*~hmac=4978fffd3d4cc1fa4ab660d036e0365fe499e032b5353aa5aef6dcbc684290a4"
#https://player-api.new.livestream.com/accounts/27460990/events/8266909/broadcasts/195799744.secure.m3u8?dw=14400&hdnea=st=1567495476~exp=1567497276~acl=/i/27460990_8266909_lsiq50tdwb1wkk0ha08_1@446541/*~hmac=98879b74432bcbb3a278cc763b22a7ddfb593e59cd710526cd1db28444a2439c&token=5d6e1660_95424f6ca14b06332b3019b367990a78d4b41d9d
#https://playback.akamaized.net/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/master.m3u8?dw=14400&hdnts=exp=1567496076~acl=/streams/27460990_8266909_lsiq50tdwb1wkk0ha08_1/master.m3u8*~hmac=e70da62168652b46bdded48f2ec499f4fe3aba5a1e3e984765a8640d85d53fb3

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266909/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Hillsong Channel" ;;

# 528) TCI Italian
528)
if [ "$getlink" = 1 ]
then
#link="https://playback.akamaized.net/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media/27460990_8287184_lsimu6y3fl7qtimwaft_1@2756000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646362~acl=/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media*~hmac=a38263cebb7fb447a44890e56caca7385b86a6e81ee2e0035dd1951715d8cf1e"
#link="https://playback.akamaized.net/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media/27460990_8287184_lsimu6y3fl7qtimwaft_1@1756000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646362~acl=/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media*~hmac=a38263cebb7fb447a44890e56caca7385b86a6e81ee2e0035dd1951715d8cf1e"
#link="https://playback.akamaized.net/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media/27460990_8287184_lsimu6y3fl7qtimwaft_1@628000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567646362~acl=/streams/27460990_8287184_lsimu6y3fl7qtimwaft_1/media*~hmac=a38263cebb7fb447a44890e56caca7385b86a6e81ee2e0035dd1951715d8cf1e"

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8287184/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="TCI Italian" ;;

# 529) Enlace Latino
529)
if [ "$getlink" = 1 ]
then
#link="https://playback.akamaized.net/streams/27460990_8266905_lsit7y7y0rp8l9kg25c_1/media/27460990_8266905_lsit7y7y0rp8l9kg25c_1@1756000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567647563~acl=/streams/27460990_8266905_lsit7y7y0rp8l9kg25c_1/media*~hmac=d4270a13b3127232472f586e25a3edf03a4dbb9685312490227eca1887855021"
#link="https://playback.akamaized.net/streams/27460990_8266905_lsit7y7y0rp8l9kg25c_1/media/27460990_8266905_lsit7y7y0rp8l9kg25c_1@628000p.m3u8?dw=14400&ts=1567472400&hdnts=exp=1567647563~acl=/streams/27460990_8266905_lsit7y7y0rp8l9kg25c_1/media*~hmac=d4270a13b3127232472f586e25a3edf03a4dbb9685312490227eca1887855021"
#link="$( curl "https://player-api.new.livestream.com/accounts/27460990/events/8266905/"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"

#link="https://livestream.com/accounts/2675843/enlace"
#link="$( curl "https://livestream.com/accounts/2675843/enlace"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"

channelURL= "https://livestream.com/accounts/2675843/enlace"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Enlace Latino" ;;

# 530) Salsa
530)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266915/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Salsa" ;;

# 531) Smile of a Child
531)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266916/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Smile" ;;

# 532) JUCE TV
532)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266912/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="JUCE TV" ;;

# 533) Nejat TV Arabic
533)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266913/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Nejat TV Arabic" ;;

# 534) Al Horreya Arabic
534)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266904/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="Al Horreya Arabic" ;;

# 535) EJTV Latino
535)
if [ "$getlink" = 1 ]
then

channelURL="https://player-api.new.livestream.com/accounts/27460990/events/8266929/"
# set the link
liveStreamGrab

fi
use_cookies="no"
chan_name="EJTV" ;;

# 536) BYUTV
#536)
#if [ "$getlink" = 1 ]
#then
#"https://byubroadcasting.hb.omtrdc.net/?s:sc:rsid=byutvprod&s:sc:tracking_server=byubroadcasting.sc.omtrdc.net&h:sc:ssl=1&s:user:mid=61234542045940268791717607808247955647&s:user:id=96e4100e-6d79-40e4-bf28-5fc75850610f&s:aam:blob=6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y&l:aam:loc_hint=9&s:sp:channel=BYUtv&s:sp:player_name=BYUtv VOD Player&s:sp:hb_version=js-2.0.1.88-c8c0b1&l:sp:hb_api_lvl=4&s:event:sid=1567475921052861134551&s:event:type=start&l:event:duration=10000&l:event:playhead=0&l:event:ts=1567476596296&l:event:prev_ts=1567476586296&s:asset:type=main&s:asset:name=Schlesinger Family - Striking a Chord&s:asset:video_id=581eb7fd-efa9-48db-b1b3-6eb3cf936c03&s:asset:publisher=8ACB7D44536B846F0A490D4D@AdobeOrg&l:asset:length=0&s:stream:type=vod&l:stream:bitrate=0&l:stream:fps=0&l:stream:dropped_frames=0&l:stream:startup_time=0"
#fi
#use_cookies="no"
#chan_name="BYUTV" ;;

###################################
# 559)
# 560)


################## MENU 3   ##################
########################## CBC CANADA #################################
# 561) CBC News Network
561)
link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master6.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master5.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master4.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master3.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master2.m3u8"
#link="https://livecbcdai-i.akamaihd.net/hls/live/567245/event2/CBCNN/master1.m3u8"
use_cookies="no"
chan_name="CBC News Network " ;;

# 562) CBC Vancouver BC Canada
562)
link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master5.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master4.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master3.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master2.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566968/event2/CBUT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Vancouver, British Columbia, Canada ";;

# 563) CBC Yellowknife North West Territories Canada
563)
link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master5.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master4.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master3.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master2.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567240/event2/CFYK/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Yellowknife, Northwest Territories, Canada ";;

# 564) CBC Edmonton Alberta Canada
564)
link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master5.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master4.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master3.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master2.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567231/event2/CBXT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Edmonton, Alberta,  Canada ";;

# 565) CBC Calgary Alberta Canada
565)
link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master5.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master4.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master3.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master2.m3u8"
#link="https://cbclivedai4-i.akamaihd.net/hls/live/567230/event2/CBRT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Calgary, Alberta, Canada ";;

# 566) CBC Regina Saskatchewan  Canada
566)
link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master5.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master4.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master3.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master2.m3u8"
#link="https://cbclivedai2-i.akamaihd.net/hls/live/566969/event2/CBKT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Regina Saskatchewan Canada ";;

# 567) CBC Winnepeg Manitoba Canada
567)
link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master5.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master4.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master3.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master2.m3u8"
#link="https://cbclivedai6-i.akamaihd.net/hls/live/567237/event2/CBWT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Winnepeg, Manitoba, Canada ";;

# 568) CBC Windsor Ontario Canada
568)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Windsor, Ontario, Canada ";;

# 569) CBC Toronto Ontario Canada
569)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566940/event2/CBLT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Toronto, Ontario, Canada ";;

# 570) CBC Ottawa Ontario Canada
570)
link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567235/event2/CBOT/master1.m3u8"
#link="http://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Ottawa Canada";;

# 571) CBC Montreal Quebec Canada
571)
link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master5.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master4.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master3.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master2.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566976/event2/CBMT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Montreal, Quebec, Canada ";;

# 572) CBC Frederickton New Brunswick Canada
572)
link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master5.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master4.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master3.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master2.m3u8"
#link="https://cbclivedai7-i.akamaihd.net/hls/live/567244/event2/CBAT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Frederickton, New Brunswick, Canada ";;

# 573) CBC Charlottetown Prince Edward Island Canada
573)
link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master5.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master4.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master3.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master2.m3u8"
#link="https://cbclivedai1-i.akamaihd.net/hls/live/566941/event2/CBET/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Charlottetown, Prince Edward Island, Canada ";;

# 574) CBC Halifax Nova Scotia Canada
574)
link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master5.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master4.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master3.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master2.m3u8"
#link="https://cbclivedai3-i.akamaihd.net/hls/live/566977/event2/CBHT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC Halifax, Nova Scotia, Canada ";;

# 575) CBC St. John's Newfoundland Canada
575)
link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master5.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master4.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master3.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master2.m3u8"
#link="https://cbclivedai5-i.akamaihd.net/hls/live/567236/event2/CBNT/master1.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC St. John's, Newfoundland, Canada ";;

# 576) Global Vancouver
576)
#link="https://glblvestu-f.akamaihd.net/i/glblvPSTu_1@80128/master.m3u8"
link="$(curl -A "$UA" "https://glblvestu-f.akamaihd.net/i/glblvPSTu_1@80128/master.m3u8" | grep 1350 | head -n 1 ) "
use_cookies="no"
chan_name="Global Vancouver" ;;

# 577 Global Calgary
577)
#link="https://glblvmstu-f.akamaihd.net/i/glblvMSTu_1@80127/master.m3u8"
link="$(curl -A "$UA" "https://glblvmstu-f.akamaihd.net/i/glblvMSTu_1@80127/master.m3u8" | grep 1350 | head -n 1 ) "
use_cookies="no"
chan_name="Global Calgary" ;;

# 578) Global Edmonton
578)
#link="https://glblvedmonton-lh.akamaihd.net/i/glblvEdmonton_1@119844/master.m3u8"
link="$(curl -A "$UA" "https://glblvedmonton-lh.akamaihd.net/i/glblvEdmonton_1@119844/master.m3u8" | grep 1350 | head -n 1 ) "
use_cookies="no"
chan_name="Global Edmonton" ;;

# 579) Global Toronto
579)
#link="https://glblvestu-f.akamaihd.net/i/glblvestu_1@78149/master.m3u8"
link="$(curl -A "$UA" "https://glblvestu-f.akamaihd.net/i/glblvestu_1@78149/master.m3u8" | grep 1350 | head -n 1 ) "
use_cookies="no"
chan_name="Global Toronto" ;;

# 580) Global Halifax
580)
#link="https://glblvhalifax-lh.akamaihd.net/i/glblvHalifax_1@119843/master.m3u8"
link="$(curl -A "$UA" "https://glblvhalifax-lh.akamaihd.net/i/glblvHalifax_1@119843/master.m3u8" | grep 1350 | head -n 1 ) "
use_cookies="no"
chan_name="Global Halifax" ;;


# 581) NTV Newfoundland
581)
if [ "$getlink" = 1 ]
then
link=http://1-fss-fso35.streamhoster.com/lv_ntv/_definst_/broadcast1/chunklist.m3u8
fi
use_cookies="no"
chan_name="NTV Newfoundland" ;;

# 582) Tele-Quebec
582)
link="https://teleqmmd.mmdlive.lldns.net/teleqmmd/f386e3b206814e1f8c8c1c71c0f8e748/chunklist_b2592000.m3u8"
use_cookies="no"
chan_name="Tele-Quebec" ;;

# 583) Tele-V
583)
link="https://bcsecurelivehls-i.akamaihd.net/hls/live/551061/618566855001/master.m3u8"
use_cookies="no"
chan_name="Tele-V" ;;

# 584)  ICI Tele CB-Yukon
584)
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704017/cancbuft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele CB-Yukon" ;;

# 585)  ICI Tele Alberta
585)
#link="https://rcavlive.akamaized.net/hls/live/704020/cancbxft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Alberta" ;;

# 586)ICI Tele Saskatchewan
586)
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704019/cancbkft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Saskatchewan" ;;

# 587) ICI Tele Manitoba
587)
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704018/cancbwft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Manitoba" ;;

# 588)ICI Tele Ontario
588)
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704022/cancblft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Ontario" ;;

# 593)ICI Tele Ottawa-Gatineau
593)
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/664046/cancboft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Ottawa-Gatineau" ;;

# 589)  ICI Tele Acadie
589)
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master.m3u8"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_2500.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704014/cancbaft/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Acadie" ;;

# 590) ICI Tele Estrie
590)
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704016/cancksh/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Estire" ;;

# 591)ICI Tele Mauricie
591)
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704021/cancktm/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Mauricie" ;;

# 592)ICI Tele Montreal
592)
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_2500.m3u8"
link="https://rcavlive-dai.akamaized.net/hls/live/696614/cancbftprem/master_5000.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Montreal" ;;

# 593)ICI Tele Saguenay
593)
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704023/cancktv/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Saguenay" ;;

# 594)ICI Tele Quebec
594)
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/664045/cancbvt/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Quebec" ;;

# 595) ICI Tele Est-Quebec
595)
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=281600,AVERAGE-BANDWIDTH=281600,CODECS="avc1.42c00c,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=14.985,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_256.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=440000,AVERAGE-BANDWIDTH=440000,CODECS="avc1.42c00d,mp4a.40.2",RESOLUTION=320x180,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_400.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=770000,AVERAGE-BANDWIDTH=770000,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_700.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1210000,AVERAGE-BANDWIDTH=1210000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_1100.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1980000,AVERAGE-BANDWIDTH=1980000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
#link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_1800.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=2750000,AVERAGE-BANDWIDTH=2750000,CODECS="avc1.4d401f,mp4a.40.2",RESOLUTION=1280x720,FRAME-RATE=29.970,AUDIO="program_audio",CLOSED-CAPTIONS="CC"
link="https://rcavlive.akamaized.net/hls/live/704024/cancjbr/master_2500.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_fr",AUTOSELECT=YES,DEFAULT=YES,URI="master_128.m3u8"
#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="program_audio",LANGUAGE="fra",NAME="audio_frdv",AUTOSELECT=YES,DEFAULT=NO,URI="master_dv.m3u8"
use_cookies="no"
chan_name="ICI Tele Est-Quebec" ;;

# 597) CityLine CA
597)
#link="https://bthlsamd-i.akamaihd.net/hls/live/621265/BTTOR_HLSAMD/1203be152b3208dae6341ec155726363/3.m3u8"
link="https://bthlsamd-i.akamaihd.net/hls/live/621265/BTTOR_HLSAMD/1203be152b3208dae6341ec155726363/2.m3u8"
#link="https://bthlsamd-i.akamaihd.net/hls/live/621265/BTTOR_HLSAMD/1203be152b3208dae6341ec155726363/1.m3u8"
use_cookies="no"
chan_name="CityLine CA" ;;

# 598) CBC News Montreal Canada
598)
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_2500_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_1800_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_700_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_400_av-p.m3u8?sd=10&rebase=on"
link="https://cbcnewshd-f.akamaihd.net/i/cbcregional_1@141286/index_256_av-p.m3u8?sd=10&rebase=on"
#link="http://cbcnewshd-f.akamaihd.net/i/cbcnews_1@8981/index_2500_av-p.m3u8"
#####method="Tor"
use_cookies="no"
chan_name="CBC News, Montreal, Canada";;

#Hard Knocks TV: https://vcnboutsports.teleosmedia.com/stream/boutsports/boutsports/playlist.m3u8

## CTV
## https://capi.9c9media.com/destinations/ctvnews_web/platforms/desktop/contents/64268/contentpackages/22710/manifest.mpd
### https://capi.9c9media.com/destinations/ctvnews_web/platforms/desktop/contents/64268/contentpackages/22710/manifest.mpd
### https://pe-ak-lp02a-9c9media.akamaized.net/live/News1Digi/p/dash/00000001/8e377c581da8df4e/manifest.mpd

##################################################################################################################3

# 600)
#############   ESPANOL EXTRA  #####################################
# 601) VIVE Venezuela
601)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCg6uD_hL72AFeZuMJL5u07w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="VIVE Venezuela" ;;
# 602) Vatican Media
602)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanes/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Vatican Media" ;;
# 603) Televen
602)
keyword="Televen EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcNva2dC9BR8QR_G02xDFqw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Televen Venezuela" ;;
# 604) Impacto USA
604)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/impactotv2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Impacto USA" ;;
# 605) UCVTV CL  Universidad Católica de Valparaíso
605)
keyword="UCVTV EN VIVO"
#link="http://unlimited1-us.dps.live/ucvtv/ucvtv.smil/ucvtv/livestream2/chunks.m3u8?nimblesessionid=14582063"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="UCVTV Chile" ;;
# 606) UCVTV CL  Universidad Católica de Valparaíso
606)
keyword="UCVTV EN VIVO"
link="http://unlimited1-us.dps.live/ucvtv2/ucvtv2.smil/ucvtv2/livestream2/chunks.m3u8?nimblesessionid=14583770"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="UCVTV 2 Chile" ;;
###################################
# 607) Noticiero Univision MX
607)
keyword="Noticiero"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UnivisionNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Noticiero Univision MX" ;;
# 608) Canal 2 Cablenet San Vicente Argentina
608)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 609)Canal 2 Telpintv Pinamar AR
609)
keyword="Telpin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelpinVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Canal 2 Telpintv Pinamar AR" ;;
# 610) Canal 8 Mar del Plata
610)
keyword="Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Canal 8 Mar del Plata Argentina" ;;
# 611) Canal 11 de Salta Argentina
611)
keyword="Salta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCy-r-BQ5BQRU6rzGS73-WBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Canal 11 de Salta Argentina" ;;
# 612) UNITVE AR  Universidad Nacional de Villa Maria, Córdoba ***
612)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_NtgyVHyQJfy3YlM6XdQdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="UNITVE Cordoba AR" ;;
################## PARAGUAY #####################################
# 613) ABC TV Paraguay
613)
keyword="ABC"
link=http://www.ustream.tv/channel/21235831
method="livestreamer"
format="best"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalabctv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="ABC TV Paraguay" ;;
################# BOLIVIA #####################################
# 614) Abya Yala Bolivia  ****
614)
keyword="Abya Yala"
link=https://www.ustream.tv/channel/23484517
method="livestreamer"
format="best"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYVYGzj8t64hFAz2T-udG5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Abya Yala Bolivia" ;;
# 615) UFRO Vision Chile *****
615)
keyword="UFRO"
linkl=https://mdstrm.com/share/live/580a80b827de0ae2086ea6d8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5H9zdp-3M24xWWJunhLJmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="UFRO Vision Chile" ;;
# 616) CAMPO ABIERTO Santiago Chile
616)
keyword="TRANSMISIÓN CAMPO ABIERTO TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwcZwWgpdrF-JsOkquSD59w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="CAMPO ABIERTO Santiago Chile" ;;
# 617) UNITV Universidad Nacional de General Sarmiento AR
617)
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWCJwDsCdRn_pwHNpLwEJcw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="UNITV Universidad Nacional de General Sarmiento AR" ;;
# 618) TelePacifico Colombia  ****
618)
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpywwd47pfQSwBO8pXZwXrw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="TelePacifico Colombia" ;;
# 619) Venevision VE
619)
keyword="Emisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Venevision VE" ;;
# 620) Telediario AR
620)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1-SmZtkXTg2ufhLMpwiRIg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Telediario AR" ;;
# 621) TVeo Canal 41 Cordoba AR
621)
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9kgE-365dvz6zJEUX1dFiw/?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="TVeo Canal 41 Cordoba AR" ;;
# 622) PSN Tijuana Mexico
622)
keyword="PSN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="PSN Tijuana Mexico";;
## 623) Senal de CNN en Espanol
623)
keyword="CNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnenespanolcom/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 629)Euronews Espanol
629)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCRVeQhiqhUAxRRUod7F-K3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="TV Camara Paraguay" ;;
# 632) Tu Canal Panama PA
632)
keyword="directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
# 635) Canal 8 San Juan Argentina
635)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 636) Showsport Cordoba Argentina
636)
keyword="Showsport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CanalShowsport/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Showsport Argentina" ;;
# 637) La Mega Bogotá 90.9 FM CO
637)
#link="https://livestream.com/accounts/13907141/lamegabogota"
link="$( curl "https://livestream.com/accounts/13907141/lamegabogota"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="La Mega Bogotá 90.9 FM CO" ;;
# 638)TV UNAM MX
638)
#link="https://livestream.com/accounts/27177136/events/8157904"
link="$( curl "https://livestream.com/accounts/27177136/events/8157904"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TV UNAM MX" ;;
# 639) Azteca 7 MX
639)
link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_3_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=528000,RESOLUTION=426x240,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=528000,RESOLUTION=426x240,CODECS="avc1.77.30, mp4a.40.2"
#link="http://aztecalive-lh.akamaihd.net/i/0pq46e6vw_1@502477/index_1_av-b.m3u8?sd=10&rebase=on"
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
# 640) Cinevision Canal 19 Dominican Republic
640)
#link="https://livestream.com/accounts/9430235/canal19"
link="$( curl "https://livestream.com/accounts/9430235/canal19"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Cinevision Canal 19 Dominican Republic" ;;

################################ LATINO III ###############################################################
# 641) Nuevolaredo.tv Flujo de Puentes Internacionales nuevo laredo MX
641)
#link="https://livestream.com/accounts/13480210/events/4837379"
link="$( curl "https://livestream.com/accounts/13480210/events/4837379"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Neuvo Larado TV MX" ;;
# 642) Sinart Digital Señal Canal 13 CR
642)
#link="https://livestream.com/accounts/1532727/events/8158158"
link="$( curl "https://livestream.com/accounts/1532727/events/8158158"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Sinart Digital Señal Canal 13 CR " ;;
# 643) BethelTV Bethel Panamá
643)
#link="https://livestream.com/accounts/16567960/events/7963429"
link="$( curl "https://livestream.com/accounts/16567960/events/7963429"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="BethelTV Bethel Panamá" ;;
# 644) Poder de Dios TV La Paz Bolivia
644)
#link="https://livestream.com/accounts/25268891/TV"
link="$( curl "https://livestream.com/accounts/25268891/TV"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Poder de Dios TV La Paz Bolivia" ;;
# 645) GUATEVISION Guatemala
645)
#link="https://livestream.com/accounts/25697071/en-vivo"
link="$( curl "https://livestream.com/accounts/25697071/en-vivo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="GUATEVISION Guatemala" ;;
# 646) Onda Cádiz RTV Spain
646)
#link="https://livestream.com/accounts/22727797/directo"
link="$( curl "https://livestream.com/accounts/22727797/directo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Onda Cádiz RTV Spain" ;;
# 647) Streaming Medios Públicos Señal Nacional
647)
#link="https://livestream.com/accounts/27228685/events/8175786"
link="$( curl "https://livestream.com/accounts/27228685/events/8175786"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Streaming Medios Públicos Señal Nacional" ;;
# 648) Tele Bahia Santo Domingo ,Dominican Republic
648)
#link="https://livestream.com/accounts/18988261/events/7725211"
link="$( curl "https://livestream.com/accounts/18988261/events/7725211"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Tele Bahia Santo Domingo ,Dominican Republic" ;;
# 649)Iglesia Advenimiento del Séptimo Día Advenimiento TV Dallas Texas
649)
#link="https://livestream.com/accounts/13655021/events/4355864"
link="$( curl "https://livestream.com/accounts/13655021/events/4355864"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Advenimiento TV Dallas Texas" ;;
# 650) Expande TV Puebla Mexico
650)
#link="https://livestream.com/accounts/7277442/envivo"
link="$( curl "https://livestream.com/accounts/7277442/envivo"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Expande TV Puebla Mexico" ;;
# 651) Tv Universal Centro de Ayuda Universal Mexico
651)
#link="https://livestream.com/accounts/4486152/oracionmedianoche"
link="$( curl "https://livestream.com/accounts/4486152/oracionmedianoche"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Tv Universal Centro de Ayuda Universal Mexico" ;;
# 652) Canal 27, El Canal de la Esperanza.
652)
#link="https://livestream.com/accounts/13639189/events/6356013"
link="$( curl "https://livestream.com/accounts/13639189/events/6356013"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal 27, El Canal de la Esperanza." ;;
# 653) teleamiga TELEAMIGA INTERNACIONAL
653)
#link="https://livestream.com/accounts/18971084/events/6841479"
link="$( curl "https://livestream.com/accounts/18971084/events/6841479"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TELEAMIGA INTERNACIONAL" ;;
# 654) Politv Poli tv Bogota Colombia
654)
#link="https://livestream.com/accounts/12256908/events/6185792"
link="$( curl "https://livestream.com/accounts/12256908/events/6185792"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Poli tv Bogota Colombia" ;;
# 655) UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina
655)
#link="https://livestream.com/accounts/5198918/events/3229548"
link="$( curl "https://livestream.com/accounts/5198918/events/3229548"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="UNTREF UN3 - Tu mirada no está sola Buenos Aires Argentina " ;;
# 656) Asociación RUAV Univalle - Canal Universitario Cali Colombia
656)
#link="https://livestream.com/accounts/2541970/events/1932032"
link="$( curl "https://livestream.com/accounts/2541970/events/1932032"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Asociación RUAV Univalle - Canal Universitario Cali Colombia" ;;
# 657) Canal JesusTV Guatemala
657)
#link="https://livestream.com/accounts/17608437/events/4834657"
link="$( curl "https://livestream.com/accounts/17608437/events/4834657"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Canal JesusTV Guatemala " ;;
# 658) FGTV Frecuencias de Gloria Jacksonville Florida
658)
#link="https://livestream.com/accounts/3107466/events/3858724"
link="$( curl "https://livestream.com/accounts/3107466/events/3858724"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="FGTV Frecuencias de Gloria Jacksonville Florida" ;;
# 659) El Evangelio Eterno EEE Network en Los Angeles Canal 63.5
659)
#link="https://livestream.com/accounts/116136/EEENet"
link="$( curl "https://livestream.com/accounts/116136/EEENet"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="El Evangelio Eterno EEE Network en Los Angeles Canal 63.5" ;;
# 660) Cosmovision TV Cosmovision HD
660)
#link="https://livestream.com/accounts/16628908/cosmovisionhd"
link="$( curl "https://livestream.com/accounts/16628908/cosmovisionhd"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Cosmovision TV" ;;
# 661) Emisora Virtual Onda Libre Cali CO
661)
#link="https://livestream.com/accounts/2541970/events/5178171"
link="$( curl "https://livestream.com/accounts/2541970/events/5178171"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Emisora Virtual Onda Libre Cali CO " ;;
# 662) Yuma Virtual TV Barrancabermeja CO
662)
#link="https://livestream.com/accounts/17972814/events/6311476"
link="$( curl "https://livestream.com/accounts/17972814/events/6311476"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Yuma Virtual TV Barrancabermeja CO" ;;
# 663) Dominio Radio: En Vivo Mexico
663)
#link="https://livestream.com/accounts/26841641/events/8163521"
link="$( curl "https://livestream.com/accounts/26841641/events/8163521"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Dominio Radio: En Vivo Mexico" ;;
# 664) Señal UNTREF
664)
#link="https://livestream.com/accounts/16129323/events/7659666"
link="$( curl "https://livestream.com/accounts/16129323/events/7659666"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="Señal UNTREF" ;;
# 665)NRT Canal 4 monclova
665)
#link="https://livestream.com/accounts/24089527/events/7172314"
link="$( curl "https://livestream.com/accounts/24089527/events/7172314"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="NRT Canal 4 monclova" ;;
# 666) TVUNAM 20 Transmisión de la Dirección General de Televisión Universitaria
666)
#link="https://livestream.com/accounts/27177136/events/8157904"
link="$( curl "https://livestream.com/accounts/27177136/events/8157904"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
use_cookies="no"
chan_name="TVUNAM 20" ;;
# 667)EVTV Miami
667)
keyword="EVTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elvenezolanotv/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="EVTV Miami" ;;
# 668) Cosmovision TV BO
668)
if [ "$getlink" = 1 ]
then
#link="https://livestream.com/accounts/16628908/cosmovisionhd"
link="$( curl "https://livestream.com/accounts/16628908/cosmovisionhd"| grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
fi
use_cookies="no"
chan_name="Cosmovision BO" ;;


# 680)
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCIxlLEYzjWPLb_CXpc-e74w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="TV Assemblelia" ;;
# 683) TV Canaco Nova
683)
keyword="Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvcancaonova/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="TV Canaco Nova" ;;
# 684) TV Igreja Internacional de Graca
684)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_hwWljVyb_o3yzasx-bG2g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="TV Igreja Internacional de Graca" ;;
# 685) TV Ales Assembleia Legeslativa
685)
keyword="Ales"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alescomunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="TV Ales Assembleia Legeslativa" ;;
# 686) TV Boas Nova
686)
keyword="Play"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/boasnovasoficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="Boas Nova" ;;
# 687) Fundacao Nazzare de Communicaco
687)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FNComunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="Fundacao Nazzare de Communicaco" ;;
# 688) STF Brazil
688)
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Radio Justicia" ;;
# 691) EXA FM 93.9
691)
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="EXA FM 93.9" ;;
# 692) RIT TV BR
692)
keyword="RIT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA0bOG0NUfJ855eDtHSxOkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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


########################################

# 717) BBC News London
717)
keyword=":"
if [ "$getlink" = 1 ]
then
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
link=https://www.filmon.com/tv/bbc-news
#link="https://1636691764.rsc.cdn77.org/LS-ATL-54548-11/tracks-v1a1/mono.m3u8"
#EXTINF:-1 tvg-logo="https://www.digitaltveurope.com/files/2011/12/BBC-World-News1.jpg" group-title="24/7 WORLD NEWS",BBC World News (Opt-1) (GB)
#link="http://ott-cdn.ucom.am/s24/index.m3u8"
#EXTIF:-1 tvg-logo="https://www.digitaltveurope.com/files/2011/12/BBC-World-News1.jpg" group-title="24/7 WORLD NEWS",BBC World News (Opt-2) (GB)
#link="https://1636691764.rsc.cdn77.org/LS-ATL-54548-11/tracks-v1a1/mono.m3u8"
#EXTINF:-1 tvg-logo="https://www.digitaltveurope.com/files/2011/12/BBC-World-News1.jpg" group-title="24/7 WORLD NEWS",BBC World News (Opt-3) (GB)
#link="http://92.43.140.249/s24/04.m3u8"
#link="http://a.files.bbci.co.uk/media/live/manifesto/audio_video/simulcast/hls/uk/abr_hdtv/ak/bbc_news24.m3u8"
fi

TAG=" BBCNEWS____"
use_cookies="no"
#method="Tor"
chan_name="BBC News London" ;;
############################## Made in ###########################################
# 718) Made in Leeds
718)
if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
fi
##method="Tor"
TAG="MADEIN_LEEDS"
chan_name="Made in Leeds" ;;
# 719) Made in Tyne & Wear
719)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
fi
###method="Tor"
TAG="MADEIN_TYNE__"
chan_name="Made in Tyne & Wear" ;;
# 720) Made in Cardiff
720)

if [ "$getlink" = 1 ]
then
link=https://www.dailymotion.com/video/x5ev9xg
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



#######################################################################################################


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
# 768)
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
# 771)
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


######################## FOX NEWS USA ########################################################

# 781) Fox News Talk
781)

if [ "$getlink" = 1 ]
then
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=364000,RESOLUTION=476x268,CODECS="avc1.66.30, mp4a.40.2"
link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_av-p.m3u8?sd=10&rebase=on"
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
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2"
#link="https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/index_300_a-b.m3u8?sd=10&rebase=on"

fi
## method="Tor"
use_cookies="no"
TAG="FOX_TALK_"
chan_name="Fox News Talk" ;;

# 782) KNBC 4 News (Los Angeles)
782)
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;
###########################################################
# 784) ABC News USA  1
784)
link="https://abclive1-lh.akamaihd.net/i/abc_live01@423395/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 1" ;;
# 785)ABC News USA 2
785)
link="https://abclive1-lh.akamaihd.net/i/abc_live02@423396/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 2" ;;
# 786)ABC News USA 3
786)
link="https://abclive1-lh.akamaihd.net/i/abc_live03@423397/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 3" ;;
# 787)ABC News USA 4
787)
link="https://abclive1-lh.akamaihd.net/i/abc_live04@423398/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 4" ;;
# 788)ABC News USA 5
788)
link="https://abclive1-lh.akamaihd.net/i/abc_live05@423399/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 5" ;;
# 789)ABC News USA 6
789)
link="https://abclive1-lh.akamaihd.net/i/abc_live06@423400/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 6" ;;
# 790)ABC News USA 7
790)
link="https://abclive1-lh.akamaihd.net/i/abc_live07@423401/index_4000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 7" ;;
# 791)ABC News USA 8
791)
link="https://abclive1-lh.akamaihd.net/i/abc_live08@423402/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 8" ;;
# 792)ABC News USA 9
792)
link="https://abclive1-lh.akamaihd.net/i/abc_live09@423403/index_1200_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="ABC Live Stream 9" ;;
# 793) ABC News USA 10
793)
if [ "$getlink" = 1 ]
then
link="https://abclive1-lh.akamaihd.net/i/abc_live10@420897/index_4000_av-p.m3u8?sd=10&rebase=on"
fi
TAG="ABC_NEWS_10"
use_cookies="no"
chan_name="ABC News USA Stream 10" ;;
# 794)ABC News USA 11
794)
if [ "$getlink" = 1 ]
then
#https://abcnews.go.com/Live
#https://abcnews.go.com/live/video/special-live-11
link="https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8"
#link="https://content-ause5.uplynk.com/channel/3324f2467c414329b3b0cc5cd987b6be/g.m3u8?v=1&pbs=962b38e9054e487aa50a6e07bfb15c14"
fi
#method="Tor"
use_cookies="no"
TAG="ABC_NEWS_USA"
chan_name="ABC News USA" ;;


################################################ Live Stream #########################################################
# 801)
# 802)
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


### FLUX TESTED

## 1052) Denver 8 TV
1052)
link="http://granicusliveus8-a.akamaihd.net/denver/G0080_002/chunklist.m3u8"
use_cookies="no"
chan_name="Denver 8 TV" ;;

## 1053) Jewlery Maker UK
1053)
link="http://edge01.cdn.aws.subset.host/JewelleryMakerLive/JewelleryMakerLive/playlist.m3u8"
use_cookies="no"
chan_name="Jewlery Maker UK" ;;



###################################### FRANCAIS EXTRA ##########################################
# 1121) CNEWS France
1121)
link=https://www.dailymotion.com/video/x3b68jn
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
# 1122)SYTRAL Rhone FR
1122)
keyword="DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SytralTCL/videos?view=2&flow=grid" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
chan_name="SYTRAL Rhone FR" ;;
# 1123) Vedia BE
1123)
# https://www.vedia.be/www/live
link=https://5a0b00d270652.streamlock.net/live/vedia-live/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1785849,CODECS="avc1.66.31,mp4a.40.2",RESOLUTION=1280x720
#link=https://5a0b00d270652.streamlock.net/live/vedia-live/chunklist_w1404141724.m3u8
use_cookies="no"
#method="Tor"
chan_name="Vedia BE" ;;
# 1124) MABI TV Canada
1124)
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="MABI TV Canada" ;;
# 1125) Vatican Media
1125)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Vatican Media" ;;
# 1126) TVM FR
1126)
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist_w1158771188.m3u8
#link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/chunklist.m3u8
link=https://cineplume.vedge.infomaniak.com/livecast/cineplume/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TVM FR" ;;
# 1127) C-Star
1127)
link=https://www.dailymotion.com/video/x5idxor
#link=https://stream-07.dc3.dailymotion.com/41/dm/3/x5idxor/live-2.m3u8
use_cookies="no"
chan_name="C-Star" ;;
# 1128) Direct Journal TVLandes
1128) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#method="Tor"
chan_name="Direct Journal Tvlandes"  ;;
# 1129) TV 7 Francais
1129)
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
#method="Tor"
chan_name="TV 7 Francais" ;;

# 1130) Generations TV
1130)
link="https://www.dailymotion.com/video/x2fxcwq"
#####method="Tor"
use_cookies="no"
chan_name="Generations TV";;

# 1131) Suivez Telesud
1131)
link="https://www.dailymotion.com/video/x52et3w"
#####method="Tor"
use_cookies="no"
chan_name="Suivez Telesud";;

# 1132) VL
1132)
link="https://www.dailymotion.com/video/x35m6bz"
#####method="Tor"
use_cookies="no"
chan_name="VL";;

# 1133)  BFM TV
1133)
link="https://www.dailymotion.com/video/xgz4t1"
#####method="Tor"
use_cookies="no"
chan_name="BFM TV";;

# 1134) 8 Mont Blanc Live 2
1134)
link="https://www.dailymotion.com/video/x6nhqs0"
#####method="Tor"
use_cookies="no"
chan_name="8 Mont Blanc Live 2";;

# 1135) RTL2
1135)
link="https://www.dailymotion.com/video/x2tzzpj"
#####method="Tor"
use_cookies="no"
chan_name="RTL2";;

# 1136) OUI FM
1136)
link="https://www.dailymotion.com/video/x10990v"
#####method="Tor"
use_cookies="no"
chan_name="OUI FM";;

# 1137) D24TV
1137)
link="https://www.dailymotion.com/video/x6cq41k"
#####method="Tor"
use_cookies="no"
chan_name="D24TV";;

# 1138)Canal Savoir Francais
1138)
if [ "$getlink" = 1 ]
then
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
fi
use_cookies="no"
#method="Tor"
chan_name="Canal Savoir Canada" ;;

# 1139) RFI
1139)
keyword="RFI en Direct"
if [ "$getlink" = 1 ]
then
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
fi
use_cookies="no"
chan_name="RFI Francais" ;;

############################################
###############################  GOVERNMENT #####################################################################

###################### EUROPEAN UNION #################################
# 1161) EBS European Commision
1161)
if [ "$getlink" = 1 ]
then
#link="https://ott.ec.streamcloud.be/live/disk1/EBS/hls_or/EBS-audio_AACL_qaa_66400_201=66400-video=800000.m3u8"
#link="https://ott.ec.streamcloud.be/live/disk1/EBS/hls_or/EBS-audio_AACL_qaa_66400_201=66400-video=800000.m3u8"
link="https://ott.ec.streamcloud.be/live/disk1/EBS/hls_en/EBS-audio_AACL_eng_66400_202=66400-video=800000.m3u8"

fi
use_cookies="no"
##method="Tor"
TAG="EBS_EU______"
chan_name="EBS European Commision" ;;
# 1162) EBS European Commision
1162)
if [ "$getlink" = 1 ]
then
#link="https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_or/EBSplus-audio_AACL_qaa_66400_401=66400-video=800000.m3u8"
#link="https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_or/EBSplus-audio_AACL_qaa_66400_401=66400-video=800000.m3u8"
link="https://ott.ec.streamcloud.be/live/disk1/EBSplus/hls_en/EBSplus-audio_AACL_eng_66400_402=66400-video=800000.m3u8"
fi
use_cookies="no"
##method="Tor"
TAG="EBS+_EU______"
chan_name="EBS Plus European Commision" ;;
############## IRELAND ###############
# 1163) Dail Eireann IE
1163)
link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/chunklist_b1228000.m3u8
#link=https://oirlive.heanet.ie/dail/ngrp:dail.stream_all/playlist.m3u8
#link=https://media.heanet.ie/oirlive/dail/ngrp:dail.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Dail Eireann IE" ;;
# 1164) Senad Eireann IE
1164)
link=https://oirlive.heanet.ie/seanad/ngrp:seanad.stream_all/playlist.m3u8
#link=https://media.heanet.ie/oirlive/seanad/ngrp:seanad.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Senad Eireann IE" ;;
# 1165)# 540)Oireachtas Committee Room 1
1165)
link=https://oirlive.heanet.ie/cr1/ngrp:cr1.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 1" ;;
# 1166)# 540)Oireachtas Committee Room 2
1166)
link=https://oirlive.heanet.ie/cr2/ngrp:cr2.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 2" ;;
# 1167) Oireachtas Committee Room 3
1167)
link=https://oirlive.heanet.ie/cr3/ngrp:cr3.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 3" ;;
# 1168)Oireachtas Committee Room 4
1168)
link=https://oirlive.heanet.ie/cr4/ngrp:cr4.stream_all/chunklist_b1228000.m3u8
use_cookies="no"
chan_name="Oireachtas Committee Room 4" ;;

############################################




################### MENU 5 ########################################

############################### AUSTRALIA /New Zealand ##########################################
## 1201) 2UE Sydney
1201)
#link="http://syd2uevid-lh.akamaihd.net/i/sydneyuevid_1@110994/master.m3u8"
link="http://syd2uevid-lh.akamaihd.net/i/sydneyuevid_1@110994/index_500_av-p.m3u8"
use_cookies="no"
chan_name="2UE Sydney" ;;

## 1202) 3AW Melbourne
1202)
# link="http://melb3awvid-lh.akamaihd.net/i/melbournevid_1@109381/master.m3u8"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=198000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
link="http://melb3awvid-lh.akamaihd.net/i/melbournevid_1@109381/index_150_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=198000,RESOLUTION=320x240,CODECS="avc1.66.30, mp4a.40.2"
#link="http://melb3awvid-lh.akamaihd.net/i/melbournevid_1@109381/index_150_av-b.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="3AW Melbourne" ;;

## 1203) 4BC Brisbane
1203)
link="http://bris4bcvid-lh.akamaihd.net/i/brisbanebcvida_1@110989/master.m3u8"
use_cookies="no"
chan_name="4BC Brisbane" ;;

## 1204) 3 News Live New Zealand
1204)
## 3 News Live New Zealand
#link="http://mediaworks-i.akamaihd.net/hls/live/220435/3812193411001/3news_live/master.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=1058932,AVERAGE-BANDWIDTH=1205600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=852x480,FRAME-RATE=25.000
link="http://mediaworks-i.akamaihd.net/hls/live/220435/3812193411001/3news_live/master_1500.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=772932,AVERAGE-BANDWIDTH=875600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360,FRAME-RATE=25.000
#link="http://mediaworks-i.akamaihd.net/hls/live/220435/3812193411001/3news_live/master_720.m3u8"
#EXT-X-STREAM-INF:BANDWIDTH=391600,AVERAGE-BANDWIDTH=435600,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=426x240,FRAME-RATE=25.000
#link="http://mediaworks-i.akamaihd.net/hls/live/220435/3812193411001/3news_live/master_325.m3u8"
use_cookies="no"
chan_name="3 News Live New Zealand" ;;


######################### TWITCH STREAMERS ##################################

# 1241) Cat Like Meow
1241)
link=https://www.twitch.tv/catlikemeow
use_cookies="no"
####method="Tor"
chan_name="CatLikeMeow";;

# 1242) Bad Bunny
1242)
link=https://www.twitch.tv/badbunny
use_cookies="no"
####method="Tor"
chan_name="Bad Bunny";;

# 1243) hasanabi
1243)
link=https://www.twitch.tv/hasanabi
use_cookies="no"
####method="Tor"
chan_name="hasanabi";;

# 1244) DizzyKitten
1244)
link=https://www.twitch.tv/dizzykitten
use_cookies="no"
####method="Tor"
chan_name="DizzyKitten";;

# 1245) intraventus
1245)
link=https://www.twitch.tv/intraventus
use_cookies="no"
####method="Tor"
chan_name="intraventus";;

# 1246) kneecoleslaw
1246)
link=https://www.twitch.tv/kneecoleslaw/
use_cookies="no"
####method="Tor"
chan_name="kneecoleslaw";;

# 1247) nanerboots
1247)
link=https://www.twitch.tv/nanerboots
use_cookies="no"
####method="Tor"
chan_name="nanerboots";;

# 1248) igotthejoos
1248)
link=https://www.twitch.tv/igotthejoos
use_cookies="no"
####method="Tor"
chan_name="igotthejoos";;

# 1249) courtneyysmoke
1249)
link=https://www.twitch.tv/courtneyysmoke
use_cookies="no"
####method="Tor"
chan_name="courtneyysmoke";;


# 1250) taylor_jevaux
1250)
link=https://www.twitch.tv/taylor_jevaux
use_cookies="no"
####method="Tor"
chan_name="taylor_jevaux";;

# 1251) ninjastarasmr
1251)
link=https://www.twitch.tv/ninjastarasmr
use_cookies="no"
####method="Tor"
chan_name="ninjastarasmr";;

# 1252) smidjen 
1252)
link=https://www.twitch.tv/smidjen
use_cookies="no"
####method="Tor"
chan_name="smidjen";;

# 1253) jadethejaguar
1253)
link=https://www.twitch.tv/jadethejaguar
use_cookies="no"
####method="Tor"
chan_name="jadethejaguar";;

# 1254) keelyvalentine
1254)
link=https://www.twitch.tv/keelyvalentine
use_cookies="no"
####method="Tor"
chan_name="keelyvalentine";;

# 1255) blondiewondie
1255)
link=https://www.twitch.tv/blondiewondie
use_cookies="no"
####method="Tor"
chan_name="blondiewondie";;

# 1256) missypwns
1256)
link=https://www.twitch.tv/missypwns
use_cookies="no"
####method="Tor"
chan_name="missypwns";;



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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEpDjqeFIGTqHwk-uULx72Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 1364) Jackson Hole Rustic Inn
1364) link=https://www.youtube.com/watch?v=KdvHzgcElx0
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 1365) Aosta Sarre Italy
1365)
keyword="Aosta Sarre Italy"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/camillimarco/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Aosta Sarre Italy" ;;
# 1366) Buenos Aires Four Seasons
1366)
keyword="Buenos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCkRwmztPEvut3gpsgmCmzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 1369) Akiba Japan Live
1369)
keyword="Akiba"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2 )"
use_cookies="no"
chan_name="Hart Beach Netherlands" ;;
# 1378)  Port du Quebec
1378)
keyword="Port"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/portqc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Port du Quebec" ;;
# 1379) Durango Colorado USA
1379)
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 |cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Durango Colorado USA" ;;
# 1380)Star Dot Cam 1
1380)
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;
# 1381) Youing Japan Route 10
1381)
keyword="Japan LIVE Camera"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Youing Japan Route 10" ;;
# 1382) Star Dot Cam 4
1382)
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;;
# 1383) Star Dot Cam 5
1383)
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;;
# 1384) Star Dot Cam 6
1384)
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;;
# 1385) Fine Cine London 1
1385)
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Fine Cine London 1" ;;
# 1386) Fine Cine London 2
1386)
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Fine Cine London 2" ;;
# 1387) Fine Cine London 3
1387)
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Fine Cine London 3" ;;
# 1388) Berlin Airport
1388)
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Berlin Airport" ;;
# 1389) Port of Los Angeles
1389)
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="Port of Los Angeles" ;;
# 1390)  ITS COM STUDIO Japan
1390)
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="ITS COM STUDIO" ;;
# 1391)  China Shoreline
1391)
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d ? -f 2 | cut -d \" -f1 | cut -d = -f 2)"
use_cookies="no"
chan_name="China Shoreline" ;;

esac
}


youTubeGrab()
{
## current link grabbing formula
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "$channelURL" | grep "$keyword" | grep "watch?v=" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /videoId/  )  print $(i+2) } '| head -n 1)"
}

liveStreamGrab(){
## set the link
link="$( curl -A "$UA" "$channelURL" | grep "secure_play_url" | awk ' BEGIN { FS="\"" } { for (i=1 ; i<=NF ; i++ )  if ( $i ~ /secure_m3u8_url/ && $(i+2) ~ /broadcasts/  )  print $(i+2) } ' | cut -d \? -f 1  | head -n 1  )"
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
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --cache="yes" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link"
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
    else
    mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
    fi
  else

    if [ "$use_cookies" = "yes" ]
    then
    echo "Fetching Cookie, Please Wait..."
    curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    mpv --ytdl-format="$format" --no-resume-playback --cache="yes" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link"
    # clear the cookie
    echo " " > "$cookie"
    elif [ "$method" = "Streamlink" ]
    then
    streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Tor" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
    elif [ "$method" = "Tor-Streamlink" ]
    then
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i streamlink --player "mpv --user-agent="$UA" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen" "$link"  "$format"
    elif [ "$method" = "Proxychains" ]
    then
    proxychains mpv --user-agent="$UA" --ytdl-format "$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
    else
    mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
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
while [ "$entry" != "q" ]
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
