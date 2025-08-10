#!/bin/bash
# Default acpi script that takes an entry for all actions
# from https://unix.stackexchange.com/questions/724908/in-a-wayland-session-how-to-automatically-disable-input-devices-when-the-laptop

case "$1" in
#     button/up)
# ;;
#     button/down)
# ;;
#     button/right)
# ;;
#     button/left)
# ;;
#     button/power)
#         case "$2" in
#             PBTN|PWRF)
#                 logger 'PowerButton pressed'
#                 ;;
#             *)
#                 logger "ACPI action undefined: $2"
#                 ;;
#         esac
#         ;;
#     button/sleep)
#         case "$2" in
#             SLPB|SBTN)
#                 logger 'SleepButton pressed'
#                 ;;
#             *)
#                 logger "ACPI action undefined: $2"
#                 ;;
#         esac
#         ;;
#     ac_adapter)
#         case "$2" in
#             AC|ACAD|ADP0)
#                 case "$4" in
#                     00000000)
#                         logger 'AC unpluged'
#                         ;;
#                     00000001)
#                         logger 'AC pluged'
#                         ;;
#                 esac
#                 ;;
#             *)
#                 logger "ACPI action undefined: $2"
#                 ;;
#         esac
#         ;;
#     battery)
#         case "$2" in
#             BAT0)
#                 case "$4" in
#                     00000000)
#                         logger 'Battery online'
#                         ;;
#                     00000001)
#                         logger 'Battery offline'
#                         ;;
#                 esac
#                 ;;
#             CPU0)
#                 ;;
#             *)  logger "ACPI action undefined: $2" ;;
#         esac
#         ;;
    button/lid)
        case "$3" in
            close)
        echo 1 > /sys/devices/platform/i8042/serio1/input/input8/inhibited 
        echo 1 > /sys/devices/platform/i8042/serio0/input/input3/inhibited
                logger 'LID closed'
                ;;
            open)
        echo 0 > /sys/devices/platform/i8042/serio1/input/input8/inhibited
        echo 0 > /sys/devices/platform/i8042/serio0/input/input3/inhibited
                logger 'LID opened'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
    esac
    ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:

