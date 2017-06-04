#! /bin/sh
######################################################################
# Title: endtv.sh
# Description:  Clearnet streaming from FilmOnTV of selected TV 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.05
# Revision Date: May 1, 2017
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
version="0.05"
rev_date="01/05/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt" 
cache_size=4096

entry="null"
# clear cookie
echo " " > "$cookie"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      EndTV  "$version"   ===================================================================================="
   echo "=========================================================================================================================================================================="
   echo "=======UK ======    =====SPORTS======  78)B-Movie!          117)Film Detective  156)Classic Arts  193)CBeebies        230)Truth Files   268)RMC Live      306)Christmas "    
   echo "1)BBC One          40)Grandstand Show  79)Alien Invasion    ===ENTERTAINMENT====157)Jazz Radio    194)CBBC            231)NewsMax       269)Raw Report    307)Nub TV  " 
   echo "2)My Face My Body  41)Football Fanatics80)Horror Channel    118)CRAGG           =====BIKINI=====  195)Talya Toys      232)TV 47         270)Linkct Network308)Chai Life "  
   echo "3)V Channel        42)FilmOn Tennis    =======MOVIES======= 119)Shockya Trailers158)Player        196)Kartoon Klassic 233)VOA           271)Urban Music   309)Joe Nation"             
   echo "4)Reality TV       43)Snooker Legends  81)FilmOn Classics   120)California Life 159)J CLub        197)Fun Little      234)FilmOn NEWS   272)Aspire Now    310)OCRealEstate"  
   echo "5)Ireland's Country44)The Ring TV      82)Love On The Range 121)Rose Parade     160)Bikini Down   198)Tayla Tea       235)Al Jazeera    273)Amp TV        311)MHL TV  "  
   echo "6)Britrox          45)Gali Lucha Libre 83)Silent Cinema     122)Screensaver     161)Cheerleaders  199)Wild Animals    236)Bloomberg     274)Weedmaps      312)RUNWAY TV "
   echo "7)Dr. Fab Show     46)Beach Sports     84)ChristmasTime     123)Drone TV        162)Party Girls   200)FilmOn Kids     237)DW English    275)Buddy Plant   313)TEOS "
   echo "8)BBC News         47)Pugalism         85)Real Life Films   124)Miss Multiverse 163)Showing Off   201)Smile Child     238)Russia Today  276)PROHBTD       314)TV ART"
   echo "9)BBC 1 Wales      48)Inside The Ring  86)Sherlock Holmesq  125)Vape Channel    164)Show and Tell 202)Mouse House     239)America Thinks277)Sweet Leaf    315)RunwayTV"
   echo "10)BBC 1 Scotland  49)Emerging Sports  87)Xtreme IND        126)Trinity Heart   165)Miss Top      =====BUSINESS=====  240)CGTN          ===LIFESTYLE===   316)Chic "
   echo "11)BBC 1 N Ireland 50)Softball 360     88)Seven Sins        127)Talent Know     166)Bikini TV     203)Crowd Angels    241)DVID          278)Health Life   317)NASA TV "
   echo "12)BBC Two         51)Golden Boy       89)The Monarch       128)EZ Way          167)Bikini Kitchen204)Red Chip        242)Press TV      279)SOBA          ===FRENCH==="
   echo "13)BBC Parliament  52)FilmOn Wrestling 90)Trailer Nut       129)Tomorrow Pics   168)Miami TV      205)Biz TV          243)Job Channel   280)Readers Digest318)ARTE  "
   echo "14)BBC Four        53)FilmOn Football  91)Thespian Theater  130)Razzies         =====COMEDY====== ===DOCUMENTARY====  244)Unreliable    281)Green Living  319)France 0  "  
   echo "15)ITV             54)Roopstigo        92)Rated B           131)24.7 The Stream 169)ComiCZoo      206)CCTV 9          245)Insider Ex    282)Safe TV       320)France 3  "
   echo "16)ITV +1          55)Fighting Athlete 93)Movie Loft TV     132)Miami Music     170)Placeholders  207)Fame TV         ==EXTREME SPORTS==283)Bid America   321)France 3  "
   echo "17)ITV2            56)Ultimate Disc    94)Dragon Arena      133)Talent Watch    171)Lumbfilm      208)Locomotion      246)GFL Combat    284)MegaMe        322)RTS UN  "	
   echo "18)ITV2 +1         57)FilmOn Boxing    95)Mad Science Cinema134)HotRock         172)FimOn Comedy  209)FBI Insider     247)XCORPS        285)Wonderful Life323)RTS Deux"
   echo "19)ITV3            58)Game Time        96)FilmOn Family     135)Hot Country     173)Spud's Funny  210)FilmOn Docs     248)MMA Now       286)Simply Me     324)BFM Biz"  
   echo "20)ITV3 +1         59)1 on 1 Boxing    97)Hollywood War     136)Music Mix       174)SupaPirateBoot211)UFO NEWS        249)GLORY Kick    287)The Walk      325)BFM TV"
   echo "21)ITV4            60)AFL Classic      98)Bloodzillathon    137)Guitar Lessons  175)Fun Little    212)WAKAJ TV        250)Sledhead      288)Time TV       326)France 2"       
   echo "22)ITV4 +1         61)Cheer Channel    99)Banned Western    138)Soundtrack      176)Comedy Time   213)FilmOn Bio      251)DestX         289)DRTV          ===GERMAN==="  
   echo "23)ITV Be          62)Football Heroes  100)Eurotrash        139)EDM TV          177)EyeforanEye   214)Victory at Sea  252)PlanetX       290)Medical News  327)HSE 2a "
   echo "24)Channel 4       63)Live Boxing      101)High School      140)Jimmy Lloyd SWS ======KIDS======= 215)FilmOn War      253)MMA Now       291)Supreme Master328)HSE 2b"  
   echo "25)E4              64)Army Boxing      102)Award Cinema     141)Beatles Stories 178)KIDS ZONE     216)Ghost Hunters   254)UFC Next      =====FILMON====   329)Kika "
   echo "26)More4           65)Tuff TV          103)New York         142)DM TV           179)AngelsAttic   217)Timeless Bios   255)Sports Blooper292)FOTV USA      330)ZDF Info"
   echo "27)Channel 5       66)Disability Sports104)Major Crimes     143)Country Star    180)SuperGeekHero 218)RealLife History256)Crash Bang    293)FOTV Workout  ===RUSSIAN== "
   echo "28)5*              67)Fashion News     105)Cultra           144)Josh and JB     181)AA Create     219)Living History  ====URBAN/PARTY===294)FilmOn Sports 331)RTR Planet"
   echo "29)5USA            ======HORROR========106)iFlix TV         145)JBTV            182)Reading       220)WW2 TV          257)Urban Firearms295)360 Exp       332)CurrentTime"    
   echo "30)Really          68)FilmOn Horror    107)Campy Channel    146)Jazz TeeVee     183)OM NOM        221)Aliens UFOS     258)Road 2 Fame   296)BH Cam 360    333)RT Docs"
   echo "31)Yesterday       69)American Horrors 108)Filmon Stars     147)Dancing Machine 184)Kids Rock     222)Crime Inc.      259)WWRTV         297)R&B Live      334)Perviy "
   echo "32)Pick TV         70)Midnight Release 109)KungFu Classics  148)Inside Music    185)Tiny Pop      223)Short a Lesson  260)Evidence      298)Cast Out      335)Music Box " 
   echo "33)CBS Reality     71)Chillings        110)Double Feature   149)Tipstr.TV       186)Kix!           =======NEWS======  261)Superfly      299)ROC Summer    336)Rossiya 24"  
   echo "34)CBS Reality+1   72)Monster Madhouse 111)FilmOn Grab Bag  150)Clubbing TV     187)Tails TV      224)Newsy           262)Harlem        300)FilmON Studio ===INDIA TV=="
   echo "35)CBS Drama       73)Zombie Underworld112)Sci-Fi Telly     151)Noise Network   188)POP           225)CDTV            263)TMTV          301)TV Gold       337)Films India"
   echo "36)CBS Action      74)Vampire Empire   113)Hollywoodland    152)Janey Kirk      189)Popeye        226)EIC TV          264)WHOMAG        302)Battle Rap    338)Live 9 TV "
   echo "37)truTV           75)Creepy Crawly    114)Western Channel  153)FilmOn Jazz     190)Funny Company 227)Global Goals    265)WHOMAG VID    303)Tribe TV      339)Delhi Aaj Tak"	
   echo "38)Psychic Today   76)RSquared         115)Matriarch        154)FilmOn Rock     191)AngelAttic    228)Native Nations2 266)New Star      304)FOn Reality   340)Aaj Tak  "
   echo "39)FusionPlus TV   77)Macabre Theater  116)Film 4           155)JCTV            192)Cat TV        229)France 24       267)Bone Thugs    305)Red Carpet    341)Tez TV  "
   echo "==========================================================================================================================================================================="
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      EndTV  "$version"   ================================================================================="
   echo "======================================================================================================================================================================="
   echo "342)ABP News          377)Date with Angels  ======OUTDOORS====== 451)DAYSTAR        487)Florida          521)A1 Bluegrass  560)---------- 600)---------- 640)---------- "    
   echo "===ITALY===           378)Man with Camera   416)Bayou Country    452)CATHOLIC TV    488)Make Your Move   522)WZQR Talk     561)---------- 601)---------- 641)---------- " 
   echo "343)Italia Channel    379)Colgate Comedy    417)Gun Student       ======CELEBS====  489)Smarts TV        522)---------     562)---------- 602)---------- 642)---------- "  
   echo "344)Camera Deputati   380)Catwalk           418)Ultimate Outdoor 453)Screenster     490)Parenting TV     523)---------     563)---------- 603)---------- 643)---------- "             
   echo "345)QVC Italy         381)Life of Riley     419)Hunt Channel     454)Celeb Action   =====SHOPPING====    524)---------     564)---------- 604)---------- 644)---------- "  
   echo "==MIDDLE EAST==       382)Strange Paradise  420)Thouroughbred    455)Dame Dash      491)Jewelry TV       525)---------     565)---------- 605)---------- 645)---------- "  
   echo "346)Rotana Aflam      383)Red Skeleton      421)Wilderness       456)Nik Richie     492)QVC HD           526)---------     566)---------- 606)---------- 646)---------- "
   echo "347)DW Arabia         384)Dragnet           422)Pursuit          457)Celeb Icons    493)Shop-N-Give      527)---------     567)---------- 607)---------- 647)---------- "
   echo "348)AlJazeera Docs    385)Private Secretary ======TRAVEL======   458)Andy Dick      494)Deals TV         528)---------     568)---------- 608)---------- 648)---------- "
   echo "349)AlJazeeraMubasher 386)Suspense TV       423)HWC              459)Janice TV      495)Beauty IQ        529)---------     569)---------- 609)---------- 649)---------- "
   echo "350)AlJazeera Arabic  387)Timeless Westerns 424)Jet Set          460)Kato Katelin   496)QVC              530)---------     570)---------- 610)---------- 650)---------- "
   echo "351)Saudi TV 2        388)You bet your Life 425)Mata             461)Celeb Fight    497)America Auction  531)---------     571)---------- 611)---------- 651)---------- "
   echo "352)Saudi TV Sports   389)Flash Gordon      426)Mega Dest        462)Vertro Live    498)Caribbean Shop   532)---------     572)---------- 612)---------- 652)---------- "
   echo "353)Suryoyo Satalite  390)Betty Boop        427)30A TV           463)Star Shop      499)Product Show     533)---------     573)---------- 613)---------- 653)---------- "
   echo "354)Rotana            391)Fury TV           428)OBX TV           =====FOOD=======   ====CARIBBEAN====    534)---------     574)---------- 614)---------- 654)---------- "  
   echo "355)Rotana Clip       392)Cisco Kid         429)Travel           464)Wine Ram       500)Calabash         535)---------     575)---------- 615)---------- 655)---------- "
   echo "356)Rotana Khalijah   393)Bonanza           430)Landmarks        465)World of Wine  501)Caribbean Life   536)---------     576)---------- 616)---------- 656)---------- "
   echo "357)Rotana Classic    394)Ozzie and Harriet 431)Infamous Places  466)The Chef Roc   502)Scruffy TV       537)---------     577)---------- 617)---------- 657)---------- "	
   echo "358)Rotana Masriya    395)One Step Beyond   =====SOMALIA======   467)Food Network+1 =======ASIAN======   538)---------     578)---------- 618)---------- 658)---------- "
   echo "359)Rotana Cinema     396)Charlie Chaplin   432)SNL TV           468)Food Champ     503)Arirang TV       539)---------     579)---------- 619)---------- 659)---------- "  
   echo "360)Saudi TV 1        397)Beverly Hillbilies433)Universal TV     469)Dude Food      504)VTC-10           540)---------     580)---------- 620)---------- 660)---------- "
   echo "361)Noor Dubai        398)Robin Hood        434)National         470)Food Network   505)VOA Weishi       541)---------     581)---------- 621)---------- 661)---------- "       
   echo "362)iFilm             399)Timeless TV       435)Horn Cable       471)iFood TV       ======AFRICAN=====   542)---------     582)---------- 622)---------- 662)---------- "  
   echo "363)Dubai Sports      400)Spud's Crime      436)ESTV             472)Indian Recipe  506)ERI TV           543)---------     583)---------- 623)---------- 663)---------- "
   echo "=====SWISS =====      401)Dick Van Dyke     437)Kalsanv          473)Wine Oh        507)Nollywood        544)---------     584)---------- 624)---------- 664)---------- "  
   echo "364)SRF 1             == SHORT FILMS==      ======GREEK======    474)Gastrolab      508)iGboro TV        545)---------     585)---------- 625)---------- 665)---------- "
   echo "365)RSI LA 1          402)Funny Shorts      438)RIK              475)Outdoor Cook   =====KAZAKH=======   546)---------     586)---------- 626)---------- 666)---------- "
   echo "366)Raido Chico       403)Movies            =====RELIGION=====   476)Wine Channel   509) Kazakh TV       547)---------     587)---------- 627)---------- 667)---------- "
   echo "=====LATINO======     404)Planet Fashion    439)Hispanic         477)Eco Rico       ======RADIO=======   548)---------     588)---------- 628)---------- 668)---------- "
   echo "367)Dancing Shorts    405)Reality Shorts    440)You Shall Live   478)Veg TV         510)Marko Polka      549)---------     589)---------- 629)---------- 669)---------- "    
   echo "368)Peliculas FilmON  406)Acid TV           441)Preach the Word  =======CARS======= 511)v104 Live        550)---------     590)---------- 630)---------- 670)---------- "
   echo "369)Catwalk Espanol   407)Horror TV         442)Audio Scripture  479)Auto Channel   512)Daytona Surf     551)---------     591)---------- 631)---------- 671)---------- "
   echo "370)Animacion FilmOn  408)Music Videos      443)Cyber Church     480)Raceline TV    513)Classic Oldies   552)---------     592)---------- 632)---------- 672)---------- " 
   echo "371)HispanTV          409)Sci Fi            444)Faith Cinema     481)Race Central   514)The Cajun        553)----------    593)---------- 633)---------- 673)---------- "  
   echo "372)Telenovelas       410)Micro Shorts      445)NRB              482)Honda HPD      515)J&J FM           554)---------     594)---------- 634)---------- 674)---------- "
   echo "373)RT Espanol        411)Sprokets          446)GLORY TV         483)Torque Tush    516)U Matter 2       555)---------     595)---------- 635)---------- 675)---------- "
   echo "374)DW Latino America 412)Teen Shorts       447)Dunamis          484)MotorZ         517)WXEA 94.7        556)---------     596)---------- 636)---------- 676)---------- "
   echo "375)Televideo Latino  413)Drama Shorts      448)Global Music     485)Steel Dreams   518)Wise Choice      557)---------     597)---------- 637)---------- 677)---------- "	
   echo "===CLASSIC TV===      414)Digi Animation    449)Church Channel   486)Distant Roads  519)FONYE Dance      558)---------     598)---------- 638)---------- 678)---------- "
   echo "376)The Lucy Show     415)Documentary       450)TBN              ====EDUCATION===   520)Key 56           559)---------     599)---------- 639)---------- 679)---------- "
   echo "=========================================================================================================================================================================="
