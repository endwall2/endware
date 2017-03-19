#! /bin/sh
######################################################################
# Title: endtv.sh
# Description:  Clearnet streaming from FilmOnTV of selected TV 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.02
# Revision Date: March 19, 2017
#
# Change Log:  - Forked from enstream.sh
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
# Dependencies: youtube-dl, mpv, read , firejail
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
version="0.02"
rev_date="19/03/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookie.tmp" 

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      EndTV  "$version"   =========================================================================="
   echo "====================================================================================================================================================================="
   echo "=======CANADA======  39)CBS Drama        77)Zombie Underworld 116)Sci-Fi Telly    155)Noise Network 192)POP             229)CDTV          267)TMTV          305)TV Gold   "    
   echo "1)CFRN CTV EDMONTON  40)CBS Action       78)Vampire Empire    117)Hollywoodland   156)Janey Kirk    193)Popeye          230)EIC TV        268)WHOMAG        306)Battle Rap " 
   echo "2)CKCK CTV REGINA    41)truTV            79)Creepy Crawly     118)Western Channel 157)FilmOn Jazz   194)Funny Company   231)Global Goals  269)WHOMAG VID    307)Tribe TV   "  
   echo "3)CFCN-5 CTV LethBr  42)Psychic Today    80)RSquared          119)Matriarch       158)FilmOn Rock   195)AngelAttic      232)Native Nations270)New Star      308)FOn Reality"             
   echo "4)CICC CTV Yorktown  43)FusionPlus TV    81)Macabre Theater   120)Film 4          159)JCTV          196)Cat TV          233)France 24     271)Bone Thugs    309)Red Carpet"  
   echo "========UK ========== =====SPORTS======  82)B-Movie!          121)Film Detective  160)Classic Arts  197)CBeebies        234)Truth Files   272)RMC Live      310)Christmas "  
   echo "5)BBC One            44)Grandstand Show  83)Alien Invasion    ===ENTERTAINMENT====161)Jazz Radio    198)CBBC            235)NewsMax       273)Raw Report    311)Nub TV  "
   echo "6)My Face My Body    45)Football Fanatics84)Horror Channel    122)CRAGG           ====BIKINI=====   199)Talya Toys      236)TV 47         274)Linkct Network312)Chai Life"
   echo "7)V Channel          46)FilmOn Tennis    =======MOVIES======= 123)Shockya Trailers162)Player        200)Kartoon Klassic 237)VOA           275)Urban Music   313)Joe Nation"
   echo "8)Reality TV         47)Snooker Legends  85)FilmOn Classics   124)California Life 163)J CLub        201)Fun Little      238)FilmOn NEWS   276)Aspire Now    314)OCRealEstate"
   echo "9)Ireland's Country  48)The Ring TV      86)Love On The Range 125)Rose Parade     164)Bikini Down   202)Tayla Tea       239)Al Jazeera    277)Amp TV        315)MHL TV  "
   echo "10)Britrox           49)Gali Lucha Libre 87)Silent Cinema     126)Screensaver     165)Cheerleaders  203)Wild Animals    240)Bloomberg     278)Weedmaps      316)RUNWAY TV"
   echo "11)Dr. Fab Show      50)Beach Sports     88)ChristmasTime     127)Drone TV        166)Party Girls   204)FilmOn Kids     241)DW English    279)Buddy Plant   317)TEOS   "
   echo "12)BBC News          51)Pugalism         89)Real Life Films   128)Miss Multiverse 167)Showing Off   205)Smile Child     242)Russia Today  280)PROHBTD       318)TV ART "
   echo "13)BBC 1 Wales       52)Inside The Ring  90)Sherlock Holmes   129)Vape Channel    168)Show and Tell 206)Mouse House     243)America Thinks281)Sweet Leaf    319)RunwayTV "  
   echo "14)BBC 1 Scotland    53)Emerging Sports  91)Xtreme IND        130)Trinity Heart   169)Miss Top      =====BUSINESS=====  244)CGTN          ===LIFESTYLE===   320)Chic   "
   echo "15)BBC 1 N Ireland   54)Softball 360     92)Seven Sins        131)Talent Know     170)Bikini TV     207)Crowd Angels    245)DVID          282)Health Life   321)NASA TV"
   echo "16)BBC Two           55)Golden Boy       93)The Monarch       132)EZ Way          171)Bikini Kitchen208)Red Chip        246)Press TV      283)SOBA          ===FRENCH==="	
   echo "17)BBC Parliament    56)FilmOn Wrestling 94)Trailer Nut       133)Tomorrow Pics   172)Miami TV      209)Biz TV          247)Job Channel   284)Readers Digest322)ARTE   "
   echo "18)BBC Four          57)FilmOn Football  95)Thespian Theater  134)Razzies         =====COMEDY====== ===DOCUMENTARY====  248)Unreliable    285)Green Living  323)France 0"  
   echo "19)ITV               58)Roopstigo        96)Rated B           135)24.7 The Stream 173)ComiCZoo      210)CCTV 9          249)Insider Ex    286)Safe TV       324)France 3"
   echo "20)ITV +1            59)Fighting Athletes97)Movie Loft TV     136)Miami Music     174)Placeholders  211)Fame TV         ==EXTREME SPORTS==287)Bid America   325)France 3"       
   echo "21)ITV2              60)Ultimate Disc    98)Dragon Arena      137)Talent Watch    175)Lumbfilm      212)Locomotion      250)GFL Combat    288)MegaMe        326)RTS UN"  
   echo "22)ITV2 +1           61)FilmOn Boxing    99)Mad Science Cinema138)HotRock         176)FimOn Comedy  213)FBI Insider     251)XCORPS        289)Wonderful Life327)RTS Deux"
   echo "23)ITV3              62)Game Time        100)FilmOn Family    139)Hot Country     177)Spud's Funny  214)FilmOn Docs     252)MMA Now       290)Simply Me     328)BFM Biz"  
   echo "24)ITV3 +1           63)1 on 1 Boxing    101)Hollywood War    140)Music Mix       178)SupaPirateBoot215)UFO NEWS        253)GLORY Kick    291)The Walk      329)BFM TV"
   echo "25)ITV4              64)AFL Classic      102)Bloodzillathon   141)Guitar Lessons  179)Fun Little    216)WAKAJ TV        254)Sledhead      292)Time TV       330)France 2"
   echo "26)ITV4 +1           65)Cheer Channel    103)Banned Western   142)Soundtrack      180)Comedy Time   217)FilmOn Bio      255)DestX         293)DRTV          ===GERMAN==="
   echo "27)ITV Be            66)Football Heroes  104)Eurotrash        143)EDM TV          181)EyeforanEye   218)Victory at Sea  256)PlanetX       294)Medical News  331)HSE 2a"
   echo "28)Channel 4         67)Live Boxing      105)High School      144)Jimmy Lloyd SWS =====KIDS======== 219)FilmOn War      257)MMA Now       295)Supreme Master332)HSE 2b"    
   echo "29)E4                68)Army Boxing      106)Award Cinema     145)Beatles Stories 182)KIDS ZONE     220)Ghost Hunters   258)UFC Next      =====FILMON====   333)Kika   "
   echo "30)More4             69)Tuff TV          107)New York         146)DM TV           183)AngelsAttic   221)Timeless Bios   259)Sports Blooper296)FOTV USA      334)ZDF Info"
   echo "31)Channel 5         70)Disability Sports108)Major Crimes     147)Country Star    184)SuperGeekHero 222)RealLife History260)Crash Bang    297)FOTV Workout  ===RUSSIAN==" 
   echo "32)5*                71)Fashion News     109)Cultra           148)Josh and JB     185)AA Create     223)Living History  ====URBAN/PARTY===298)FilmOn Sports 335)RTR Planet"  
   echo "33)5USA              ======HORROR========110)iFlix TV         149)JBTV            186)Reading       224)WW2 TV          261)Urban Firearms299)360 Exp       336)CurrentTime"
   echo "34)Really            72)FilmOn Horror    111)Campy Channel    150)Jazz TeeVee     187)OM NOM        225)Aliens UFOS     262)Road 2 Fame   300)BH Cam 360    337)RT Docs"
   echo "35)Yesterday         73)American Horrors 112)Filmon Stars     151)Dancing Machine 188)Kids Rock     226)Crime Inc.      263)WWRTV         301)R&B Live      338)Perviy "
   echo "36)Pick TV           74)Midnight Release 113)KungFu Classics  152)Inside Music    189)Tiny Pop      227)Short a Lesson  264)Evidence      302)Cast Out      339)Music Box"	
   echo "37)CBS Reality       75)Chillings        114)Double Feature   153)Tipstr.TV       190)Kix!          ======NEWS========= 265)Superfly      303)ROC Summer    340)Rossiya 24"
   echo "38)CBS Reality+1     76)Monster Madhouse 115)FilmOn Grab Bag  154)Clubbing TV     191)Tails TV      228)Newsy           266)Harlem        304)FilmON Studio ===INDIA TV=="
   echo "========================================================================================================================================================================"
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      EndTV  "$version"   =========================================================================="
   echo "=====INDIA==========================================================================================================================================================="
   echo "341)Films of India   377)RT Espanol        415)Sprokets         450)GLORY TV      487)Torque Tush    520)U Matter 2    560)      600)     640)     "    
   echo "342)Live 9 TV        378)DW Latino America 416)Teen Shorts      451)Dunamis       488)MotorZ         521)WXEA 94.7     561)      601)     641)     " 
   echo "343)Delhi Aaj Tak    379)Televideo Latino  417)Drama Shorts     452)Global Music  489)Steel Dreams   522)Wise Choice   562)      602)     642)     "  
   echo "344)Aaj Tak          ===CLASSIC TV===      418)Digi Animation   453)Church Channel490)Distant Roads  523)FONYE Dance   563)      603)     643)     "             
   echo "345)Tez TV           380)The Lucy Show     419)Documentary      454)TBN           ====EDUCATION===   524)Key 56        564)      604)     644)     "  
   echo "346)ABP News         381)Date with Angels  ===OUTDOORS=====     455)DAYSTAR       491)Florida        525)A1 Bluegrass  565)      605)     645)     "  
   echo "===ITALY===          382)Man with Camera   420)Bayou Country    456)CATHOLIC TV   492)Make Your Move 526)WZQR Talk     566)      606)     646)     "
   echo "347)Italia Channel   383)Colgate Comedy    421)Gun Student      ===CELEBS====     493)Smarts TV      527)              567)      607)     647)     "
   echo "348)Camera Deputati  384)Catwalk           422)Ultimate Outdoor 457)Screenster    494)Parenting TV   528)              568)      608)     648)     "
   echo "349)QVC Italy        385)Life of Riley     423)Hunt Channel     458)Celeb Action  =====SHOPPING====  529)              569)      609)     649)     "
   echo "==MIDDLE EAST==      386)Strange Paradise  424)Thouroughbred    459)Dame Dash     495)Jewelry TV     530)              570)      610)     650)     "
   echo "350)Rotana Aflam     387)Red Skeleton      425)Wilderness       460)Nik Richie    496)QVC HD         531)              571)      611)     651)     "
   echo "351)DW Arabia        388)Dragnet           426)Pursuit          461)Celeb Icons   497)Shop-N-Give    532)              572)      612)     652)     "
   echo "352)AlJazeera Docs   389)Private Secretary ===TRAVEL======      462)Andy Dick     498)Deals TV       533)              573)      613)     653)     "
   echo "353)AlJazeeraMubasher390)Suspense TV       427)HWC              463)Janice TV     499)Beauty IQ      534)              574)      614)     654)     "  
   echo "354)AlJazeera Arabic 391)Timeless Westerns 428)Jet Set          464)Kato Katelin  500)QVC            535)              575)      615)     655)     "
   echo "355)Saudi TV 2       392)You bet your Life 429)Mata             465)Celeb Fight   501)America Auction536)              576)      616)     656)     "
   echo "356)Saudi TV Sports  393)Flash Gordon      430)Mega Dest        466)Vertro Live   502)Caribbean Shop 537)              577)      617)     657)   "	
   echo "357)Suryoyo Satalite 394)Betty Boop        431)30A TV           467)Star Shop     503)Product Show   538)              578)      618)     658)   "
   echo "358)Rotana           395)Fury TV           432)OBX TV           =====FOOD====     ====CARIBBEAN====  539)              579)      619)     659)   "  
   echo "359)Rotana Clip      396)Cisco Kid         433)Travel           468)Wine Ram      504)Calabash       540)              580)      620)     660)   "
   echo "360)Rotana Khalijah  397)Bonanza           434)Landmarks        469)World of Wine 505)Caribbean Life 541)              581)      621)     661)   "       
   echo "361)Rotana Classic   398)Ozzie and Harriet 435)Infamous Places  470)The Chef Roc  506)Scruffy TV     542)              582)      622)     662)   "  
   echo "362)Rotana Masriya   399)One Step Beyond   ====SOMALIA====      471)Food Network+1====ASIAN========  543)              583)      623)     663)   "
   echo "363)Rotana Cinema    400)Charlie Chaplin   436)SNL TV           472)Food Champ    507)Arirang TV     544)              584)      624)     664)   "  
   echo "364)Saudi TV 1       401)Beverly Hillbilies437)Universal TV     473)Dude Food     508)VTC-10         545)              585)      625)     665)   "
   echo "365)Noor Dubai       402)Robin Hood        438)National         474)Food Network  509)VOA Weishi     546)              586)      626)     666)   "
   echo "366)iFilm            403)Timeless TV       439)Horn Cable       475)iFood TV      ===AFRICAN======   547)              587)      627)     667)   "
   echo "367)Dubai Sports     404)Spud's Crime      440)ESTV             476)Indian Recipe 510)ERI TV         548)              588)      628)     668)   "
   echo "=====SWISS =====     405)Dick Van Dyke     441)Kalsan           477)Wine Oh       511)Nollywood      549)              589)      629)     669)   "    
   echo "368)SRF 1            == SHORT FILMS==      ===GREEK======       478)Gastrolab     512)iGboro TV      550)              590)      630)     670)   "
   echo "369)RSI LA 1         406)Funny Shorts      442)RIK              479)Outdoor Cook  ===KAZAKH=======   551)              591)      631)     671)   "
   echo "370)Raido Chico      407)Movies            ==RELIGION=====      480)Wine Channel  513)Kazakh TV      552)              592)      632)     672)   " 
   echo "=====LATINO======    408)Dancing Shorts    443)Hispanic         481)Eco Rico      ====RADIO=====     553)              593)      633)     673)   "  
   echo "371)Peliculas FilmON 409)Reality Shorts    444)You Shall Live   482)Veg TV        514)Marko Polka    554)              594)      634)     674)   "
   echo "372)Catwalk Espanol  410)Acid TV           445)Preach the Word  ====CARS=======   515)v104 Live      555)              595)      635)     675)   "
   echo "373)Animacion FilmOn 411)Horror TV         446)Audio Scripture  483)Auto Channel  516)Daytona Surf   556)              596)      636)     676)   "
   echo "374)Planet Fashion   412)Music Videos      447)Cyber Church     484)Raceline TV   517)Classic Oldies 557)              597)      637)     677)   "	
   echo "375)HispanTV         413)Sci Fi            448)Faith Cinema     485)Race Central  518)The Cajun      558)              598)      638)     678)   "
   echo "376)Telenovelas      414)Micro Shorts      449)NRB              486)Honda HPD     519) J&J FM        559)              599)      639)     679)   "
   echo "========================================================================================================================================================================"
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
echo "Select a new stream number or press q to quit."
read num
fi

fi

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    CANADIAN TV  ##################################
# 1) CFRN CTV Edmonton
1) link=https://www.filmon.com/tv/cfrn-ctv-edmonton
   chan_name="CFRN CTV Edmonton";;
# 2) CKCK CTV Regina
2) link=https://www.filmon.com/tv/ckck-ctv-regina 
   chan_name="CKCK CTV Regina" ;;  
#  3) CFCN 5 CTV Lethbridge
3) link=https://www.filmon.com/tv/cfcn-5-ctv-lethbridge  
    chan_name="CFCN 5 CTV Lethbridge";;   
# 4) CICC CTV Yorktown
4) link=https://www.filmon.com/tv/cicc-ctv-yorkton  
 chan_name="CICC CTV Yorktown" ;;
# 5) BBC One
5) link=https://www.filmon.com/tv/bbc-one 
   chan_name="BBC One";;
# 6) My Face My Body 
6) link=https://www.filmon.com/tv/my-face-my-body   
     chan_name="My Face My Body" ;;
# 7) V Channel
7) link=https://www.filmon.com/tv/v-channel
   chan_name="V Channel";;
# 8) Reality TV
8) link=https://www.filmon.com/tv/reality-tv    
    chan_name="Reality TV";;    
# 9) Ireland's Country
9) link=https://www.filmon.com/tv/irelands-country-tv 
   chan_name="Ireland's Coundry";;     
#  10) Brit Rox
10) link=https://www.filmon.com/tv/britrox 
    chan_name="britrox" ;;
# 11) Dr. Fab Show
11) link=https://www.filmon.com/tv/dr-fab-show
    chan_name="Dr. Fab Show" ;;
# 12)BBC News
12) link=https://www.filmon.com/tv/bbc-news
    chan_name="BBC News" ;;
# 13) BBC 1 Wales
13) link=https://www.filmon.com/tv/bbc-1-wales
    chan_name="BBC 1 Wales" ;;
# 14) BBC 1 Scotland
14) link=https://www.filmon.com/tv/bbc-1-scotland
    chan_name="BBC 1 Scotland" ;;
# 15) BBC 1 North Ireland
15)  link=https://www.filmon.com/tv/bbc-1-north-ireland
     chan_name="BBC 1 North Ireland" ;;
# 16)  BBC TWO
16) link=https://www.filmon.com/tv/bbc-two
    chan_name="BBC TWO" ;;
# 17) BBC Parliament
17) link=https://www.filmon.com/tv/bbc-parliament
    chan_name="BBC Parliament" ;;
# 18)  BBC Four
18) link=https://www.filmon.com/tv/cbeebiesbbc-four
    chan_name="BBC Four" ;; 
# 19) ITV
19) link=https://www.filmon.com/tv/itv1
    chan_name="ITV" ;;
# 20) ITV + 1
20) link=https://www.filmon.com/tv/itv-plus-1
chan_name="ITV + 1" ;; 
# 21) ITV 2
21) link=https://www.filmon.com/tv/itv2
chan_name="ITV 2" ;;   
# 22) ITV 2 + 1
22) link=https://www.filmon.com/tv/itv2-plus-1
chan_name="ITV 2 + 1" ;;
# 23) ITV 3
23) link=https://www.filmon.com/tv/itv3
chan_name="ITV 3" ;;
# 24) ITV 3 + 1
24) link=https://www.filmon.com/tv/itv3-plus-1 
chan_name="ITV 3 + 1" ;;
# 25) ITV 4
25) link=https://www.filmon.com/tv/itv4
chan_name="ITV 4" ;;
# 26) ITV 4 + 1
26) link=https://www.filmon.com/tv/itv4-plus-1
chan_name="ITV 4 + 1" ;;
# 27) ITV Be
27) link=https://www.filmon.com/tv/itvbe
    chan_name="ITV Be" ;;
# 28)  Channel 4
28) link=https://www.filmon.com/tv/channel-4
     chan_name="Channel 4" ;;    
# 29) E4
29) link=https://www.filmon.com/tv/channel-4
chan_name="E4" ;;
# 30) More4
30) link=https://www.filmon.com/tv/more4
chan_name="More4" ;;
# 31) Channel 5
31) link=https://www.filmon.com/tv/channel-5
chan_name="Channel 5" ;;
# 32) 5*
32) link=https://www.filmon.com/tv/5-star
chan_name="5*" ;;
# 33) 5 USA
33) link=https://www.filmon.com/tv/5usa
chan_name="5 USA" ;;
# 34) Really
34) link=https://www.filmon.com/tv/really
chan_name="Really" ;;
# 35) Yesterday
35) link=https://www.filmon.com/tv/yesterday
chan_name="Yesterday" ;;
# 36) Pick TV
36) link=https://www.filmon.com/tv/pick-tv
chan_name="Pick TV" ;;
# 37) CBS Reality 
37) link=https://www.filmon.com/tv/cbs-reality
chan_name="CBS Reality" ;;
# 38) CBS Reality + 1
38) link=https://www.filmon.com/tv/cbs-reality1
chan_name="CBS Reality + 1" ;;  
# 39) CBS Drama
39) link=https://www.filmon.com/tv/cbs-drama
chan_name="CBS Drama" ;;
# 40) CBS Action
40) link=https://www.filmon.com/tv/cbs-action
    chan_name="CBS Action" ;;
