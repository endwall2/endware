#! /bin/sh
######################################################################
# Title: endtv.sh
# Description:  Clearnet streaming from FilmOnTV of selected TV 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.091
# Revision Date: July 26, 2021
#
# Change Log:  - Stay on previously selected menu after video finishes
#              - proper implimentation of channel switching while loop
#              - Set to infinite repeat to reload streams automatically + grab cookie with curl
#              - Forked from enstream.sh
#              - grab transient channels by channel name 
#              - Removed transient streams added some home shopping channels
#              - Rearranged channels
#              - Added more streams from Taiwan and Japan
#              - Added a while loop to keep alive until user inputs q
#              - remove dead streams, channel listing function
#              - remove dead streams, rearrange channel listing and channels
#              - take channel input from console + --list-chans + more channelskf
#              - Add firejail before mpv, remove dead streams
#              - dailymotion + twitch + fix channel list
#              - Add channels, rearange, remove dead streams
#              - Rearanged the channels, added more channels
#              - File creation, testing, remove dead streams
#
#
#####################################################################
# Dependencies: youtube-dl, mpv, read , firejail, curl
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endtv.sh ~/bin/endtv
# $ cd ~/bin
# $ chmod u+wrx endtv
# $ export PATH=~/bin:"$PATH"
#
# Run ENDTV
# $ endtv
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
version="0.091"
rev_date="26/07/2021"
branch="gnu/linux"
product="EndTV"
##################################################
USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/tv.txt"
cookie="$HOME/bin/cookies.txt" 
cache_size=4096
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
entry="null"
# clear cookie
echo " " > "$cookie"


### Define function for displaying channels  CHANGE MENU HERE
channel_matrix_0()
{
   echo "==============================================================      "$product" "$version"   ========================================================================="
   echo "================================================================================================================================================================"
   echo "=======UK ======  40)Drama            78)Creepy Crawly      116)Screensaver     154)Noise Network  191)POP             230)Newsy  **       268)Harlem        "    
   echo "1)BBC One         41)Box Hits         79)B-Movie!           117)Drone TV        155)Janey Kirk     192)Popeye          231)CDTV **         269)TMTV          " 
   echo "2)BBC News        42)The Box          80)Alien Invasion     118)Miss Multiverse 156)FilmOn Jazz    193)Funny Company   232)EIC TV          270)WHOMAG        "  
   echo "3)BBC 1 Wales     43)-----------      81)Horror Channel     119)Vape Channel    157)FilmOn Rock    194)AngelAttic      233)Global Goals    271)WHOMAG VID    "             
   echo "4)BBC 1 Scotland  44)-----------      =======MOVIES=======  120)Talent Know     158)JCTV           195)Cat TV          234)Native Nations2*272)New Star      "  
   echo "5)BBC 1 N Ireland ====SPORTS======    82)FilmOn Classics    121)EZ Way          159)Classic Arts   196)CBeebies        235)France 24**     273)Bone Thugs    "  
   echo "6)BBC Two         45)Grandstand Show  83)Love On The Range  122)Tomorrow Pics   160)Jazz Radio     197)CBBC            236)Truth Files**   274)RMC Live      "
   echo "7)BBC Parliament  46)Football Fanatics84)Silent Cinema      123)Razzies         =====BIKINI=====   198)Talya Toys      237)NewsMax**       275)Raw Report    "
   echo "8)BBC Four        47)FilmOn Tennis    85)ChristmasTime      124)Noahpop tv      161)Player         199)Kartoon Klassic 238)TV 47**         276)Linkct Network"
   echo "9)ITV             48)Snooker Legends  86)Sherlock Holmes    124)Hollywood Show  162)J CLub         200)Fun Little      239)VOA             277)Urban Music   "
   echo "10)ITV +1         49)The Ring TV      87)Seven Sins         125)Director's Cut  163)Bikini Down    201)Tayla Tea       240)FilmOn NEWS     278)Aspire Now    "
   echo "11)ITV2           50)Gali Lucha Libre 88)The Monarch        126)Romance         164)Cheerleaders   202)Wild Animals    241)Al Jazeera      279)Amp TV        "
   echo "12)ITV2 +1        51)Beach Sports     89)Trailer Nut        127)Miss Peurto Rico165)Party Girls    203)FilmOn Kids     242)Bloomberg**     280)Weedmaps      "
   echo "13)ITV3           52)Pugalism         90)Thespian Theater   128)On The Mike     166)Showing Off    204)Mouse House     243)DW English      281)Buddy Plant   "
   echo "14)ITV3 +1        53)Inside The Ring  91)Rated B            =======MUSIC======  167)Show and Tell  205)Clutch Cargo    244)Russia Today    282)PROHBTD       "  
   echo "15)ITV4           54)Emerging Sports  92)Movie Loft TV      129)TVM TV          168)Miss Top       206)Felix The Cat   245)America Thinks  283)Sweet Leaf    "
   echo "16)ITV4 +1        55)Softball 360     93)Dragon Arena       130)MVTV            169)Bikini TV      207)Little Smart    246)CGTN            ===LIFESTYLE===   "
   echo "17)ITV Be         56)Golden Boy       94)Mad Science Cinema 131)Ditty TV        170)Bikini Kitchen 208)Crowd Angels    247)DVID            284)Health Life   "	
   echo "18)Channel 4      57)FilmOn Wrestling 95)FilmOn Family      132)Irish Country   171)Miami TV       ====DOCUMENTARY==== 248)Press TV        285)SOBA          "
   echo "19)E4             58)FilmOn Football  96)Hollywood War      133)Britrox         =====COMEDY======  209)Red Chip        249)Job Channel     286)Readers Digest"  
   echo "20)More4          59)Roopstigo        97)Bloodzillathon     134)24.7 The Stream 172)ComiCZoo       210)Biz TV          250)Unreliable**    287)Green Living  "
   echo "21)Channel 5      60)Fighting Athlete 98)Banned Western     135)Miami Music     173)Placeholders   211)CCTV 9          251)Insider Ex      288)Safe TV       "       
   echo "22)5*             61)Ultimate Disc    99)Eurotrash          136)Talent Watch    174)Lumbfilm       212)Fame TV         ==EXTREME SPORTS==  289)Bid America   "  
   echo "23)5USA           62)FilmOn Boxing    100)High School       137)HotRock         175)FimOn Comedy   213)                252)GFL Combat      290)MegaMe        "
   echo "24)Really         63)Game Time        101)Award Cinema      138)Hot Country     176)Spud's Funny   214)FBI Insider     253)XCORPS          291)Wonderful Life"  
   echo "25)Yesterday      64)1 on 1 Boxing    102)New York          139)Music Mix       177)SupaPirateBoot 215)FilmOn Docs     254)MMA Now         292)Simply Me     "
   echo "26)Pick TV        65)AFL Classic      103)Major Crimes      140)Guitar Lessons  178)Fun Little     216)UFO NEWS        255)GLORY Kick      293)The Walk      "
   echo "27)CBS Reality    66)Cheer Channel    104)iFlix TV          141)Soundtrack      179)EyeforanEye    217)WAKAJ TV        256)Sledhead        294)Time TV       "
   echo "28)CBS Reality+1  67)Football Heroes  105)Campy Channel     142)EDM TV          180)Locomotion     218)FilmOn Bio      257)DestX           295)DRTV          "
   echo "29)CBS Drama      68)Live Boxing      106)KungFu Classics   143)Jimmy Lloyd SWS ======KIDS=======  219)Victory at Sea  258)PlanetX         296)Medical News  "    
   echo "30)CBS Action     69)Army Boxing      107)Matriarch         144)Beatles Stories 181)KIDS ZONE      220)FilmOn War      259)MMA Now         297)Supreme Master"
   echo "31)truTV          69)Tuff TV          108)Film 4            145)DM TV           182)AngelsAttic    221)Ghost Hunters   260)UFC Next        =====FILMON====   "
   echo "32)FusionPlus TV  70)Disability Sports109)Film Detective    146)Country Star    183)SuperGeekHero  222)Timeless Bios   261)Sports Blooper  298)FOTV USA      " 
   echo "33)Forces TV      71)Blitzed          110)Renderyard Films  147)Josh and JB     184)AA Create      223)RealLife History262)Crash Bang      299)FOTV Workout  "  
   echo "34)Challenge      72)Dart's Nation    111)Mogolian Invasion 148)JBTV            185)Reading        224)Living History  ====URBAN/PARTY===  300)FilmOn Sports "
   echo "35)Pick TV        ======HORROR======== ===ENTERTAINMENT==== 149)Jazz TeeVee     186)OM NOM         225)WW2 TV          263)Urban Firearms  301)360 Exp       "
   echo "36)V Channel      74)Chillings        112)CRAGG             150)Dancing Machine 187)Kids Rock      226)Aliens UFOS     264)Road 2 Fame     302)BH Cam 360    "
   echo "37)Really TV      75)Monster Madhouse 113)Shockya Trailers  151)Inside Music    188)Tiny Pop       227)Crime Inc.      265)WWRTV           303)R&B Live      "	
   echo "38)My Face My Body76)Zombie Underworld114)California Life   152)Tipstr.TV       189)Kix!           228)Short a Lesson  266)Evidence        304)Cast Out      "
   echo "39)Dr. Fab Show   77)Vampire Empire   115)Rose Parade       153)Clubbing TV     190)Tails TV       229)Locomotion TV   267)Superfly        305)ROC Summer    "
   echo "==============================================================================================================================================================="
echo " " 
}   