echo " " 
}	

for arg in $@
do 
 if [ "$arg" == "--help" ]
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
   echo "$ endtv  55            # use channel number in command line"  
   echo "$ endtv  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDTV: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
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
echo "Please Select a Number corresponding to a YouTube Live Stream or press n for next menu or q to quit:"

############# DEFAULT SELECTION #######################
# in case of non-numeric entry 
 link=https://www.youtube.com/watch?v=1Ydto3Iyzic 
 chan_name="France 24 English"
#######################################################

read num

if [ "$num" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
elif [ "$num" == "n" ]
then
channel_matrix_2
echo "You were watching "$chan_name" on Channel "$num" "
echo "Please Select a Number corresponding to a YouTube Live Stream:"
echo "Select a new stream number, press m for the main menu, or press q to quit."
read num
fi

fi

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    CANADIAN TV  ##################################
# 1) BBC One
1) link=https://www.filmon.com/tv/bbc-one 
   chan_name="BBC One";;
# 2) My Face My Body 
2) link=https://www.filmon.com/tv/my-face-my-body   
     chan_name="My Face My Body" ;;
# 3) V Channel
3) link=https://www.filmon.com/tv/v-channel
   chan_name="V Channel";;
# 4) Reality TV
4) link=https://www.filmon.com/tv/reality-tv    
    chan_name="Reality TV";;    
# 5) Ireland's Country
5) link=https://www.filmon.com/tv/irelands-country-tv 
   chan_name="Ireland's Coundry";;     
#  6) Brit Rox
6) link=https://www.filmon.com/tv/britrox 
    chan_name="britrox" ;;
# 7) Dr. Fab Show
7) link=https://www.filmon.com/tv/dr-fab-show
    chan_name="Dr. Fab Show" ;;
# 8)BBC News
8) link=https://www.filmon.com/tv/bbc-news
    chan_name="BBC News" ;;
# 9) BBC 1 Wales
9) link=https://www.filmon.com/tv/bbc-1-wales
    chan_name="BBC 1 Wales" ;;
# 10) BBC 1 Scotland
10) link=https://www.filmon.com/tv/bbc-1-scotland
    chan_name="BBC 1 Scotland" ;;
# 11) BBC 1 North Ireland
11)  link=https://www.filmon.com/tv/bbc-1-north-ireland
     chan_name="BBC 1 North Ireland" ;;
# 12)  BBC TWO
12) link=https://www.filmon.com/tv/bbc-two
    chan_name="BBC TWO" ;;
# 13) BBC Parliament
13) link=https://www.filmon.com/tv/bbc-parliament
    chan_name="BBC Parliament" ;;
# 14)  BBC Four
14) link=https://www.filmon.com/tv/cbeebiesbbc-four
    chan_name="BBC Four" ;; 
# 15) ITV
15) link=https://www.filmon.com/tv/itv1
    chan_name="ITV" ;;
# 16) ITV + 1
16) link=https://www.filmon.com/tv/itv-plus-1
chan_name="ITV + 1" ;; 
# 17) ITV 2
17) link=https://www.filmon.com/tv/itv2
chan_name="ITV 2" ;;   
# 18) ITV 2 + 1
18) link=https://www.filmon.com/tv/itv2-plus-1
chan_name="ITV 2 + 1" ;;
# 19) ITV 3
19) link=https://www.filmon.com/tv/itv3
chan_name="ITV 3" ;;
# 20) ITV 3 + 1
20) link=https://www.filmon.com/tv/itv3-plus-1 
chan_name="ITV 3 + 1" ;;
# 21) ITV 4
21) link=https://www.filmon.com/tv/itv4
chan_name="ITV 4" ;;
# 22) ITV 4 + 1
22) link=https://www.filmon.com/tv/itv4-plus-1
chan_name="ITV 4 + 1" ;;
# 23) ITV Be
23) link=https://www.filmon.com/tv/itvbe
    chan_name="ITV Be" ;;
# 24)  Channel 4
24) link=https://www.filmon.com/tv/channel-4
     chan_name="Channel 4" ;;    
# 25) E4
25) link=https://www.filmon.com/tv/channel-4
chan_name="E4" ;;
# 26) More4
26) link=https://www.filmon.com/tv/more4
chan_name="More4" ;;
# 27) Channel 5
27) link=https://www.filmon.com/tv/channel-5
chan_name="Channel 5" ;;
# 28) 5*
28) link=https://www.filmon.com/tv/5-star
chan_name="5*" ;;
# 29) 5 USA
29) link=https://www.filmon.com/tv/5usa
chan_name="5 USA" ;;
# 30) Really
30) link=https://www.filmon.com/tv/really
chan_name="Really" ;;
# 31) Yesterday
31) link=https://www.filmon.com/tv/yesterday
chan_name="Yesterday" ;;
# 32) Pick TV
32) link=https://www.filmon.com/tv/pick-tv
chan_name="Pick TV" ;;
# 33) CBS Reality 
33) link=https://www.filmon.com/tv/cbs-reality
chan_name="CBS Reality" ;;
# 34) CBS Reality + 1
34) link=https://www.filmon.com/tv/cbs-reality1
chan_name="CBS Reality + 1" ;;  
# 35) CBS Drama
35) link=https://www.filmon.com/tv/cbs-drama
chan_name="CBS Drama" ;;
# 36) CBS Action
36) link=https://www.filmon.com/tv/cbs-action
    chan_name="CBS Action" ;;
# 37) TruTV
37) link=https://www.filmon.com/tv/tru-tv
chan_name="TruTV" ;;
# 38) Psychic TV
38) link=https://www.filmon.com/tv/psychic-today
chan_name="Psychic TV" ;;
# 39) FussionPlus TV
39) link=https://www.filmon.com/tv/fusionplus
    chan_name="Fussion Plus TV" ;;

###################### SPORTS ################################    
# 40) Grandstand Show
40) link=https://www.filmon.com/tv/grandstand-show
    chan_name="Grandstand Show" ;;                                                            
# 41) Football Fanatics
41) link=https://www.filmon.com/tv/football-fanatics
    chan_name="Football Fanatics" ;;
# 42) FilmOn Tennis
42) link=https://www.filmon.com/tv/filmon-tennis
    chan_name="FilmOn Tennis" ;;
# 43) Snooker Legends
43) link=https://www.filmon.com/tv/snooker-legends
    chan_name="Snooker Legends" ;;