# 41) TruTV
41) link=https://www.filmon.com/tv/tru-tv
chan_name="TruTV" ;;
# 42) Psychic TV
42) link=https://www.filmon.com/tv/psychic-today
chan_name="Psychic TV" ;;
# 43) FussionPlus TV
43) link=https://www.filmon.com/tv/fusionplus
    chan_name="Fussion Plus TV" ;;
###################### SPORTS ################################    
# 44) Grandstand Show
44) link=https://www.filmon.com/tv/grandstand-show
    chan_name="Grandstand Show" ;;                                                            
# 45) Football Fanatics
45) link=https://www.filmon.com/tv/football-fanatics
    chan_name="Football Fanatics" ;;
# 46) FilmOn Tennis
46) link=https://www.filmon.com/tv/filmon-tennis
    chan_name="FilmOn Tennis" ;;
# 47) Snooker Legends
47) link=https://www.filmon.com/tv/snooker-legends
    chan_name="Snooker Legends" ;;
# 48) The Ring TV
48) link=https://www.filmon.com/tv/ring-tv
    chan_name="The Ring TV" ;;
# 49) Gali Lucha Libre
49) link=https://www.filmon.com/tv/galli-lucha-libre
    chan_name="Gali Lucha Libra" ;;
# 50) Beach Sports Network
50) link=https://www.filmon.com/tv/beach-sports-network
    chan_name="Beach Sports Network" ;;
# 51) Pugalism TV   
51) link=https://www.filmon.com/tv/pugilism-tv
chan_name="Pugilism TV"  ;;      
# 52) Inside The Ring
52) link=https://www.filmon.com/tv/inside-the-ring
chan_name="Inside The Ring" ;;
# 53) Emerging Sports TV
53) link=https://www.filmon.com/tv/emerging-sports-tv
chan_name="Emerging Sports TV";;
# 54) Softball 360
54) link=https://www.filmon.com/tv/softball-360
chan_name="Softball 360" ;;
# 55) Golden Boy Channel
55) link=https://www.filmon.com/tv/golden-boy-channel
chan_name="Golden Boy Channel";;
# 56) FilmOn Wrestling
56) link=https://www.filmon.com/tv/filmon-wrestling-network
chan_name="Film On Wrestling" ;;
# 57) FilmOn Football
57) link=https://www.filmon.com/tv/filmon-football
chan_name="FilmOn Football" ;;
# 58) Roopstigo 
58) link=https://www.filmon.com/tv/roopstigo
chan_name="Roopstigo";;
# 59) Fighting Athletes Network
59) link=https://www.filmon.com/tv/fighting-athletes-network
chan_name="Fighting Athletes Network" ;;
# 60) Ultimate Disc TV
60) link=https://www.filmon.com/tv/ultimate-disc-tv
    chan_name="Ultimate Disc TV" ;;
# 61) FilmOn Boxing
61) link=https://www.filmon.com/tv/filmon-boxing
    chan_name="FilmOn Boxing" ;;
# 62) Game Time
62) link=https://www.filmon.com/tv/game-time  
    chan_name="Game Time" ;;
# 63) 1 on 1 Boxing TV
63) link=https://www.filmon.com/tv/1-on-1-boxing-tv
    chan_name="1 on 1 Boxing TV" ;;  
# 64) AFL Classic
64) link=https://www.filmon.com/tv/afl-classics
chan_name="AFL Classic" ;;
# 65) Cheer Channel
65) link=https://www.filmon.com/tv/cheer-channel
    chan_name="Cheer Channel" ;;
# 66) Football Heroes
66) link=https://www.filmon.com/tv/football-heroes
    chan_name="Football Heroes" ;;
# 67) Live Boxing
67) link=https://www.filmon.com/tv/live-boxing 
    chan_name="Live Boxing" ;;
# 68) Armed Forces Boxing
68) link=https://www.filmon.com/tv/armed-forces-boxing
    chan_name="Armed Forces Boxing" ;;
# 69) Tuff TV
69) link=https://www.filmon.com/tv/tuff
    chan_name="TUFF TV" ;;
# 70) Disability Sports
70) link=https://www.filmon.com/tv/disability-sports-network
    chan_name="Disability Sports" ;;
####################### PAY TV ############################    
# 71) Fashion News Network
71) link=https://www.filmon.com/tv/fashion-news-lifestyle
chan_name="Fashion News Network" ;;
####################### HORROR ###########################
# 72) FilmOn Horror
72) link=https://www.filmon.com/tv/filmon-horror-network
    chan_name="FilmON Horror";;
# 73) American Horrors
73) link=https://www.filmon.com/tv/american-horrors 
    chan_name="American Horrors" ;; 
# 74) Midnight Releasing
74) link=https://www.filmon.com/tv/midnight-releasing  
    chan_name="Midnight Releasing" ;; 
# 75) Chillings
75) link=https://www.filmon.com/tv/chillings
chan_name="Chillings" ;;
# 76) Monster Madhouse
76) link=https://www.filmon.com/tv/monster-madhouse
   chan_name="Monster Madhouse" ;;
# 77) Zombie Underworld
77) link=https://www.filmon.com/tv/zombie-underworld
    chan_name="Zombie Underworld" ;;
# 78) Vampire Empire
78) link=https://www.filmon.com/tv/vampire-empire
   chan_name="Vampire Empire" ;;
# 79) Creepy Crawly
79) link=https://www.filmon.com/tv/creepy-crawly  
chan_name="Creepy Crawly" ;; 
# 80) RSquared
80) link=https://www.filmon.com/tv/rsquared  
chan_name="RSquared" ;;
# 81) Macabre Theater
81) link=https://www.filmon.com/tv/macabre-theatre  
 chan_name="Macabre Theater" ;;   
# 82) B-Movie! 
82) link=https://www.filmon.com/tv/b-movie  
 chan_name="B-Movie" ;; 
# 83) Alien Invasion Channel
83) link=https://www.filmon.com/tv/alien-invasion-channel  
 chan_name="Alien Invasion Channel" ;; 
# 84) Horror Channel
84)  link=https://www.filmon.com/tv/horror-channel  
 chan_name="Horror Channel" ;; 
######################### MOVIES   #######################
# 85) FilmOn Classics
85)  link=https://www.filmon.com/tv/filmon-classic-films 
 chan_name="FilmOn Classics" ;;  
# 86) Love On The Range
86)  link=https://www.filmon.com/tv/love-on-the-range
 chan_name="Love On The Range" ;;   
# 87) Silent Cinema
87)  link=https://www.filmon.com/tv/silent-cinema
 chan_name="Silent Cinema" ;;   
# 88) Christmastime TV
88)  link=https://www.filmon.com/tv/christmastime-tv 
 chan_name="ChristmasTime TV" ;; 
# 89) Real Life Films 
89)  link=https://www.filmon.com/tv/real-life-films
 chan_name="Real Life Films" ;; 
 # 90) Sherlock Holmes Channel
90)  link=https://www.filmon.com/tv/sherlock-holmes-channel 
 chan_name="Sherlock Holmes Channel" ;; 
 # 91) Xtreme IND Films
91)  link=https://www.filmon.com/tv/xtreme-ind-films 
 chan_name="Xtreme IND Films" ;;  
 # 92) Seven Sins TV
92)  link=https://www.filmon.com/tv/seven-sins-tv 
 chan_name="Seven Sins TV" ;;  
 # 93) The Monarch Channel
93)  link=https://www.filmon.com/tv/the-monarch-channel 
 chan_name="The Monarch Channel" ;;  
# 94) Trailer Nut TV
94)  link=https://www.filmon.com/tv/trailer-nut-tv 
 chan_name="Trailer Nut TV" ;;  
# 95) Thespian Theater
95) link=https://www.filmon.com/tv/thespian-theater
    chan_name="Thespian Theater" ;;
#  96)  Rated B
96) link=https://www.filmon.com/tv/rated-b
chan_name="Rated B" ;;
# 97) Movie Loft TV
97) link=https://www.filmon.com/tv/movie-loft-tv
chan_name="Movie Loft TV" ;;
# 98) Dragon Arena
98) link=https://www.filmon.com/tv/dragon-arena
    chan_name="Dragon Arena" ;;
# 99) Mad Science Cinema
99) link=https://www.filmon.com/tv/mad-science-cinema
chan_name="Mad Sience Cinema" ;;
#  100) FilmOn Family
100) link=https://www.filmon.com/tv/filmon-family
chan_name="FilmOn Family" ;; 
# 101) Hollywood War
101) link=https://www.filmon.com/tv/hollywood-war
chan_name="Hollywood war";;
# 102) Bloodzillathon
102) link=https://www.filmon.com/tv/bloodzillathon
chan_name="Bloodzillathon"  ;;
# 103) Banned Westerns
103) link=https://www.filmon.com/tv/banned-westerns
chan_name="Banned Westerns" ;;
# 104) Eurotrash
104) link=https://www.filmon.com/tv/eurotrash
chan_name="Eurotrash" ;;
# 105) High School
105) link=https://www.filmon.com/tv/high-school
chan_name="High School" ;;
# 106) Award Cinema
106) link=https://www.filmon.com/tv/award-cinema
chan_name="Award Cinema" ;;  
# 107) New York Channel
107) link=https://www.filmon.com/tv/new-york-channel
chan_name="New York Channel" ;;
# 108) Major Crimes
108) link=https://www.filmon.com/tv/major-crimes
chan_name="Major Crimes" ;; 
#  109) Cultra
109) link=https://www.filmon.com/tv/cultra
     chan_name="Cultra" ;;
# 110) iFlix TV
110) link=https://www.filmon.com/tv/iflix-tv
     chan_name="iFlix TV" ;;
