#!/usr/bin/env bash

sed -i.bak -E '/.mojang.com/d' /etc/hosts
echo "Alt Dispenser alt authentication should now have been disabled."