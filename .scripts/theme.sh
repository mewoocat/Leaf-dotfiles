#!/bin/bash


# Inputs
#   Wallpaper
#   Color theme file
#   Dark / Light?
#
# Effects
#   Change Hyprland colors
#   Change Eww colors
#   Set wallpaper
#
#
# Applicaitons that do not respect theme change
#   Discord - Requires restart
#   Startpage?

# from https://github.com/AmadeusWM/dotfiles-hyprland/blob/main/themes/apatheia/scripts/wallpaper
# swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60
#
# Set kitty color scheme from file
# kitty @ set-colors -A ~/.config/kitty/current-theme.conf

wallpaper=$(cat $HOME/.cache/wal/wal)
wallpaper_path="$HOME/.cache/wal/wal"
theme_path="$HOME/.cache/wal/colors"

wallpaper_light="/home/ghost/wallpapers/cloud.png"
wallpaper_dark="/home/ghost/wallpapers/wp2461890-mars-wallpapers.jpg"
wallpaper_dark="/home/ghost/wallpapers/pexels-irina-iriser-837453.jpg"
wallpaper_dark="/home/ghost/wallpapers/10-13.jpg"
wallpaper_dark="/home/ghost/wallpapers/10-7-6k.jpg"
wallpaper_light="/home/ghost/wallpapers/13-Ventura-Light.jp"
wallpaper_light="/home/ghost/wallpapers/0303.jpg"
wallpaper_light="/home/ghost/wallpapers/mobile-suit-gundam-gundam-mech-master-grade-wallpaper-7bb62c4d3321cfd91594fbf90ddcaca0.jpg"
wallpaper_dark="/home/ghost/wallpapers/2560x1440_leaves-green-bushes-carved-dark-plant.jpg"
wallpaper_dark="/home/ghost/wallpapers/pexels-irina-iriser-837453.jpg"
wallpaper_dark="/home/ghost/wallpapers/pexels-irina-iriser-837453.jpg"
wallpaper_dark="/home/ghost/wallpapers/pexels-sebastian-sørensen-1276518.jpg"
wallpaper_light="/home/ghost/wallpapers/isn8l7lknxua1.png"
wallpaper_light="/home/ghost/wallpapers/pexels-daniel-frese-1055379.jpg"
wallpaper_dark="/home/ghost/wallpapers/isn8l7lknxua1.png"
wallpaper_dark="/home/ghost/wallpapers/pexels-peter-fazekas-1089462.jpg"
wallpaper_dark="/home/ghost/wallpapers/pexels-daniel-frese-1055379.jpg"

theme_colors="base16-3024"
#theme_colors_light="base16-atelier-dune"
#theme_colors_light="base16-shapeshifter"
#theme_colors_light="base16-cupertino"
theme_colors_light="base16-atelier-seaside"
theme_colors_light="base16-shapeshifter"
theme_colors_light="base16-github"
#theme_colors_dark="base16-3024"
theme_colors_dark="base16-macintosh"
#theme_colors_dark="solarized"
#theme_colors_dark="base16-gruvbox-hard"
theme_colors_dark="base16-3024"
theme_colors_dark="base16-chalk"
theme_colors_dark="base16-atelier-seaside"
theme_colors_dark="base16-gruvbox-hard"
theme_colors_light="base16-gruvbox-hard"

gtk_light_theme="Mojave-Light"
gtk_dark_theme="Mojave-Dark"
gtk_dark_theme="Gruvbox-Dark-B"


kitty_light="Github"
kitty_dark="Dark Pastel"

theme=false;

# From chatGPT
lighten_color() {
  # Convert the input hex code to RGB values
  hex=$1
  amount=$2

  r=$(printf '0x%s' ${hex:0:2})
  g=$(printf '0x%s' ${hex:2:2})
  b=$(printf '0x%s' ${hex:4:2})

  # Add a small amount to each RGB value to lighten the color
  r=$((r + $amount))
  g=$((g + $amount))
  b=$((b + $amount))

  # Make sure the RGB values stay within the valid range of 0-255
  r=$((r > 255 ? 255 : r))
  g=$((g > 255 ? 255 : g))
  b=$((b > 255 ? 255 : b))

  # Convert the new RGB values back to a hex code
  printf '#%02x%02x%02x\n' $r $g $b
}