channel_matrix_1()
{
   echo "===============================================================      "$product"  "$version"   ================================================================"
   echo "=========FORIEGN==============INDIA==========================================================================================================================="
   echo "306)FilmON Studio 343)Films India       379)RT Espanol         417)Sprokets         452)GLORY TV       489)Torque Tush     522)U Matter 2    561)----------  "    
   echo "307)TV Gold       344)Live 9 TV         380)DW Latino America  418)Teen Shorts      453)Dunamis        490)MotorZ          523)WXEA 94.7     562)----------  " 
   echo "308)Battle Rap    345)Delhi Aaj Tak     381)Televideo Latino   419)Drama Shorts     454)Global Music   491)Steel Dreams    524)Wise Choice   563)---------- "  
   echo "309)Tribe TV      346)Aaj Tak           ===CLASSIC TV===       420)Digi Animation   455)Church Channel 492)Distant Roads   525)FONYE Dance   564)---------- "             
   echo "310)FOn Reality   347)Tez TV            382)The Lucy Show      421)Documentary      456)TBN            ====EDUCATION===    526)Key 56        565)---------- "  
   echo "311)Red Carpet    348)ABP News          383)Date with Angels   ======OUTDOORS====== 457)DAYSTAR        493)Florida         527)A1 Bluegrass  566)---------- "  
   echo "312)Christmas     ===ITALY===           384)Man with Camera    422)Bayou Country    458)CATHOLIC TV    494)Make Your Move  528)WZQR Talk     567)---------- "
   echo "313)Nub TV        349)Italia Channel    385)Colgate Comedy     423)Gun Student      ======CELEBS====   495)Smarts TV       529)---------     568)---------- "
   echo "314)Chai Life     350)Camera Deputati   386)Catwalk            424)Ultimate Outdoor 459)Screenster     496)Parenting TV    530)---------     569)---------- "
   echo "315)Joe Nation    351)QVC Italy         387)Life of Riley      425)Hunt Channel     460)Celeb Action   =====SHOPPING====   531)---------     570)---------- "
   echo "316)OCRealEstate  ==MIDDLE EAST==       388)Strange Paradise   426)Thouroughbred    461)Dame Dash      497)Jewelry TV      532)---------     571)---------- "
   echo "317)MHL TV        352)Rotana Aflam      389)Red Skeleton       427)Wilderness       462)Nik Richie     498)QVC HD          533)---------     572)---------- "
   echo "318)RUNWAY TV     353)DW Arabia         390)Dragnet            428)Pursuit          463)Celeb Icons    499)Shop-N-Give     534)---------     573)---------- "
   echo "319)TEOS          354)AlJazeera Docs    391)Private Secretary  ======TRAVEL======   464)Andy Dick      500)Deals TV        535)---------     574)---------- "
   echo "320)TV ART        355)AlJazeeraMubasher 392)Suspense TV        429)HWC              465)Janice TV      501)Beauty IQ       536)---------     575)---------- "  
   echo "321)RunwayTV      356)AlJazeera Arabic  393)Timeless Westerns  430)Jet Set          466)Kato Katelin   502)QVC             537)---------     576)---------- "
   echo "322)Chic          357)Saudi TV 2        394)You bet your Life  431)Mata             467)Celeb Fight    503)America Auction 538)---------     577)---------- "
   echo "323)NASA TV       358)Saudi TV Sports   395)Flash Gordon       432)Mega Dest        468)Vertro Live    504)Caribbean Shop  539)---------     578)---------- "	
   echo "===FRENCH===      359)Suryoyo Satalite  396)Betty Boop         433)30A TV           469)Star Shop      505)Product Show    540)---------     579)---------- "
   echo "324)ARTE          360)Rotana            397)Fury TV            434)OBX TV           =====FOOD=======   ====CARIBBEAN====   541)---------     580)---------- "  
   echo "325)France 0      361)Rotana Clip       398)Cisco Kid          435)Travel           470)Wine Ram       506)Calabash        542)---------     581)---------- "
   echo "326)France 3      362)Rotana Khalijah   499)Bonanza            436)Landmarks        471)World of Wine  507)Caribbean Life  543)---------     582)---------- "       
   echo "327)France 3      363)Rotana Classic    400)Ozzie and Harriet  437)Infamous Places  472)The Chef Roc   508)Scruffy TV      543)---------     583)---------- "  
   echo "328)RTS UN        364)Rotana Masriya    401)One Step Beyond    =====SOMALIA======   473)Food Network+1 =======ASIAN======  544)---------     584)---------- "
   echo "329)RTS Deux      365)Rotana Cinema     402)Charlie Chaplin    438)SNL TV           474)Food Champ     509)Arirang TV      545)---------     585)---------- "  
   echo "330)BFM Biz       366)Saudi TV 1        403)Beverly Hillbilies 439)Universal TV     475)Dude Food      510)VTC-10          546)---------     586)---------- "
   echo "331)BFM TV        367)Noor Dubai        404)Robin Hood         440)National         476)Food Network   511)VOA Weishi      547)---------     587)---------- "
   echo "332)France 2      368)iFilm             405)Timeless TV        441)Horn Cable       477)iFood TV       ======AFRICAN=====  548)---------     588)---------- "
   echo "===GERMAN===      369)Dubai Sports      406)Spud's Crime       442)ESTV             478)Indian Recipe  512)ERI TV          549)---------     589)---------- "
   echo "333)HSE 2a        =====SWISS =====      407)Dick Van Dyke      443)Kalsanv          479)Wine Oh        513)Nollywood       550)---------     590)---------- "    
   echo "334)HSE 2b        370)SRF 1             == SHORT FILMS==       ======GREEK======    480)Gastrolab      514)iGboro TV       551)---------     591)---------- "
   echo "335)Kika          371)RSI LA 1          408)Funny Shorts       444)RIK              481)Outdoor Cook   =====KAZAKH=======  552)---------     592)---------- "
   echo "336)ZDF Info      372)Raido Chico       409)Movies             =====RELIGION=====   482)Wine Channel   515)Kazakh TV       553)---------     593)---------- " 
   echo "===RUSSIAN===     =====LATINO======     410)Planet Fashion     445)Hispanic         483)Eco Rico       ======RADIO=======  554)----------    594)---------- "  
   echo "337)RTR Planet    373)Dancing Shorts    411)Reality Shorts     446)You Shall Live   484)Veg TV         516)Marko Polka     555)---------     595)---------- "
   echo "338)CurrentTime   374)Peliculas FilmON  412)Acid TV            447)Preach the Word  =======CARS======= 517)v104 Live       556)---------     596)---------- "
   echo "339)RT Docs       375)Catwalk Espanol   413)Horror TV          448)Audio Scripture  485)Auto Channel   518)Daytona Surf    557)---------     597)---------- "
   echo "340)Perviy        376)Animacion FilmOn  414)Music Videos       449)Cyber Church     486)Raceline TV    519)Classic Oldies  558)---------     598)---------- "	
   echo "341)Music Box     377)HispanTV          415)Sci Fi             450)Faith Cinema     487)Race Central   520)The Cajun       559)---------     599)---------- "
   echo "342)Rossiya 24    378)Telenovelas       416)Micro Shorts       451)NRB              488)Honda HPD      521)J&J FM          560)---------     600)---------- "
   echo "==============================================================================================================================================================="
echo " " 
}	
channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||        Column 1     ||     Column 2         ||    Column 3       ||   Column      4     ||  Column 5         ||    Column 6        ||   Column 7    ||"
   echo "============================================================================================================================================================="
   echo "681)------------      721)------------       761)------------      801)------------     841)------------      881)------------     921)------------ "    
   echo "682)------------      722)------------       762)------------      802)------------     842)------------      882)------------     922)------------ " 
   echo "683)------------      723)------------       763)------------      803)------------     843)------------      883)------------     923)------------ "  
   echo "684)------------      724)------------       764)------------      804)------------     844)------------      884)------------     924)------------ "             
   echo "685)------------      725)------------       765)------------      805)------------     845)------------      885)------------     925)------------ "  
   echo "686)------------      726)------------       766)------------      806)------------     846)------------      886)------------     926)------------ "  
   echo "687)------------      727)------------       767)------------      807)------------     847)------------      887)------------     927)------------ "
   echo "688)------------      728)------------       768)------------      808)------------     848)------------      888)------------     928)------------ "
   echo "689)------------      729)------------       769)------------      809)------------     849)------------      889)------------     929)------------ "
   echo "690)------------      730)------------       770)------------      810)------------     850)------------      890)------------     930)------------ "
   echo "691)------------      731)------------       771)------------      811)------------     851)------------      891)------------     931)------------ "
   echo "692)------------      732)------------       772)------------      812)------------     852)------------      892)------------     932)------------ "
   echo "693)------------      733)------------       773)------------      813)------------     853)------------      893)------------     933)------------ "
   echo "694)------------      734)------------       774)------------      814)------------     854)------------      894)------------     934)------------ "
   echo "695)------------      735)------------       775)------------      815)------------     855)------------      895)------------     935)------------ " 
   echo "696)------------      736)------------       776)------------      816)------------     856)------------      896)------------     936)------------ "
   echo "697)------------      737)------------       777)------------      817)------------     857)------------      897)------------     937)------------ "
   echo "698)------------      738)------------       778)------------      818)------------     858)------------      898)------------     938)------------ "	
   echo "699)------------      739)------------       779)------------      819)------------     859)------------      899)------------     939)------------ "
   echo "700)------------      740)------------       780)------------      820)------------     860)------------      900)------------     940)------------ "  
   echo "701)------------      741)------------       781)------------      821)------------     861)------------      901)------------     941)------------ "
   echo "702)------------      742)------------       782)------------      822)------------     862)------------      902)------------     942)------------ "       
   echo "703)------------      743)------------       783)------------      823)------------     863)------------      903)------------     943)------------ "  
   echo "704)------------      744)------------       784)------------      824)------------     864)------------      904)------------     944)------------ "
   echo "705)------------      745)------------       785)------------      825)------------     865)------------      905)------------     945)------------ "  
   echo "706)------------      746)-------------      786)------------      826)------------     866)------------      906)------------     946)------------ "
   echo "707)------------      747)------------       787)------------      827)------------     867)------------      907)------------     947)------------ "
   echo "708)------------      748)------------       788)------------      828)------------     868)------------      908)------------     948)------------ "
   echo "709)------------      749)------------       789)------------      829)------------     869)------------      909)------------     949)------------ "
   echo "710)------------      750)------------       790)------------      830)------------     870)------------      910)------------     950)------------ "    
   echo "711)------------      751)------------       791)------------      831)------------     871)------------      911)------------     951)------------"
   echo "712)------------      752)------------       792)------------      832)------------     872)------------      912)------------     952)------------"
   echo "713)------------      753)------------       793)------------      833)------------     873)------------      913)------------     953)------------" 
   echo "714)------------      754)------------       794)------------      834)------------     874)------------      914)------------     954)------------"  
   echo "715)------------      755)------------       795)------------      835)------------     875)------------      915)------------     955)------------"
   echo "716)------------      756)------------       796)------------      836)------------     876)------------      916)------------     956)------------"
   echo "717)------------      757)------------       797)------------      837)------------     877)------------      917)------------     957)------------"
   echo "718)------------      758)------------       798)------------      838)------------     878)------------      918)------------     958)------------"	
   echo "719)------------      759)------------       799)------------      839)-----------      879)------------      919)------------     959)------------"
   echo "720)------------      760)------------       800)------------      840)-----------      880)------------      920)------------     960)------------"
   echo "==========================================================================================================================================================="
}	



for arg in $@
do 
 if [ "$arg" = "--help" ]
 then
   echo "ENDTV: watch entertainment and news streams in CLEARNET from filmontv using youtube-dl mpv using"
   echo "Type in the terminal $ endtv "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endtv --help         # usage messages"
   echo "$ endtv --version      # print version information"
   echo "$ endtv --list-matrix  # channel list in matrix format"
   echo "$ endtv --list-all     # channel list in column format"
   echo "$ endtv --ua-tor       # use tor-browser user-agent"
   echo "$ endtv --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endtv --ua-ranstr    # use a random string as the user agent"
   echo "$ endtv  55            # use channel number in command line"  
   echo "$ endtv  "
   shift
   exit 0
   elif [ "$arg" = "--version" ]
   then
   echo "ENDTV: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" = "--list-matrix" ]
   then 
   channel_matrix
   exit 0
   elif [ "$arg" = "--list-all" ]
   then
   more "$chan_columns"
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


###################### FUNCTIONS #######################################

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    BRITISH TV  ##################################
# 1) BBC One
1) link=https://www.filmon.com/tv/bbc-one 
   chan_name="BBC One";;
# 2)BBC News
2) link=https://www.filmon.com/tv/bbc-news
    chan_name="BBC News" ;;
# 3) BBC 1 Wales
3) link=https://www.filmon.com/tv/bbc-1-wales
    chan_name="BBC 1 Wales" ;;
# 4) BBC 1 Scotland
4) link=https://www.filmon.com/tv/bbc-1-scotland
    chan_name="BBC 1 Scotland" ;;
# 5) BBC 1 North Ireland
5)  link=https://www.filmon.com/tv/bbc-1-north-ireland
     chan_name="BBC 1 Northern Ireland" ;;
# 6)  BBC TWO
6) link=https://www.filmon.com/tv/bbc-two
    chan_name="BBC TWO" ;;
# 7) BBC Parliament
7) link=https://www.filmon.com/tv/bbc-parliament
    chan_name="BBC Parliament" ;;
# 8)  BBC Four
8) link=https://www.filmon.com/tv/cbeebiesbbc-four
    chan_name="BBC Four" ;; 
# 9) ITV
9) link=https://www.filmon.com/tv/itv1
    chan_name="ITV" ;;
