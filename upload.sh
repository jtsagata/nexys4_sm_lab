#!/bin/bash

djtgcfg init -d Nexys4
djtgcfg prog -d Nexys4 -i 0 -f ../sm_top.bit