# 44) The Ring TV
44) link=https://www.filmon.com/tv/ring-tv
    chan_name="The Ring TV" ;;
# 45) Gali Lucha Libre
45) link=https://www.filmon.com/tv/galli-lucha-libre
    chan_name="Gali Lucha Libra" ;;
# 46) Beach Sports Network
46) link=https://www.filmon.com/tv/beach-sports-network
    chan_name="Beach Sports Network" ;;
# 47) Pugalism TV   
47) link=https://www.filmon.com/tv/pugilism-tv
chan_name="Pugilism TV"  ;;      
# 48) Inside The Ring
48) link=https://www.filmon.com/tv/inside-the-ring
chan_name="Inside The Ring" ;;
# 49) Emerging Sports TV
49) link=https://www.filmon.com/tv/emerging-sports-tv
chan_name="Emerging Sports TV";;
# 50) Softball 360
50) link=https://www.filmon.com/tv/softball-360
chan_name="Softball 360" ;;
# 51) Golden Boy Channel
51) link=https://www.filmon.com/tv/golden-boy-channel
chan_name="Golden Boy Channel";;
# 52) FilmOn Wrestling
52) link=https://www.filmon.com/tv/filmon-wrestling-network
chan_name="Film On Wrestling" ;;
# 53) FilmOn Football
53) link=https://www.filmon.com/tv/filmon-football
chan_name="FilmOn Football" ;;
# 54) Roopstigo 
54) link=https://www.filmon.com/tv/roopstigo
chan_name="Roopstigo";;
# 55) Fighting Athletes Network
55) link=https://www.filmon.com/tv/fighting-athletes-network
chan_name="Fighting Athletes Network" ;;
# 56) Ultimate Disc TV
56) link=https://www.filmon.com/tv/ultimate-disc-tv
    chan_name="Ultimate Disc TV" ;;
# 57) FilmOn Boxing
57) link=https://www.filmon.com/tv/filmon-boxing
    chan_name="FilmOn Boxing" ;;
# 58) Game Time
58) link=https://www.filmon.com/tv/game-time  
    chan_name="Game Time" ;;
# 59) 1 on 1 Boxing TV
59) link=https://www.filmon.com/tv/1-on-1-boxing-tv
    chan_name="1 on 1 Boxing TV" ;;  
# 60) AFL Classic
60) link=https://www.filmon.com/tv/afl-classics
chan_name="AFL Classic" ;;
# 61) Cheer Channel
61) link=https://www.filmon.com/tv/cheer-channel
    chan_name="Cheer Channel" ;;
# 62) Football Heroes
62) link=https://www.filmon.com/tv/football-heroes
    chan_name="Football Heroes" ;;
# 63) Live Boxing
63) link=https://www.filmon.com/tv/live-boxing 
    chan_name="Live Boxing" ;;
# 64) Armed Forces Boxing
64) link=https://www.filmon.com/tv/armed-forces-boxing
    chan_name="Armed Forces Boxing" ;;
# 65) Tuff TV
65) link=https://www.filmon.com/tv/tuff
    chan_name="TUFF TV" ;;
# 66) Disability Sports
66) link=https://www.filmon.com/tv/disability-sports-network
    chan_name="Disability Sports" ;;
####################### PAY TV ############################    
# 67) Fashion News Network
67) link=https://www.filmon.com/tv/fashion-news-lifestyle
chan_name="Fashion News Network" ;;
####################### HORROR ###########################
# 68) FilmOn Horror
68) link=https://www.filmon.com/tv/filmon-horror-network
    chan_name="FilmON Horror";;
# 69) American Horrors
69) link=https://www.filmon.com/tv/american-horrors 
    chan_name="American Horrors" ;; 
# 70) Midnight Releasing
70) link=https://www.filmon.com/tv/midnight-releasing  
    chan_name="Midnight Releasing" ;; 
# 71) Chillings
71) link=https://www.filmon.com/tv/chillings
chan_name="Chillings" ;;
# 72) Monster Madhouse
72) link=https://www.filmon.com/tv/monster-madhouse
   chan_name="Monster Madhouse" ;;
# 73) Zombie Underworld
73) link=https://www.filmon.com/tv/zombie-underworld
    chan_name="Zombie Underworld" ;;
# 74) Vampire Empire
74) link=https://www.filmon.com/tv/vampire-empire
   chan_name="Vampire Empire" ;;
# 75) Creepy Crawly
75) link=https://www.filmon.com/tv/creepy-crawly  
chan_name="Creepy Crawly" ;; 
# 76) RSquared
76) link=https://www.filmon.com/tv/rsquared  
chan_name="RSquared" ;;
# 77) Macabre Theater
77) link=https://www.filmon.com/tv/macabre-theatre  
 chan_name="Macabre Theater" ;;   
# 78) B-Movie! 
78) link=https://www.filmon.com/tv/b-movie  
 chan_name="B-Movie" ;; 
# 79) Alien Invasion Channel
79) link=https://www.filmon.com/tv/alien-invasion-channel  
 chan_name="Alien Invasion Channel" ;; 
# 80) Horror Channel
80)  link=https://www.filmon.com/tv/horror-channel  
 chan_name="Horror Channel" ;; 
######################### MOVIES   #######################
# 81) FilmOn Classics
81)  link=https://www.filmon.com/tv/filmon-classic-films 
 chan_name="FilmOn Classics" ;;  
# 82) Love On The Range
82)  link=https://www.filmon.com/tv/love-on-the-range
 chan_name="Love On The Range" ;;   
# 83) Silent Cinema
83)  link=https://www.filmon.com/tv/silent-cinema
 chan_name="Silent Cinema" ;;   
# 84) Christmastime TV
84)  link=https://www.filmon.com/tv/christmastime-tv 
 chan_name="ChristmasTime TV" ;; 
# 85) Real Life Films 
85)  link=https://www.filmon.com/tv/real-life-films
 chan_name="Real Life Films" ;; 
 # 86) Sherlock Holmes Channel
86)  link=https://www.filmon.com/tv/sherlock-holmes-channel 
 chan_name="Sherlock Holmes Channel" ;; 
 # 87) Xtreme IND Films
87)  link=https://www.filmon.com/tv/xtreme-ind-films 
 chan_name="Xtreme IND Films" ;;  
 # 88) Seven Sins TV
88)  link=https://www.filmon.com/tv/seven-sins-tv 
 chan_name="Seven Sins TV" ;;  
 # 89) The Monarch Channel
89)  link=https://www.filmon.com/tv/the-monarch-channel 
 chan_name="The Monarch Channel" ;;  
# 90) Trailer Nut TV
90)  link=https://www.filmon.com/tv/trailer-nut-tv 
 chan_name="Trailer Nut TV" ;;  
# 91) Thespian Theater
91) link=https://www.filmon.com/tv/thespian-theater
    chan_name="Thespian Theater" ;;
#  92)  Rated B
92) link=https://www.filmon.com/tv/rated-b
chan_name="Rated B" ;;
# 93) Movie Loft TV
93) link=https://www.filmon.com/tv/movie-loft-tv
chan_name="Movie Loft TV" ;;
# 94) Dragon Arena
94) link=https://www.filmon.com/tv/dragon-arena
    chan_name="Dragon Arena" ;;
# 95) Mad Science Cinema
95) link=https://www.filmon.com/tv/mad-science-cinema
chan_name="Mad Sience Cinema" ;;
#  96) FilmOn Family
96) link=https://www.filmon.com/tv/filmon-family
chan_name="FilmOn Family" ;; 
# 97) Hollywood War
97) link=https://www.filmon.com/tv/hollywood-war
chan_name="Hollywood war";;
# 98) Bloodzillathon
98) link=https://www.filmon.com/tv/bloodzillathon
chan_name="Bloodzillathon"  ;;
# 99) Banned Westerns
99) link=https://www.filmon.com/tv/banned-westerns
chan_name="Banned Westerns" ;;
# 100) Eurotrash
100) link=https://www.filmon.com/tv/eurotrash
chan_name="Eurotrash" ;;
# 101) High School
101) link=https://www.filmon.com/tv/high-school
chan_name="High School" ;;
# 102) Award Cinema
102) link=https://www.filmon.com/tv/award-cinema
chan_name="Award Cinema" ;;  
# 103) New York Channel
103) link=https://www.filmon.com/tv/new-york-channel
chan_name="New York Channel" ;;
# 104) Major Crimes
104) link=https://www.filmon.com/tv/major-crimes
chan_name="Major Crimes" ;; 
#  105) Cultra
105) link=https://www.filmon.com/tv/cultra
     chan_name="Cultra" ;;
# 106) iFlix TV
106) link=https://www.filmon.com/tv/iflix-tv
     chan_name="iFlix TV" ;;
# 107) Campy Channel
107) link=https://www.filmon.com/tv/campy-channel
chan_name="Campy Channel" ;;
# 108) Filmon Stars
108) link=https://www.filmon.com/tv/filmon-stars
chan_name="Filmon Stars" ;;  
#  109) KungFu Classics
109) link=https://www.filmon.com/tv/kung-fu-classics
    chan_name="KungFu Classics" ;;
# 110) Double Feature TV
110) link=https://www.filmon.com/tv/double-feature-tv
chan_name="Double Feature TV";; 
# 111) FilmOn Grab Bag TV
111) link=https://www.filmon.com/tv/filmon-grab-bag-tv
chan_name="FilmOn Grab Bag TV" ;; 
# 112) Sci-Fi Telly
112) link=https://www.filmon.com/tv/sci-fi-telly
chan_name="Sci-Fi Telly";;    
# 113) Hollywoodland Channel
113) link=https://www.filmon.com/tv/hollywoodland-channel
chan_name="Hollywoodland-channel" ;;
# 114) The Western Channel
114) link=https://www.filmon.com/tv/the-western-channel
chan_name="The Western Channel" ;; 
# 115) Matriarch TV
115) link=https://www.filmon.com/tv/matriarch-tv
     chan_name="Matriarch TV" ;; 
# 116) Film 4
116) link=https://www.filmon.com/tv/film-4
chan_name="Film 4" ;;
# 117) The Film Detective
117) link=https://www.filmon.com/tv/the-film-detective
chan_name="The Film Detective";; 
#############################   ENTERTAINMENT ########################################
# 118) CRAGG
118) link=https://www.filmon.com/tv/cragg
chan_name="CRAGG" ;;
# 119) Shockya Trailers
119) link=https://www.filmon.com/tv/fotv-trailers
 chan_name="Shockya Trailers" ;;
## 120) California Life
120) link=https://www.filmon.com/tv/california-life
chan_name="California Life" ;;  
# 121) Rose Parade 2017
121) link=https://www.filmon.com/tv/rose-parade-2016
     chan_name="Rose Parade" ;;
# 122) Screensaver TV
122) link=https://www.filmon.com/tv/screensaver-tv
     chan_name="Screensaver TV" ;;
# 123) Drone TV
123) link=https://www.filmon.com/tv/drone-race-tv
chan_name="Drone TV" ;;
# 124) Miss Multiverse
124) link=https://www.filmon.com/tv/miss-multiverse
     chan_name="Miss Multverse" ;;
# 125) Vape Channel
125) link=https://www.filmon.com/tv/vape-channel
     chan_name="Vape Channel" ;;
