#
# ~/.bashrc
#

# If not running interactively, don't do anything
export LC_ALL=es_ES.utf-8
export MER_ROOT=/home/kudrom/bin/mer
alias sdk=$MER_ROOT/sdks/sdk/mer-sdk-chroot
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
