#!/bin/bash

pushd ..
/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/xtclsh src/StateMachine.tcl run_process
popd

./upload.sh
