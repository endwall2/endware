#!/bin/sh
################################################################################################
# TITLE: renum.sh
# TYPE: Bourne Shell Script
# DESCRIPTION: Renames files in a directory by number and extention from 000000-999999 sequentially 
# AUTHOR: THE ENDWARE DEVELOPMENT TEAM
# CREATION DATE: JUL 17, 2016
# VERSION: 0.10
# REVISION DATE: AUG 5, 2017
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
#  DEPENDENCIES:  sort, cut, expr, mv , tar, gzip, sha256sum ,md5sum, perl-image-exiftool
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
#################### BEGINNING OF PROGRAM ###########################

################### VERSION INFORMATION #################
version="0.11"
rev_date="11/08/2017"
branch="gnu/linux"
############################################
name_style="number"
sort_style="alpha"
check_type="no"

for arg in "$@"
do
 if [ "$arg" == "--help" ]
 then
   echo "RENUM: rename randomly named picture files to numbers or string filenames and backup original files"
   echo ""
   echo "USAGE:"
   echo "$ renum --help        # usage messages"
   echo "$ renum --version     # print version information"
   echo "$ renum --rand        # randomize files before rename"
   echo "$ renum --md5str      # use md5sum string for rename"
   echo "$ renum --sha256str   # use sha256sum string for rename"
   echo "$ renum --ranstr      # use random string for rename"
   echo "$ renum --check-type  # check the file type with exiftool to get extension"
   echo "$ renum               # default to numbers as filenames in alphabetic sort"
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "RENUM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" == --rand ]
   then
   sort_style="rand" 
   shift
   elif [ "$arg" == --md5str ]
   then
   name_style="md5str"
   shift
   elif [ "$arg" == --sha256str ]
   then
   name_style="sha256str"
   shift
   elif [ "$arg" == --ranstr ]
   then
   name_style="ranstr"
   shift
   elif [ "$arg" == --check-type ]
   then
   check_type="yes"
   shift
 fi  
done 

## Backup all files first
echo "Backing up all files in the current working directory to backup.tar"
tar -cvf backup.tar *

# switch -r for random file sequential renumbering
if [ "$sort_style" == "rand" ] ;
then
# randomly sort a list of the directory files into a temp file
ls | sort -R | sort -R | sort -R > filelist.txt
else
# regular listing in the same name sequential order
ls  > filelist.txt
fi 

# make a directory to store renamed files
mkdir -p renum

# initialize index
index=0
IFS=$'\n' 
# main loop
for file in $(cat filelist.txt)
do

if [ "$check_type" == "yes" ]
then
# Get the file type"
file_type=$( exiftool "$file" | grep "File Type" | head -n 1 | awk ' {print $4}' )
  if [ "$file_type" == "" ]
  then
  ext="unk"
  else
  ext="$file_type"
  fi
else
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
   ( imagesvg ) ext="svg" ;;
  esac

fi

# Standardize Extentions 
if [ "$ext" == "jpeg" ]
 then 
 ext=jpg
elif [ "$ext" == "JPEG" ]
 then 
 ext=jpg
elif [ "$ext" == "JPG" ]
 then 
 ext=jpg
elif [ "$ext" == "jpg" ]
 then 
 ext=jpg
elif [ "$ext" == "GIF" ]
 then 
 ext=gif
elif [ "$ext" == "gif" ]
 then 
 ext=gif 
elif [ "$ext" == "TIFF" ]
 then 
 ext=tif
elif [ "$ext" == "tiff" ]
 then 
 ext=tif 
elif [ "$ext" == "BMP" ]
 then 
 ext=bmp
elif [ "$ext" == "bmp" ]
 then 
 ext=bmp 
elif [ "$ext" == "PNG" ]
 then 
 ext=png
elif [ "$ext" == "png" ]
 then 
 ext=png
elif [ "$ext" == "SVG" ]
 then 
 ext=svg 
elif [ "$ext" == "svg" ]
 then 
 ext=svg  
else
 ext="$ext"
fi

if [ $name_style == "number" ]
then
 # Relabel index to an 8 digit number
  if [ "$index" -lt 10 ]
   then
   filenum=0000000"$index"
  elif [ "$index" -lt 100 ]
   then 
   filenum=000000"$index"
  elif [ "$index" -lt 1000 ]
   then 
   filenum=00000"$index"
  elif [ "$index" -lt 10000 ]
   then 
   filenum=0000"$index"
  elif [ "$index" -lt 100000 ]
   then 
   filenum=000"$index"
  elif [ "$index" -lt 1000000 ]
   then 
   filenum=00"$index"
  elif [ "$index" -lt 10000000 ]
   then 
   filenum=0"$index"
  elif [ "$index" -ge 10000000 ]
   then
   filenum="$index"
   fi