# 126) Trinity Heart Media
126) link=https://www.filmon.com/tv/trinity-heart-media
     chan_name="Trinity Heart Media" ;;
# 127) Talent You Should Know
127) link=https://www.filmon.com/tv/talent-you-should-know
     chan_name="Talent You SHould Know" ;;
# 128) EZ Way TV
128) link=https://www.filmon.com/tv/ez-way-tv
     chan_name="EZ Way TV" ;;
# 129) Tomorrow Pictures 
129) link=https://www.filmon.com/tv/tomorrow-pictures
   chan_name="Tomorrow Pictures";;
# 130) Razzies Channel
130) link=https://www.filmon.com/tv/razzies-channel
  chan_name="Razzies Channel" ;;    
# 131) 24.7 The Stream
131) link=https://www.filmon.com/tv/247-the-stream 
chan_name="24. 7 The Stream" ;;   
# 132) Miami Music Television
132) link=https://www.filmon.com/tv/miami-music-television
chan_name="Miami Music Television";;     
# 133) Talent Watch
133) link=https://www.filmon.com/tv/talentwatch 
chan_name="Talent Watch" ;;
# 134) HotRock TV
134) link=https://www.filmon.com/tv/hotrock-tv 
chan_name="HotRock TV" ;; 
#  135) Hot Country Ireland
135) link=https://www.filmon.com/tv/hot-country-ireland
chan_name="Hot Country Ireland" ;;
# 136) Music Mix USA
136) link=https://www.filmon.com/tv/music-mix-usa
chan_name="Music Mix USA" ;;   
# 137) Guitar Lessons TV
137) link=https://www.filmon.com/tv/guitar-lessons-tv
chan_name="Guitar Lessons TV" ;;
# 138)  The Soundtrack Channel
 138) link=https://www.filmon.com/tv/the-soundtrack-channel
 chan_name="The Soundtrack Channel";;
## 139) EDM TV
139) link=https://www.filmon.com/tv/edm-tv
chan_name="EDM TV";; 
## 140) Jimmy Lloyd Song Writer Showcase
140) link=https://www.filmon.com/tv/jimmy-lloyd-song-writer-showcase
chan_name="Jimmy Lloyd Song Writer Showcase" ;;
## 141) Beatles Stories
 141) link=https://www.filmon.com/tv/beatles-stories
 chan_name="Beatles Stories" ;; 
## 142) DM TV
 142) link=https://www.filmon.com/tv/dmtv
 chan_name="DM TV" ;;
# 143) Country Star TV
 143) link=https://www.filmon.com/tv/country-star-tv
chan_name="Country Star TV" ;;
# 144) Josh and JB in the Industry
 144) link=https://www.filmon.com/tv/josh-and-jb-in-the-industry 
 chan_name="Josh and JB in the Industry" ;;
# 145) JBTV
 145) link=https://www.filmon.com/tv/jbtv
 chan_name="JBTV" ;;     
# 146) Jazz TeeVee
 146) link=https://www.filmon.com/tv/jazz-teevee
 chan_name="Jazz TeeVee" ;;     
# 147) Dancing Machine TV
 147) link=https://www.filmon.com/tv/dancing-machine-tv
  chan_name="Dancing Machine TV"  ;;
# 148) Inside Music TV
148) link=https://www.filmon.com/tv/inside-music-tv
 chan_name="Inside Music TV" ;;
# 149) Tipstr.TV
149) link=https://www.filmon.com/tv/tipstrtv
chan_name="Tipstr.TV" ;;
# 150) Clubbing TV
150) link=https://www.filmon.com/tv/clubbing-tv
chan_name="Clubbing TV" ;;
# 151) The Noise Network
151) link=https://www.filmon.com/tv/the-noise-network
chan_name="The Noise Network" ;;
# 152) Janey Kirk TV
152) link=https://www.filmon.com/tv/janey-kirk-tv
     chan_name="Janey Kirk" ;;
# 153) FilmOn Jazz and Blues
153) link=https://www.filmon.com/tv/filmon-jazz-and-blues
     chan_name="FilmOn Jazz and Blues" ;;
# 154) FilmOn Rock TV
154) link=https://www.filmon.com/tv/filmon-rock-tv
     chan_name="FilmOn Rock TV" ;;
# 155) JCTV
155) link=https://www.filmon.com/tv/jctv
     chan_name="JCTV" ;;
# 156) Classic Arts Showcase
156) link=https://www.filmon.com/tv/classic-arts-showcase
     chan_name="Classic Arts Showcase" ;;
# 157) International Jazz Radio
157) link=https://www.filmon.com/tv/international-jazz-radio
     chan_name="International Jazz Radio" ;;
################# BIKINI BABE ########################
# 158) Player TV
158) link=https://www.filmon.com/tv/player-tv
     chan_name="Player TV" ;;
# 159) J CLub TV
159) link=https://www.filmon.com/tv/j-club-tv
     chan_name="J Club TV" ;;
# 160) Bikini Down Under
160) link=https://www.filmon.com/tv/bikini-down-under
     chan_name="Bikini Down Under" ;;
# 161) America's Hottest Cheerleaders
161) link=https://www.filmon.com/tv/americas-hottest-cheerleaders
     chan_name="America's Hottest Cheerleaders" ;;
# 162) Party Girls TV
162) link=https://www.filmon.com/tv/party-girls-tv
     chan_name="" ;;
# 163) Bikini Girls Showing Off
163) link=https://www.filmon.com/tv/bikini-girls-showing-off
     chan_name="Bikini Girls Showing Off" ;;    
# 164) Bikini Girls Show and Tell
164) link=https://www.filmon.com/tv/bikini-girls-show-and-tell
     chan_name="Bikini Girls Show and Tell" ;;
# 165) Miss Top of the World
165) link=https://www.filmon.com/tv/miss-top-of-the-world
     chan_name="Miss Top of the World" ;;
# 166) Bikini TV
166) link=https://www.filmon.com/tv/bikini-teevee
     chan_name="Bikini TV" ;;
# 167) Bikini Kitchen
167) link=https://www.filmon.com/tv/bikini-kitchen
     chan_name="Bikini Kitchen" ;;
# 168) Miami TV
168) link=https://www.filmon.com/tv/miamitv
     chan_name="Miami TV" ;;
################################### COMEDY ##########################
# 169) ComiCZoo
169) link=https://www.filmon.com/tv/comiczoo
     chan_name="ComiCZoo" ;;
# 170) The Placeholders
170) link=https://www.filmon.com/tv/the-placeholders
     chan_name="The Placeholders" ;;
# 171) Lumbfilm Comedy
171) link=https://www.filmon.com/tv/lumbfilm-comedy
     chan_name="Lumbfilm Comedy" ;;
# 172) FimOn Comedy Classics
172) link=https://www.filmon.com/tv/filmon-comedy-classics
     chan_name="FilmON Comedy Classics" ;;
# 173) Spud's Funny Channel
173) link=https://www.filmon.com/tv/spuds-funny-channel
     chan_name="Spud's Funny Channel" ;;
# 174) Supa Pirate Booty Hunt
174) link=https://www.filmon.com/tv/supa-pirate-booty-hunt
     chan_name="Supa Pirate Booty Hunt" ;;
# 175) Fun Little Movies
175) link=https://www.filmon.com/tv/fun-little-movies
     chan_name="Fun Little Movies" ;;
# 176) Comedy Time TV
176) link=https://www.filmon.com/tv/comedytime-tv
     chan_name="Comedy Time TV" ;;
# 177) Eye for an Eye
177) link=https://www.filmon.com/tv/eye-for-an-eye
     chan_name="Eye for an Eye" ;;    
################################## KIDS  ##################################    
# 178) KIDS ZONE
178) link=https://www.filmon.com/tv/kids-zone
     chan_name="KIDS ZONE" ;;
# 179) Angels from the Attic ComicFlix
179) link=https://www.filmon.com/tv/the-angels-from-the-attic-comicflix
     chan_name="Angels from the Attic ComicFlix" ;;
# 180) Super Geek Heroes
180) link=https://www.filmon.com/tv/super-geek-heroes
     chan_name="Super Geek Heroes" ;;
# 181) Angels from the Attic Create-Alongs
181) link=https://www.filmon.com/tv/the-angels-from-the-attic-create-alongs
     chan_name="Angels from the Attic Create" ;;
# 182) Children's Reading Channel
182) link=https://www.filmon.com/tv/childrens-reading-channel
     chan_name="Children's Reading Channel" ;;
# 183) OM NOM
183) link=https://www.filmon.com/tv/om-nom
     chan_name="OM NOM" ;;
# 184) Kids Rock TV
184) link=https://www.filmon.com/tv/kids-rock-tv
     chan_name="Kids Rock TV" ;;
# 185) Tiny Pop
185) link=https://www.filmon.com/tv/tiny-pop
     chan_name="Tiny Pop" ;;
# 186) Kix!
186) link=https://www.filmon.com/tv/kix
     chan_name="Kix!" ;;
# 187) Tails TV
187) link=https://www.filmon.com/tv/tails-tv
     chan_name="Tails TV" ;;
# 188) POP
188) link=https://www.filmon.com/tv/pop
     chan_name="POP" ;;
# 189) Popeye TV
189) link=https://www.filmon.com/tv/popeye-tv
     chan_name="Popeye TV" ;;
# 190) Funny Company
190) link=https://www.filmon.com/tv/funny-company-tv
     chan_name="Funny Company" ;;
# 191) Angels from the Attic Featurettes
191) link=https://www.filmon.com/tv/the-angels-from-the-attic-featurettes
     chan_name="Angels from the Attic Featurettes" ;;
# 192) Cat TV
192) link=https://www.filmon.com/tv/cat-tv
     chan_name="Cat TV" ;;
# 193) CBeebies 
193) link=https://www.filmon.com/tv/cbeebies
     chan_name="CBeebies" ;;
# 194) CBBC
194) link=https://www.filmon.com/tv/cbbc
     chan_name="CBBC" ;;
# 195) Tayla's Toddler Toy Review
195) link=https://www.filmon.com/tv/taylas-toddler-toy-review
     chan_name="Tayla's Toddler Toy Review" ;;
# 196) Kartoon Klassics
196) link=https://www.filmon.com/tv/kartoon-klassics
     chan_name="Kartoon Klassics" ;;
# 197) Fun Little Kids
197) link=https://www.filmon.com/tv/fun-little-kids
     chan_name="Fun Little Kids" ;;
# 198) Tea Time with Tayla
198) link=https://www.filmon.com/tv/tea-time-with-tayla
     chan_name="Tea Time with Tayla" ;;
# 199) Wild About Animals
199) link=https://www.filmon.com/tv/wild-about-animals
     chan_name="Wild About Animals" ;;
# 200) FilmOn Kids
200) link=https://www.filmon.com/tv/filmon-kids
     chan_name="FilmOn Kids" ;;
# 201) Smile of a Child
201) link=https://www.filmon.com/tv/smile-of-child
     chan_name="Smile of a Child" ;;
# 202) Mouse House Radio
202) link=https://www.filmon.com/tv/mouse-house-radio
     chan_name="Mouse House Radio" ;;
############################   BUSINESS TV    ############################
# 203) Crowd Angels TV
203) link=https://www.filmon.com/tv/crowd-angels-tv
     chan_name="Crowd Angels TV" ;;