# From chatGPT
darken_color() {
  # Convert the input hex code to RGB values
  hex=$1
  amount=$2

  r=$(printf '0x%s' ${hex:0:2})
  g=$(printf '0x%s' ${hex:2:2})
  b=$(printf '0x%s' ${hex:4:2})

  # Add a small amount to each RGB value to lighten the color
  r=$((r - $amount))
  g=$((g - $amount))
  b=$((b - $amount))

  # Make sure the RGB values stay within the valid range of 0-255
  r=$((r < 0 ? 0 : r))
  g=$((g < 0 ? 0 : g))
  b=$((b < 0 ? 0 : b))

  # Convert the new RGB values back to a hex code
  printf '#%02x%02x%02x\n' $r $g $b
}


# Notes:    Add new color called iconBG where is a darken/lightend version of fg
function setEWWColors(){
    mode=$1

    # sed command from https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file
    echo "\$bg: $(sed '1q;d' ~/.cache/wal/colors);" > ~/.config/eww/_colors.scss;
    echo "\$fg: $(sed '16q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;

    # Get theme variables 
    bg=$(sed '1q;d' ~/.cache/wal/colors | cut -c 2-)
    fg=$(sed '16q;d' ~/.cache/wal/colors | cut -c 2-)

    if [ $mode == "light" ]; then
        echo "hi"
        echo "\$bg_alt: $(darken_color $bg 80);" >> ~/.config/eww/_colors.scss;
        #echo "\$fg_alt: $(lighten_color $fg 100);" >> ~/.config/eww/_colors.scss;
        echo "\$fg_alt: $(darken_color $bg 100);" >> ~/.config/eww/_colors.scss;
    fi

    if [ $mode == "dark" ]; then
        echo "ho"
        echo "\$bg_alt: $(lighten_color $bg 40);" >> ~/.config/eww/_colors.scss;
        #echo "\$fg_alt: $(darken_color $fg 100);" >> ~/.config/eww/_colors.scss;
        echo "\$fg_alt: $(lighten_color $bg 100);" >> ~/.config/eww/_colors.scss;
    fi

    echo "\$color1: $(sed '2q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;
    echo "\$color2: $(sed '3q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;
    echo "\$color3: $(sed '4q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;
    echo "\$color4: $(sed '5q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;


    # Set rofi theme colors
    # Global ignore from:  https://stackoverflow.com/questions/102049/how-do-i-escape-the-wildcard-asterisk-character-in-bash
    
    bg0="#${bg}8F"
    fg0="#${fg}FF"

    GLOBIGNORE="*"
    text="* {
    bg0:    $bg0;
    bg1:    #2A2A2A;
    bg2:    #3D3D3D80;
    bg3:    #616161F2;
    fg0:    $fg0;
    fg1:    #FFFFFF;
    fg2:    #969696;
    fg3:    #3D3D3D;\n}\n@import \"rounded-common.rasi\"
    "

    echo -e "$text" > ~/.config/rofi/theme.rasi

    eww reload;
}

function setRofiColors(){
    # Global ignore from:  https://stackoverflow.com/questions/102049/how-do-i-escape-the-wildcard-asterisk-character-in-bash
    GLOBIGNORE="*"
    text="* {
    bg0:    #212121F2;
    bg1:    #2A2A2A;
    bg2:    #3D3D3D80;
    bg3:    #616161F2;
    fg0:    #E6E6E6;
    fg1:    #FFFFFF;
    fg2:    #969696;
    fg3:    #3D3D3D;\n}\n@import \"rounded-common.rasi\"
    "

    echo -e "$text" > ~/.config/rofi/theme.rasi

}

function setLight(){
    wal -l --theme $theme_colors_light; 
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_light_theme;
    swww img $wallpaper_light;
    setEWWColors light;
    #killall eww && killall eww && eww open bar;
    echo $wallpaper_light > ~/.config/wallpaper;
    sleep 0.1 # Prevents the EWW reload from changing the colors to reset the theme_light variable
    eww update theme_light=true;
}

