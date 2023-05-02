#!/usr/bin/expect
set timeout -1
set t0 [exec date +%s]

spawn qemu-system-x86_64 -cpu host -enable-kvm -m 4096 -nic none -drive file=tmp.qcow2,format=qcow2 -cdrom win10-x86_64.iso -monitor stdio

set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Start. (dt = $dt s)\n"

# Choose language
set finished 0
while {$finished <= 0} {
    sleep 5
    send "screendump dump.ppm\r"
    set t [exec date +%s]
    set dt [expr {$t - $t0}]
    send_user "Wait for blue screen. (dt = $dt s)\n"
    # exec ./readppm dump.ppm 1 >@stdout
    if {[exec ./readppm dump.ppm 1] eq "24 0 82"} {
        set finished 1
    }
    exec rm -f dump.ppm
}
sleep 5
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Press NEXT. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Install now
sleep 1
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Press INSTALL NOW. (dt = $dt s)\n"
send "sendkey kp_enter\r"

# Activation
set finished 0
while {$finished <= 0} {
    sleep 5
    send "screendump dump.ppm\r"
    set t [exec date +%s]
    set dt [expr {$t - $t0}]
    send_user "Setup is starting. (dt = $dt s)\n"
    # exec ./readppm dump.ppm 184530 >@stdout
    if {[exec ./readppm dump.ppm 184530] eq "255 255 255"} {
        set finished 1
    }
    exec rm -f dump.ppm
}
sleep 1
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "I have nothing. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Choose version
sleep 3
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Choose version. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Accept license
sleep 3
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "ACCEPT. (dt = $dt s)\n"
send "sendkey shift-kp_add\r"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Choose type of installation
sleep 3
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Choose CUSTOM. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Choose install location
sleep 5
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Choose install location. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Wait for install
set finished 0
while {$finished <= 0} {
    sleep 5
    send "screendump dump.ppm\r"
    set t [exec date +%s]
    set dt [expr {$t - $t0}]
    send_user "Installing. (dt = $dt s)\n"
    # exec ./readppm dump.ppm 1 >@stdout
    if {[exec ./readppm dump.ppm 1] eq "31 31 31"} {
        set finished 1
    }
    exec rm -f dump.ppm
}

# Set region
sleep 15
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Set region. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey kp_enter\r"

# Set keyboard layout
sleep 15
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Set keyboard layout. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey kp_enter\r"
sleep 10
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Skip. (dt = $dt s)\n"
send "sendkey kp_enter\r"

# Connect to network
sleep 10
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "No network. (dt = $dt s)\n"
send "sendkey tab\r"
send "sendkey kp_enter\r"
sleep 3
send "sendkey shift-tab\r"
send "sendkey kp_enter\r"

# Set user
sleep 10
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Username and password. (dt = $dt s)\n"
send "sendkey a\r"
send "sendkey kp_enter\r"

# Set password
sleep 10
send "sendkey kp_enter\r"

# Set privacy settings
sleep 15
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Privacy. (dt = $dt s)\n"
send "sendkey kp_enter\r"

# Enable cortana
sleep 15
set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Cortana. (dt = $dt s)\n"
send "sendkey shift-tab\r"
send "sendkey kp_enter\r"

# Complete
set finished 0
while {$finished <= 0} {
    sleep 5
    send "screendump dump.ppm\r"
    set t [exec date +%s]
    set dt [expr {$t - $t0}]
    send_user "Wait for completion. (dt = $dt s)\n"
    # exec ./readppm dump.ppm 768010 >@stdout
    if {[exec ./readppm dump.ppm 768010] eq "203 228 239"} {
        set finished 1
    }
    exec rm -f dump.ppm
}

set t [exec date +%s]
set dt [expr {$t - $t0}]
send_user "Complete. (dt = $dt s)\n"
send "system_powerdown\r"
interact