# 204) Red Chip Money Report
204) link=https://www.filmon.com/tv/red-chip-money-report
     chan_name="Red Chip Money Report" ;;
# 205) Biz TV
205) link=https://www.filmon.com/tv/biztv
     chan_name="Biz TV" ;;
######################### Documentary #################################
# 206) CCTV 9 Documentary
206) link=https://www.filmon.com/tv/cctv9-documentary
     chan_name="CCTV 9 Documentary" ;;
# 207) Fame TV
207) link=https://www.filmon.com/tv/fame-tv
     chan_name="Fame TV" ;;
# 208) Locomotion TV
208) link=https://www.filmon.com/tv/loco-motion-tv
     chan_name="Locomotion TV" ;;
# 209) FBI Insider
209) link=https://www.filmon.com/tv/fbi-insider
     chan_name="FBI Insider" ;;
# 210) FilmOn Documentary
210) link=https://www.filmon.com/tv/filmon-documentary
     chan_name="FilmOn Documentary" ;;
# 211) UFO NEWS
211) link=https://www.filmon.com/tv/ufo-news
     chan_name="UFO NEWS" ;;
# 212) WAKAJ TV
212) link=https://www.filmon.com/tv/wkaj-tv
     chan_name="WAKAJ TV" ;;
# 213) FilmOn Biography
213) link=https://www.filmon.com/tv/filmon-biography-channel
     chan_name="FilmOn Biography" ;;
# 214) Victory at Sea
214) link=https://www.filmon.com/tv/victory-at-sea-tv
     chan_name="Victory at Sea" ;;
# 215) FilmOn War
215) link=https://www.filmon.com/tv/filmon-war-channel
     chan_name="FilmOn War" ;;
# 216) Ghost Hunters
216) link=https://www.filmon.com/tv/ghost-hunters
     chan_name="Ghost Hunters" ;;
# 217) Timeless Biographies
217) link=https://www.filmon.com/tv/timeless-biographies
     chan_name="Timeless Biographies" ;;
# 218) Real Life History
218) link=https://www.filmon.com/tv/real-life-history-channel
     chan_name="Real Life History" ;;
# 219) Living History
219) link=https://www.filmon.com/tv/living-history-channel
     chan_name="Living History" ;;
# 220) WW2 TV
220) link=https://www.filmon.com/tv/war-crime-network
     chan_name="WW2 TV" ;;
# 221) Aliens and UFOs
221) link=https://www.filmon.com/tv/aliens-and-ufos
     chan_name="Aliens and UFOs" ;;
# 222) Crime Inc.
222) link=https://www.filmon.com/tv/crime-inc
     chan_name="Crime Inc" ;;
# 223) In Short a Lesson in Almost Everything
223) link=https://www.filmon.com/tv/in-short-a-lesson-in-almost-everything
     chan_name="In Short a Lesson in Almost Everything" ;;
###################### NEWS TV   #########################
# 224) Newsy
224) link=https://www.filmon.com/tv/newsy
     chan_name="Newsy" ;;
# 225) CDTV
225) link=https://www.filmon.com/tv/cdtv
     chan_name="CDTV" ;;
# 226) EIC TV
226) link=https://www.filmon.com/tv/eic-tv
     chan_name="EIC TV" ;;
# 227) The Global Goals
227) link=https://www.filmon.com/tv/the-global-goals
     chan_name="The Global Goals" ;;
# 228) Native Nations TV
228) link=https://www.filmon.com/tv/native-nations-tv
     chan_name="Native Nations TV" ;;
# 229) France 24
229) link=https://www.filmon.com/tv/france24
     chan_name="France 24" ;;
# 230) Truth Files
230) link=https://www.filmon.com/tv/truth-files
     chan_name="Truth Files" ;;
# 231) NewsMax
231) link=https://www.filmon.com/tv/newsmax
     chan_name="NEWSMAX" ;;
# 232) TV 47
232) link=https://www.filmon.com/tv/tv47
     chan_name="TV 47" ;;
# 233) VOA
233) link=https://www.filmon.com/tv/voa-english
     chan_name="VOA" ;;
# 234) FilmOn Breaking NEWS
234) link=https://www.filmon.com/tv/filmon-breaking-news
     chan_name="Breaking News" ;;
# 235) Al Jazeera
235) link=https://www.filmon.com/tv/al-jazeera
     chan_name="Al Jazeera" ;;
# 236) Bloomberg
236) link=https://www.filmon.com/tv/bloomberg
     chan_name="Bloomberg" ;;
# 237) DW English
237) link=https://www.filmon.com/tv/dw-english
     chan_name="DW English" ;;
# 238) Russia Today
238) link=https://www.filmon.com/tv/russia-today-2
     chan_name="Russia Today" ;;
# 239) What America Thinks
239) link=https://www.filmon.com/tv/what-america-thinks
     chan_name="What America Thinks" ;;
# 240) CGTN
240) link=https://www.filmon.com/tv/cctv-news
     chan_name="CGTN" ;;   
# 241) DVIDs TV
241) link=https://www.filmon.com/tv/dvids-tv
     chan_name="DVIDs TV" ;;     
# 242) Press TV
242) link=https://www.filmon.com/tv/press-tv
     chan_name="Press TV" ;;     
# 243) Job Channel
243) link=https://www.filmon.com/tv/job-channel-network
     chan_name="Job Channel" ;;
# 244) Unreliable Sources
244) link=https://www.filmon.com/tv/unreliable-sources
     chan_name="Unreliable Sources" ;;
# 245) Insider Exclusive
245) link=https://www.filmon.com/tv/insider-exclusive-tv
     chan_name="Insider Exclusive" ;;
############################### EXTREME SPORTS ####################
# 246) GFL Combat Sports
246) link=https://www.filmon.com/tv/gfl-combat-sports
     chan_name="GFL Combat Sports" ;;
# 247) XCORPS
247) link=https://www.filmon.com/tv/xcorps
     chan_name="XCORPS" ;;
# 248) MMA Now 360
248) link=https://www.filmon.com/tv/mma-now-360
     chan_name="MMA Now 360" ;;
# 249) GLORY Kickboxing
249) link=https://www.filmon.com/tv/glory-kickboxing
     chan_name="GLORY Kickboxing" ;;
# 250) Sledhead 24/7
250) link=https://www.filmon.com/tv/sledhead-247
     chan_name="Sledhead 24/7" ;;
# 251) Destination X
251) link=https://www.filmon.com/tv/destination-x
     chan_name="Destination X" ;;
# 252) Planet X Sport
252) link=https://www.filmon.com/tv/planet-x-sport
     chan_name="Planet X Sport" ;;     
# 253) MMA Now
253) link=https://www.filmon.com/tv/mmanow
     chan_name="MMA Now" ;;
# 254) UFC Next
254) link=https://www.filmon.com/tv/ufc-next
     chan_name="UFC Next" ;;
# 255) Sports Bloopers
255) link=https://www.filmon.com/tv/sports-bloopers-tv
     chan_name="Sports Bloopers" ;;
# 256) Crash Bang Boom
256) link=https://www.filmon.com/tv/crash-bang-boom
     chan_name="Crash Bang Boom" ;;
####################### URBAN  #############################
# 257) Urban Firearms
257) link=https://www.filmon.com/tv/urban-firearms-tv
     chan_name="Urban Firearms" ;;
# 258) Road 2 Fame
258) link=https://www.filmon.com/tv/road2fame
     chan_name="Road 2 Fame" ;;
# 259) WWRTV
259) link=https://www.filmon.com/tv/wwrtv
     chan_name="WWRTV" ;;
# 260) Irrefutable Evidence
260) link=https://www.filmon.com/tv/irrefutable-evidence-tv
     chan_name="Irrefutable Evidence" ;;
# 261) Superfly Cinema
261) link=https://www.filmon.com/tv/super-fly-cinema
     chan_name="SuperFly Cinema" ;;
# 262) Harlem Renaissance
262) link=https://www.filmon.com/tv/harlem-renaissance
     chan_name="Harlem Renaissance" ;;
# 263) TMTV
263) link=https://www.filmon.com/tv/tmtv
     chan_name="TMTV" ;;
# 264) WHOMAG
264) link=https://www.filmon.com/tv/whomag-tv
     chan_name="WHOMAG" ;;
# 265) WHOMAG VIDEOS
265) link=https://www.filmon.com/tv/whomag-video-vision
     chan_name="Whomag Videos" ;;
# 266) New Star TV
266) link=https://www.filmon.com/tv/new-star-tv
     chan_name="New Star TV" ;;
# 267) Bone Thugs
267) link=https://www.filmon.com/tv/bone-thugs-n-harmony
     chan_name="Bone Thugs" ;;
# 268) RMC Live
268) link=https://www.filmon.com/tv/rmc-live
     chan_name="RMC Live" ;;
# 269) The Raw Report
269) link=https://www.filmon.com/tv/the-raw-report
     chan_name="The Raw Report" ;;
# 270) Linkct Network
270) link=https://www.filmon.com/tv/linkct-network
     chan_name="Linkct Network" ;;
# 271) Urban Music Network
271) link=https://www.filmon.com/tv/urban-music-network
     chan_name="Urban Music Network" ;;
# 272) Aspire Now
272) link=https://www.filmon.com/tv/aspirenow-tv
     chan_name="Aspire Now" ;;
# 273) Amp TV
273) link=https://www.filmon.com/tv/amp-tv
     chan_name="Amp TV" ;;    
###################### PARTY TV ##############################     
# 274) Weedmaps
274) link=https://www.filmon.com/tv/weedmaps-tv
   chan_name="Weedmaps" ;;
# 275) Buddy Plant
275) link=https://www.filmon.com/tv/buddy-plant
     chan_name="Buddy Plant" ;;
# 276) PROHBTD
276) link=https://www.filmon.com/tv/prohbtd
     chan_name="PROHBTD" ;;
# 277) Sweet Leaf TV
277) link=https://www.filmon.com/tv/sweet-leaf-tv
     chan_name="Sweet Leaf TV" ;;
###################### LIFESTYLE #################################
# 278) Health and Lifestyle
278) link=https://www.filmon.com/tv/health-and-lifestyle
     chan_name="Health and Lifestyle" ;;
# 279) SOBA recovery
279) link=https://www.filmon.com/tv/soba-network
     chan_name="SOBA Recovery" ;;
# 280) Reader's Digest Lifetime
280) link=https://www.filmon.com/tv/readers-digest-lifetime
     chan_name="Reader's Digest Lifetime" ;;
# 281) Home and Green Living
281) link=https://www.filmon.com/tv/home-and-green-living
     chan_name="Home and Green Living" ;;
# 282) Safe TV
282) link=https://www.filmon.com/tv/safe-tvr
     chan_name="Safe TV" ;;
# 283) Bid America
283) link=https://www.filmon.com/tv/bid-america
     chan_name="Bid America" ;;
# 284) MegaMe TV
284) link=https://www.filmon.com/tv/megame-tv
     chan_name="MegaMe TV" ;;
# 285) Wonderful Living
285) link=https://www.filmon.com/tv/wonderful-living-tv
     chan_name="Wonderful Living" ;;
# 286) Simply Me
286) link=https://www.filmon.com/tv/simply-me
     chan_name="Simply Me" ;;
# 287) The Walk
287) link=https://www.filmon.com/tv/the-walk-tv
     chan_name="The Walk" ;;
