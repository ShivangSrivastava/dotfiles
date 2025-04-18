#!/bin/bash

current_ws=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current_ws" -eq 2 ]; then
    if pgrep firefox > /dev/null; then
      :
    else
        nohup firefox >/dev/null 2>&1 &
        sleep 0.5
        exit 0
    fi
fi

website=$(echo -e 'Normal\nWhatsapp\nYouTube\nLinkedIn\nChatGPT\nGitHub\nYoutube Music\nGMail\nGoogle Docs\nGoogle Sheets' | fzf --layout reverse --border )

case "$website" in
    "Whatsapp") url="https://web.whatsapp.com" ;;
    "YouTube") url="https://youtube.com" ;;
    "LinkedIn") url="https://linkedin.com" ;;
    "ChatGPT") url="https://chatgpt.com" ;;
    "GitHub") url="https://github.com/ShivangSrivastava" ;;
    "Youtube Music") url="https://music.youtube.com" ;;
    "GMail") url="https://mail.google.com" ;;
    "Google Docs") url="https://docs.google.com/document/u/0/" ;;
    "Google Sheets") url="https://docs.google.com/spreadsheets/u/0/" ;;
    *) url="" ;;
esac

hyprctl dispatch workspace 2
if pgrep firefox > /dev/null; then
    xdg-open "$url"
else
    if [ -z $url ]; then
        nohup firefox >/dev/null 2>&1 &
    else
        nohup firefox "$url" >/dev/null 2>&1 &
    fi
    sleep 0.5
fi
