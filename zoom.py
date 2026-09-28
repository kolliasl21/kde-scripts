#!/usr/bin/env python3

from evdev import UInput, ecodes
import time
import argparse


def execute_zoom(key_code, x):
    ui.write(ecodes.EV_KEY, ecodes.KEY_LEFTMETA, 1)  # Key press
    for i in range(x):
        ui.write(ecodes.EV_KEY, key_code, 1)  # Key press
        time.sleep(0.1)
        ui.write(ecodes.EV_KEY, key_code, 0)  # Key release
    ui.write(ecodes.EV_KEY, ecodes.KEY_LEFTMETA, 0)  # Key release
    ui.syn()


def main(zoom_type, zoom_intensity):
    mapping = {
        'zoom-in': ecodes.KEY_EQUAL,
        'zoom-out': ecodes.KEY_MINUS,
        'zoom-to-zero': ecodes.KEY_0
    }
    if zoom_type in mapping:
        execute_zoom(mapping[zoom_type], zoom_intensity)


if __name__ == '__main__':
    ui = UInput()
    parser = argparse.ArgumentParser(
            prog='Zoom tool for KDE',
            description='Zoom in-out tool for KDE')
    parser.add_argument('-o', '--option', choices=['zoom-to-zero', 'zoom-in',
                                                   'zoom-out'],
                        default='zoom-to-zero', help='Zoom options')
    parser.add_argument('-c', '--count', type=int,
                        default=1, help='Zoom multiplier')
    args = parser.parse_args()

    count = max(min(5, args.count), 1)

    main(args.option, count)