# 288) Time TV
288) link=https://www.filmon.com/tv/time-tv
     chan_name="Time TV" ;;
# 289) DRTV
289) link=https://www.filmon.com/tv/drtv
     chan_name="DRTV" ;;
# 290) Medical News
290) link=https://www.filmon.com/tv/medical-news-minute
     chan_name="Medical News" ;;
# 291) Supreme Master
291) link=https://www.filmon.com/tv/supreme-master-tv
     chan_name="Supreme Master" ;;
     
######################## FILMON EXCLUSIVE ###############################     
# 292) FOTV USA
292) link=https://www.filmon.com/tv/fotv-usa
     chan_name="FOTV USA" ;;
# 293) FOTV Workout
293) link=https://www.filmon.com/tv/360-fotv-workout
     chan_name="FOTV Workout" ;;
# 294) FilmOn Sports
294) link=https://www.filmon.com/tv/filmon-sports
     chan_name="FilmOn Sports" ;;
# 295) 360 Experimental
295) link=https://www.filmon.com/tv/360-experimental
     chan_name="360 Experimental" ;;
# 296) BH Cam 360
296) link=https://www.filmon.com/tv/bh-360-cam-2
     chan_name="BH Cam 360" ;;
# 297) R&B Live 
297) link=https://www.filmon.com/tv/rnb-live-afterparty
     chan_name="R&B Live" ;;
# 298) Cast Out of Paradise
298) link=https://www.filmon.com/tv/castoutofparadise-tv
     chan_name="Cast Out of Paradise" ;;
# 299) ROC Summer Explossion
299) link=https://www.filmon.com/tv/roc-summer-explosion
     chan_name="ROC Summer Explosion" ;;
# 300) FilmON Studio
300) link=https://www.filmon.com/tv/filmon-studio
     chan_name="FilmON Studio" ;;
# 301) TV Gold
301) link=https://www.filmon.com/tv/tv-gold
     chan_name="TV Gold" ;;
# 302) Battle Rap
302) link=https://www.filmon.com/tv/battle-rap
     chan_name="Battle Rap" ;;
# 303) Tribe TV
303) link=https://www.filmon.com/tv/tribe-tv
     chan_name="Tribe TV" ;;
# 304) FilmOn Reality
304) link=https://www.filmon.com/tv/filmon-reality
     chan_name="FilmOn Reality" ;;
# 305) FilmOn Red Carpet 
305) link=https://www.filmon.com/tv/filmon-red-carpet
     chan_name="FilmOn Red Carpet" ;;
# 306) Christmas Channel
306) link=https://www.filmon.com/tv/the-christmas-channel-by-zuzu-project
     chan_name="Christmas Channel" ;;
# 307) Nub TV
307) link=https://www.filmon.com/tv/nub-tv
     chan_name="Nub TV" ;;
# 308) Chai Life TV
308) link=https://www.filmon.com/tv/livefromthecenteroftheuniverse
     chan_name="Chai Life TV" ;;
# 309) Joe Nation
309) link=https://www.filmon.com/tv/joe-nation
     chan_name="Joe Nation" ;;
# 310) OC Real Estate
310) link=https://www.filmon.com/tv/oc-real-estate-tv
     chan_name="OC Real Estate" ;;
# 311) MHL TV
311) link=https://www.filmon.com/tv/mhl-tv
     chan_name="MHL TV" ;;
################################## FASHION ##########################
# 312) RUNWAY TV
312) link=https://www.filmon.com/tv/runway-tv
     chan_name="RUNWAY TV" ;;
# 313) TEOS
313) link=https://www.filmon.com/tv/teos-tv
     chan_name="TEOS" ;;
# 314) TV ART LIVE
314) link=https://www.filmon.com/tv/tv-art-live
     chan_name="TV Art Live" ;;
# 315) Runway TV 2016
315) link=https://www.filmon.com/tv/runway-tv-2016
     chan_name="Runway TV" ;;
# 316) Chic
316) link=https://www.filmon.com/tv/chic
     chan_name="Chic" ;;
########################## SCIENCE and TECH ###################################
# 317) NASA TV
317) link=https://www.filmon.com/tv/nasa-hd
     chan_name="NASA TV" ;;
####################### FRENCH TV ########################################

# 318) ARTE Francais
318) link=https://www.filmon.com/tv/arte-francais
     chan_name="ARTE Francais" ;;
# 319) France 0
319) link=https://www.filmon.com/tv/france-0
     chan_name="France 0" ;;
# 320) France 3 Rhone Alpes
320) link=https://www.filmon.com/tv/france-3-rhone-alpes
     chan_name="France 3 Rhone Alps" ;;
# 321) France 3 Alpes
321) link=https://www.filmon.com/tv/france-3-alpes
     chan_name="France 3 Alpes" ;;
# 322) RTS UN
322) link=https://www.filmon.com/tv/rts-un
     chan_name="RTS UN" ;;
# 323) RTS Deux
323) link=https://www.filmon.com/tv/rts-deux
     chan_name="RTS Deux" ;;
#  324) BFM Business
324) link=https://www.filmon.com/tv/bfm-business
     chan_name="BFM Business" ;;
# 325) BFM TV
325) link=https://www.filmon.com/tv/bfm-tv
     chan_name="BFM TV" ;;
# 326) FRANCE 2
326) link=https://www.filmon.com/tv/france-2
     chan_name="France 2" ;;
################################ GERMAN TV  #####################################
# 327) HSE 2 
327) link=https://www.filmon.com/tv/hse24-hd
     chan_name="HSE 2" ;;
# 328) HSE 2 Extra
328) link=https://www.filmon.com/tv/hse24-extra
     chan_name="HSE 2 Extra" ;;
# 329) Kika
329) link=https://www.filmon.com/tv/kika
     chan_name="KIKA" ;;
# 330) ZDF Infokanal
330) link=https://www.filmon.com/tv/zdf-infokanal
     chan_name="ZDF Infokanal" ;;
########################## RUSSIAN TV ######################################
# 331) RTR Planeta
331) link=https://www.filmon.com/tv/rtr-planeta
     chan_name="RTR Planeta" ;;
# 332) Current Time TV
332) link=https://www.filmon.com/tv/current-time-tv
     chan_name="Current Time TV" ;;
# 333) RT Documentary
333) link=https://www.filmon.com/tv/rt-documentary
     chan_name="RT Documentary" ;;
# 334) Perviy Kanal Europa
334) link=https://www.filmon.com/tv/perviy-kanal-europa
     chan_name="Perviy Kanal Europa" ;;
# 335) Music Box Russia
335) link=https://www.filmon.com/tv/music-box-russia
     chan_name="Music Box Russia" ;;
# 336) Rossiya 24
336) link=https://www.filmon.com/tv/rossiya-24
     chan_name="Rossiya 24" ;;
########################### INDIA TV  ##########################################
# 337) Films of India
337) link=https://www.filmon.com/tv/original-films-of-india
     chan_name="Films of India" ;;
# 338) Live 9 TV
338) link=https://www.filmon.com/tv/live9-tv
     chan_name="Live 9 TV" ;;
# 339) Delhi Aaj Tak
339) link=https://www.filmon.com/tv/delhi-aaj-tak
     chan_name="Delhi Aaj Tak" ;;
# 340) Aaj Tak
340) link=https://www.filmon.com/tv/aaj-tak
     chan_name="Aaj Tak" ;;
# 341) Tez TV
341) link=https://www.filmon.com/tv/tez-tv
     chan_name="Tez TV" ;;
# 342) ABP News
342) link=https://www.filmon.com/tv/abp-news
     chan_name="ABP News" ;;  
######################## ITALIAN TV ############################################# 
# 343) Italia Channel
343) link=https://www.filmon.com/tv/canale-italia
     chan_name="Italia Channel" ;;
# 344) Camera dei Deputati
344) link=https://www.filmon.com/tv/camera-dei-deputati
     chan_name="Camera dei Deputati" ;;
# 345) QVC Italy
345) link=https://www.filmon.com/tv/qvc-italia
     chan_name="QVC Italy" ;;
####################### Middle East #############################
# 346) Rotana Aflam
346) link=https://www.filmon.com/tv/rotana-aflam
     chan_name="Rotana Aflam" ;;
# 347) DW Arabia
347) link=https://www.filmon.com/tv/dw-arabia
     chan_name="DW Arabia" ;;
# 348) Al Jazeera Documentary
348) link=https://www.filmon.com/tv/al-jazeera-documentary
     chan_name="Al Jazeera Documentary" ;;
# 349) Al Jazeera Mubasher
349) link=https://www.filmon.com/tv/al-jazeera-mubasher
     chan_name="Al Jazeera Mubasher" ;;
# 350) Al Jazeera Arabic
350) link=https://www.filmon.com/tv/al-jazeera-arabic
     chan_name="Al Jazeera Arabic" ;;
# 351) Saudi TV 2
351) link=https://www.filmon.com/tv/saudi-arabian-tv-2
     chan_name="Saudi TV 2" ;;
# 352) Saudi TV Sports
352) link=https://www.filmon.com/tv/saudi-arabian-tv-sports
     chan_name="Saudi TV Sports" ;;
# 353) Suryoyo Satalite
353) link=https://www.filmon.com/tv/suryoyo-sat
     chan_name="Suryoyo Sat" ;;
# 354) Rotana
354) link=https://www.filmon.com/tv/rotana
     chan_name="Rotana" ;;
# 355) Rotana Clip
355) link=https://www.filmon.com/tv/rotana-clip
     chan_name="Rotana Clip" ;;
# 356) Rotana Khalijah
356) link=https://www.filmon.com/tv/rotana-khalijiah
     chan_name="Rotana Khalijah" ;;
# 357) Rotana Classic
357) link=https://www.filmon.com/tv/rotana-classic
     chan_name="Rotana classic" ;;
# 358) Rotana Masriya
358) link=https://www.filmon.com/tv/rotana-masriya
     chan_name="Rotana Masriya" ;;
# 359) Rotana Cinema
359) link=https://www.filmon.com/tv/rotana-cinema
     chan_name="Rotana Cinema" ;;
# 360) Saudi TV 1
360) link=https://www.filmon.com/tv/saudi-arabian-tv-1
     chan_name="Saudi TV 1" ;;
# 361) Noor Dubai
361) link=https://www.filmon.com/tv/noor-dubai
     chan_name="Noor Dubai" ;;
# 362) iFilm
362) link=https://www.filmon.com/tv/ifilm
     chan_name="iFilm" ;;
# 363) Dubai Sports
363) link=https://www.filmon.com/tv/dubai-sports
     chan_name="Dubai Sports" ;;
########################## SWISS TV  ############################################       
# 364) SRF 1
364) link=https://www.filmon.com/tv/srf-1
     chan_name="SRF 1" ;;
# 365) RSI LA 1
365) link=https://www.filmon.com/tv/rsi-la-1
     chan_name="RSI LA 1" ;;
# 366) Raido Chico
366) link=https://www.filmon.com/tv/radio-chico
     chan_name="Radio Chico" ;;
########################### LATINO  #############################################3
# 367) Peliculas FilmON
367) link=https://www.filmon.com/tv/peliculas-de-filmon
     chan_name="Peliculas FilmON" ;;
# 368) Catwalk Espanol
368) link=https://www.filmon.com/tv/catwalk-en-espanol
     chan_name="Catwalk Espanol" ;;
