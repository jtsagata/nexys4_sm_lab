#!/bin/bash

PFILE='sm_top.bit'

djtgcfg init -d Nexys4
djtgcfg prog -d Nexys4 -i 0 -f ../${PFILE}