# 10) ITV + 1
10) link=https://www.filmon.com/tv/itv-plus-1
chan_name="ITV + 1" ;; 
# 11) ITV 2
11) link=https://www.filmon.com/tv/itv2
chan_name="ITV 2" ;;   
# 12) ITV 2 + 1
12) link=https://www.filmon.com/tv/itv2-plus-1
chan_name="ITV 2 + 1" ;;
# 13) ITV 3
13) link=https://www.filmon.com/tv/itv3
chan_name="ITV 3" ;;
# 14) ITV 3 + 1
14) link=https://www.filmon.com/tv/itv3-plus-1 
chan_name="ITV 3 + 1" ;;
# 15) ITV 4
15) link=https://www.filmon.com/tv/itv4
chan_name="ITV 4" ;;
# 16) ITV 4 + 1
16) link=https://www.filmon.com/tv/itv4-plus-1
chan_name="ITV 4 + 1" ;;
# 17) ITV Be
17) link=https://www.filmon.com/tv/itvbe
    chan_name="ITV Be" ;;
# 18)  Channel 4
18) link=https://www.filmon.com/tv/channel-4
     chan_name="Channel 4" ;;    
# 19) E4
19) link=https://www.filmon.com/tv/e4
chan_name="E4" ;;
# 20) More4
20) link=https://www.filmon.com/tv/more4
chan_name="More4" ;;
# 21) Channel 5
21) link=https://www.filmon.com/tv/channel-5
chan_name="Channel 5" ;;
# 22) 5*
22) link=https://www.filmon.com/tv/5-star
chan_name="5*" ;;
# 23) 5 USA
23) link=https://www.filmon.com/tv/5usa
chan_name="5 USA" ;;
# 24) Really
24) link=https://www.filmon.com/tv/really
chan_name="Really" ;;
# 25) Yesterday
25) link=https://www.filmon.com/tv/yesterday
chan_name="Yesterday" ;;
# 26) Pick TV
26) link=https://www.filmon.com/tv/pick-tv
chan_name="Pick TV" ;;
# 27) CBS Reality 
27) link=https://www.filmon.com/tv/cbs-reality
chan_name="CBS Reality" ;;
# 28) CBS Reality + 1
28) link=https://www.filmon.com/tv/cbs-reality1
chan_name="CBS Reality + 1" ;;  
# 29) CBS Drama
29) link=https://www.filmon.com/tv/cbs-drama
chan_name="CBS Drama" ;;
# 30) CBS Action
30) link=https://www.filmon.com/tv/cbs-action
    chan_name="CBS Action" ;;
# 31) TruTV
31) link=https://www.filmon.com/tv/tru-tv
chan_name="TruTV" ;;
# 32) FusionPlus TV
32) link=https://www.filmon.com/tv/fusionplus
    chan_name="Fusion Plus TV" ;;
# 33) Forces TV
33) link=https://www.filmon.com/tv/forces-tv
    chan_name="Forces TV" ;;
# 34) Challenge 
34) link=https://www.filmon.com/tv/challenge
    chan_name="Challenge" ;;
# 35) Pick TV
35) link=https://www.filmon.com/tv/pick-tv
    chan_name="Pick TV" ;;  
 # 36) V Channel
36) link=https://www.filmon.com/tv/v-channel
   chan_name="V Channel";;   
# 37) Really TV
37) link=https://www.filmon.com/tv/reality-tv    
    chan_name="Really TV";;              
# 38) My Face My Body 
38) link=https://www.filmon.com/tv/my-face-my-body   
     chan_name="My Face My Body" ;;
# 39) Dr. Fab Show
39) link=https://www.filmon.com/tv/dr-fab-show
    chan_name="Dr. Fab Show" ;;
# 40) Drama
40)link=https://www.filmon.com/tv/drama
chan_name="Drama" ;;
# 41) Box Hits
41) link=https://www.filmon.com/tv/box-hits
    chan_name="Box Hits" ;;
# 42) The Box
42) link=https://www.filmon.com/tv/the-box
    chan_name="The Box" ;;
# 43)
# 44)

###################### SPORTS ################################    
# 45) Grandstand Show
45) link=https://www.filmon.com/tv/grandstand-show
    chan_name="Grandstand Show" ;;                                                            
# 46) Football Fanatics
46) link=https://www.filmon.com/tv/football-fanatics
    chan_name="Football Fanatics" ;;
# 47) FilmOn Tennis
47) link=https://www.filmon.com/tv/filmon-tennis
    chan_name="FilmOn Tennis" ;;
# 48) Snooker Legends
48) link=https://www.filmon.com/tv/snooker-legends
    chan_name="Snooker Legends" ;;
# 49) The Ring TV
49) link=https://www.filmon.com/tv/ring-tv
    chan_name="The Ring TV" ;;
# 50) Gali Lucha Libre
50) link=https://www.filmon.com/tv/galli-lucha-libre
    chan_name="Gali Lucha Libra" ;;
# 51) Beach Sports Network
51) link=https://www.filmon.com/tv/beach-sports-network
    chan_name="Beach Sports Network" ;;
# 52) Pugalism TV   
52) link=https://www.filmon.com/tv/pugilism-tv
chan_name="Pugilism TV"  ;;      
# 53) Inside The Ring
53) link=https://www.filmon.com/tv/inside-the-ring
chan_name="Inside The Ring" ;;
# 54) Emerging Sports TV
54) link=https://www.filmon.com/tv/emerging-sports-tv
chan_name="Emerging Sports TV";;
# 55) Softball 360
55) link=https://www.filmon.com/tv/softball-360
chan_name="Softball 360" ;;
# 56) Golden Boy Channel
56) link=https://www.filmon.com/tv/golden-boy-channel
chan_name="Golden Boy Channel";;
# 57) FilmOn Wrestling
57) link=https://www.filmon.com/tv/filmon-wrestling-network
chan_name="Film On Wrestling" ;;
# 58) FilmOn Football
58) link=https://www.filmon.com/tv/filmon-football
chan_name="FilmOn Football" ;;
# 59) Roopstigo 
59) link=https://www.filmon.com/tv/roopstigo
chan_name="Roopstigo";;
# 60) Fighting Athletes Network
60) link=https://www.filmon.com/tv/fighting-athletes-network
chan_name="Fighting Athletes Network" ;;
# 61) Ultimate Disc TV
61) link=https://www.filmon.com/tv/ultimate-disc-tv
    chan_name="Ultimate Disc TV" ;;
# 62) FilmOn Boxing
62) link=https://www.filmon.com/tv/filmon-boxing
    chan_name="FilmOn Boxing" ;;
# 63) Game Time
63) link=https://www.filmon.com/tv/game-time  
    chan_name="Game Time" ;;
# 64) 1 on 1 Boxing TV
64) link=https://www.filmon.com/tv/1-on-1-boxing-tv
    chan_name="1 on 1 Boxing TV" ;;  
# 65) AFL Classic
65) link=https://www.filmon.com/tv/afl-classics
chan_name="AFL Classic" ;;
# 66) Cheer Channel
66) link=https://www.filmon.com/tv/cheer-channel
    chan_name="Cheer Channel" ;;
# 67) Football Heroes
67) link=https://www.filmon.com/tv/football-heroes
    chan_name="Football Heroes" ;;
# 68) Live Boxing
68) link=https://www.filmon.com/tv/live-boxing 
    chan_name="Live Boxing" ;;
# 69) Armed Forces Boxing
69) link=https://www.filmon.com/tv/armed-forces-boxing
    chan_name="Armed Forces Boxing" ;;
# 70) Tuff TV
70) link=https://www.filmon.com/tv/tuff
    chan_name="TUFF TV" ;;
# 71) Disability Sports
71) link=https://www.filmon.com/tv/disability-sports-network
    chan_name="Disability Sports" ;;
# 72) Blitzed
72) link=http://www.filmon.com/tv/blitzed
    chan_name="Blitzed" ;;      
# 73) Darts Nation
73) link=http://www.filmon.com/tv/darts-nation
   chan_name="Darts Nation" ;;    
####################### HORROR ###########################
# 74) Chillings
74) link=https://www.filmon.com/tv/chillings
chan_name="Chillings" ;;
# 75) Monster Madhouse
75) link=https://www.filmon.com/tv/monster-madhouse
   chan_name="Monster Madhouse" ;;
# 76) Zombie Underworld
76) link=https://www.filmon.com/tv/zombie-underworld
    chan_name="Zombie Underworld" ;;
# 77) Vampire Empire
77) link=https://www.filmon.com/tv/vampire-empire
   chan_name="Vampire Empire" ;;
# 78) Creepy Crawly
78) link=https://www.filmon.com/tv/creepy-crawly  
chan_name="Creepy Crawly" ;;  
# 79) B-Movie! 
79) link=https://www.filmon.com/tv/b-movie  
 chan_name="B-Movie" ;; 
# 80) Alien Invasion Channel
80) link=https://www.filmon.com/tv/alien-invasion-channel  
 chan_name="Alien Invasion Channel" ;; 
# 81) Horror Channel
81)  link=https://www.filmon.com/tv/horror-channel  
 chan_name="Horror Channel" ;; 
######################### MOVIES   #######################
# 82) FilmOn Classics
82)  link=https://www.filmon.com/tv/filmon-classic-films 
 chan_name="FilmOn Classics" ;;  
# 83) Love On The Range
83)  link=https://www.filmon.com/tv/love-on-the-range
 chan_name="Love On The Range" ;;   
# 84) Silent Cinema
84)  link=https://www.filmon.com/tv/silent-cinema
 chan_name="Silent Cinema" ;;   
# 85) Christmastime TV
85)  link=https://www.filmon.com/tv/christmastime-tv 
 chan_name="ChristmasTime TV" ;; 
 # 86) Sherlock Holmes Channel
86)  link=https://www.filmon.com/tv/sherlock-holmes-channel 
 chan_name="Sherlock Holmes Channel" ;; 
# 87) Seven Sins TV
87)  link=https://www.filmon.com/tv/seven-sins-tv 
 chan_name="Seven Sins TV" ;;  
 # 88) The Monarch Channel
88)  link=https://www.filmon.com/tv/the-monarch-channel 
 chan_name="The Monarch Channel" ;;  
# 89) Trailer Nut TV
89)  link=https://www.filmon.com/tv/trailer-nut-tv 
 chan_name="Trailer Nut TV" ;;  
# 90) Thespian Theater
90) link=https://www.filmon.com/tv/thespian-theater
    chan_name="Thespian Theater" ;;
# 91)  Rated B
91) link=https://www.filmon.com/tv/rated-b
chan_name="Rated B" ;;
# 92) Movie Loft TV
92) link=https://www.filmon.com/tv/movie-loft-tv
chan_name="Movie Loft TV" ;;
# 93) Dragon Arena
93) link=https://www.filmon.com/tv/dragon-arena
    chan_name="Dragon Arena" ;;
# 94) Mad Science Cinema
94) link=https://www.filmon.com/tv/mad-science-cinema
chan_name="Mad Sience Cinema" ;;
#  95) FilmOn Family
95) link=https://www.filmon.com/tv/filmon-family
chan_name="FilmOn Family" ;; 
# 96) Hollywood War
96) link=https://www.filmon.com/tv/hollywood-war
chan_name="Hollywood war";;
# 97) Bloodzillathon
97) link=https://www.filmon.com/tv/bloodzillathon
chan_name="Bloodzillathon"  ;;
# 98) Banned Westerns
98) link=https://www.filmon.com/tv/banned-westerns
chan_name="Banned Westerns" ;;
# 99) Eurotrash
99) link=https://www.filmon.com/tv/eurotrash
chan_name="Eurotrash" ;;
# 100) High School
100) link=https://www.filmon.com/tv/high-school
chan_name="High School" ;;
# 101) Award Cinema
101) link=https://www.filmon.com/tv/award-cinema
chan_name="Award Cinema" ;;  
# 102) New York Channel
102) link=https://www.filmon.com/tv/new-york-channel
chan_name="New York Channel" ;;
# 103) Major Crimes
103) link=https://www.filmon.com/tv/major-crimes
chan_name="Major Crimes" ;; 
# 104) iFlix TV
104) link=https://www.filmon.com/tv/iflix-tv
     chan_name="iFlix TV" ;;
