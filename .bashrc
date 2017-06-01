# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1='\h:\w\$ '
umask 022

### self.bash.alias
#===> (self)
if [[ -f ~/.bash_alias ]]; then
source ~/.bash_alias
fi

### self.bash.tools
#===> (self)
if [[ -f ~/.bash_tools ]]; then
source ~/.bash_tools
fi


# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# РґРµС†РєРїРєС„РІРѕ С…Рє Р·СЋРµР¶СЂСЋРµР¶Рµ, СЏРІ РґРІ РїРµ С…Рµ Р¶С„СЂС‰РІ РґРІ СЉРє С‚РєС‰РІ
NONE="\[\033[0m\]"
BK="\[\033[0;30m\]" #Black
EBK="\[\033[1;30m\]"
RD="\[\033[0;31m\]" #Red
ERD="\[\033[1;31m\]"
GR="\[\033[0;32m\]" #Green
EGR="\[\033[1;32m\]"
YW="\[\033[0;33m\]" #Yellow
EYW="\[\033[1;33m\]"
BL="\[\033[0;34m\]" #Blue
EBL="\[\033[1;34m\]"
MG="\[\033[0;35m\]" #Magenta
EMG="\[\033[1;35m\]"
CY="\[\033[0;36m\]" #Cyan
ECY="\[\033[1;36m\]"
WH="\[\033[0;37m\]" #White
EWH="\[\033[1;37m\]"
unset LESS
export PAGER=less

# С‚С„СЂСЋРµС„РјРІ РґРІРЅРє С…СЃРѕ root
# РІРјСЂ РїРµ С…СЃРѕ, Р¶СЂ Р±СЏСЃС„РІ СЊРµ Рµ СЋ СЏРµРЅРµРїСЂ, РІ РІРјСЂ С…СЃРѕ
# Р¶СЂ СЊРµ Рµ СЋ Р°РµС„СЋРµРїСЂ :)

if [ `id -un` != root ]; then
  PS1="[${EGR}\u:${EBL} \W${NONE}]$ "
else
  PS1="[${ERD}\u:${EYW} \W${NONE}]# "
fi

umask 022
# РїРІС…Р¶С„СЂР»РјРє РїРІ ls
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS -p'
 alias ll='ls $LS_OPTIONS -l'
 alias l='ls $LS_OPTIONS -lA'
# РїРІС…Р¶С„СЂР»РјРє РїРІ rm
 alias rm='rm -i'
# РїРІС…Р¶С„СЂР»РјРє РїРІ cp
 alias cp='cp -i'
# РїРІС…Р¶С„СЂР»РјРє РїРІ mv
 alias mv='mv -i'
# РїРІС…Р¶С„СЂР»РјРє РїРІ apt Рє dpkg
 alias -- -se="apt-cache search"
 alias -- -show="apt-cache show"
 alias -- -in="apt-get install"
 alias -- -rem="apt-get remove"
 alias -- -upd="apt-get update"
 alias -- -upg="apt-get upgrade"
 alias -- -list="dpkg -l"
 alias -- -check="dpkg --get-selections| grep $1"
# РїРІС…Р¶С„СЂР»РјРє РїРІ less
 alias less="less -I -R"
# РїРІС…Р¶С„СЂР»РјРє РїРІ grep - С‚СЂРґР°РµС„Р¶РІСЋРІ С… Р°РµС„СЋРµРїСЂ (С‚С„Рє РѕРµРї)
# Р¶СЃС„С…РµРїРІР¶РІ РґРёРѕРІ СЋ РєСЏР№СЂРґРІ
 alias grep="grep --color=auto"
# С‚СЂРґС„РІСЏС‡РєС„РІСЊ С…Рµ С„РµРґРІРјР¶СЂС„
 export EDITOR=vim 

