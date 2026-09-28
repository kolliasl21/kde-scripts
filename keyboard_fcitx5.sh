#!/bin/bash

. ./switch_virtual_keyboard.sh

switch_virtual_keyboard fcitx5-wayland-launcher.desktop

switch_input_method 1

display_osd_message 0
