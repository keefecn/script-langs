# Usage: gawk -v word=something -f thisfile.awk [ big.txt [ big2.txt ... ]]
# Gawk version with 15 lines -- 04/13/2008
# Author: tiago (dot) peczenyj (at) gmail (dot) com
# Based on : http://norvig.com/spell-correct.html

function edits(w,max,candidates,list,        i,j){
      for(i=0;i<  max ;++i) ++list[substr(w,0,i) substr(w,i+2)]
      for(i=0;i< max-1;++i) ++list[substr(w,0,i) substr(w,i+2,1) substr(w,i+1,1) substr(w,i+3)]
      for(i=0;i<  max ;++i) for(j in alpha) ++list[substr(w,0,i) alpha[j] substr(w,i+2)]
      for(i=0;i<= max ;++i) for(j in alpha) ++list[substr(w,0,i) alpha[j] substr(w,i+1)]
      for(i in list) if(i in NWORDS) candidates[i] = NWORDS[i] }

function correct(word            ,candidates,i,list,max,temp){
      edits(word,length(word),candidates,list)
      if (!asort(candidates,temp)) for(i in list) edits(i,length(i),candidates)
      return (max = asorti(candidates)) ? candidates[max] : word }

BEGIN{ if (ARGC == 1) ARGV[ARGC++] = "big.txt" # http://norvig.com/big.txt
      while(++i<=length(x="abcdefghijklmnopqrstuvwxyz")) alpha[i]=substr(x,i,1)
      IGNORECASE=RS="[^"x"]+" }
{      ++NWORDS[tolower($1)]  }
END{   print (word in NWORDS) ? word : "correct("word")=> " correct(tolower(word)) }