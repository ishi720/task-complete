#!/bin/bash

# カレントディレクトリから上の階層へ向かってファイルの探索を行う
#
# Examples:
#   fileSerachClimb 'package.json'
#   echo ${findFile}
#   unset findFile
# Args:
#   $1 - 検索するファイル名
# Return:
#   0 - Error 
function fileSerachClimb(){
    local fileName=$1
    local cd=`pwd`
    local repeatCount=$((`echo -n ${cd} | sed -e 's@[^/]@@g' | wc -c`-1))

    local count=0
    local climbStr=''

    while [[ ${repeatCount} -ge ${count} ]]; do
        if [[ ${count} -eq 0 ]]; then
            ls ./${fileName} >& /dev/null
        else
            climbStr="../"${climbStr}
            ls ${climbStr}${fileName} >& /dev/null
        fi

        if [ $? = 0 ]; then
            findFile="${climbStr}${fileName}"
            break
        fi
        count=$((${count}+1))
    done
    return 0
}

_composer() {
    fileSerachClimb 'composer.json'
    if [ ! ${findFile} == '' ]; then
        case "$3" in
            composer)
                local cur prev opts
                _get_comp_words_by_ref -n : cur prev
                opts=`cat "${findFile}" | jq -rc '.scripts | keys | @csv' | sed s/\"//g | sed s/,/" "/g`
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        esac
    fi
    unset findFile
}
complete -F _composer composer

_yarn() {
    fileSerachClimb 'package.json'
    if [ ! ${findFile} == '' ]; then
        case "$3" in
            yarn)
                local cur prev opts
                _get_comp_words_by_ref -n : cur prev
                opts=`cat "${findFile}" | jq -rc '.scripts | keys | @csv' | sed s/\"//g | sed s/,/" "/g`
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") );;
            run)
                local cur prev opts
                _get_comp_words_by_ref -n : cur prev
                opts=`cat "${findFile}" | jq -rc '.scripts | keys | @csv' | sed s/\"//g | sed s/,/" "/g`
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") );;
        esac
    fi
    unset findFile
}
complete -F _yarn yarn

_npm() {
    fileSerachClimb 'package.json'
    if [ ! ${findFile} == '' ]; then
        case "$3" in
            run-scripts)
                local cur prev opts
                _get_comp_words_by_ref -n : cur prev
                opts=`cat "${findFile}" | jq -rc '.scripts | keys | @csv' | sed s/\"//g | sed s/,/" "/g`
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") );;
        esac
    fi
    unset findFile
}
complete -F _npm npm