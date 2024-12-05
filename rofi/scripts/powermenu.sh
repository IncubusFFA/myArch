#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
#dir="~/.config/rofi/scripts/rasi/style-3.rasi"
#theme='style-3'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host='ThinkPad'

# Options
shutdown='Выключение'
reboot='Перезагрузка'
lock='Блокировка'
suspend='Сон'
logout='Быстрая блокировка'
yes='Да'
no='Да'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-mesg "Время работы: $uptime" \
		-theme ~/.config/rofi/scripts/rasi/style-3.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Вы уверены' \
		-theme ~/.config/rofi/scripts/rasi/style-3.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	#selected="$(confirm_exit)"
	
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			if [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			fi
		fi
	
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		i3-nagbar -t warning -m 'Вы нажали ярлык выхода. Вы действительно хотите выйти из i3? Это завершит ваш нынешний сеанс.' -B 'Да, блокировать i3' 'i3-msg exit'

        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
