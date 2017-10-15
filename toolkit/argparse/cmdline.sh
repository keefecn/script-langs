#!/bin/bash

show_args()
{
    # $@ show all args
    for args in $@
    do
        echo $args
    done
}

show_file()
{   # * = current directory and files
    for file in *
    do
        #if [ -d ${file} ]; then
        echo $file
    done
}

recurise_mv()
{
    for args in ./go/* ./do/*
    do
        cp ${args} ./fo
        echo "copying ${args} to ./fo/${args}"
    done
}

show_args
show_file