# 369) Animacion de FilmOn
369) link=https://www.filmon.com/tv/animacion-de-filmon
     chan_name="Animacion de FilmOn" ;;
# 370) Planet Fashion
370) link=https://www.filmon.com/tv/planet-fashion-en-espanol
     chan_name="Planet Fashion" ;;
# 371) HispanTV
371) link=https://www.filmon.com/tv/hispan-tv
     chan_name="HispanTV" ;;
# 372) Telenovelas
372) link=https://www.filmon.com/tv/telenovelas-tv
     chan_name="Telenovelas" ;;
# 373) RT Espanol
373) link=https://www.filmon.com/tv/rt-espanol
     chan_name="RT Espanol" ;;
# 374) DW Latino America
374) link=https://www.filmon.com/tv/dw-latinoamerica
     chan_name="DW Latino America" ;;
# 375) Televideo Latino
375) link=https://www.filmon.com/tv/televideo-latino
     chan_name="Televido Latino" ;;
############################# CLASSIC TV  ####################################
# 376) The Lucy Show
376) link=https://www.filmon.com/tv/the-lucy-show
     chan_name="The Lucy Show" ;;
# 377) Date With the Angels TV
377) link=https://www.filmon.com/tv/date-with-angels-tv
     chan_name="Date with the Angels" ;;
# 378) Man with a Camera
378) link=https://www.filmon.com/tv/man-with-a-camera-tv
     chan_name="Man with a Camera" ;;
# 379) Colgate Comedy Hour
379) link=https://www.filmon.com/tv/the-colgate-comedy-hour
     chan_name="Colgate Comedy Hour" ;;
# 380) Catwalk
380) link=https://www.filmon.com/tv/catwalk
     chan_name="Catwalk" ;;
# 381) Life of Riley
381) link=https://www.filmon.com/tv/the-life-of-riley-tv
     chan_name="Life of Riley" ;;
# 382) Strange Paradise
382) link=https://www.filmon.com/tv/strange-paradise
     chan_name="Strange Paradise" ;;
# 383) Red Skeleton
383) link=https://www.filmon.com/tv/the-red-skelton-show-tv
     chan_name="Red Skeleton" ;;
# 384) Dragnet
384) link=https://www.filmon.com/tv/dragnet-tv
     chan_name="Dragnet" ;;
# 385) Private Secretary
385) link=https://www.filmon.com/tv/private-secretary-tv
     chan_name="Private Secretary" ;;
# 386) Suspense TV
386) link=https://www.filmon.com/tv/suspense-tv
     chan_name="Suspense TV" ;;
# 387) Timeless Westerns
387) link=https://www.filmon.com/tv/timeless-westerns
     chan_name="Timeless Westerns" ;;
# 388) You bet your Life
388) link=https://www.filmon.com/tv/you-bet-your-life-tv
     chan_name="You Bet Your Life" ;;
# 389) Flash Gordon
389) link=https://www.filmon.com/tv/flash-gordon
     chan_name="Flash Gordon" ;;
# 390) Betty Boop
390) link=https://www.filmon.com/tv/betty-boop-tv
     chan_name="Betty Boop" ;;
# 391) Fury TV
391) link=https://www.filmon.com/tv/fury-tv
     chan_name="Fury TV" ;;
# 392) Cisco Kid
392) link=https://www.filmon.com/tv/cisco-kid-tv
     chan_name="Cisco Kid" ;;
# 393) Bonanza
393) link=https://www.filmon.com/tv/filmon-binge-bonanza
     chan_name="Bonanza" ;;
# 394) Ozzie and Harriet
394) link=https://www.filmon.com/tv/filmon-binge-ozzie-harriet
     chan_name="Ozzie and Harriet" ;;
# 395) One Step Beyond
395) link=https://www.filmon.com/tv/filmon-binge-one-step-beyond
     chan_name="One Step Beyond" ;;
# 396) Charlie Chaplin
396) link=https://www.filmon.com/tv/filmon-binge-charlie-chaplin
     chan_name="Charlie Chaplin" ;;
# 397) The Beverly Hillbillies
397) link=https://www.filmon.com/tv/filmon-binge-the-beverly-hillbillies
     chan_name="The Beverly Hillbilies" ;;
# 398) Robin Hood
398) link=https://www.filmon.com/tv/filmon-binge-adventures-of-robin-hood
     chan_name="Robin Hood" ;;
# 399) Timeless TV
399) link=https://www.filmon.com/tv/timeless-television
     chan_name="Timeless TV" ;;
# 400) Spud's Crime and Punishment
400) link=https://www.filmon.com/tv/spuds-crime-and-punishment-channel
     chan_name="Spud's Crime and Punishment" ;;
# 401) The Dick Van Dyke Show
401) link=https://www.filmon.com/tv/the-dick-van-dyke-show
     chan_name="The Dick Van Dyke Show" ;;
####################### SHORT FILMS ####################################
# 402) Funny Shorts
402) link=https://www.filmon.com/tv/funny-shorts
     chan_name="Funny Shorts" ;;
# 403) Movies
403) link=https://www.filmon.com/tv/movies
     chan_name="Movies" ;;
# 404) Dancing Shorts
404) link=https://www.filmon.com/tv/dancing-shorts
     chan_name="Dancing Shorts" ;;
# 405) Reality Shorts
405) link=https://www.filmon.com/tv/reality-shorts
     chan_name="Reality Shorts" ;;
# 406) Acid TV
406) link=https://www.filmon.com/tv/acid-tv
     chan_name="Acid TV" ;;
# 407) Horror TV
407) link=https://www.filmon.com/tv/horror-tv
     chan_name="Horror TV" ;;
# 408) Music Videos
408) link=https://www.filmon.com/tv/music-videos
     chan_name="Music Videos" ;;
# 409) Sci Fi
409) link=https://www.filmon.com/tv/sci-fi
     chan_name="Sci Fi" ;;
# 410) Micro Shorts
410) link=https://www.filmon.com/tv/micro-shorts
     chan_name="Micro Shorts" ;;
# 411) Sproklets and Splices
411) link=https://www.filmon.com/tv/sprockets-and-splices-tv
     chan_name="Sprokets and Splices" ;;
# 412) Teen Shorts
412) link=https://www.filmon.com/tv/teen-shorts
     chan_name="Teen Shorts" ;;
# 413) Drama Shorts
413) link=https://www.filmon.com/tv/drama-shorts
     chan_name="Drama Shorts" ;;
# 414) Digital Animation
414) link=https://www.filmon.com/tv/digital-animation
     chan_name="Digital Animation" ;;
# 415) Documentary
415) link=https://www.filmon.com/tv/documentary
     chan_name="Documentary" ;;
     
######################## OUTDOORS   ########################################33
# 416) Bayou Country
416) link=https://www.filmon.com/tv/bayou-country-outdoors
     chan_name="Bayou Country" ;;
# 417) Student of the Gun
417) link=https://www.filmon.com/tv/student-of-the-gun
     chan_name="Student of the Gun" ;;
# 418) Ultimate Outdoors
418) link=https://www.filmon.com/tv/ultimate-outdoors
     chan_name="Ultimater Outdoors" ;;
# 419) Hunt Channel
419) link=https://www.filmon.com/tv/hunt-channel
     chan_name="Hunt Channel" ;;
# 420) Thouroughbred World Show
420) link=https://www.filmon.com/tv/thoroughbred-show
     chan_name="Thouroughbred World Show" ;;
# 421) Wilderness Channel
421) link=https://www.filmon.com/tv/wilderness-channel
     chan_name="Wilderness Channel" ;;
# 422) Pursuit
422) link=https://www.filmon.com/tv/pursuit-channel
     chan_name="Pursuit" ;;
##################### TRAVEL ###########################
# 423) HWC
423) link=https://www.filmon.com/tv/hwc-network
     chan_name="HWC" ;;
# 424) The Jet Set Channel
424) link=https://www.filmon.com/tv/the-jet-set-channel
     chan_name="The Jet Set Channel" ;;
# 425) Discover Malta
425) link=https://www.filmon.com/tv/discover-malta
     chan_name="Discover Malta" ;;
# 426) Mega Destinations
426) link=https://www.filmon.com/tv/mega-destinations
     chan_name="Mega Destinations" ;;
# 427) 30A TV
427) link=https://www.filmon.com/tv/30a-tv
     chan_name="30A TV" ;;
# 428) OBX TV
428) link=https://www.filmon.com/tv/obxtv
     chan_name="OBX TV" ;;
# 429) Travel Channel
429) link=https://www.filmon.com/tv/travel-channel1
     chan_name="Travel Channel" ;;
# 430) Landmarks
430) link=https://www.filmon.com/tv/landmarks
     chan_name="Landmarks" ;;
# 431) Infamous Places
431) link=https://www.filmon.com/tv/infamous-places
     chan_name="Infamous Places" ;;  
############################ SOMALI TV ####################################     
# 432) Somalia SNL TV
432) link=https://www.filmon.com/tv/snltv-somaliland-national-tv
     chan_name="SNL TV Somalia" ;;
# 433) Universal TV Somalia
433) link=https://www.filmon.com/tv/universaltv-somali-television
     chan_name="Universal TV Somalia" ;;
# 434) Somali National TV
434) link=https://www.filmon.com/tv/somali-national-tv
     chan_name="Somali National TV" ;;
# 435) Horn Cable Somalia
435) link=https://www.filmon.com/tv/horn-cable-tv
     chan_name="Horn Cable Somalia" ;;
# 436) ESTV Somali Ethiopia
436) link=https://www.filmon.com/tv/estv-somali-ethiopia-tv
     chan_name="ESTV Somali Ethiopia" ;;
# 437) Kalsan TV Somali
437) link=https://www.filmon.com/tv/kalsan-tv-somali
     chan_name="Kalsan TV Somali" ;;
######################## GREEK ###############################################
# 438) RIK Greek
438) link=https://www.filmon.com/tv/rik
     chan_name="RIK Greece" ;;
############################# RELIGION
# 439) Hispanic American Faith
439) link=https://www.filmon.com/tv/hispanic-american-faith-tv
     chan_name="Hispanic American Faith" ;;
# 440) You Shall Live
440) link=https://www.filmon.com/tv/you-shall-live
     chan_name="You Shall Live" ;;
# 441) Preach the Word
441) link=https://www.filmon.com/tv/preach-the-word
     chan_name="Preach the Word" ;;
# 442) Audio Scripture
442) link=https://www.filmon.com/tv/audio-scripture-channel
     chan_name="Audio Scripture" ;;
# 443) Cyber Church
443) link=https://www.filmon.com/tv/cyber-church-tv
     chan_name="Cyber Church" ;;
# 444) Faith Cinema
444) link=https://www.filmon.com/tv/faith-cinema
     chan_name="Faith Cinema" ;;
# 445) NRB
445) link=https://www.filmon.com/tv/nrb
     chan_name="NRB" ;;
# 446) Glory TV
446) link=https://www.filmon.com/tv/glory-tv
     chan_name="Glory TV" ;;
# 447) Dunamis Radio TV
447) link=https://www.filmon.com/tv/dunamis-radio-tv
     chan_name="Dunamis Radio" ;;
# 448) Global Music TV
448) link=https://www.filmon.com/tv/global-music-tv
     chan_name="Global Music TV" ;;
