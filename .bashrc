#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias thinkfetch='neofetch --ascii /home/Inc/config/thinkpad.txt --ascii_colors 1 15'
alias makimafetch='neofetch --ascii /home/Inc/config/makima.txt'
alias deadfetch='neofetch --ascii /home/Inc/config/888.txt'
thinkfetch
#neofetch
#makimafetch




PS1='[\u@\h \W]\$ '