# 111) Campy Channel
111) link=https://www.filmon.com/tv/campy-channel
chan_name="Campy Channel" ;;
# 112) Filmon Stars
112) link=https://www.filmon.com/tv/filmon-stars
chan_name="Filmon Stars" ;;  
#  113) KungFu Classics
113) link=https://www.filmon.com/tv/kung-fu-classics
    chan_name="KungFu Classics" ;;
# 114) Double Feature TV
114) link=https://www.filmon.com/tv/double-feature-tv
chan_name="Double Feature TV";; 
# 115) FilmOn Grab Bag TV
115) link=https://www.filmon.com/tv/filmon-grab-bag-tv
chan_name="FilmOn Grab Bag TV" ;; 
# 116) Sci-Fi Telly
116) link=https://www.filmon.com/tv/sci-fi-telly
chan_name="Sci-Fi Telly";;    
# 117) Hollywoodland Channel
117) link=https://www.filmon.com/tv/hollywoodland-channel
chan_name="Hollywoodland-channel" ;;
# 118) The Western Channel
118) link=https://www.filmon.com/tv/the-western-channel
chan_name="The Western Channel" ;; 
# 119) Matriarch TV
119) link=https://www.filmon.com/tv/matriarch-tv
     chan_name="Matriarch TV" ;; 
# 120) Film 4
120) link=https://www.filmon.com/tv/film-4
chan_name="Film 4" ;;
# 121) The Film Detective
121) link=https://www.filmon.com/tv/the-film-detective
chan_name="The Film Detective";; 
#############################   ENTERTAINMENT ########################################
# 122) CRAGG
122) link=https://www.filmon.com/tv/cragg
chan_name="CRAGG" ;;
# 123) Shockya Trailers
123) link=https://www.filmon.com/tv/fotv-trailers
 chan_name="Shockya Trailers" ;;
## 124) California Life
124) link=https://www.filmon.com/tv/california-life
chan_name="California Life" ;;  
# 125) Rose Parade 2017
125) link=https://www.filmon.com/tv/rose-parade-2016
     chan_name="Rose Parade" ;;
# 126) Screensaver TV
126) link=https://www.filmon.com/tv/screensaver-tv
     chan_name="Screensaver TV" ;;
# 127) Drone TV
127) link=https://www.filmon.com/tv/drone-race-tv
chan_name="Drone TV" ;;
# 128) Miss Multiverse
128) link=https://www.filmon.com/tv/miss-multiverse
     chan_name="Miss Multverse" ;;
# 129) Vape Channel
129) link=https://www.filmon.com/tv/vape-channel
     chan_name="Vape Channel" ;;
# 130) Trinity Heart Media
130) link=https://www.filmon.com/tv/trinity-heart-media
     chan_name="Trinity Heart Media" ;;
# 131) Talent You Should Know
131) link=https://www.filmon.com/tv/talent-you-should-know
     chan_name="Talent You SHould Know" ;;
# 132) EZ Way TV
132) link=https://www.filmon.com/tv/ez-way-tv
     chan_name="EZ Way TV" ;;
# 133) Tomorrow Pictures 
133) link=https://www.filmon.com/tv/tomorrow-pictures
   chan_name="Tomorrow Pictures";;
# 134) Razzies Channel
134) link=https://www.filmon.com/tv/razzies-channel
  chan_name="Razzies Channel" ;;    
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
## 143) EDM TV
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
176) link=https://www.filmon.com/tv/filmon-comedy-classics
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
# 180) Comedy Time TV
180) link=https://www.filmon.com/tv/comedytime-tv
     chan_name="Comedy Time TV" ;;
# 181) Eye for an Eye
181) link=https://www.filmon.com/tv/eye-for-an-eye
     chan_name="Eye for an Eye" ;;    
################################## KIDS  ##################################    
# 182) KIDS ZONE
182) link=https://www.filmon.com/tv/kids-zone
     chan_name="KIDS ZONE" ;;
# 183) Angels from the Attic ComicFlix
183) link=https://www.filmon.com/tv/the-angels-from-the-attic-comicflix
     chan_name="Angels from the Attic ComicFlix" ;;
# 184) Super Geek Heroes
184) link=https://www.filmon.com/tv/super-geek-heroes
     chan_name="Super Geek Heroes" ;;
# 185) Angels from the Attic Create-Alongs
185) link=https://www.filmon.com/tv/the-angels-from-the-attic-create-alongs
     chan_name="Angels from the Attic Create" ;;
# 186) Children's Reading Channel
186) link=https://www.filmon.com/tv/childrens-reading-channel
     chan_name="Children's Reading Channel" ;;
# 187) OM NOM
187) link=https://www.filmon.com/tv/om-nom
     chan_name="OM NOM" ;;
# 188) Kids Rock TV
188) link=https://www.filmon.com/tv/kids-rock-tv
     chan_name="Kids Rock TV" ;;
# 189) Tiny Pop
189) link=https://www.filmon.com/tv/tiny-pop
     chan_name="Tiny Pop" ;;
# 190) Kix!
190) link=https://www.filmon.com/tv/kix
     chan_name="Kix!" ;;
# 191) Tails TV
191) link=https://www.filmon.com/tv/tails-tv
     chan_name="Tails TV" ;;
# 192) POP
192) link=https://www.filmon.com/tv/pop
     chan_name="POP" ;;
# 193) Popeye TV
193) link=https://www.filmon.com/tv/popeye-tv
     chan_name="Popeye TV" ;;
# 194) Funny Company
194) link=https://www.filmon.com/tv/funny-company-tv
     chan_name="Funny Company" ;;
# 195) Angels from the Attic Featurettes
195) link=https://www.filmon.com/tv/the-angels-from-the-attic-featurettes
     chan_name="Angels from the Attic Featurettes" ;;
# 196) Cat TV
196) link=https://www.filmon.com/tv/cat-tv
     chan_name="Cat TV" ;;
# 197) CBeebies 
197) link=https://www.filmon.com/tv/cbeebies
     chan_name="CBeebies" ;;
# 198) CBBC
198) link=https://www.filmon.com/tv/cbbc
     chan_name="CBBC" ;;
# 199) Tayla's Toddler Toy Review
199) link=https://www.filmon.com/tv/taylas-toddler-toy-review
     chan_name="Tayla's Toddler Toy Review" ;;
# 200) Kartoon Klassics
200) link=https://www.filmon.com/tv/kartoon-klassics
     chan_name="Kartoon Klassics" ;;
# 201) Fun Little Kids
201) link=https://www.filmon.com/tv/fun-little-kids
     chan_name="Fun Little Kids" ;;
# 202) Tea Time with Tayla
202) link=https://www.filmon.com/tv/tea-time-with-tayla
     chan_name="Tea Time with Tayla" ;;
# 203) Wild About Animals
203) link=https://www.filmon.com/tv/wild-about-animals
     chan_name="Wild About Animals" ;;
# 204) FilmOn Kids
204) link=https://www.filmon.com/tv/filmon-kids
     chan_name="FilmOn Kids" ;;
# 205) Smile of a Child
205) link=https://www.filmon.com/tv/smile-of-child
     chan_name="Smile of a Child" ;;
# 206) Mouse House Radio
206) link=https://www.filmon.com/tv/mouse-house-radio
     chan_name="Mouse House Radio" ;;
############################   BUSINESS TV    ############################
# 207) Crowd Angels TV
207) link=https://www.filmon.com/tv/crowd-angels-tv
     chan_name="Crowd Angels TV" ;;
# 208) Red Chip Money Report
208) link=https://www.filmon.com/tv/red-chip-money-report
     chan_name="Red Chip Money Report" ;;
# 209) Biz TV
209) link=https://www.filmon.com/tv/biztv
     chan_name="Biz TV" ;;
######################### Documentary #################################
# 210) CCTV 9 Documentary
210) link=https://www.filmon.com/tv/cctv9-documentary
     chan_name="CCTV 9 Documentary" ;;
# 211) Fame TV
211) link=https://www.filmon.com/tv/fame-tv
     chan_name="Fame TV" ;;
# 212) Locomotion TV
212) link=https://www.filmon.com/tv/loco-motion-tv
     chan_name="Locomotion TV" ;;
# 213) FBI Insider
213) link=https://www.filmon.com/tv/fbi-insider
     chan_name="FBI Insider" ;;
# 214) FilmOn Documentary
214) link=https://www.filmon.com/tv/filmon-documentary
     chan_name="FilmOn Documentary" ;;
# 215) UFO NEWS
215) link=https://www.filmon.com/tv/ufo-news
     chan_name="UFO NEWS" ;;
# 216) WAKAJ TV
216) link=https://www.filmon.com/tv/wkaj-tv
     chan_name="WAKAJ TV" ;;
# 217) FilmOn Biography
217) link=https://www.filmon.com/tv/filmon-biography-channel
     chan_name="FilmOn Biography" ;;
# 218) Victory at Sea
218) link=https://www.filmon.com/tv/victory-at-sea-tv
     chan_name="Victory at Sea" ;;
# 219) FilmOn War
219) link=https://www.filmon.com/tv/filmon-war-channel
     chan_name="FilmOn War" ;;
# 220) Ghost Hunters
220) link=https://www.filmon.com/tv/ghost-hunters
     chan_name="Ghost Hunters" ;;
# 221) Timeless Biographies
221) link=https://www.filmon.com/tv/timeless-biographies
     chan_name="Timeless Biographies" ;;
# 222) Real Life History
222) link=https://www.filmon.com/tv/real-life-history-channel
     chan_name="Real Life History" ;;
# 223) Living History
223) link=https://www.filmon.com/tv/living-history-channel
     chan_name="Living History" ;;
# 224) WW2 TV
224) link=https://www.filmon.com/tv/war-crime-network
     chan_name="WW2 TV" ;;
# 225) Aliens and UFOs
225) link=https://www.filmon.com/tv/aliens-and-ufos
     chan_name="Aliens and UFOs" ;;
# 226) Crime Inc.
226) link=https://www.filmon.com/tv/crime-inc
     chan_name="Crime Inc" ;;
# 227) In Short a Lesson in Almost Everything
227) link=https://www.filmon.com/tv/in-short-a-lesson-in-almost-everything
     chan_name="In Short a Lesson in Almost Everything" ;;
###################### NEWS TV   #########################
# 228) Newsy
228) link=https://www.filmon.com/tv/newsy
     chan_name="Newsy" ;;