function apt-search()
{
search=`apt-cache search $1 | awk -F" " '{print $1}'`

for i in $search;
do
if(dpkg -l | grep $i > /dev/null )
then
echo -e "Package: \e[00;36m`apt-cache show $i | grep -m 1 Section | awk -F" " '{print $2}'`/$i\e[00m"
echo -e "\e[00;32m\t* Installed \n\t\t>>> `apt-cache show $i | grep -m 1 Version`\e[00m"
echo -e "\e[00;32m\t\t>>> `apt-cache show $i | grep -m 1 Size`\e[00m\n"
else
echo -e "Package: \e[00;36m`apt-cache show $i | grep -m 1 Section | awk -F" " '{print $2}'`/$i\e[00m"
echo -e "\e[00;31m\t! Not installed. \e[00m"
echo -e "\e[00;32m\t\t>>> Available `apt-cache show $i | grep -m 1 Version` \e[00m"
echo -e "\e[00;32m\t\t>>> `apt-cache show $i | grep -m 1 Size`\e[00m\n"
fi
done
}

function apt-depend()
{
dep=`LC_ALL=C apt-cache depends $1 | grep Depends | awk -F" " '{print $2}'`

echo -e "\e[00;32m>>> \e[00;36m`apt-cache show $1 | grep -m 1 Section | awk -F" " '{print $2}'`/$1 \e[00;32m<<<\e[00m\n"
for i in $dep ;
do
if (dpkg -l | awk -F" " '{print $2}' | grep -x $i > /dev/null)
then
if(apt-cache show $i > /dev/null)
then echo -e "\e[00;32m>>> \e[00;36m`apt-cache show $i | grep -m 1 Section | awk -F" " '{print $2}'`/$i\e[00m"
fi
echo -e "\t\e[00;32m * Installed\e[00m"
echo -e "\t\t\e[00;32m>>> `apt-cache show $i | grep -m 1 Version`\e[00m\n"
else
if(apt-cache show $i > /dev/null)
then echo -e "\e[00;32m>>> \e[00;36m`apt-cache show $i | grep -m 1 Section | awk -F" " '{print $2}'`/$i\e[00m"
fi
echo -e "\t\e[00;31m ! Not installed\e[00m"
echo -e "\t\t\e[00;32m>>> Available `apt-cache show $i | grep -m 1 Version`\e[00m\n"
fi
done
} 

#alias SlaSerX
alias update='apt-get update'
alias upgrade='apt-get upgrade'
alias search='apt-cache search'
alias install='apt-get install'
alias remove='apt-get remove'
alias ipv6='sh /etc/tsp/ping'
alias upd='apt-get update'
alias upg='apt-get upgrade'
alias tail='grc tail'

# Colors

Black="$(tput setaf 0)"
BlackBG="$(tput setab 0)"
DarkGrey="$(tput bold ; tput setaf 0)"
LightGrey="$(tput setaf 7)"
LightGreyBG="$(tput setab 7)"
White="$(tput bold ; tput setaf 7)"
Red="$(tput setaf 1)"
RedBG="$(tput setab 1)"
LightRed="$(tput bold ; tput setaf 1)"
Green="$(tput setaf 2)"
GreenBG="$(tput setab 2)"
LightGreen="$(tput bold ; tput setaf 2)"
Brown="$(tput setaf 3)"
BrownBG="$(tput setab 3)"
Yellow="$(tput bold ; tput setaf 3)"
Blue="$(tput setaf 4)"
BlueBG="$(tput setab 4)"
LightBlue="$(tput bold ; tput setaf 4)"
Purple="$(tput setaf 5)"
PurpleBG="$(tput setab 5)"
Pink="$(tput bold ; tput setaf 5)"
Cyan="$(tput setaf 6)"
CyanBG="$(tput setab 6)"
LightCyan="$(tput bold ; tput setaf 6)"
NC="$(tput sgr0)"       # No Color

# Functions

spin ()
{
echo -ne "$White-"
echo -ne "$LightGray\b|"
echo -ne "$LightGreen\bx"
sleep .02
echo -ne "$DarkGrey\b+$RC"
}

typetext1 ()
{
sleep .02
echo -ne "$LightGreen W"
sleep .02
echo -ne e
sleep .02
echo -ne l
sleep .02
echo -ne c
sleep .02
echo -ne o
sleep .02
echo -ne m
sleep .02
echo -ne e
sleep .02
echo -ne " "
sleep .02
echo -ne t
sleep .02
echo -ne o
sleep .02
echo -ne " "
sleep .02
echo -ne "$HOSTNAME $NC"
sleep .02
}