fi
# skip renaming the list or the backups or hash lists
if [ "$file" == "filelist.txt"  ]
 then  
 echo "Skipping $file" 
elif [ "$file" == "concordance.txt"  ]
 then  
 echo "Skipping $file" 
elif [ "$file" == "backup.tar" ]
 then 
 echo "Skipping $file" 
elif [ "$file" == "backup.tar.gz" ]
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
 if [ "$name_style" == "md5str" ] 
 then
  md5var=$( md5sum "$file" | awk '{print $1}' )
  sha256var=$(sha256sum "$file" | awk '{print $1}')
  filename=""
  while [ "$filename" == "" ]
  do
  filename="$( echo "$md5var" | base64 -i | tr -d "\n=+=\/" )"
  done
#  filename="$index$filename"
  echo "Renaming file: "$file"  to "$filename.$ext" "
  echo "$md5var" " $file" >> md5.txt 
  echo "$sha256var" " $file" >> sha256.txt
  cp -n "$file" renum/"$filename.$ext"       
  echo "$sha256var" " $filename.$ext" >> renum/sha256_renum.txt
  echo "$md5var" " $filename.$ext" >> renum/md5_renum.txt
  echo ""$file" ->  "$filename.$ext" " >> renum/concordance.txt
  index=$(expr "$index" + 1)    
 elif [ "$name_style" == "sha256str" ] 
 then
  md5var=$( md5sum "$file" | awk '{print $1}' )
  sha256var=$( sha256sum "$file" | awk '{print $1}')
  # make a random string for the name
  bytes=$( expr 18 + $RANDOM  % 48  )
  filename=""
  while [ "$filename" == "" ]
  do
  echo "$sha256var"
  filename="$( echo "$sha256var" | base64 -i | tr -d "\n=+=\/" )"
  done
#  filename="$index$filename"
  echo "Renaming file: "$file"  to "$filename.$ext" "
  echo "$md5var" " $file" >> md5.txt 
  echo "$sha256var" " $file" >> sha256.txt
  cp -n "$file" renum/"$filename.$ext"       
  echo "$sha256var" " $filename.$ext" >> renum/sha256_renum.txt
  echo "$md5var" " $filename.$ext" >> renum/md5_renum.txt
  echo ""$file" ->  "$filename.$ext" " >> renum/concordance.txt
  index=$(expr "$index" + 1)     
 elif [ "$name_style" == "ranstr" ] 
 then
  md5var=$( md5sum "$file" | awk '{print $1}' )
  sha256var=$(sha256sum "$file" | awk '{print $1}')
  # make a random string for the name
  bytes=$( expr 18 + $RANDOM  % 48  )
  filename=""
  while [ "$filename" == "" ]
  do
  filename="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')"
  done
#  filename="$index$filename"
  echo "Renaming file: "$file"  to "$filename.$ext" "
  echo "$md5var" " $file" >> md5.txt 
  echo "$sha256var" " $file" >> sha256.txt
  cp -n "$file" renum/"$filename.$ext"       
  echo "$sha256var" " $filename.$ext" >> renum/sha256_renum.txt
  echo "$md5var" " $filename.$ext" >> renum/md5_renum.txt
  echo ""$file" ->  "$filename.$ext" " >> renum/concordance.txt
  index=$(expr "$index" + 1)    
 elif [ "$name_style" == "number" ]
 then
  echo "Renaming file: "$file"  to "$filenum.$ext" "
  md5var=$( md5sum "$file" | awk '{print $1}' )
  sha256var=$(sha256sum "$file" | awk '{print $1}')
  cp -n "$file" renum/"$filenum.$ext"
  echo "$md5var" " $file" >> md5.txt   
  echo "$sha256var" " $file" >> sha256.txt   
  echo "$sha256var" " $filename.$ext" >> renum/sha256_renum.txt
  echo "$md5var" " $filename.$ext" >> renum/md5_renum.txt
  echo ""$file" ->  "$filenum.$ext" " >> renum/concordance.txt  
  index=$(expr "$index" + 1)  
 fi 

fi

done

# Append sha256 and concordances to archive and zip all files 
echo "Appending md5.txt sha256.txt, and concordance.txt to backup.tar"
tar -rvf backup.tar md5.txt sha256.txt renum/concordance.txt
# zip the files
echo "Compressing backup.tar"
gzip backup.tar 
## clean up
## comment out to not remove these files  
rm filelist.txt
rm sha256.txt 
rm md5.txt

echo "Files backed up to backup.tar.gz"
echo "Please verify that there is no data loss"
echo "If any files have been lost, unpack the archive to restore"

exit "$?"

################################# END OF PROGRAM  ################################################