# 229) CDTV
229) link=https://www.filmon.com/tv/cdtv
     chan_name="CDTV" ;;
# 230) EIC TV
230) link=https://www.filmon.com/tv/eic-tv
     chan_name="EIC TV" ;;
# 231) The Global Goals
231) link=https://www.filmon.com/tv/the-global-goals
     chan_name="The Global Goals" ;;
# 232) Native Nations TV
232) link=https://www.filmon.com/tv/native-nations-tv
     chan_name="Native Nations TV" ;;
# 233) France 24
233) link=https://www.filmon.com/tv/france24
     chan_name="France 24" ;;
# 234) Truth Files
234) link=https://www.filmon.com/tv/truth-files
     chan_name="Truth Files" ;;
# 235) NewsMax
235) link=https://www.filmon.com/tv/newsmax
     chan_name="NEWSMAX" ;;
# 236) TV 47
236) link=https://www.filmon.com/tv/tv47
     chan_name="TV 47" ;;
# 237) VOA
237) link=https://www.filmon.com/tv/voa-english
     chan_name="VOA" ;;
# 238) FilmOn Breaking NEWS
238) link=https://www.filmon.com/tv/filmon-breaking-news
     chan_name="" ;;
# 239) Al Jazeera
239) link=https://www.filmon.com/tv/al-jazeera
     chan_name="Al Jazeera" ;;
# 240) Bloomberg
240) link=https://www.filmon.com/tv/bloomberg
     chan_name="Bloomberg" ;;
# 241) DW English
241) link=https://www.filmon.com/tv/dw-english
     chan_name="DW English" ;;
# 242) Russia Today
242) link=https://www.filmon.com/tv/russia-today-2
     chan_name="Russia Today" ;;
# 243) What America Thinks
243) link=https://www.filmon.com/tv/what-america-thinks
     chan_name="What America Thinks" ;;
# 244) CGTN
244) link=https://www.filmon.com/tv/cctv-news
     chan_name="CGTN" ;;   
# 245) DVIDs TV
245) link=https://www.filmon.com/tv/dvids-tv
     chan_name="DVIDs TV" ;;     
# 246) Press TV
246) link=https://www.filmon.com/tv/press-tv
     chan_name="Press TV" ;;     
# 247) Job Channel
247) link=https://www.filmon.com/tv/job-channel-network
     chan_name="Job Channel" ;;
# 248) Unreliable Sources
248) link=https://www.filmon.com/tv/unreliable-sources
     chan_name="Unreliable Sources" ;;
# 249) Insider Exclusive
249) link=https://www.filmon.com/tv/insider-exclusive-tv
     chan_name="Insider Exclusive" ;;
############################### EXTREME SPORTS ####################
# 250) GFL Combat Sports
250) link=https://www.filmon.com/tv/gfl-combat-sports
     chan_name="GFL Combat Sports" ;;
# 251) XCORPS
251) link=https://www.filmon.com/tv/xcorps
     chan_name="XCORPS" ;;
# 252) MMA Now 360
252) link=https://www.filmon.com/tv/mma-now-360
     chan_name="MMA Now 360" ;;
# 253) GLORY Kickboxing
253) link=https://www.filmon.com/tv/glory-kickboxing
     chan_name="GLORY Kickboxing" ;;
# 254) Sledhead 24/7
254) link=https://www.filmon.com/tv/sledhead-247
     chan_name="Sledhead 24/7" ;;
# 255) Destination X
255) link=https://www.filmon.com/tv/destination-x
     chan_name="Destination X" ;;
# 256) Planet X Sport
256) link=https://www.filmon.com/tv/planet-x-sport
     chan_name="Planet X Sport" ;;     
# 257) MMA Now
257) link=https://www.filmon.com/tv/mmanow
     chan_name="MMA Now" ;;
# 258) UFC Next
258) link=https://www.filmon.com/tv/ufc-next
     chan_name="UFC Next" ;;
# 259) Sports Bloopers
259) link=https://www.filmon.com/tv/sports-bloopers-tv
     chan_name="Sports Bloopers" ;;
# 260) Crash Bang Boom
260) link=https://www.filmon.com/tv/crash-bang-boom
     chan_name="Crash Bang Boom" ;;
####################### URBAN  #############################
# 261) Urban Firearms
261) link=https://www.filmon.com/tv/urban-firearms-tv
     chan_name="Urban Firearms" ;;
# 262) Road 2 Fame
262) link=https://www.filmon.com/tv/road2fame
     chan_name="Road 2 Fame" ;;
# 263) WWRTV
263) link=https://www.filmon.com/tv/wwrtv
     chan_name="WWRTV" ;;
# 264) Irrefutable Evidence
264) link=https://www.filmon.com/tv/irrefutable-evidence-tv
     chan_name="Irrefutable Evidence" ;;
# 265) Superfly Cinema
265) link=https://www.filmon.com/tv/super-fly-cinema
     chan_name="SuperFly Cinema" ;;
# 266) Harlem Renaissance
266) link=https://www.filmon.com/tv/harlem-renaissance
     chan_name="Harlem Renaissance" ;;
# 267) TMTV
267) link=https://www.filmon.com/tv/tmtv
     chan_name="TMTV" ;;
# 268) WHOMAG
268) link=https://www.filmon.com/tv/whomag-tv
     chan_name="WHOMAG" ;;
# 269) WHOMAG VIDEOS
269) link=https://www.filmon.com/tv/whomag-video-vision
     chan_name="Whomag Videos" ;;
# 270) New Star TV
270) link=https://www.filmon.com/tv/new-star-tv
     chan_name="New Star TV" ;;
# 271) Bone Thugs
271) link=https://www.filmon.com/tv/bone-thugs-n-harmony
     chan_name="Bone Thugs" ;;
# 272) RMC Live
272) link=https://www.filmon.com/tv/rmc-live
     chan_name="RMC Live" ;;
# 273) The Raw Report
273) link=https://www.filmon.com/tv/the-raw-report
     chan_name="The Raw Report" ;;
# 274) Linkct Network
274) link=https://www.filmon.com/tv/linkct-network
     chan_name="Linkct Network" ;;
# 275) Urban Music Network
275) link=https://www.filmon.com/tv/urban-music-network
     chan_name="Urban Music Network" ;;
# 276) Aspire Now
276) link=https://www.filmon.com/tv/aspirenow-tv
     chan_name="Aspire Now" ;;
# 277) Amp TV
277) link=https://www.filmon.com/tv/amp-tv
     chan_name="Amp TV" ;;
     
###################### PARTY TV ##############################     
# 278) Weedmaps
278) link=https://www.filmon.com/tv/weedmaps-tv
     chan_name="Weedmaps" ;;
# 279) Buddy Plant
279) link=https://www.filmon.com/tv/buddy-plant
     chan_name="Buddy Plant" ;;
# 280) PROHBTD
280) link=https://www.filmon.com/tv/prohbtd
     chan_name="PROHBTD" ;;
# 281) Sweet Leaf TV
281) link=https://www.filmon.com/tv/sweet-leaf-tv
     chan_name="Sweet Leaf TV" ;;
###################### LIFESTYLE #################################
# 282) Health and Lifestyle
282) link=https://www.filmon.com/tv/health-and-lifestyle
     chan_name="Health and Lifestyle" ;;
# 283) SOBA recovery
283) link=https://www.filmon.com/tv/soba-network
     chan_name="SOBA Recovery" ;;
# 284) Reader's Digest Lifetime
284) link=https://www.filmon.com/tv/readers-digest-lifetime
     chan_name="Reader's Digest Lifetime" ;;
# 285) Home and Green Living
285) link=https://www.filmon.com/tv/home-and-green-living
     chan_name="Home and Green Living" ;;
# 286) Safe TV
286) link=https://www.filmon.com/tv/safe-tvr
     chan_name="Safe TV" ;;
# 287) Bid America
287) link=https://www.filmon.com/tv/bid-america
     chan_name="Bid America" ;;
# 288) MegaMe TV
288) link=https://www.filmon.com/tv/megame-tv
     chan_name="MegaMe TV" ;;
# 289) Wonderful Living
289) link=https://www.filmon.com/tv/wonderful-living-tv
     chan_name="Wonderful Living" ;;
# 290) Simply Me
290) link=https://www.filmon.com/tv/simply-me
     chan_name="Simply Me" ;;
# 291) The Walk
291) link=https://www.filmon.com/tv/the-walk-tv
     chan_name="The Walk" ;;
# 292) Time TV
292) link=https://www.filmon.com/tv/time-tv
     chan_name="Time TV" ;;
# 293) DRTV
293) link=https://www.filmon.com/tv/drtv
     chan_name="DRTV" ;;
# 294) Medical News
294) link=https://www.filmon.com/tv/medical-news-minute
     chan_name="Medical News" ;;
# 295) Supreme Master
295) link=https://www.filmon.com/tv/supreme-master-tv
     chan_name="Supreme Master" ;;
     
######################## FILMON EXCLUSIVE ###############################     
# 296) FOTV USA
296) link=https://www.filmon.com/tv/fotv-usa
     chan_name="FOTV USA" ;;
# 297) FOTV Workout
297) link=https://www.filmon.com/tv/360-fotv-workout
     chan_name="FOTV Workout" ;;
# 298) FilmOn Sports
298) link=https://www.filmon.com/tv/filmon-sports
     chan_name="FilmOn Sports" ;;
# 299) 360 Experimental
299) link=https://www.filmon.com/tv/360-experimental
     chan_name="360 Experimental" ;;
# 300) BH Cam 360
300) link=https://www.filmon.com/tv/bh-360-cam-2
     chan_name="BH Cam 360" ;;
# 301) R&B Live 
301) link=https://www.filmon.com/tv/rnb-live-afterparty
     chan_name="R&B Live" ;;
# 302) Cast Out of Paradise
302) link=https://www.filmon.com/tv/castoutofparadise-tv
     chan_name="Cast Out of Paradise" ;;
# 303) ROC Summer Explossion
303) link=https://www.filmon.com/tv/roc-summer-explosion
     chan_name="ROC Summer Explosion" ;;
# 304) FilmON Studio
304) link=https://www.filmon.com/tv/filmon-studio
     chan_name="FilmON Studio" ;;