typetext2 ()
{
sleep .02
echo -ne "$LightGreen E"
sleep .02
echo -ne n
sleep .02
echo -ne j
sleep .02
echo -ne o
sleep .02
echo -ne y
sleep .02
echo -ne " "
sleep .02
echo -ne y
sleep .02
echo -ne o
sleep .02
echo -ne u
sleep .02
echo -ne r
sleep .02
echo -ne " "
sleep .02
echo -ne s
sleep .02
echo -ne t
sleep .02
echo -ne a
sleep .02
echo -ne y
sleep .02
echo -ne "! "
sleep .02
}

dots ()
{
sleep .5
echo -ne "$LightGreen ."
sleep .5
echo -ne .
sleep .5
echo -ne .
sleep .8
echo -ne "$DarkGrey done"
}

#Distribution
DISTRO="Unknown Distro"
DISTRO='Debian'

memfree="`cat /proc/meminfo | grep MemFree | cut -d: -f2 | cut -dk -f1`";
memtotal="`cat /proc/meminfo | grep MemTotal | cut -d: -f2 | cut -dk -f1`";
memfreepcnt=$(echo "scale=5; $memfree/$memtotal*100" | bc -l);

# Welcome screen

clear;
echo -e "";
for i in `seq 1 15` ; do spin; done; typetext1; for i in `seq 1 15` ; do spin; done ;echo "";
echo "";
echo -ne "$DarkGrey Hello $LightGreen$USER $DarkGrey!";
echo ""; sleep .3;
echo "";
echo -ne "$DarkGrey Today is: $LightGreen`date`";
echo ""; sleep .3;
echo -ne "$DarkGrey Last login:$LightGreen `lastlog | grep $USER | awk '{print $4" "$6" "$5" "$9}'`$DarkGrey at$LightGreen `lastlog | grep $USER | awk '{print $7}'`$DarkGrey from$LightGreen `lastlog | grep $USER | awk '{print $3}'`";
echo ""; sleep .3;
echo "";
echo -ne "$DarkGrey Loading system information"; dots; 
echo ""; sleep .3;
echo "";
echo -ne "$DarkGrey Distro: $LightGreen $DISTRO";
echo "";
echo -ne "$DarkGrey Kernel: $LightGreen `uname -smri`";
echo "";
echo -ne "$DarkGrey CPU:   $LightGreen `grep "model name" /proc/cpuinfo | cut -d : -f2`";
echo "";
echo -ne "$DarkGrey Speed:  $LightGreen`grep "cpu MHz" /proc/cpuinfo | cut -d : -f2` MHz"; 
echo "";
echo -ne "$DarkGrey Load:   $LightGreen `w | grep up | awk '{print $10" "$11" "$12}'`";
echo "";
echo -ne "$DarkGrey RAM:    $LightGreen `cat /proc/meminfo | head -n 1 | awk '/[0-9]/ {print $2}'` KB";
echo "";
echo -ne "$DarkGrey Usage:  $LightGreen $memfreepcnt %"
echo "";
echo -ne "$DarkGrey Host:     $LightGreen lab.linuxhelps.net";
echo "";
echo -ne "$DarkGrey Uptime: $LightGreen `uptime | awk {'print $3" "$4" "$5'} | sed 's/:/ hours, /' | sed -r 's/,$/ minutes/'`";
echo ""; sleep .3;
echo "";
for i in `seq 1 21` ; do spin; done; typetext2; for i in `seq 1 20` ; do spin; done ;echo "";
echo "" $NC;

# Fancy bash

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ '

#PS1='\[$Blue\]\[$Yellow\]\u\[$Blue\]@\[$Yellow\]\h\[$Blue\]:\[$Red\]\w\[$Blue\]\$\[$NC\] '
#PS1="$LightBlue[$Red\u$LightBlue@$Red\H$LightBlue:$Red\w$LightBlue]$White$ "
