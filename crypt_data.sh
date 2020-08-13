#!/bin/bash

# aschar — печать представления символов ascii
# числа, переданного в качестве аргумента
# example: aschar 65 ==> A
function aschar()
{
    local ashex
    printf -v ashex '\\x%02x' $1
    printf '%b' $ashex
}

# asnum — печатать ascii (десятичное) значение символа,
# переданного в качестве значения $1
# пример: asnum A ==> 65
function asnum()
{
    printf '%d' "\"$1"
}

# ncrypt – шифрование — считывание символов
# на выходе двухзначный шестнадцатеричный #s
function ncrypt()
{
    TXT="$1"
    for((i=0; i<${#TXT}; i++))
    do
        CHAR="${TXT:i:1}"
        RAW=$(asnum "$CHAR")
        NUM=${RANDOM}
        COD=$(( RAW ^ ( NUM & 0x7F )))
        printf "%02X" "$COD"
    done
    echo
}

# dcrypt - дешифрование — считывание двухзначного шестнадцатеричного #s
# на выходе символы (буквенные и цифровые)
function dcrypt()
{
    TXT="$1"
    for((i=0; i<${#TXT}; i=i+2))
    do
        CHAR="0x${TXT:i:2}"
        RAW=$(( $CHAR ))
        NUM=${RANDOM}
        COD=$(( RAW ^ ( NUM & 0x7F )))
        aschar "$COD"
    done
    echo
}

if [[ -n $1 && $1 == "-d" ]]
then
    DECRYPT="YES"
    shift # $2 становится первым аргументом
fi

KEY=${1:-1776} # либо аргумент, либо 1776
RANDOM="${KEY}"

while read -r
do
    if [[ -z $DECRYPT ]]
    then
        ncrypt "$REPLY"
    else
        dcrypt "$REPLY"
    fi
done