# 105) Campy Channel
105) link=https://www.filmon.com/tv/campy-channel
chan_name="Campy Channel" ;;
# 106) KungFu Classics
106) link=https://www.filmon.com/tv/kung-fu-classics
    chan_name="KungFu Classics" ;;
# 107) Matriarch TV
107) link=https://www.filmon.com/tv/matriarch-tv
     chan_name="Matriarch TV" ;; 
# 108) Film 4
108) link=https://www.filmon.com/tv/film-4
chan_name="Film 4" ;;
# 109) The Film Detective
109) link=https://www.filmon.com/tv/the-film-detective
chan_name="The Film Detective";; 
# 110) Renderyard Films
110) link=http://www.filmon.com/tv/renderyard-films
chan_name="Renderyard Films";; 
# 111) Mongolian Invasion
111) link=http://www.filmon.com/tv/mongolian-invasion
chan_name="The Film Detective";; 

#############################   ENTERTAINMENT ########################################
# 112) CRAGG
112) link=https://www.filmon.com/tv/cragg
chan_name="CRAGG" ;;
# 113) Shockya Trailers
113) link=https://www.filmon.com/tv/fotv-trailers
 chan_name="Shockya Trailers" ;;
## 114) California Life
114) link=https://www.filmon.com/tv/california-life
chan_name="California Life" ;;  
# 115) Rose Parade 2017
115) link=https://www.filmon.com/tv/rose-parade-2016
     chan_name="Rose Parade" ;;
# 116) Screensaver TV
116) link=https://www.filmon.com/tv/screensaver-tv
     chan_name="Screensaver TV" ;;
# 117) Drone TV
117) link=https://www.filmon.com/tv/drone-race-tv
chan_name="Drone TV" ;;
# 118) Miss Multiverse
118) link=https://www.filmon.com/tv/miss-multiverse
     chan_name="Miss Multverse" ;;
# 119) Vape Channel
119) link=https://www.filmon.com/tv/vape-channel
     chan_name="Vape Channel" ;;
# 120) Talent You Should Know
120) link=https://www.filmon.com/tv/talent-you-should-know
     chan_name="Talent You SHould Know" ;;
# 121) EZ Way TV
121) link=https://www.filmon.com/tv/ez-way-tv
     chan_name="EZ Way TV" ;;
# 122) Tomorrow Pictures 
122) link=https://www.filmon.com/tv/tomorrow-pictures
   chan_name="Tomorrow Pictures";;
# 123) Razzies Channel
123) link=https://www.filmon.com/tv/razzies-channel
  chan_name="Razzies Channel" ;;     
# 124) Noahpop tv
124) link=https://www.filmon.com/channel/noahpop-tv
  chan_name="Noahpop-tv" ;;  
# 125) Hollywood Show Live
125) link=https://www.filmon.com/channel/hollywood-show-live
  chan_name="Hollywood Show Live" ;;  
# 126) The Directors Cut 
126) link=https://www.filmon.com/channel/the-directors-cut
  chan_name="The Directors Cut" ;;  
# 127) The Romance
127) link=https://www.filmon.com/channel/the-romance
  chan_name="The Romance" ;;  
# 128) Miss Earth Puerto Rico
128) link=https://www.filmon.com/channel/miss-earth-puerto-rico-pageant
  chan_name="Miss Earth Puerto Rico" ;;  
# 129) On The Mike
129) link=https://www.filmon.com/channel/on-the-mike 
  chan_name="On The Mike" ;;    
###################### MUSIC  ####################################### 
# 130) TVM TV
130) link=http://www.filmon.com/channel/tvm-tv
chan_name="TVM TV" ;;   
# 131) MVTV
131) link=http://www.filmon.com/channel/mvtv
chan_name="MVTV" ;;   
# 132) Ditty TV
132) link=http://www.filmon.com/channel/ditty-tv
chan_name="Ditty TV" ;;   
# 133) Irelands Country TV
133) link=http://www.filmon.com/channel/irelands-country-tv
chan_name="Irelands Country TV" ;;   
# 134) Britrox
134) link=http://www.filmon.com/channel/britrox
chan_name="Britrox" ;;   
# 135) 24.7 The Stream
135) link=https://www.filmon.com/tv/247-the-stream 
chan_name="24. 7 The Stream" ;;   
# 136) Miami Music Television
136) link=https://www.filmon.com/tv/miami-music-television
chan_name="Miami Music Television";;     
# 137) Talent Watch
137) link=https://www.filmon.com/tv/talentwatch 
chan_name="Talent Watch" ;;
# 138) HotRock TV
138) link=https://www.filmon.com/tv/hotrock-tv 
chan_name="HotRock TV" ;; 
#  139) Hot Country Ireland
139) link=https://www.filmon.com/tv/hot-country-ireland
chan_name="Hot Country Ireland" ;;
# 140) Music Mix USA
140) link=https://www.filmon.com/tv/music-mix-usa
chan_name="Music Mix USA" ;;   
# 141) Guitar Lessons TV
141) link=https://www.filmon.com/tv/guitar-lessons-tv
chan_name="Guitar Lessons TV" ;;
# 142)  The Soundtrack Channel
142) link=https://www.filmon.com/tv/the-soundtrack-channel
chan_name="The Soundtrack Channel";;
# 143) EDM TV
143) link=https://www.filmon.com/tv/edm-tv
chan_name="EDM TV";; 
## 144) Jimmy Lloyd Song Writer Showcase
144) link=https://www.filmon.com/tv/jimmy-lloyd-song-writer-showcase
chan_name="Jimmy Lloyd Song Writer Showcase" ;;
## 145) Beatles Stories
145) link=https://www.filmon.com/tv/beatles-stories
 chan_name="Beatles Stories" ;; 
## 146) DM TV
146) link=https://www.filmon.com/tv/dmtv
 chan_name="DM TV" ;;
# 147) Country Star TV
147) link=https://www.filmon.com/tv/country-star-tv
chan_name="Country Star TV" ;;
# 148) Josh and JB in the Industry
148) link=https://www.filmon.com/tv/josh-and-jb-in-the-industry 
 chan_name="Josh and JB in the Industry" ;;
# 149) JBTV
149) link=https://www.filmon.com/tv/jbtv
chan_name="JBTV" ;;     
# 150) Jazz TeeVee
150) link=https://www.filmon.com/tv/jazz-teevee
chan_name="Jazz TeeVee" ;;     
# 151) Dancing Machine TV
151) link=https://www.filmon.com/tv/dancing-machine-tv
chan_name="Dancing Machine TV"  ;;
# 152) Inside Music TV
152) link=https://www.filmon.com/tv/inside-music-tv
 chan_name="Inside Music TV" ;;
# 153) Tipstr.TV
153) link=https://www.filmon.com/tv/tipstrtv
chan_name="Tipstr.TV" ;;
# 154) Clubbing TV
154) link=https://www.filmon.com/tv/clubbing-tv
chan_name="Clubbing TV" ;;
# 155) The Noise Network
155) link=https://www.filmon.com/tv/the-noise-network
chan_name="The Noise Network" ;;
# 156) Janey Kirk TV
156) link=https://www.filmon.com/tv/janey-kirk-tv
chan_name="Janey Kirk" ;;
# 157) FilmOn Jazz and Blues
157) link=https://www.filmon.com/tv/filmon-jazz-and-blues
chan_name="FilmOn Jazz and Blues" ;;
# 158) FilmOn Rock TV
158) link=https://www.filmon.com/tv/filmon-rock-tv
chan_name="FilmOn Rock TV" ;;
# 159) JCTV
159) link=https://www.filmon.com/tv/jctv
chan_name="JCTV" ;;
# 160) Classic Arts Showcase
160) link=https://www.filmon.com/tv/classic-arts-showcase
chan_name="Classic Arts Showcase" ;;
# 161) International Jazz Radio
161) link=https://www.filmon.com/tv/international-jazz-radio
chan_name="International Jazz Radio" ;;
################# BIKINI BABE ########################
# 162) Player TV
162) link=https://www.filmon.com/tv/player-tv
chan_name="Player TV" ;;
# 163) J CLub TV
163) link=https://www.filmon.com/tv/j-club-tv
chan_name="J Club TV" ;;
# 164) Bikini Down Under
164) link=https://www.filmon.com/tv/bikini-down-under
chan_name="Bikini Down Under" ;;
# 165) America's Hottest Cheerleaders
165) link=https://www.filmon.com/tv/americas-hottest-cheerleaders
chan_name="America's Hottest Cheerleaders" ;;
# 166) Party Girls TV
166) link=https://www.filmon.com/tv/party-girls-tv
chan_name="" ;;
# 167) Bikini Girls Showing Off
167) link=https://www.filmon.com/tv/bikini-girls-showing-off
chan_name="Bikini Girls Showing Off" ;;    
# 168) Bikini Girls Show and Tell
168) link=https://www.filmon.com/tv/bikini-girls-show-and-tell
chan_name="Bikini Girls Show and Tell" ;;
# 169) Miss Top of the World
169) link=https://www.filmon.com/tv/miss-top-of-the-world
chan_name="Miss Top of the World" ;;
# 170) Bikini TV
170) link=https://www.filmon.com/tv/bikini-teevee
chan_name="Bikini TV" ;;
# 171) Bikini Kitchen
171) link=https://www.filmon.com/tv/bikini-kitchen
chan_name="Bikini Kitchen" ;;
# 172) Miami TV
172) link=https://www.filmon.com/tv/miamitv
chan_name="Miami TV" ;;
################################### COMEDY ##########################
# 173) ComiCZoo
173) link=https://www.filmon.com/tv/comiczoo
chan_name="ComiCZoo" ;;
# 174) The Placeholders
174) link=https://www.filmon.com/tv/the-placeholders
chan_name="The Placeholders" ;;
# 175) Lumbfilm Comedy
175) link=https://www.filmon.com/tv/lumbfilm-comedy
chan_name="Lumbfilm Comedy" ;;
# 176) FimOn Comedy Classics
176)link=https://www.filmon.com/tv/filmon-comedy-classics
chan_name="FilmON Comedy Classics" ;;
# 177) Spud's Funny Channel
177) link=https://www.filmon.com/tv/spuds-funny-channel
chan_name="Spud's Funny Channel" ;;
# 178) Supa Pirate Booty Hunt
178) link=https://www.filmon.com/tv/supa-pirate-booty-hunt
chan_name="Supa Pirate Booty Hunt" ;;
# 179) Fun Little Movies
179) link=https://www.filmon.com/tv/fun-little-movies
chan_name="Fun Little Movies" ;;
# 180) Eye for an Eye
180) link=https://www.filmon.com/tv/eye-for-an-eye
     chan_name="Eye for an Eye" ;;    
################################## KIDS  ##################################    
# 181) KIDS ZONE
181) link=https://www.filmon.com/tv/kids-zone
     chan_name="KIDS ZONE" ;;
# 182) Angels from the Attic ComicFlix
182) link=https://www.filmon.com/tv/the-angels-from-the-attic-comicflix
     chan_name="Angels from the Attic ComicFlix" ;;
# 183) Super Geek Heroes
183) link=https://www.filmon.com/tv/super-geek-heroes
     chan_name="Super Geek Heroes" ;;
# 184) Angels from the Attic Create-Alongs
184) link=https://www.filmon.com/tv/the-angels-from-the-attic-create-alongs
     chan_name="Angels from the Attic Create" ;;
# 185) Children's Reading Channel
185) link=https://www.filmon.com/tv/childrens-reading-channel
     chan_name="Children's Reading Channel" ;;
# 186) OM NOM
186) link=https://www.filmon.com/tv/om-nom
     chan_name="OM NOM" ;;
# 187) Kids Rock TV
187) link=https://www.filmon.com/tv/kids-rock-tv
     chan_name="Kids Rock TV" ;;
# 188) Tiny Pop
188) link=https://www.filmon.com/tv/tiny-pop
     chan_name="Tiny Pop" ;;
