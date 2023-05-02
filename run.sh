#!/usr/bin/expect
set timeout -1
set t0 [exec date +%s]

spawn qemu-system-x86_64 -cpu host -enable-kvm -m 4096 -nic user,hostfwd=tcp::13650-:22 -drive file=disk.qcow2,format=qcow2 -device intel-hda -device hda-duplex -usb -rtc base=localtime -monitor stdio

# Complete
set finished 0
while {$finished <= 0} {
    sleep 5
    send "screendump dump.ppm\r"
    set t [exec date +%s]
    set dt [expr {$t - $t0}]
    send_user "Wait. (dt = $dt s)\n"
    if {[exec ./readppm dump.ppm 768010] eq "203 228 239"} {
        set finished 1
    }
    exec rm -f dump.ppm
}

interact
