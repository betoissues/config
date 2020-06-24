#!/bin/sh

[ -f ~/.zprofile ] && . ~/.zprofile
exec startplasma-x11