# 449) The Church Channel
449) link=https://www.filmon.com/tv/the-church-channel
     chan_name="The Church Channel" ;;
# 450) TBN
450) link=https://www.filmon.com/tv/tbn
     chan_name="TBN" ;;
# 451) Daystar
451) link=https://www.filmon.com/tv/daystar
     chan_name="Daystar" ;;
# 452) Catholic TV
452) link=https://www.filmon.com/tv/catholic-tv
     chan_name="Catholic TV" ;;
################################ CELEBRITY TV 
# 453) Scenester TV
453) link=https://www.filmon.com/tv/scenestertv
     chan_name="Scenester TV" ;;
# 454) Celeberity Action Network
454) link=https://www.filmon.com/tv/celebrity-action-network
     chan_name="Celebrity Action Network" ;;
# 455) Dame Dash TV
455) link=https://www.filmon.com/tv/dame-dash-tv
     chan_name="Dame Dash TV" ;;
# 456) Nik Richie Network
456) link=https://www.filmon.com/tv/nik-richie-network
     chan_name="Nik Richie Network" ;;
# 457) Celebrity Icons
457) link=https://www.filmon.com/tv/celebrity-icons-tv
     chan_name="Celebrity Icons" ;;
# 458) Andy Dick
458) link=https://www.filmon.com/tv/andy-dick
     chan_name="Andy Dick" ;;
# 459) Janice TV
459) link=https://www.filmon.com/tv/janice-tv
     chan_name="Janice TV" ;;
# 460) Kato Katelin
460) link=https://www.filmon.com/tv/kato
     chan_name="Kato Katelin" ;;
# 461) PPV Celebrity Fight
461) link=https://www.filmon.com/tv/ppv-celebrity-fight
     chan_name="PPV Celebrity Fight" ;;
# 462) Vertro Live
462) link=https://www.filmon.com/tv/vertrolive
     chan_name="Vertro Live" ;;
# 463) Star Shop
463) link=https://www.filmon.com/tv/starshop
     chan_name="Star Shop" ;;  
############################# FOOD #########################################
# 464) Wine RAM
464) link=https://www.filmon.com/tv/wineram
     chan_name="Wine Ram" ;;
# 465) World of Wine
465) link=https://www.filmon.com/tv/world-of-wine
     chan_name="World of Wine" ;;
# 466) The Chef Roc Show
466) link=https://www.filmon.com/tv/the-chef-roc-tv-show
     chan_name="The Chef Roc Show" ;;
# 467) Food Network Plus 1
467) link=https://www.filmon.com/tv/food-network-plus-1
     chan_name=Food Network + 1"" ;;
# 468) World Food Championships
468) link=https://www.filmon.com/tv/world-food-championships
     chan_name="World Food Championships" ;;
# 469) Dude Food
469) link=https://www.filmon.com/tv/dude-food
     chan_name="Dude Food" ;;
# 470) Food Network
470) link=https://www.filmon.com/tv/food-network
     chan_name="Food Network" ;;
# 471) iFood TV
471) link=https://www.filmon.com/tv/ifood-tv
     chan_name="iFood TV" ;;
# 472) Indian Recipes
472) link=https://www.filmon.com/tv/indian-recipes
     chan_name="Indian Recipes" ;;
# 473) Wine Oh TV 
473) link=https://www.filmon.com/tv/wine-oh-tv
     chan_name="Wine Oh TV" ;;
# 474) Gastrolab
474) link=https://www.filmon.com/tv/gastrolab
     chan_name="Gastrolab" ;;
# 475) Outdoor Cooking Channel
475) link=https://www.filmon.com/tv/outdoor-cooking-channel
     chan_name="Outdoor Cooking Channel" ;;
# 476) Wine Channel TV
476) link=https://www.filmon.com/tv/wine-channel-tv
     chan_name="Wine Channel TV" ;;
# 477) ECO RICO
477) link=https://www.filmon.com/tv/eco-rico
     chan_name="Eco Rico" ;;
# 478) Veg TV
478) link=https://www.filmon.com/tv/veg-tv
     chan_name="Veg TV" ;;
     
############################## CARS AUTO
#  479) Auto Channel
479) link=https://www.filmon.com/tv/auto-channel
     chan_name="Auto Channel" ;;
# 480) Raceline TV
480) link=https://www.filmon.com/tv/raceline-tv
     chan_name="Raceline TV" ;;
# 481) Race Central
481) link=https://www.filmon.com/tv/race-central-tv
     chan_name="Race Central" ;;
# 482) Honda HPD
482) link=https://www.filmon.com/tv/honda-hpd
     chan_name="Honda HPD" ;;
# 483) Torque and Tush
483) link=https://www.filmon.com/tv/torque-and-tush
     chan_name="Torque and Tush" ;;
# 484) MotorZ
484) link=https://www.filmon.com/tv/motorz
     chan_name="MotorZ" ;;
# 485) Steel Dreams
485) link=https://www.filmon.com/tv/steel-dreams
     chan_name="Steel Dreams" ;;
# 486) Distant Roads
486) link=https://www.filmon.com/tv/distant-roads
     chan_name="Distant Roads" ;;
############################# EDUCATION
# 487) The Florida Channel
487) link=https://www.filmon.com/tv/the-florida-channel
     chan_name="The Florida Channel" ;;
# 488) Make Your Move
488) link=https://www.filmon.com/tv/make-your-move
     chan_name="Make Your Move" ;;
# 489) Smarts TV
489) link=https://www.filmon.com/tv/smarts-tv
     chan_name="Smarts TV" ;;
# 490) Parenting International
490) link=https://www.filmon.com/tv/parenting-international-tv
     chan_name="Parenting International" ;;
########################## SHOPPING
# 491) Jewlery TV
491) link=https://www.filmon.com/tv/jewelry-tv
     chan_name="Jewlery TV" ;;
# 492) QVC HD 
492) link=https://www.filmon.com/tv/qvc-hd
     chan_name="QVC HD" ;;
# 493) Shop N Give
493) link=https://www.filmon.com/tv/shop-n-give
     chan_name="Shop N Give" ;;
# 494) Deals TV
494) link=https://www.filmon.com/tv/deals-tv
     chan_name="Deals TV" ;;
# 495) Beauty IQ
495) link=https://www.filmon.com/tv/beauty-iq
     chan_name="Beauty IQ" ;;
# 496) QVC
496) link=https://www.filmon.com/tv/qvc
     chan_name="QVC" ;;
# 497)  American Auctions
497) link=https://www.filmon.com/tv/americas-auction-network
     chan_name="American Auction" ;;
# 498) Caribbean Shopping
498) link=https://www.filmon.com/tv/caribbean-shopping-channel
     chan_name="Caribbean Shopping" ;;
# 499) Product Showcase
499) link=https://www.filmon.com/tv/product-showcase-network
     chan_name="Product Showcase Network" ;;
############################### CARIBBEAN
# 500) Calabash TV
500) link=https://www.filmon.com/tv/calabash-tv
     chan_name="Calabash TV" ;;
# 501) Caribbean Lifestyle
501) link=https://www.filmon.com/tv/caribbean-lifestyle-channel
     chan_name="Caribbean Lifestyle" ;;
# 502) Scruffy TV
502) link=https://www.filmon.com/tv/scruffy-tv
     chan_name="Scruffy TV" ;;
############################### ASIAN
# 503) Arirang TV Korea
503) link=https://www.filmon.com/tv/arirang-tv
     chan_name="Ariran TV Korea" ;;
# 504) VTC 10
504) link=https://www.filmon.com/tv/vtc-10
     chan_name="VTC 10" ;;
# 505) Voice of America Weishi
505) link=https://www.filmon.com/tv/voa-weishi
     chan_name="Voice of America Weishi" ;;
################################ AFRICAN
# 506) Eri Eritrea TV Africa
506) link=https://www.filmon.com/tv/eri-tv
     chan_name="Eri TV Eritrea";;
# 507) Nollywood Nigeria
507) link=https://www.filmon.com/tv/nollywood
     chan_name="Nollywood" ;;
# 508) Igboro TV
508) link=https://www.filmon.com/tv/igboro-tv
     chan_name="I Goboro TV" ;;
######################### KAZAKH
# 509) KAZAKH
509) link=https://www.filmon.com/tv/kazakh-tv
     chan_name="Kazakh TV" ;;
####################### RADIO   ##########################################     
# 510) The Marko Polka Show
510) link=https://www.filmon.com/tv/the-marko-polka-show
     chan_name="The Marko Polka Show" ;;
# 511) V104 Live
511) link=https://www.filmon.com/tv/v104-live
     chan_name="V104 Live" ;;
# 512) Daytona's Surf
512) link=https://www.filmon.com/tv/daytonas-surf
     chan_name="Daytona's Surf" ;;
# 513) Classic Oldies Jukebox
513) link=https://www.filmon.com/tv/classic-oldies-jukebox-hd-internet-radio
     chan_name="Classic Oldies Jukebox" ;;
# 514) Radio 337 The Cajun
514) link=https://www.filmon.com/tv/radio337-the-cajun
     chan_name="Radio 337 The Cajun" ;;
# 515) J and J FM
515) link=https://www.filmon.com/tv/j-and-j-fm
     chan_name="J and J FM" ;;
# 516) U Matter 2 Radio
516) link=https://www.filmon.com/tv/u-matter-2-radio
     chan_name="U Matter 2 Radio" ;;
# 517) WXEA 94.7
517) link=https://www.filmon.com/tv/wxea-947-1071
     chan_name="WXEA 94.7" ;;
# 518) The Wise Choice
518) link=https://www.filmon.com/tv/the-wise-choice
     chan_name="The Wise Choice" ;;
# 519) FONYE Dance
519) link=https://www.filmon.com/tv/fonye-dance
     chan_name="FONYE Dance" ;;
# 520) Key 56 Internet Radio
520) link=https://www.filmon.com/tv/key56-internet-radio
     chan_name="Key 56 Internet Radio" ;;
# 521) A-1 Bluegrass Favorites
521) link=https://www.filmon.com/tv/a-1-bluegrass-favorites
     chan_name="A-1 Bluegrass Favorites" ;;
# 522) WZQR Talks
522) link=https://www.filmon.com/tv/wzqr-talks
     chan_name="WZQR Talks" ;;
esac
}

# initialize menu value
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
elif [ "$input" == " " ]
then
menstat="no"
chan_state="return"
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

num=1

# get the menu selection status
menu_status $num

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
else 
num="$entry"
fi

# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select "$num"
 echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
  
 menu_switch "$menu" 
 echo "You were watching "$chan_name" on Channel "$num" "
 chan_state="normal"
 read entry
 else 
 menu_switch "$menu"
 read entry
fi

while [ "$entry" != q ]
do
menu_status $entry

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
else 
num="$entry"
fi

if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  menu_switch "$menu"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
  
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
read entry
else 
menu_switch "$menu"
chan_state="normal"
read entry

fi
done


echo "Type endstream to open a new stream."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

# --user-agent=<string>
# mpv --http-header-fields='Field1: value1','Field2: value2' 
# --tls-verify
# --referrer=<string>
# --cache-secs=<seconds>
# --cache-file-size=<kBytes>
# --cache-pause  --cache=<kBytes|yes|no|auto>
# https://mpv.io/manual/master/

######################     END OF PROGRAM      ####################################################

