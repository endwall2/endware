#!/bin/sh
################################################################################################
# TITLE: renum.sh
# TYPE: Bourne Shell Script
# DESCRIPTION: Renames files in a directory by number and extention from 000000-999999 sequentially 
# AUTHOR: THE ENDWARE DEVELOPMENT TEAM
# CREATION DATE: JUL 17, 2016
# VERSION: 0.05
# REVISION DATE: JUL 20, 2016
# COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016
#
# CHANGE LOG: - Fixed a bug with for loop read in blank spaces as 1 line 
#             - Added switch -r for random sort ordering, regular ordering is default 
#             - Standardized .jpg extention
#             - Changed hash to sha256
#             - Changed from mv to cp -n into directory renum ( fixes major bug ) 
#             - Zipp the backup + sha512sum for each file into sha512.txt 
#             - Renamed the script to renum.sh 
#             - Added tar backup and append   
#             - Added Instructions and EULA
#
#################################################################################################
#  DEPENDENCIES:  sort, cut, expr, mv , tar, gzip, sha256sum
#################################################################################################
#                      INSTRUCTIONS:   
#################################################################################################
# $ torsocks wget http://ix.io/15Hq
# $ mkdir ~/bin
# $ cp 15Hq ~/bin/renum
# $ export PATH=$PATH:~/bin/
# $ cd ~/bin
# $ chmod u+x renum
#
#  Renum for name sequential sort order
# $ cd ~/pictures/
# $ renum
# Renum random sort ordering
# $ renum -r
#
##################################################################################################
#############################################################################################################################################################################
#                                         ACKNOWLEDGEMENTS
#############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, and SnakeDude who graciously hosted and promoted this software project.  
#  Without their efforts and their wonderful website www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, and to SnakeDude for inspiring this work and for hosting and promoting it. 
#  
#  The Endware Suite including Endwall,Endsets,Endlists,Endtools,Endloads and Endtube are named in honor of Endchan.
#
#  The Endware Suite is available for download at the following locations:
#  https://gitgud.io/Endwall/ , https://github.com/endwall2/, https://www.endchan.xyz/os/, http://42xlyaqlurifvvtq.onion,
#
#  Thank you also to early beta testers including a@a, and to other contributors 
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
#                               LICENSE AGREEMENT  
##############################################################################################################################################################################
#  BEGINNING OF LICENSE AGREMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.10 
#  VERSION DATE: JULY 7, 2016
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, posses, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, public official, sovereign, monarch, head of state,
#        dignitary, ambassdor, noble, commoner, clergy, layity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any gender, including men, women, and any other gender not mentioned.       
#  1) e) This program may be used by anyone of any afiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any person of any race, ethnicity, identity, origin, genetic makeup, physical apperance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, subsea, in a submarine, underground,
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
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGEMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or saleable goods.
#  6) a) Any user of this program is granted the freedom to modify and improve the code.
#  6) b) When modified or improved, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or saleable goods.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procur a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procur a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intelectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#      b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  WHO GRANTS THESE FREEDOMS ?
#  10) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team", as well as ancillary contributors, and user modifiers and developers of the software. 
#  11) The aformentioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  12)  This software is distributed without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  13)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution or renumeration for any such loss real or imagined.
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADITIONAL NOTES:
#  14)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  15)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) h) are presented to clarify 1 a) and to enforce non-discrimination and non-exlusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################

#################### BEGINNING OF PROGRAM ###########################

# archive all the files in the directory
tar -rvf backup.tar *
mkdir -p renum

# switch -r for random file sequential renumbering
if [ "$1" == "-r" ] ;
then
# randomly sort a list of the directory files into a temp file
ls  | sort -R > filelist.txt
else
# regular listing in the same name sequential order
ls  > filelist.txt
fi 

# Add the file list to the tar backup
tar -rvf backup.tar filelist.txt 

# initialize index
index=0
IFS=$'\n' 
# main loop
for file in $(cat filelist.txt); do

# get the root and extention of the file
rt=$( echo "$file" | cut -d . -f 1)
ext=$( echo "$file" |cut -d . -f 2 ) 
end=$( echo "$file" | cut -d - -f 2 )

#case for no extention
case $end in 
( imagejpeg ) ext="jpg" ;;
( imagepng  ) ext="png" ;;
( imagegif  ) ext="gif" ;;
( imagetiff ) ext="tif" ;;
esac

# standardize extentions 
if [ "$ext" == "jpeg" ]
 then 
 ext=jpg
elif [ "$ext" == "JPEG" ]
 then 
 ext=jpg
elif [ "$ext" == "JPG" ]
 then 
 ext=jpg
elif [ "$ext" == "GIF" ]
 then 
 ext=gif
elif [ "$ext" == "TIFF" ]
 then 
 ext=tif
elif [ "$ext" == "BMP" ]
 then 
 ext=bmp
elif [ "$ext" == "PNG" ]
 then 
 ext=png
fi

# Relabel index to 6 digit number
if [ "$index" -lt 10 ]
 then
 filenum=00000"$index"
elif [ "$index" -lt 100 ]
 then 
 filenum=0000"$index"
elif [ "$index" -lt 1000 ]
 then 
 filenum=000"$index"
elif [ "$index" -lt 10000 ]
 then 
 filenum=00"$index"
elif [ "$index" -lt 100000 ]
 then 
 filenum=0"$index"
elif [ "$index" -ge 100000 ]
 then
 filenum="$index"
fi

# rename the file by file number if not the list or the backup

if [ "$file" == "filelist.txt"  ]
 then  
 echo "Skipping $file" 
elif [ "$file" == "concordance.txt"  ]
 then  
 echo "Skipping $file" 
elif [ "$file" == "backup.tar" ]
 then 
 echo "Skipping $file" 
elif [ "$file" == "sha256.txt" ]
 then
 echo "Skipping $file" 
elif [ "$file" == "md5.txt" ]
 then
 echo "Skipping $file" 
elif [ "$file" == "sha256_renum.txt" ]
 then
 echo "Skipping $file" 
elif [ "$file" == "md5_renum.txt" ]
 then
 echo "Skipping $file" 
elif [ "$file" == "renum" ]
 then
 echo "Skipping $file" 
else
  echo "Renaming file: "$file"  to "$filenum.$ext" "
  cp -n "$file" renum/"$filenum.$ext"
  sha256sum "$file" >> sha256.txt   
  md5sum "$file" >> md5.txt   
  sha256sum renum/"$filenum.$ext" >> renum/sha256_renum.txt
  md5sum renum/"$filenum.$ext" >> renum/md5_renum.txt
  echo ""$file" ->  "$filenum.$ext" " >> renum/concordance.txt   
  index=$(expr "$index" + 1) 
fi

done

# clean up
tar -rvf backup.tar sha256.txt md5.txt 
echo "Added to backup.tar" 
# compress the data / zip it
gzip backup.tar
## comment out to not remove these files  
rm filelist.txt
rm sha256.txt 
rm md5.txt

echo "Files backed up to backup.tar.gz"
echo "Please verify that there is no data loss"
echo "If any files have been lost, unpack the archive to restore"

################################# END OF PROGRAM  ##################################################