# 189) Kix!
189) link=https://www.filmon.com/tv/kix
     chan_name="Kix!" ;;
# 190) Tails TV
190) link=https://www.filmon.com/tv/tails-tv
     chan_name="Tails TV" ;;
# 191) POP
191) link=https://www.filmon.com/tv/pop
     chan_name="POP" ;;
# 192) Popeye TV
192) link=https://www.filmon.com/tv/popeye-tv
     chan_name="Popeye TV" ;;
# 193) Funny Company
193) link=https://www.filmon.com/tv/funny-company-tv
     chan_name="Funny Company" ;;
# 194) Angels from the Attic Featurettes
194) link=https://www.filmon.com/tv/the-angels-from-the-attic-featurettes
     chan_name="Angels from the Attic Featurettes" ;;
# 195) Cat TV
195) link=https://www.filmon.com/tv/cat-tv
     chan_name="Cat TV" ;;
# 196) CBeebies 
196) link=https://www.filmon.com/tv/cbeebies
     chan_name="CBeebies" ;;
# 197) CBBC
197) link=https://www.filmon.com/tv/cbbc
     chan_name="CBBC" ;;
# 198) Tayla's Toddler Toy Review
198) link=https://www.filmon.com/tv/taylas-toddler-toy-review
     chan_name="Tayla's Toddler Toy Review" ;;
# 199) Kartoon Klassics
199) link=https://www.filmon.com/tv/kartoon-klassics
     chan_name="Kartoon Klassics" ;;
# 200) Fun Little Kids
200) link=https://www.filmon.com/tv/fun-little-kids
     chan_name="Fun Little Kids" ;;
# 201) Tea Time with Tayla
201) link=https://www.filmon.com/tv/tea-time-with-tayla
     chan_name="Tea Time with Tayla" ;;
# 202) Wild About Animals
202) link=https://www.filmon.com/tv/wild-about-animals
     chan_name="Wild About Animals" ;;
# 203) FilmOn Kids
203) link=https://www.filmon.com/tv/filmon-kids
     chan_name="FilmOn Kids" ;;
# 204) Mouse House Radio
204) link=https://www.filmon.com/tv/mouse-house-radio
     chan_name="Mouse House Radio" ;;   
# 205) Clutch Cargo
205) link=https://www.filmon.com/channel/clutch-cargo
     chan_name="Clutch Cargoo" ;;
# 206) Felix The Cat
206) link=http://www.filmon.com/channel/felix-the-cat
     chan_name="Felix The Cat" ;;
# 207) Little Smart Planet
207) link=http://www.filmon.com/channel/little-smart-planet
     chan_name="Little Smart Planet" ;;
     
############################   BUSINESS TV    ############################
# 208) Crowd Angels TV
208) link=https://www.filmon.com/tv/crowd-angels-tv
     chan_name="Crowd Angels TV" ;;
# 209) Red Chip Money Report
209) link=https://www.filmon.com/tv/red-chip-money-report
     chan_name="Red Chip Money Report" ;;
# 210) Biz TV
210) link=https://www.filmon.com/tv/biztv
     chan_name="Biz TV" ;;
######################### Documentary #################################
# 211) CCTV 9 Documentary
211) link=https://www.filmon.com/tv/cctv9-documentary
     chan_name="CCTV 9 Documentary" ;;
# 212) Fame TV
212) link=https://www.filmon.com/tv/fame-tv
     chan_name="Fame TV" ;;
# 213) Locomotion TV
213) link=https://www.filmon.com/tv/loco-motion-tv
     chan_name="Locomotion TV" ;;
# 214) FBI Insider
214) link=https://www.filmon.com/tv/fbi-insider
     chan_name="FBI Insider" ;;
# 215) FilmOn Documentary
215) link=https://www.filmon.com/tv/filmon-documentary
     chan_name="FilmOn Documentary" ;;
# 216) UFO NEWS
216) link=https://www.filmon.com/tv/ufo-news
     chan_name="UFO NEWS" ;;
# 217) WAKAJ TV
217) link=https://www.filmon.com/tv/wkaj-tv
     chan_name="WAKAJ TV" ;;
# 218) FilmOn Biography
218) link=https://www.filmon.com/tv/filmon-biography-channel
     chan_name="FilmOn Biography" ;;
# 219) Victory at Sea
219) link=https://www.filmon.com/tv/victory-at-sea-tv
     chan_name="Victory at Sea" ;;
# 220) FilmOn War
220) link=https://www.filmon.com/tv/filmon-war-channel
     chan_name="FilmOn War" ;;
# 221) Ghost Hunters
221) link=https://www.filmon.com/tv/ghost-hunters
     chan_name="Ghost Hunters" ;;
# 222) Timeless Biographies
222) link=https://www.filmon.com/tv/timeless-biographies
     chan_name="Timeless Biographies" ;;
# 223) Real Life History
223) link=https://www.filmon.com/tv/real-life-history-channel
     chan_name="Real Life History" ;;
# 224) Living History
224) link=https://www.filmon.com/tv/living-history-channel
     chan_name="Living History" ;;
# 225) WW2 TV
225) link=https://www.filmon.com/tv/war-crime-network
     chan_name="WW2 TV" ;;
# 226) Aliens and UFOs
226) link=https://www.filmon.com/tv/aliens-and-ufos
     chan_name="Aliens and UFOs" ;;
# 227) Crime Inc.
227) link=https://www.filmon.com/tv/crime-inc
     chan_name="Crime Inc" ;;
# 228) In Short a Lesson in Almost Everything
228) link=https://www.filmon.com/tv/in-short-a-lesson-in-almost-everything
     chan_name="In Short a Lesson in Almost Everything" ;;
# 229) Locomotion TV
229) link=https://www.filmon.com/channel/loco-motion-tv
     chan_name=" Locomotion TV" ;;      
   
###################### NEWS TV   #########################
# 230) Newsy
230) link=https://www.filmon.com/tv/newsy
     chan_name="Newsy" ;;
# 231) CDTV
231) link=https://www.filmon.com/tv/cdtv
     chan_name="CDTV" ;;
# 232) EIC TV
232) link=https://www.filmon.com/tv/eic-tv
     chan_name="EIC TV" ;;
# 233) The Global Goals
233) link=https://www.filmon.com/tv/the-global-goals
     chan_name="The Global Goals" ;;
# 234) Native Nations TV
234) link=https://www.filmon.com/tv/native-nations-tv
     chan_name="Native Nations TV" ;;
# 235) France 24
235) link=https://www.filmon.com/tv/france24
     chan_name="France 24" ;;
# 236) Truth Files
236) link=https://www.filmon.com/tv/truth-files
     chan_name="Truth Files" ;;
# 237) NewsMax
237) link=https://www.filmon.com/tv/newsmax
     chan_name="NEWSMAX" ;;
# 238) TV 47
238) link=https://www.filmon.com/tv/tv47
     chan_name="TV 47" ;;
# 239) VOA
239) link=https://www.filmon.com/tv/voa-english
     chan_name="VOA" ;;
# 240) FilmOn Breaking NEWS
240) link=https://www.filmon.com/tv/filmon-breaking-news
     chan_name="Breaking News" ;;
# 241) Al Jazeera
241) link=https://www.filmon.com/tv/al-jazeera
     chan_name="Al Jazeera" ;;
# 242) Bloomberg
242) link=https://www.filmon.com/tv/bloomberg
     chan_name="Bloomberg" ;;
# 243) DW English
243) link=https://www.filmon.com/tv/dw-english
     chan_name="DW English" ;;
# 244) Russia Today
244) link=https://www.filmon.com/tv/russia-today-2
     chan_name="Russia Today" ;;
# 245) What America Thinks
245) link=https://www.filmon.com/tv/what-america-thinks
     chan_name="What America Thinks" ;;
# 246) CGTN
246) link=https://www.filmon.com/tv/cctv-news
     chan_name="CGTN" ;;   
# 247) DVIDs TV
247) link=https://www.filmon.com/tv/dvids-tv
     chan_name="DVIDs TV" ;;     
# 248) Press TV
248) link=https://www.filmon.com/tv/press-tv
     chan_name="Press TV" ;;     
# 249) Job Channel
249) link=https://www.filmon.com/tv/job-channel-network
     chan_name="Job Channel" ;;
# 250) Unreliable Sources
250) link=https://www.filmon.com/tv/unreliable-sources
     chan_name="Unreliable Sources" ;;
# 251) Insider Exclusive
251) link=https://www.filmon.com/tv/insider-exclusive-tv
     chan_name="Insider Exclusive" ;;
############################### EXTREME SPORTS ####################
# 252) GFL Combat Sports
252) link=https://www.filmon.com/tv/gfl-combat-sports
     chan_name="GFL Combat Sports" ;;
# 253) XCORPS
253) link=https://www.filmon.com/tv/xcorps
     chan_name="XCORPS" ;;
# 254) MMA Now 360
254) link=https://www.filmon.com/tv/mma-now-360
     chan_name="MMA Now 360" ;;
# 255) GLORY Kickboxing
255) link=https://www.filmon.com/tv/glory-kickboxing
     chan_name="GLORY Kickboxing" ;;
# 256) Sledhead 24/7
256) link=https://www.filmon.com/tv/sledhead-247
     chan_name="Sledhead 24/7" ;;
# 257) Destination X
257) link=https://www.filmon.com/tv/destination-x
     chan_name="Destination X" ;;
# 258) Planet X Sport
258) link=https://www.filmon.com/tv/planet-x-sport
     chan_name="Planet X Sport" ;;     
# 259) MMA Now
259) link=https://www.filmon.com/tv/mmanow
     chan_name="MMA Now" ;;
# 260) UFC Next
260) link=https://www.filmon.com/tv/ufc-next
     chan_name="UFC Next" ;;
# 261) Sports Bloopers
261) link=https://www.filmon.com/tv/sports-bloopers-tv
     chan_name="Sports Bloopers" ;;
# 262) Crash Bang Boom
262) link=https://www.filmon.com/tv/crash-bang-boom
     chan_name="Crash Bang Boom" ;;
####################### URBAN  #############################
# 263) Urban Firearms
263) link=https://www.filmon.com/tv/urban-firearms-tv
     chan_name="Urban Firearms" ;;
# 264) Road 2 Fame
264) link=https://www.filmon.com/tv/road2fame
     chan_name="Road 2 Fame" ;;
# 265) WWRTV
265) link=https://www.filmon.com/tv/wwrtv
     chan_name="WWRTV" ;;
# 266) Irrefutable Evidence
266) link=https://www.filmon.com/tv/irrefutable-evidence-tv
     chan_name="Irrefutable Evidence" ;;
# 267) Superfly Cinema
267) link=https://www.filmon.com/tv/super-fly-cinema
     chan_name="SuperFly Cinema" ;;
# 268) Harlem Renaissance
268) link=https://www.filmon.com/tv/harlem-renaissance
     chan_name="Harlem Renaissance" ;;
# 269) TMTV
269) link=https://www.filmon.com/tv/tmtv
     chan_name="TMTV" ;;
# 270) WHOMAG
270) link=https://www.filmon.com/tv/whomag-tv
     chan_name="WHOMAG" ;;
# 271) WHOMAG VIDEOS
271) link=https://www.filmon.com/tv/whomag-video-vision
     chan_name="Whomag Videos" ;;
# 272) New Star TV
272) link=https://www.filmon.com/tv/new-star-tv
     chan_name="New Star TV" ;;
# 273) Bone Thugs
273) link=https://www.filmon.com/tv/bone-thugs-n-harmony
     chan_name="Bone Thugs" ;;
# 274) RMC Live
274) link=https://www.filmon.com/tv/rmc-live
     chan_name="RMC Live" ;;
# 275) The Raw Report
275) link=https://www.filmon.com/tv/the-raw-report
     chan_name="The Raw Report" ;;
