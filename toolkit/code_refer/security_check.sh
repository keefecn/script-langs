#! /bin/bash
# ----------------------------------------------------------------------
# file: security_check.sh
# author: keefe, wuqifu@gmail.com
# date: 2016/5/8, 2017/10/15
# note: check database password, langs sensitive functions(string,...)
#   use check_langs_list.xls to compare
# tools: 
#   regex support tools: find grep
# ----------------------------------------------------------------------

DIR=$1
LANG='php'
LANGS_REGEX='.*\.\(c\|h\|cpp\|py\|php\)' 
STRA='word1'
STRB='word2'

find_word()
{   # read~ get variable from input
    # use find to get file, then use grep to get wrod line
    find $DIR -regex $LANGS_REGEX | xargs grep $word
    #grep -rl $KEY $DIR | xargs grep $KEY
}

replace_word()
{
    sed -i "s/$STRA/$STRB/g" `grep -rl "STRA" $DIR`
}

# check db passwd
check_db()
{
    echo "check db..."
    DB_KEYS='connect root'
    for word in $DB_KEYS
    do
        #echo $word
        find_word
    done
}

# check c/cpp
check_c()
{
    echo "check c..."
}

# check java
check_java()
{
    echo "check java..."

}

# check python
check_python()
{
    echo "check python..."

}

check_db