# 305) TV Gold
305) link=https://www.filmon.com/tv/tv-gold
     chan_name="TV Gold" ;;
# 306) Battle Rap
306) link=https://www.filmon.com/tv/battle-rap
     chan_name="Battle Rap" ;;
# 307) Tribe TV
307) link=https://www.filmon.com/tv/tribe-tv
     chan_name="Tribe TV" ;;
# 308) FilmOn Reality
308) link=https://www.filmon.com/tv/filmon-reality
     chan_name="FilmOn Reality" ;;
# 309) FilmOn Red Carpet 
309) link=https://www.filmon.com/tv/filmon-red-carpet
     chan_name="FilmOn Red Carpet" ;;
# 310) Christmas Channel
310) link=https://www.filmon.com/tv/the-christmas-channel-by-zuzu-project
     chan_name="Christmas Channel" ;;
# 311) Nub TV
311) link=https://www.filmon.com/tv/nub-tv
     chan_name="Nub TV" ;;
# 312) Chai Life TV
312) link=https://www.filmon.com/tv/livefromthecenteroftheuniverse
     chan_name="Chai Life TV" ;;
# 313) Joe Nation
313) link=https://www.filmon.com/tv/joe-nation
     chan_name="Joe Nation" ;;
# 314) OC Real Estate
314) link=https://www.filmon.com/tv/oc-real-estate-tv
     chan_name="OC Real Estate" ;;
# 315) MHL TV
315) link=https://www.filmon.com/tv/mhl-tv
     chan_name="MHL TV" ;;
################################## FASHION ##########################
# 316) RUNWAY TV
316) link=https://www.filmon.com/tv/runway-tv
     chan_name="RUNWAY TV" ;;
# 317) TEOS
317) link=https://www.filmon.com/tv/teos-tv
     chan_name="TEOS" ;;
# 318) TV ART LIVE
318) link=https://www.filmon.com/tv/tv-art-live
     chan_name="TV Art Live" ;;
# 319) Runway TV 2016
319) link=https://www.filmon.com/tv/runway-tv-2016
     chan_name="Runway TV" ;;
# 320) Chic
320) link=https://www.filmon.com/tv/chic
     chan_name="Chic" ;;
########################## SCIENCE and TECH ###################################
# 321) NASA TV
321) link=https://www.filmon.com/tv/nasa-hd
     chan_name="NASA TV" ;;
####################### FRENCH TV ########################################

# 322) ARTE Francais
322) link=https://www.filmon.com/tv/arte-francais
     chan_name="ARTE Francais" ;;
# 323) France 0
323) link=https://www.filmon.com/tv/france-0
     chan_name="France 0" ;;
# 324) France 3 Rhone Alpes
324) link=https://www.filmon.com/tv/france-3-rhone-alpes
     chan_name="France 3 Rhone Alps" ;;
# 325) France 3 Alpes
325) link=https://www.filmon.com/tv/france-3-alpes
     chan_name="France 3 Alpes" ;;
# 326) RTS UN
326) link=https://www.filmon.com/tv/rts-un
     chan_name="RTS UN" ;;
# 327) RTS Deux
327) link=https://www.filmon.com/tv/rts-deux
     chan_name="RTS Deux" ;;
#  328) BFM Business
328) link=https://www.filmon.com/tv/bfm-business
     chan_name="BFM Business" ;;
# 329) BFM TV
329) link=https://www.filmon.com/tv/bfm-tv
     chan_name="BFM TV" ;;
# 330) FRANCE 2
330) link=https://www.filmon.com/tv/france-2
     chan_name="France 2" ;;
################################ GERMAN TV  #####################################
# 331) HSE 2 
331) link=https://www.filmon.com/tv/hse24-hd
     chan_name="HSE 2" ;;
# 332) HSE 2 Extra
332) link=https://www.filmon.com/tv/hse24-extra
     chan_name="HSE 2 Extra" ;;
# 333) Kika
333) link=https://www.filmon.com/tv/kika
     chan_name="KIKA" ;;
# 334) ZDF Infokanal
334) link=https://www.filmon.com/tv/zdf-infokanal
     chan_name="ZDF Infokanal" ;;
########################## RUSSIAN TV ######################################
# 335) RTR Planeta
335) link=https://www.filmon.com/tv/rtr-planeta
     chan_name="RTR Planeta" ;;
# 336) Current Time TV
336) link=https://www.filmon.com/tv/current-time-tv
     chan_name="Current Time TV" ;;
# 337) RT Documentary
337) link=https://www.filmon.com/tv/rt-documentary
     chan_name="RT Documentary" ;;
# 338) Perviy Kanal Europa
338) link=https://www.filmon.com/tv/perviy-kanal-europa
     chan_name="Perviy Kanal Europa" ;;
# 339) Music Box Russia
339) link=https://www.filmon.com/tv/music-box-russia
     chan_name="Music Box Russia" ;;
# 340) Rossiya 24
340) link=https://www.filmon.com/tv/rossiya-24
     chan_name="Rossiya 24" ;;
########################### INDIA TV  ##########################################
# 341) Films of India
341) link=https://www.filmon.com/tv/original-films-of-india
     chan_name="Films of India" ;;
# 342) Live 9 TV
342) link=https://www.filmon.com/tv/live9-tv
     chan_name="Live 9 TV" ;;
# 343) Delhi Aaj Tak
343) link=https://www.filmon.com/tv/delhi-aaj-tak
     chan_name="Delhi Aaj Tak" ;;
# 344) Aaj Tak
344) link=https://www.filmon.com/tv/aaj-tak
     chan_name="Aaj Tak" ;;
# 345) Tez TV
345) link=https://www.filmon.com/tv/tez-tv
     chan_name="Tez TV" ;;
# 346) ABP News
346) link=https://www.filmon.com/tv/abp-news
     chan_name="ABP News" ;;
     
######################## ITALIAN TV ############################################# 
# 347) Italia Channel
347) link=https://www.filmon.com/tv/canale-italia
     chan_name="Italia Channel" ;;
# 348) Camera dei Deputati
348) link=https://www.filmon.com/tv/camera-dei-deputati
     chan_name="Camera dei Deputati" ;;
# 349) QVC Italy
349) link=https://www.filmon.com/tv/qvc-italia
     chan_name="QVC Italy" ;;
####################### Middle East #############################
# 350) Rotana Aflam
350) link=https://www.filmon.com/tv/rotana-aflam
     chan_name="Rotana Aflam" ;;
# 351) DW Arabia
351) link=https://www.filmon.com/tv/dw-arabia
     chan_name="DW Arabia" ;;
# 352) Al Jazeera Documentary
352) link=https://www.filmon.com/tv/al-jazeera-documentary
     chan_name="Al Jazeera Documentary" ;;
# 353) Al Jazeera Mubasher
353) link=https://www.filmon.com/tv/al-jazeera-mubasher
     chan_name="Al Jazeera Mubasher" ;;
# 354) Al Jazeera Arabic
354) link=https://www.filmon.com/tv/al-jazeera-arabic
     chan_name="Al Jazeera Arabic" ;;
# 355) Saudi TV 2
355) link=https://www.filmon.com/tv/saudi-arabian-tv-2
     chan_name="Saudi TV 2" ;;
# 356) Saudi TV Sports
357) link=https://www.filmon.com/tv/saudi-arabian-tv-sports
     chan_name="Saudi TV Sports" ;;
# 357) Suryoyo Satalite
357) link=https://www.filmon.com/tv/suryoyo-sat
     chan_name="Suryoyo Sat" ;;
# 358) Rotana
358) link=https://www.filmon.com/tv/rotana
     chan_name="Rotana" ;;
# 359) Rotana Clip
359) link=https://www.filmon.com/tv/rotana-clip
     chan_name="Rotana Clip" ;;
# 360) Rotana Khalijah
360) link=https://www.filmon.com/tv/rotana-khalijiah
     chan_name="Rotana Khalijah" ;;
# 361) Rotana Classic
361) link=https://www.filmon.com/tv/rotana-classic
     chan_name="Rotana classic" ;;
# 362) Rotana Masriya
362) link=https://www.filmon.com/tv/rotana-masriya
     chan_name="Rotana Masriya" ;;
# 363) Rotana Cinema
363) link=https://www.filmon.com/tv/rotana-cinema
     chan_name="Rotana Cinema" ;;
# 364) Saudi TV 1
364) link=https://www.filmon.com/tv/saudi-arabian-tv-1
     chan_name="Saudi TV 1" ;;
# 365) Noor Dubai
365) link=https://www.filmon.com/tv/noor-dubai
     chan_name="Noor Dubai" ;;
# 366) iFilm
366) link=https://www.filmon.com/tv/ifilm
     chan_name="iFilm" ;;
# 367) Dubai Sports
367) link=https://www.filmon.com/tv/dubai-sports
     chan_name="Dubai Sports" ;;
########################## SWISS TV  ############################################       
# 368) SRF 1
368) link=https://www.filmon.com/tv/srf-1
     chan_name="SRF 1" ;;
# 369) RSI LA 1
369) link=https://www.filmon.com/tv/rsi-la-1
     chan_name="RSI LA 1" ;;
# 370) Raido Chico
370) link=https://www.filmon.com/tv/radio-chico
     chan_name="Radio Chico" ;;
########################### LATINO  #############################################3
# 371) Peliculas FilmON
371) link=https://www.filmon.com/tv/peliculas-de-filmon
     chan_name="Peliculas FilmON" ;;
# 372) Catwalk Espanol
372) link=https://www.filmon.com/tv/catwalk-en-espanol
     chan_name="Catwalk Espanol" ;;
# 373) Animacion de FilmOn
373) link=https://www.filmon.com/tv/animacion-de-filmon
     chan_name="Animacion de FilmOn" ;;
# 374) Planet Fashion
374) link=https://www.filmon.com/tv/planet-fashion-en-espanol
     chan_name="Planet Fashion" ;;
# 375) HispanTV
375) link=https://www.filmon.com/tv/hispan-tv
     chan_name="HispanTV" ;;
# 376) Telenovelas
376) link=https://www.filmon.com/tv/telenovelas-tv
     chan_name="Telenovelas" ;;
# 377) RT Espanol
377) link=https://www.filmon.com/tv/rt-espanol
     chan_name="RT Espanol" ;;