# 276) Linkct Network
276) link=https://www.filmon.com/tv/linkct-network
     chan_name="Linkct Network" ;;
# 277) Urban Music Network
277) link=https://www.filmon.com/tv/urban-music-network
     chan_name="Urban Music Network" ;;
# 278) Aspire Now
278) link=https://www.filmon.com/tv/aspirenow-tv
     chan_name="Aspire Now" ;;
# 279) Amp TV
279) link=https://www.filmon.com/tv/amp-tv
     chan_name="Amp TV" ;;    
###################### PARTY TV ##############################     
# 280) Weedmaps
280) link=https://www.filmon.com/tv/weedmaps-tv
   chan_name="Weedmaps" ;;
# 281) Buddy Plant
281) link=https://www.filmon.com/tv/buddy-plant
     chan_name="Buddy Plant" ;;
# 282) PROHBTD
282) link=https://www.filmon.com/tv/prohbtd
     chan_name="PROHBTD" ;;
# 283) Sweet Leaf TV
283) link=https://www.filmon.com/tv/sweet-leaf-tv
     chan_name="Sweet Leaf TV" ;;
###################### LIFESTYLE #################################
# 284) Health and Lifestyle
284) link=https://www.filmon.com/tv/health-and-lifestyle
     chan_name="Health and Lifestyle" ;;
# 285) SOBA recovery
285) link=https://www.filmon.com/tv/soba-network
     chan_name="SOBA Recovery" ;;
# 286) Reader's Digest Lifetime
286) link=https://www.filmon.com/tv/readers-digest-lifetime
     chan_name="Reader's Digest Lifetime" ;;
# 287) Home and Green Living
287) link=https://www.filmon.com/tv/home-and-green-living
     chan_name="Home and Green Living" ;;
# 288) Safe TV
288) link=https://www.filmon.com/tv/safe-tvr
     chan_name="Safe TV" ;;
# 289) Bid America
289) link=https://www.filmon.com/tv/bid-america
     chan_name="Bid America" ;;
# 290) MegaMe TV
290) link=https://www.filmon.com/tv/megame-tv
     chan_name="MegaMe TV" ;;
# 291) Wonderful Living
291) link=https://www.filmon.com/tv/wonderful-living-tv
     chan_name="Wonderful Living" ;;
# 292) Simply Me
292) link=https://www.filmon.com/tv/simply-me
     chan_name="Simply Me" ;;
# 293) The Walk
293) link=https://www.filmon.com/tv/the-walk-tv
     chan_name="The Walk" ;;
# 294) Time TV
294) link=https://www.filmon.com/tv/time-tv
     chan_name="Time TV" ;;
# 295) DRTV
295) link=https://www.filmon.com/tv/drtv
     chan_name="DRTV" ;;
# 296) Medical News
296) link=https://www.filmon.com/tv/medical-news-minute
     chan_name="Medical News" ;;
# 297) Supreme Master
297) link=https://www.filmon.com/tv/supreme-master-tv
     chan_name="Supreme Master" ;;
     
######################## FILMON EXCLUSIVE ###############################     
# 298) FOTV USA
298) link=https://www.filmon.com/tv/fotv-usa
     chan_name="FOTV USA" ;;
# 299) FOTV Workout
299) link=https://www.filmon.com/tv/360-fotv-workout
     chan_name="FOTV Workout" ;;
# 300) FilmOn Sports
300) link=https://www.filmon.com/tv/filmon-sports
     chan_name="FilmOn Sports" ;;
# 301) 360 Experimental
301) link=https://www.filmon.com/tv/360-experimental
     chan_name="360 Experimental" ;;
# 302) BH Cam 360
302) link=https://www.filmon.com/tv/bh-360-cam-2
     chan_name="BH Cam 360" ;;
# 303) R&B Live 
303) link=https://www.filmon.com/tv/rnb-live-afterparty
     chan_name="R&B Live" ;;
# 304) Cast Out of Paradise
304) link=https://www.filmon.com/tv/castoutofparadise-tv
     chan_name="Cast Out of Paradise" ;;
# 305) ROC Summer Explossion
305) link=https://www.filmon.com/tv/roc-summer-explosion
     chan_name="ROC Summer Explosion" ;;
# 306) FilmON Studio
306) link=https://www.filmon.com/tv/filmon-studio
     chan_name="FilmON Studio" ;;
# 307) TV Gold
307) link=https://www.filmon.com/tv/tv-gold
     chan_name="TV Gold" ;;
# 308) Battle Rap
308) link=https://www.filmon.com/tv/battle-rap
     chan_name="Battle Rap" ;;
# 309) Tribe TV
309) link=https://www.filmon.com/tv/tribe-tv
     chan_name="Tribe TV" ;;
# 310) FilmOn Reality
310) link=https://www.filmon.com/tv/filmon-reality
     chan_name="FilmOn Reality" ;;
# 311) FilmOn Red Carpet 
311) link=https://www.filmon.com/tv/filmon-red-carpet
     chan_name="FilmOn Red Carpet" ;;
# 312) Christmas Channel
312) link=https://www.filmon.com/tv/the-christmas-channel-by-zuzu-project
     chan_name="Christmas Channel" ;;
# 313) Nub TV
313) link=https://www.filmon.com/tv/nub-tv
     chan_name="Nub TV" ;;
# 314) Chai Life TV
314) link=https://www.filmon.com/tv/livefromthecenteroftheuniverse
     chan_name="Chai Life TV" ;;
# 315) Joe Nation
315) link=https://www.filmon.com/tv/joe-nation
     chan_name="Joe Nation" ;;
# 316) OC Real Estate
316) link=https://www.filmon.com/tv/oc-real-estate-tv
     chan_name="OC Real Estate" ;;
# 317) MHL TV
317) link=https://www.filmon.com/tv/mhl-tv
     chan_name="MHL TV" ;;
################################## FASHION ##########################
# 318) RUNWAY TV
318) link=https://www.filmon.com/tv/runway-tv
     chan_name="RUNWAY TV" ;;
# 319) TEOS
319) link=https://www.filmon.com/tv/teos-tv
     chan_name="TEOS" ;;
# 320) TV ART LIVE
320) link=https://www.filmon.com/tv/tv-art-live
     chan_name="TV Art Live" ;;
# 321) Runway TV 2016
321) link=https://www.filmon.com/tv/runway-tv-2016
     chan_name="Runway TV" ;;
# 322) Chic
322) link=https://www.filmon.com/tv/chic
     chan_name="Chic" ;;
########################## SCIENCE and TECH ###################################
# 323) NASA TV
323) link=https://www.filmon.com/tv/nasa-hd
     chan_name="NASA TV" ;;
####################### FRENCH TV ########################################
# 324) ARTE Francais
324) link=https://www.filmon.com/tv/arte-francais
     chan_name="ARTE Francais" ;;
# 325) France 0
325) link=https://www.filmon.com/tv/france-0
     chan_name="France 0" ;;
# 326) France 3 Rhone Alpes
326) link=https://www.filmon.com/tv/france-3-rhone-alpes
     chan_name="France 3 Rhone Alps" ;;
# 327) France 3 Alpes
327) link=https://www.filmon.com/tv/france-3-alpes
     chan_name="France 3 Alpes" ;;
# 328) RTS UN
328) link=https://www.filmon.com/tv/rts-un
     chan_name="RTS UN" ;;
# 329) RTS Deux
329) link=https://www.filmon.com/tv/rts-deux
     chan_name="RTS Deux" ;;
#  330) BFM Business
330) link=https://www.filmon.com/tv/bfm-business
     chan_name="BFM Business" ;;
# 331) BFM TV
331) link=https://www.filmon.com/tv/bfm-tv
     chan_name="BFM TV" ;;
# 332) FRANCE 2
332) link=https://www.filmon.com/tv/france-2
     chan_name="France 2" ;;
################################ GERMAN TV  #####################################
# 333) HSE 2 
333) link=https://www.filmon.com/tv/hse24-hd
     chan_name="HSE 2" ;;
# 334) HSE 2 Extra
334) link=https://www.filmon.com/tv/hse24-extra
     chan_name="HSE 2 Extra" ;;
# 335) Kika
335) link=https://www.filmon.com/tv/kika
     chan_name="KIKA" ;;
# 336) ZDF Infokanal
336) link=https://www.filmon.com/tv/zdf-infokanal
     chan_name="ZDF Infokanal" ;;
########################## RUSSIAN TV ######################################
# 337) RTR Planeta
337) link=https://www.filmon.com/tv/rtr-planeta
     chan_name="RTR Planeta" ;;
# 338) Current Time TV
338) link=https://www.filmon.com/tv/current-time-tv
     chan_name="Current Time TV" ;;
# 339) RT Documentary
339) link=https://www.filmon.com/tv/rt-documentary
     chan_name="RT Documentary" ;;
# 340) Perviy Kanal Europa
340) link=https://www.filmon.com/tv/perviy-kanal-europa
     chan_name="Perviy Kanal Europa" ;;
# 341) Music Box Russia
341) link=https://www.filmon.com/tv/music-box-russia
     chan_name="Music Box Russia" ;;
# 342) Rossiya 24
342) link=https://www.filmon.com/tv/rossiya-24
     chan_name="Rossiya 24" ;;
########################### INDIA TV  ##########################################
# 343) Films of India
343) link=https://www.filmon.com/tv/original-films-of-india
     chan_name="Films of India" ;;
# 344) Live 9 TV
344) link=https://www.filmon.com/tv/live9-tv
     chan_name="Live 9 TV" ;;
# 345) Delhi Aaj Tak
345) link=https://www.filmon.com/tv/delhi-aaj-tak
     chan_name="Delhi Aaj Tak" ;;
# 346) Aaj Tak
346) link=https://www.filmon.com/tv/aaj-tak
     chan_name="Aaj Tak" ;;
# 347) Tez TV
347) link=https://www.filmon.com/tv/tez-tv
     chan_name="Tez TV" ;;
# 348) ABP News
348) link=https://www.filmon.com/tv/abp-news
     chan_name="ABP News" ;;  
######################## ITALIAN TV ############################################# 
# 349) Italia Channel
349) link=https://www.filmon.com/tv/canale-italia
     chan_name="Italia Channel" ;;
# 350) Camera dei Deputati
350) link=https://www.filmon.com/tv/camera-dei-deputati
     chan_name="Camera dei Deputati" ;;
# 351) QVC Italy
351) link=https://www.filmon.com/tv/qvc-italia
     chan_name="QVC Italy" ;;
####################### Middle East #############################
# 352) Rotana Aflam
352) link=https://www.filmon.com/tv/rotana-aflam
     chan_name="Rotana Aflam" ;;
# 353) DW Arabia
353) link=https://www.filmon.com/tv/dw-arabia
     chan_name="DW Arabia" ;;
# 354) Al Jazeera Documentary
354) link=https://www.filmon.com/tv/al-jazeera-documentary
     chan_name="Al Jazeera Documentary" ;;
# 355) Al Jazeera Mubasher
355) link=https://www.filmon.com/tv/al-jazeera-mubasher
     chan_name="Al Jazeera Mubasher" ;;
# 356) Al Jazeera Arabic
356) link=https://www.filmon.com/tv/al-jazeera-arabic
     chan_name="Al Jazeera Arabic" ;;
# 357) Saudi TV 2
357) link=https://www.filmon.com/tv/saudi-arabian-tv-2
     chan_name="Saudi TV 2" ;;
# 358) Saudi TV Sports
358) link=https://www.filmon.com/tv/saudi-arabian-tv-sports
     chan_name="Saudi TV Sports" ;;
# 359) Suryoyo Satalite
359) link=https://www.filmon.com/tv/suryoyo-sat
     chan_name="Suryoyo Sat" ;;
# 360) Rotana
360) link=https://www.filmon.com/tv/rotana
     chan_name="Rotana" ;;
