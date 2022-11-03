#!/bin/bash

pkill polybar
polybar -c $HOME/.config/polybar/config.ini -r mainbar
