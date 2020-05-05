# xmodmap .xmodmap.conf

#Let QT and GTK autodetect retina screen and autoadjust
export QT_DEVICE_PIXEL_RATIO=1.2
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# Adjust keyboard delay and rate
xset r rate 250 30

# Start Xorg servwe at this DPI
xrandr --dpi 192

#Merge & load configs 
xrdb -merge ~/.Xresources

~/.fehbg &


exec i3
# exec startplasma-x11