# 361) Rotana Clip
361) link=https://www.filmon.com/tv/rotana-clip
     chan_name="Rotana Clip" ;;
# 362) Rotana Khalijah
362) link=https://www.filmon.com/tv/rotana-khalijiah
     chan_name="Rotana Khalijah" ;;
# 363) Rotana Classic
363) link=https://www.filmon.com/tv/rotana-classic
     chan_name="Rotana classic" ;;
# 364) Rotana Masriya
364) link=https://www.filmon.com/tv/rotana-masriya
     chan_name="Rotana Masriya" ;;
# 365) Rotana Cinema
365) link=https://www.filmon.com/tv/rotana-cinema
     chan_name="Rotana Cinema" ;;
# 366) Saudi TV 1
366) link=https://www.filmon.com/tv/saudi-arabian-tv-1
     chan_name="Saudi TV 1" ;;
# 367) Noor Dubai
367) link=https://www.filmon.com/tv/noor-dubai
     chan_name="Noor Dubai" ;;
# 368) iFilm
368) link=https://www.filmon.com/tv/ifilm
     chan_name="iFilm" ;;
# 369) Dubai Sports
369) link=https://www.filmon.com/tv/dubai-sports
     chan_name="Dubai Sports" ;;
########################## SWISS TV  ############################################       
# 370) SRF 1
370) link=https://www.filmon.com/tv/srf-1
     chan_name="SRF 1" ;;
# 371) RSI LA 1
371) link=https://www.filmon.com/tv/rsi-la-1
     chan_name="RSI LA 1" ;;
# 372) Raido Chico
372) link=https://www.filmon.com/tv/radio-chico
     chan_name="Radio Chico" ;;
########################### LATINO  #############################################3
# 373) Peliculas FilmON
373) link=https://www.filmon.com/tv/peliculas-de-filmon
     chan_name="Peliculas FilmON" ;;
# 374) Catwalk Espanol
374) link=https://www.filmon.com/tv/catwalk-en-espanol
     chan_name="Catwalk Espanol" ;;
# 375) Animacion de FilmOn
375) link=https://www.filmon.com/tv/animacion-de-filmon
     chan_name="Animacion de FilmOn" ;;
# 376) Planet Fashion
376) link=https://www.filmon.com/tv/planet-fashion-en-espanol
     chan_name="Planet Fashion" ;;
# 377) HispanTV
377) link=https://www.filmon.com/tv/hispan-tv
     chan_name="HispanTV" ;;
# 378) Telenovelas
378) link=https://www.filmon.com/tv/telenovelas-tv
     chan_name="Telenovelas" ;;
# 379) RT Espanol
379) link=https://www.filmon.com/tv/rt-espanol
     chan_name="RT Espanol" ;;
# 380) DW Latino America
380) link=https://www.filmon.com/tv/dw-latinoamerica
     chan_name="DW Latino America" ;;
# 381) Televideo Latino
381) link=https://www.filmon.com/tv/televideo-latino
     chan_name="Televido Latino" ;;
############################# CLASSIC TV  ####################################
# 382) The Lucy Show
382) link=https://www.filmon.com/tv/the-lucy-show
     chan_name="The Lucy Show" ;;
# 383) Date With the Angels TV
383) link=https://www.filmon.com/tv/date-with-angels-tv
     chan_name="Date with the Angels" ;;
# 384) Man with a Camera
384) link=https://www.filmon.com/tv/man-with-a-camera-tv
     chan_name="Man with a Camera" ;;
# 385) Colgate Comedy Hour
385) link=https://www.filmon.com/tv/the-colgate-comedy-hour
     chan_name="Colgate Comedy Hour" ;;
# 386) Catwalk
386) link=https://www.filmon.com/tv/catwalk
     chan_name="Catwalk" ;;
# 387) Life of Riley
387) link=https://www.filmon.com/tv/the-life-of-riley-tv
     chan_name="Life of Riley" ;;
# 388) Strange Paradise
388) link=https://www.filmon.com/tv/strange-paradise
     chan_name="Strange Paradise" ;;
# 389) Red Skeleton
389) link=https://www.filmon.com/tv/the-red-skelton-show-tv
     chan_name="Red Skeleton" ;;
# 390) Dragnet
390) link=https://www.filmon.com/tv/dragnet-tv
     chan_name="Dragnet" ;;
# 391) Private Secretary
391) link=https://www.filmon.com/tv/private-secretary-tv
     chan_name="Private Secretary" ;;
# 392) Suspense TV
392) link=https://www.filmon.com/tv/suspense-tv
     chan_name="Suspense TV" ;;
# 393) Timeless Westerns
393) link=https://www.filmon.com/tv/timeless-westerns
     chan_name="Timeless Westerns" ;;
# 394) You bet your Life
394) link=https://www.filmon.com/tv/you-bet-your-life-tv
     chan_name="You Bet Your Life" ;;
# 395) Flash Gordon
395) link=https://www.filmon.com/tv/flash-gordon
     chan_name="Flash Gordon" ;;
# 396) Betty Boop
396) link=https://www.filmon.com/tv/betty-boop-tv
     chan_name="Betty Boop" ;;
# 397) Fury TV
397) link=https://www.filmon.com/tv/fury-tv
     chan_name="Fury TV" ;;
# 398) Cisco Kid
398) link=https://www.filmon.com/tv/cisco-kid-tv
     chan_name="Cisco Kid" ;;
# 399) Bonanza
399) link=https://www.filmon.com/tv/filmon-binge-bonanza
     chan_name="Bonanza" ;;
# 400) Ozzie and Harriet
400) link=https://www.filmon.com/tv/filmon-binge-ozzie-harriet
     chan_name="Ozzie and Harriet" ;;
# 401) One Step Beyond
401) link=https://www.filmon.com/tv/filmon-binge-one-step-beyond
     chan_name="One Step Beyond" ;;
# 402) Charlie Chaplin
402) link=https://www.filmon.com/tv/filmon-binge-charlie-chaplin
     chan_name="Charlie Chaplin" ;;
# 403) The Beverly Hillbillies
403) link=https://www.filmon.com/tv/filmon-binge-the-beverly-hillbillies
     chan_name="The Beverly Hillbilies" ;;
# 404) Robin Hood
404) link=https://www.filmon.com/tv/filmon-binge-adventures-of-robin-hood
     chan_name="Robin Hood" ;;
# 405) Timeless TV
405) link=https://www.filmon.com/tv/timeless-television
     chan_name="Timeless TV" ;;
# 406) Spud's Crime and Punishment
406) link=https://www.filmon.com/tv/spuds-crime-and-punishment-channel
     chan_name="Spud's Crime and Punishment" ;;
# 407) The Dick Van Dyke Show
407) link=https://www.filmon.com/tv/the-dick-van-dyke-show
     chan_name="The Dick Van Dyke Show" ;;
####################### SHORT FILMS ####################################
# 408) Funny Shorts
408) link=https://www.filmon.com/tv/funny-shorts
     chan_name="Funny Shorts" ;;
# 409) Movies
409) link=https://www.filmon.com/tv/movies
     chan_name="Movies" ;;
# 410) Dancing Shorts
410) link=https://www.filmon.com/tv/dancing-shorts
     chan_name="Dancing Shorts" ;;
# 411) Reality Shorts
411) link=https://www.filmon.com/tv/reality-shorts
     chan_name="Reality Shorts" ;;
# 412) Acid TV
412) link=https://www.filmon.com/tv/acid-tv
     chan_name="Acid TV" ;;
# 413) Horror TV
413) link=https://www.filmon.com/tv/horror-tv
     chan_name="Horror TV" ;;
# 414) Music Videos
414) link=https://www.filmon.com/tv/music-videos
     chan_name="Music Videos" ;;
# 415) Sci Fi
415) link=https://www.filmon.com/tv/sci-fi
     chan_name="Sci Fi" ;;
# 416) Micro Shorts
416) link=https://www.filmon.com/tv/micro-shorts
     chan_name="Micro Shorts" ;;
# 417) Sproklets and Splices
417) link=https://www.filmon.com/tv/sprockets-and-splices-tv
     chan_name="Sprokets and Splices" ;;
# 418) Teen Shorts
418) link=https://www.filmon.com/tv/teen-shorts
     chan_name="Teen Shorts" ;;
# 419) Drama Shorts
419) link=https://www.filmon.com/tv/drama-shorts
     chan_name="Drama Shorts" ;;
# 420) Digital Animation
420) link=https://www.filmon.com/tv/digital-animation
     chan_name="Digital Animation" ;;
# 421) Documentary
421) link=https://www.filmon.com/tv/documentary
     chan_name="Documentary" ;;
     
######################## OUTDOORS   ########################################33
# 422) Bayou Country
422) link=https://www.filmon.com/tv/bayou-country-outdoors
     chan_name="Bayou Country" ;;
# 423) Student of the Gun
423) link=https://www.filmon.com/tv/student-of-the-gun
     chan_name="Student of the Gun" ;;
# 424) Ultimate Outdoors
424) link=https://www.filmon.com/tv/ultimate-outdoors
     chan_name="Ultimater Outdoors" ;;
# 425) Hunt Channel
425) link=https://www.filmon.com/tv/hunt-channel
     chan_name="Hunt Channel" ;;
# 426) Thouroughbred World Show
426) link=https://www.filmon.com/tv/thoroughbred-show
     chan_name="Thouroughbred World Show" ;;
# 427) Wilderness Channel
427) link=https://www.filmon.com/tv/wilderness-channel
     chan_name="Wilderness Channel" ;;
# 428) Pursuit
428) link=https://www.filmon.com/tv/pursuit-channel
     chan_name="Pursuit" ;;
##################### TRAVEL ###########################
# 429) HWC
429) link=https://www.filmon.com/tv/hwc-network
     chan_name="HWC" ;;
# 430) The Jet Set Channel
430) link=https://www.filmon.com/tv/the-jet-set-channel
     chan_name="The Jet Set Channel" ;;
# 431) Discover Malta
431) link=https://www.filmon.com/tv/discover-malta
     chan_name="Discover Malta" ;;
# 432) Mega Destinations
432) link=https://www.filmon.com/tv/mega-destinations
     chan_name="Mega Destinations" ;;
# 433) 30A TV
433) link=https://www.filmon.com/tv/30a-tv
     chan_name="30A TV" ;;
# 434) OBX TV
434) link=https://www.filmon.com/tv/obxtv
     chan_name="OBX TV" ;;
# 435) Travel Channel
435) link=https://www.filmon.com/tv/travel-channel1
     chan_name="Travel Channel" ;;
# 436) Landmarks
436) link=https://www.filmon.com/tv/landmarks
     chan_name="Landmarks" ;;
# 437) Infamous Places
437) link=https://www.filmon.com/tv/infamous-places
     chan_name="Infamous Places" ;;  
############################ SOMALI TV ####################################     
# 438) Somalia SNL TV
438) link=https://www.filmon.com/tv/snltv-somaliland-national-tv
     chan_name="SNL TV Somalia" ;;
# 439) Universal TV Somalia
439) link=https://www.filmon.com/tv/universaltv-somali-television
     chan_name="Universal TV Somalia" ;;
# 440) Somali National TV
440) link=https://www.filmon.com/tv/somali-national-tv
     chan_name="Somali National TV" ;;
# 441) Horn Cable Somalia
441) link=https://www.filmon.com/tv/horn-cable-tv
     chan_name="Horn Cable Somalia" ;;
# 442) ESTV Somali Ethiopia
442) link=https://www.filmon.com/tv/estv-somali-ethiopia-tv
     chan_name="ESTV Somali Ethiopia" ;;
# 443) Kalsan TV Somali
443) link=https://www.filmon.com/tv/kalsan-tv-somali
     chan_name="Kalsan TV Somali" ;;
######################## GREEK ###############################################
# 444) RIK Greek
444) link=https://www.filmon.com/tv/rik
     chan_name="RIK Greece" ;;