# 378) DW Latino America
378) link=https://www.filmon.com/tv/dw-latinoamerica
     chan_name="DW Latino America" ;;
# 379) Televideo Latino
379) link=https://www.filmon.com/tv/televideo-latino
     chan_name="Televido Latino" ;;
############################# CLASSIC TV  ####################################
# 380) The Lucy Show
380) link=https://www.filmon.com/tv/the-lucy-show
     chan_name="The Lucy Show" ;;
# 381) Date With the Angels TV
381) link=https://www.filmon.com/tv/date-with-angels-tv
     chan_name="Date with the Angels" ;;
# 382) Man with a Camera
382) link=https://www.filmon.com/tv/man-with-a-camera-tv
     chan_name="Man with a Camera" ;;
# 383) Colgate Comedy Hour
383) link=https://www.filmon.com/tv/the-colgate-comedy-hour
     chan_name="Colgate Comedy Hour" ;;
# 384) Catwalk
384) link=https://www.filmon.com/tv/catwalk
     chan_name="Catwalk" ;;
# 385) Life of Riley
385) link=https://www.filmon.com/tv/the-life-of-riley-tv
     chan_name="Life of Riley" ;;
# 386) Strange Paradise
386) link=https://www.filmon.com/tv/strange-paradise
     chan_name="Strange Paradise" ;;
# 387) Red Skeleton
387) link=https://www.filmon.com/tv/the-red-skelton-show-tv
     chan_name="Red Skeleton" ;;
# 388) Dragnet
388) link=https://www.filmon.com/tv/dragnet-tv
     chan_name="Dragnet" ;;
# 389) Private Secretary
389) link=https://www.filmon.com/tv/private-secretary-tv
     chan_name="Private Secretary" ;;
# 390) Suspense TV
390) link=https://www.filmon.com/tv/suspense-tv
     chan_name="Suspense TV" ;;
# 391) Timeless Westerns
391) link=https://www.filmon.com/tv/timeless-westerns
     chan_name="Timeless Westerns" ;;
# 392) You bet your Life
392) link=https://www.filmon.com/tv/you-bet-your-life-tv
     chan_name="You Bet Your Life" ;;
# 393) Flash Gordon
393) link=https://www.filmon.com/tv/flash-gordon
     chan_name="Flash Gordon" ;;
# 394) Betty Boop
394) link=https://www.filmon.com/tv/betty-boop-tv
     chan_name="Betty Boop" ;;
# 395) Fury TV
395) link=https://www.filmon.com/tv/fury-tv
     chan_name="Fury TV" ;;
# 396) Cisco Kid
396) link=https://www.filmon.com/tv/cisco-kid-tv
     chan_name="Cisco Kid" ;;
# 397) Bonanza
397) link=https://www.filmon.com/tv/filmon-binge-bonanza
     chan_name="Bonanza" ;;
# 398) Ozzie and Harriet
398) link=https://www.filmon.com/tv/filmon-binge-ozzie-harriet
     chan_name="Ozzie and Harriet" ;;
# 399) One Step Beyond
399) link=https://www.filmon.com/tv/filmon-binge-one-step-beyond
     chan_name="One Step Beyond" ;;
# 400) Charlie Chaplin
400) link=https://www.filmon.com/tv/filmon-binge-charlie-chaplin
     chan_name="Charlie Chaplin" ;;
# 401) The Beverly Hillbillies
401) link=https://www.filmon.com/tv/filmon-binge-the-beverly-hillbillies
     chan_name="The Beverly Hillbilies" ;;
# 402) Robin Hood
402) link=https://www.filmon.com/tv/filmon-binge-adventures-of-robin-hood
     chan_name="Robin Hood" ;;
# 403) Timeless TV
403) link=https://www.filmon.com/tv/timeless-television
     chan_name="Timeless TV" ;;
# 404) Spud's Crime and Punishment
404) link=https://www.filmon.com/tv/spuds-crime-and-punishment-channel
     chan_name="Spud's Crime and Punishment" ;;
# 405) The Dick Van Dyke Show
405) link=https://www.filmon.com/tv/the-dick-van-dyke-show
     chan_name="The Dick Van Dyke Show" ;;
####################### SHORT FILMS ####################################
# 406) Funny Shorts
406) link=https://www.filmon.com/tv/funny-shorts
     chan_name="Funny Shorts" ;;
# 407) Movies
407) link=https://www.filmon.com/tv/movies
     chan_name="Movies" ;;
# 408) Dancing Shorts
408) link=https://www.filmon.com/tv/dancing-shorts
     chan_name="Dancing Shorts" ;;
# 409) Reality Shorts
409) link=https://www.filmon.com/tv/reality-shorts
     chan_name="Reality Shorts" ;;
# 410) Acid TV
410) link=https://www.filmon.com/tv/acid-tv
     chan_name="Acid TV" ;;
# 411) Horror TV
411) link=https://www.filmon.com/tv/horror-tv
     chan_name="Horror TV" ;;
# 412) Music Videos
412) link=https://www.filmon.com/tv/music-videos
     chan_name="Music Videos" ;;
# 413) Sci Fi
413) link=https://www.filmon.com/tv/sci-fi
     chan_name="Sci Fi" ;;
# 414) Micro Shorts
414) link=https://www.filmon.com/tv/micro-shorts
     chan_name="Micro Shorts" ;;
# 415) Sproklets and Splices
415) link=https://www.filmon.com/tv/sprockets-and-splices-tv
     chan_name="Sprokets and Splices" ;;
# 416) Teen Shorts
416) link=https://www.filmon.com/tv/teen-shorts
     chan_name="Teen Shorts" ;;
# 417) Drama Shorts
417) link=https://www.filmon.com/tv/drama-shorts
     chan_name="Drama Shorts" ;;
# 418) Digital Animation
418) link=https://www.filmon.com/tv/digital-animation
     chan_name="Digital Animation" ;;
# 419) Documentary
419) link=https://www.filmon.com/tv/documentary
     chan_name="Documentary" ;;
     
######################## OUTDOORS   ########################################33
# 420) Bayou Country
420) link=https://www.filmon.com/tv/bayou-country-outdoors
     chan_name="Bayou Country" ;;
# 421) Student of the Gun
421) link=https://www.filmon.com/tv/student-of-the-gun
     chan_name="Student of the Gun" ;;
# 422) Ultimate Outdoors
422) link=https://www.filmon.com/tv/ultimate-outdoors
     chan_name="Ultimater Outdoors" ;;
# 423) Hunt Channel
423) link=https://www.filmon.com/tv/hunt-channel
     chan_name="Hunt Channel" ;;
# 424) Thouroughbred World Show
424) link=https://www.filmon.com/tv/thoroughbred-show
     chan_name="Thouroughbred World Show" ;;
# 425) Wilderness Channel
425) link=https://www.filmon.com/tv/wilderness-channel
     chan_name="Wilderness Channel" ;;
# 426) Pursuit
426) link=https://www.filmon.com/tv/pursuit-channel
     chan_name="Pursuit" ;;
##################### TRAVEL ###########################
# 427) HWC
427) link=https://www.filmon.com/tv/hwc-network
     chan_name="HWC" ;;
# 428) 
428) link=https://www.filmon.com/tv/the-jet-set-channel
     chan_name="" ;;
# 429) 
429) link=https://www.filmon.com/tv/discover-malta
     chan_name="" ;;
# 430) 
430) link=https://www.filmon.com/tv/mega-destinations
     chan_name="" ;;
# 431) 
431) link=https://www.filmon.com/tv/30a-tv
     chan_name="" ;;
# 432) 
432) link=https://www.filmon.com/tv/obxtv
     chan_name="" ;;
# 433) 
433) link=https://www.filmon.com/tv/travel-channel1
     chan_name="" ;;
# 434) 
434) link=https://www.filmon.com/tv/landmarks
     chan_name="" ;;
# 435) 
435) link=https://www.filmon.com/tv/infamous-places
     chan_name="" ;;  
############################ SOMALI TV ####################################     
# 436) 
436) link=https://www.filmon.com/tv/snltv-somaliland-national-tv
     chan_name="" ;;
# 437) 
437) link=https://www.filmon.com/tv/universaltv-somali-television
     chan_name="" ;;
# 438) 
438) link=https://www.filmon.com/tv/somali-national-tv
     chan_name="" ;;
# 439) 
439) link=https://www.filmon.com/tv/horn-cable-tv
     chan_name="" ;;
# 440) 
440) link=https://www.filmon.com/tv/estv-somali-ethiopia-tv
     chan_name="" ;;
# 441) 
441) link=https://www.filmon.com/tv/kalsan-tv-somali
     chan_name="" ;;
######################## GREEK ###############################################
# 442) 
442) link=https://www.filmon.com/tv/rik
     chan_name="" ;;
############################# RELIGION

# 443)
443) link=https://www.filmon.com/tv/hispanic-american-faith-tv
     chan_name="" ;;
# 444) 
444) link=https://www.filmon.com/tv/you-shall-live
     chan_name="" ;;
# 445) 
445) link=https://www.filmon.com/tv/preach-the-word
     chan_name="" ;;
# 446) 
446) link=https://www.filmon.com/tv/audio-scripture-channel
     chan_name="" ;;
# 447) 
447) link=https://www.filmon.com/tv/cyber-church-tv
     chan_name="" ;;
# 448) 
448) link=https://www.filmon.com/tv/faith-cinema
     chan_name="" ;;
# 449) 
449) link=https://www.filmon.com/tv/nrb
     chan_name="" ;;
# 450) 
450) link=https://www.filmon.com/tv/glory-tv
     chan_name="" ;;
# 451) 
451) link=https://www.filmon.com/tv/dunamis-radio-tv
     chan_name="" ;;
# 452) 
452) link=https://www.filmon.com/tv/global-music-tv
     chan_name="" ;;
# 453) 
453) link=https://www.filmon.com/tv/the-church-channel
     chan_name="" ;;
# 454) 
454) link=https://www.filmon.com/tv/tbn
     chan_name="" ;;
# 455) 
455) link=https://www.filmon.com/tv/daystar
     chan_name="" ;;
# 456) 
456) link=https://www.filmon.com/tv/catholic-tv
     chan_name="" ;;
