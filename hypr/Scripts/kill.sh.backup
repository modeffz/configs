#!/usr/bin/env bash

win=$(hyprctl activewindow -j | jq -r '.address')

if [ -z "$win" ] || [ "$win" = "null" ]; then
    notify-send "Hyprland" "Нет активного окна"
    exit 1
fi

pid=$(hyprctl activewindow -j | jq -r '.pid')

if [ -z "$pid" ] || [ "$pid" = "null" ]; then
    notify-send "Hyprland" "Не удалось получить PID"
    exit 1
fi

kill -9 "$pid"

notify-send "Hyprland" "Процесс $pid был убит"