############################# RELIGION
# 445) Hispanic American Faith
445) link=https://www.filmon.com/tv/hispanic-american-faith-tv
     chan_name="Hispanic American Faith" ;;
# 446) You Shall Live
446) link=https://www.filmon.com/tv/you-shall-live
     chan_name="You Shall Live" ;;
# 447) Preach the Word
447) link=https://www.filmon.com/tv/preach-the-word
     chan_name="Preach the Word" ;;
# 448) Audio Scripture
448) link=https://www.filmon.com/tv/audio-scripture-channel
     chan_name="Audio Scripture" ;;
# 449) Cyber Church
449) link=https://www.filmon.com/tv/cyber-church-tv
     chan_name="Cyber Church" ;;
# 450) Faith Cinema
450) link=https://www.filmon.com/tv/faith-cinema
     chan_name="Faith Cinema" ;;
# 451) NRB
451) link=https://www.filmon.com/tv/nrb
     chan_name="NRB" ;;
# 452) Glory TV
452) link=https://www.filmon.com/tv/glory-tv
     chan_name="Glory TV" ;;
# 453) Dunamis Radio TV
453) link=https://www.filmon.com/tv/dunamis-radio-tv
     chan_name="Dunamis Radio" ;;
# 454) Global Music TV
454) link=https://www.filmon.com/tv/global-music-tv
     chan_name="Global Music TV" ;;
# 455) The Church Channel
455) link=https://www.filmon.com/tv/the-church-channel
     chan_name="The Church Channel" ;;
# 456) TBN
456) link=https://www.filmon.com/tv/tbn
     chan_name="TBN" ;;
# 457) Daystar
457) link=https://www.filmon.com/tv/daystar
     chan_name="Daystar" ;;
# 458) Catholic TV
458) link=https://www.filmon.com/tv/catholic-tv
     chan_name="Catholic TV" ;;
################################ CELEBRITY TV 
# 459) Scenester TV
459) link=https://www.filmon.com/tv/scenestertv
     chan_name="Scenester TV" ;;
# 460) Celeberity Action Network
460) link=https://www.filmon.com/tv/celebrity-action-network
     chan_name="Celebrity Action Network" ;;
# 461) Dame Dash TV
461) link=https://www.filmon.com/tv/dame-dash-tv
     chan_name="Dame Dash TV" ;;
# 462) Nik Richie Network
462) link=https://www.filmon.com/tv/nik-richie-network
     chan_name="Nik Richie Network" ;;
# 463) Celebrity Icons
463) link=https://www.filmon.com/tv/celebrity-icons-tv
     chan_name="Celebrity Icons" ;;
# 464) Andy Dick
464) link=https://www.filmon.com/tv/andy-dick
     chan_name="Andy Dick" ;;
# 465) Janice TV
465) link=https://www.filmon.com/tv/janice-tv
     chan_name="Janice TV" ;;
# 466) Kato Katelin
466) link=https://www.filmon.com/tv/kato
     chan_name="Kato Katelin" ;;
# 467) PPV Celebrity Fight
467) link=https://www.filmon.com/tv/ppv-celebrity-fight
     chan_name="PPV Celebrity Fight" ;;
# 468) Vertro Live
468) link=https://www.filmon.com/tv/vertrolive
     chan_name="Vertro Live" ;;
# 469) Star Shop
469) link=https://www.filmon.com/tv/starshop
     chan_name="Star Shop" ;;  
############################# FOOD #########################################
# 470) Wine RAM
470) link=https://www.filmon.com/tv/wineram
     chan_name="Wine Ram" ;;
# 471) World of Wine
471) link=https://www.filmon.com/tv/world-of-wine
     chan_name="World of Wine" ;;
# 472) The Chef Roc Show
472) link=https://www.filmon.com/tv/the-chef-roc-tv-show
     chan_name="The Chef Roc Show" ;;
# 473) Food Network Plus 1
473) link=https://www.filmon.com/tv/food-network-plus-1
     chan_name=Food Network + 1"" ;;
# 474) World Food Championships
474) link=https://www.filmon.com/tv/world-food-championships
     chan_name="World Food Championships" ;;
# 475) Dude Food
475) link=https://www.filmon.com/tv/dude-food
     chan_name="Dude Food" ;;
# 476) Food Network
476) link=https://www.filmon.com/tv/food-network
     chan_name="Food Network" ;;
# 477) iFood TV
477) link=https://www.filmon.com/tv/ifood-tv
     chan_name="iFood TV" ;;
# 478) Indian Recipes
478) link=https://www.filmon.com/tv/indian-recipes
     chan_name="Indian Recipes" ;;
# 479) Wine Oh TV 
479) link=https://www.filmon.com/tv/wine-oh-tv
     chan_name="Wine Oh TV" ;;
# 480) Gastrolab
480) link=https://www.filmon.com/tv/gastrolab
     chan_name="Gastrolab" ;;
# 481) Outdoor Cooking Channel
481) link=https://www.filmon.com/tv/outdoor-cooking-channel
     chan_name="Outdoor Cooking Channel" ;;
# 482) Wine Channel TV
482) link=https://www.filmon.com/tv/wine-channel-tv
chan_name="Wine Channel TV" ;;
# 483) ECO RICO
483) link=https://www.filmon.com/tv/eco-rico
     chan_name="Eco Rico" ;;
# 484) Veg TV
484) link=https://www.filmon.com/tv/veg-tv
     chan_name="Veg TV" ;;
     
############################## CARS AUTO
#  485) Auto Channel
485) link=https://www.filmon.com/tv/auto-channel
     chan_name="Auto Channel" ;;
# 486) Raceline TV
486) link=https://www.filmon.com/tv/raceline-tv
     chan_name="Raceline TV" ;;
# 487) Race Central
487) link=https://www.filmon.com/tv/race-central-tv
     chan_name="Race Central" ;;
# 488) Honda HPD
488) link=https://www.filmon.com/tv/honda-hpd
     chan_name="Honda HPD" ;;
# 489) Torque and Tush
489) link=https://www.filmon.com/tv/torque-and-tush
     chan_name="Torque and Tush" ;;
# 490) MotorZ
490) link=https://www.filmon.com/tv/motorz
     chan_name="MotorZ" ;;
# 491) Steel Dreams
491) link=https://www.filmon.com/tv/steel-dreams
     chan_name="Steel Dreams" ;;
# 492) Distant Roads
492) link=https://www.filmon.com/tv/distant-roads
     chan_name="Distant Roads" ;;
############################# EDUCATION
# 493) The Florida Channel
493) link=https://www.filmon.com/tv/the-florida-channel
     chan_name="The Florida Channel" ;;
# 494) Make Your Move
494) link=https://www.filmon.com/tv/make-your-move
     chan_name="Make Your Move" ;;
# 495) Smarts TV
495) link=https://www.filmon.com/tv/smarts-tv
     chan_name="Smarts TV" ;;
# 496) Parenting International
496) link=https://www.filmon.com/tv/parenting-international-tv
     chan_name="Parenting International" ;;
########################## SHOPPING
# 497) Jewlery TV
497) link=https://www.filmon.com/tv/jewelry-tv
     chan_name="Jewlery TV" ;;
# 498) QVC HD 
498) link=https://www.filmon.com/tv/qvc-hd
     chan_name="QVC HD" ;;
# 499) Shop N Give
499) link=https://www.filmon.com/tv/shop-n-give
     chan_name="Shop N Give" ;;
# 500) Deals TV
500) link=https://www.filmon.com/tv/deals-tv
     chan_name="Deals TV" ;;
# 501) Beauty IQ
501) link=https://www.filmon.com/tv/beauty-iq
     chan_name="Beauty IQ" ;;
# 502) QVC
502) link=https://www.filmon.com/tv/qvc
     chan_name="QVC" ;;
# 503)  American Auctions
503) link=https://www.filmon.com/tv/americas-auction-network
     chan_name="American Auction" ;;
# 504) Caribbean Shopping
504) link=https://www.filmon.com/tv/caribbean-shopping-channel
     chan_name="Caribbean Shopping" ;;
# 505) Product Showcase
505) link=https://www.filmon.com/tv/product-showcase-network
     chan_name="Product Showcase Network" ;;
############################### CARIBBEAN
# 506) Calabash TV
506) link=https://www.filmon.com/tv/calabash-tv
     chan_name="Calabash TV" ;;
# 507) Caribbean Lifestyle
507) link=https://www.filmon.com/tv/caribbean-lifestyle-channel
     chan_name="Caribbean Lifestyle" ;;
# 508) Scruffy TV
508) link=https://www.filmon.com/tv/scruffy-tv
     chan_name="Scruffy TV" ;;
############################### ASIAN
# 509) Arirang TV Korea
509) link=https://www.filmon.com/tv/arirang-tv
     chan_name="Ariran TV Korea" ;;
# 510) VTC 10
510) link=https://www.filmon.com/tv/vtc-10
     chan_name="VTC 10" ;;
# 511) Voice of America Weishi
511) link=https://www.filmon.com/tv/voa-weishi
     chan_name="Voice of America Weishi" ;;
################################ AFRICAN
# 512) Eri Eritrea TV Africa
512) link=https://www.filmon.com/tv/eri-tv
     chan_name="Eri TV Eritrea";;
# 513) Nollywood Nigeria
513) link=https://www.filmon.com/tv/nollywood
     chan_name="Nollywood" ;;
# 514) Igboro TV
514) link=https://www.filmon.com/tv/igboro-tv
     chan_name="I Goboro TV" ;;
######################### KAZAKH
# 515) KAZAKH
515) link=https://www.filmon.com/tv/kazakh-tv
     chan_name="Kazakh TV" ;;
####################### RADIO   ##########################################     
# 516) The Marko Polka Show
516) link=https://www.filmon.com/tv/the-marko-polka-show
     chan_name="The Marko Polka Show" ;;
# 517) V104 Live
517) link=https://www.filmon.com/tv/v104-live
     chan_name="V104 Live" ;;
# 518) Daytona's Surf
518) link=https://www.filmon.com/tv/daytonas-surf
     chan_name="Daytona's Surf" ;;
# 519) Classic Oldies Jukebox
519) link=https://www.filmon.com/tv/classic-oldies-jukebox-hd-internet-radio
     chan_name="Classic Oldies Jukebox" ;;
# 520) Radio 337 The Cajun
520) link=https://www.filmon.com/tv/radio337-the-cajun
     chan_name="Radio 337 The Cajun" ;;
# 521) J and J FM
521) link=https://www.filmon.com/tv/j-and-j-fm
     chan_name="J and J FM" ;;
# 522) U Matter 2 Radio
522) link=https://www.filmon.com/tv/u-matter-2-radio
     chan_name="U Matter 2 Radio" ;;
# 523) WXEA 94.7
523) link=https://www.filmon.com/tv/wxea-947-1071
     chan_name="WXEA 94.7" ;;
# 524) The Wise Choice
524) link=https://www.filmon.com/tv/the-wise-choice
     chan_name="The Wise Choice" ;;
# 525) FONYE Dance
525) link=https://www.filmon.com/tv/fonye-dance
     chan_name="FONYE Dance" ;;
# 526) Key 56 Internet Radio
526) link=https://www.filmon.com/tv/key56-internet-radio
     chan_name="Key 56 Internet Radio" ;;
# 527) A-1 Bluegrass Favorites
527) link=https://www.filmon.com/tv/a-1-bluegrass-favorites
     chan_name="A-1 Bluegrass Favorites" ;;
# 528) WZQR Talks
528) link=https://www.filmon.com/tv/wzqr-talks
     chan_name="WZQR Talks" ;;
esac
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
elif [ "$input" -lt 1400 ]
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
men_num=$(expr "$men_num" % 3)
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
    torsocks -a "$torsocks_ip" -P "$torsocks_port" -i mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="yes" --fullscreen "$link"
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
use_cookies="no"

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