################################ CELEBRITY TV 
# 457) 
457) link=https://www.filmon.com/tv/scenestertv
     chan_name="" ;;
# 458) 
458) link=https://www.filmon.com/tv/celebrity-action-network
     chan_name="" ;;
# 459) 
459) link=https://www.filmon.com/tv/dame-dash-tv
     chan_name="" ;;
# 460) 
460) link=https://www.filmon.com/tv/nik-richie-network
     chan_name="" ;;
# 461) 
461) link=https://www.filmon.com/tv/celebrity-icons-tv
     chan_name="" ;;
# 462) 
462) link=https://www.filmon.com/tv/andy-dick
     chan_name="" ;;
# 463) 
463) link=https://www.filmon.com/tv/janice-tv
     chan_name="" ;;
# 464) 
464) link=https://www.filmon.com/tv/kato
     chan_name="" ;;
# 465) 
465) link=https://www.filmon.com/tv/ppv-celebrity-fight
     chan_name="" ;;
# 466) 
466) link=https://www.filmon.com/tv/vertrolive
     chan_name="" ;;
# 467) 
467) link=https://www.filmon.com/tv/starshop
     chan_name="" ;;  
############################# FOOD #########################################
# 468) 
468) link=https://www.filmon.com/tv/wineram
     chan_name="" ;;
# 469) 
469) link=https://www.filmon.com/tv/world-of-wine
     chan_name="" ;;
# 470) 
470) link=https://www.filmon.com/tv/the-chef-roc-tv-show
     chan_name="" ;;
# 471) 
471) link=https://www.filmon.com/tv/food-network-plus-1
     chan_name="" ;;
# 472) 
472) link=https://www.filmon.com/tv/world-food-championships
     chan_name="" ;;
# 473) 
473) link=https://www.filmon.com/tv/dude-food
     chan_name="" ;;
# 474) 
474) link=https://www.filmon.com/tv/food-network
     chan_name="" ;;
# 475) 
475) link=https://www.filmon.com/tv/ifood-tv
     chan_name="" ;;
# 476) 
476) link=https://www.filmon.com/tv/indian-recipes
     chan_name="" ;;
# 477) 
477) link=https://www.filmon.com/tv/wine-oh-tv
     chan_name="" ;;
# 478) 
478) link=https://www.filmon.com/tv/gastrolab
     chan_name="" ;;
# 479) 
479) link=https://www.filmon.com/tv/outdoor-cooking-channel
     chan_name="" ;;
# 480) 
480) link=https://www.filmon.com/tv/wine-channel-tv
     chan_name="" ;;
# 481) 
481) link=https://www.filmon.com/tv/eco-rico
     chan_name="" ;;
# 482) 
482) link=https://www.filmon.com/tv/veg-tv
     chan_name="" ;;
     
############################## CARS AUTO
#  483) 
483) link=https://www.filmon.com/tv/auto-channel
     chan_name="" ;;
# 484) 
484) link=https://www.filmon.com/tv/raceline-tv
     chan_name="" ;;
# 485) 
485) link=https://www.filmon.com/tv/race-central-tv
     chan_name="" ;;
# 486) 
486) link=https://www.filmon.com/tv/honda-hpd
     chan_name="" ;;
# 487) 
487) link=https://www.filmon.com/tv/torque-and-tush
     chan_name="" ;;
# 488) 
488) link=https://www.filmon.com/tv/motorz
     chan_name="" ;;
# 489) 
489) link=https://www.filmon.com/tv/steel-dreams
     chan_name="" ;;
# 490) 
490) link=https://www.filmon.com/tv/distant-roads
     chan_name="" ;;
############################# EDUCATION
# 491) 
491) link=https://www.filmon.com/tv/the-florida-channel
     chan_name="" ;;
# 492) 
492) link=https://www.filmon.com/tv/make-your-move
     chan_name="" ;;
# 493) 
493) link=https://www.filmon.com/tv/smarts-tv
     chan_name="" ;;
# 494) 
494) link=https://www.filmon.com/tv/parenting-international-tv
     chan_name="" ;;
########################## SHOPPING
# 495) 
495) link=https://www.filmon.com/tv/jewelry-tv
     chan_name="" ;;
# 496) 
496) link=https://www.filmon.com/tv/qvc-hd
     chan_name="" ;;
# 497) 
497) link=https://www.filmon.com/tv/shop-n-give
     chan_name="" ;;
# 498) 
498) link=https://www.filmon.com/tv/deals-tv
     chan_name="" ;;
# 499) 
499) link=https://www.filmon.com/tv/beauty-iq
     chan_name="" ;;
# 500) 
500) link=https://www.filmon.com/tv/qvc
     chan_name="" ;;
# 501) 
501) link=https://www.filmon.com/tv/americas-auction-network
     chan_name="" ;;
# 502) 
502) link=https://www.filmon.com/tv/caribbean-shopping-channel
     chan_name="" ;;
# 503) 
503) link=https://www.filmon.com/tv/product-showcase-network
     chan_name="" ;;
############################### CARIBBEAN
# 504) 
504) link=https://www.filmon.com/tv/calabash-tv
     chan_name="" ;;
# 505) 
505) link=https://www.filmon.com/tv/caribbean-lifestyle-channel
     chan_name="" ;;
# 506) 
506) link=https://www.filmon.com/tv/scruffy-tv
     chan_name="" ;;
############################### ASIAN
# 507) 
507) link=https://www.filmon.com/tv/arirang-tv
     chan_name="" ;;
# 508) 
508) link=https://www.filmon.com/tv/vtc-10
     chan_name="" ;;
# 509) 
509) link=https://www.filmon.com/tv/voa-weishi
     chan_name="" ;;
################################ AFRICAN
# 510) 
510) link=https://www.filmon.com/tv/eri-tv
     chan_name="" ;;
# 511) Nollywood
511) link=https://www.filmon.com/tv/nollywood
     chan_name="Nollywood" ;;
# 512) Igboro TV
512) link=https://www.filmon.com/tv/igboro-tv
     chan_name="I Goboro TV" ;;
######################### KAZAKH
# 513) KAZAKH
513) link=https://www.filmon.com/tv/kazakh-tv
     chan_name="Kazakh TV" ;;
####################### RADIO   ##########################################     
# 514) The Marko Polka Show
514) link=https://www.filmon.com/tv/the-marko-polka-show
     chan_name="The Marko Polka Show" ;;
# 515) V104 Live
515) link=https://www.filmon.com/tv/v104-live
     chan_name="V104 Live" ;;
# 516) Daytona's Surf
516) link=https://www.filmon.com/tv/daytonas-surf
     chan_name="Daytona's Surf" ;;
# 517) Classic Oldies Jukebox
517) link=https://www.filmon.com/tv/classic-oldies-jukebox-hd-internet-radio
     chan_name="Classic Oldies Jukebox" ;;
# 518) Radio 337 The Cajun
518) link=https://www.filmon.com/tv/radio337-the-cajun
     chan_name="Radio 337 The Cajun" ;;
# 519) J and J FM
519) link=https://www.filmon.com/tv/j-and-j-fm
     chan_name="J and J FM" ;;
# 520) U Matter 2 Radio
520) link=https://www.filmon.com/tv/u-matter-2-radio
     chan_name="U Matter 2 Radio" ;;
# 521) WXEA 94.7
521) link=https://www.filmon.com/tv/wxea-947-1071
     chan_name="WXEA 94.7" ;;
# 522) The Wise Choice
522) link=https://www.filmon.com/tv/the-wise-choice
     chan_name="The Wise Choice" ;;
# 523) FONYE Dance
523) link=https://www.filmon.com/tv/fonye-dance
     chan_name="FONYE Dance" ;;
# 524) Key 56 Internet Radio
524) link=https://www.filmon.com/tv/key56-internet-radio
     chan_name="Key 56 Internet Radio" ;;
# 525) A-1 Bluegrass Favorites
525) link=https://www.filmon.com/tv/a-1-bluegrass-favorites
     chan_name="A-1 Bluegrass Favorites" ;;
# 526) WZQR Talks
526) link=https://www.filmon.com/tv/wzqr-talks
     chan_name="WZQR Talks" ;;
esac
}

channel_select $num


echo "$chan_name"
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --cookies --cookies-file "$cookie" "$link" 



entry="null"

channel_matrix
echo "You were watching "$chan_name" on Channel "$num" "
echo "Please Select a Number corresponding to a YouTube Live Stream:"
echo "Select a new stream number or press q to quit."

read entry 

if [ "$entry" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
elif [ "$entry" == "n" ]
then
channel_matrix_2
echo "You were watching "$chan_name" on Channel "$num" "
echo "Please Select a Number corresponding to a YouTube Live Stream:"
echo "Select a new stream number, or press q to quit."
read entry 
    if [ "$entry" == "q" ]
    then 
    echo "Type endstream to open a new stream."
    exit "$?" 
    else
    channel_select $entry
    echo "$chan_name"
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --cookies --cookies-file "$cookie" "$link" 
    fi
else 


channel_select $entry
echo "$chan_name"
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --cookies --cookies-file "$cookie" "$link" 

# echo "You were watching "$chan_name" on Channel "$entry" "

while [ "$entry" != "q" ]
do

  channel_matrix
  echo "You were watching "$chan_name" on Channel "$entry" "
  echo "Please Select a Number corresponding to a YouTube Live Stream, press n for the next menu, or press q to quit:"

  read entry 

  if [ "$entry" == "q" ]
  then 
  echo "Type endstream to open a new stream."
  exit "$?"
  elif [ "$entry" == "n" ]
  then
  channel_matrix_2
  echo "You were watching "$chan_name" on Channel "$num" "
  echo "Please Select a Number corresponding to a YouTube Live Stream:"
  echo "Select a new stream number, or press q to quit."
  read entry
  
    if [ "$entry" == "q" ]
    then 
    echo "Type endstream to open a new stream."
    exit "$?"if 
    else
    channel_select $entry
    echo "$chan_name"
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --cookies --cookies-file "$cookie" "$link" 
    fi
  else
  channel_select $entry
  echo "$chan_name"
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --cookies --cookies-file "$cookie" "$link" 
 
  fi

done

fi


echo "Type endstream to open a new stream."


exit "$?"

######################     END OF PROGRAM      ####################################################