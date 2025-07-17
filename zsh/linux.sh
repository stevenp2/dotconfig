### scripts
function brightness() {
  xrandr --current --output DP-4 --brightness $1
  xrandr --current --output DVI-D-0 --brightness $1
  xrandr --current --output HDMI-0 --brightness $1
}

### aliases
# restart hid devices
alias ubsr='sudo modprobe -r usbhid && sudo modprobe usbhid'

