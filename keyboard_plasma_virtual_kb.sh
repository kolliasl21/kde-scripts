#!/bin/bash

. ./switch_virtual_keyboard.sh

switch_virtual_keyboard /usr/share/applications/org.kde.plasma.keyboard.desktop

switch_input_method 2

display_osd_message 1
