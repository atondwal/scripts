# xinitcomom

emacs --daemon &
xflux -z 98115
sh ~/.fehbg
xsetroot -cursor_name left_ptr
xcompmgr -c &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
setxkbmap -option ctrl:nocaps
exec xmonad