function setDark(){
    # Includes setting the background to black in all cases
    #wal -b 000000 --backend colorz --theme $theme_colors_dark;
    wal --backend colorz --theme $theme_colors_dark;
    if [ false == false ]; then
        echo "theme false"
        gsettings set org.gnome.desktop.interface gtk-theme $gtk_dark_theme;
    fi
    #swww img $wallpaper_dark --transition-type outer;
    swww img $wallpaper_dark
    echo "\$color1: $(sed '2q;d' ~/.cache/wal/colors);" >> ~/.config/eww/_colors.scss;
    setEWWColors dark;
    #killall eww && killall eww && eww open bar;
    echo $wallpaper_dark > ~/.config/wallpaper;
    sleep 0.1 # Prevents the EWW reload from changing the colors to reset the theme_light variable
    eww update theme_light=false;

}

function setWallpaperDark(){
    echo "here"
    bgBlack=$2
    if [ $bgBlack == true ]; then
        echo "true"
        wal -i $1 -b 000000 --backend colorz;
    else
        echo "false"
        wal -i $1;
    fi
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_dark_theme;
    swww img $1;
    setEWWColors dark;
    #killall eww && killall eww && eww open bar;
    echo $1 > ~/.config/wallpaper;
    sleep 0.1 # Prevents the EWW reload from changing the colors to reset the theme_light variable
    eww update theme_light=false;
}

function setWallpaperLight(){
    wal -l -i $1;
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_dark_theme;
    swww img $1;
    setEWWColors light;
    #killall eww && killall eww && eww open bar;
    echo $1 > ~/.config/wallpaper;
    sleep 0.1 # Prevents the EWW reload from changing the colors to reset the theme_light variable
    eww update theme_light=false;
}

# Toggle integration with EWW
function toggleTheme(){
    if [[ $(eww get theme_light) == "false" ]]; then
        setLight
    else
        setDark
    fi
}

theme=false
bgBlack=false

# get input flags
while getopts W:i:bwldt:B:TL:D:Gx flag
do
    case "${flag}" in
        # New
        #i)  hyprctl hyprctl unload all; hyprctl hyprpaper preload ${OPTARG}; hyprctl hyprpaper wallpaper "eDP-1,${OPTARG}" ; hyprctl hyprpaper wallpaper "DP-1,${OPTARG}"; > /dev/null; theme=false;;

        # Set wallpaper path in a file for compatibility between file types
        i) swww img ${OPTARG} ; echo "${OPTARG}" > ~/.config/wallpaper ;;

		# set wallpaper and theme
        #i) wal -i ${OPTARG}; > /dev/null ; theme=true ;;
		
		# set wallpaper and theme with black bg
        b) bgBlack=true ;;
		
		# set wallpaper only
        #w) > $wallpaper_path && echo ${OPTARG} >> $wallpaper_path ; theme=false ;;
        w) currentWallpaper=$(cat ~/.config/wallpaper) && swww img "$currentWallpaper" ; theme=false ;;
        # w) > $wallpaper_path && echo "$(pwd)/${OPTARG}" >> $wallpaper_path ; theme=false ;;
        #
        # w) setWallpaperDark ${OPTARG} ;;
		
		# set theme to light
        l) setLight;;

		# set theme to dark
        d) setDark;; 	

        L) setWallpaperLight ${OPTARG} ;;

        D) setWallpaperDark ${OPTARG} $bgBlack;;

		# set theme only
		t) wal --theme ${OPTARG} > /dev/null ; theme=true ;;

        # set theme only and black background
        B) wal -b 000000 --theme ${OPTARG} > /dev/null ; theme=true ;;

        T) toggleTheme ;;
        
        # Set gtk theme from current pywal theme
        G) theme=true ;; 

        x) setRofiColors ;;
		
    esac
done

if [ $theme == true ]; then
	# sets gtk theme colors
	oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse > /dev/null
	#oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse-materia > /dev/null
	# reloads gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme "oomox-xresources-reverse"
	#killall xsettingsd > /dev/null 2>&1
	#timeout 1 xsettingsd -c .config/xsettingsd/xsettingsd.conf > /dev/null 2>&1
fi
#reset
#
#killall eww && killall eww && eww open bar
exit 0
