# xinitcommon

emacs --daemon &
xflux -z 98115
sh ~/.fehbg
xsetroot -cursor_name left_ptr
xcompmgr -c &
setxkbmap -option ctrl:nocaps
tilda &
unclutter &
PATH=~/bin/:$PATH
twmnd &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec xmonad
