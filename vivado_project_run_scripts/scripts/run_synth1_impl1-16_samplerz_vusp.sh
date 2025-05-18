#!/bin/bash

PROJECT_FILE=$1
NUM_JOBS=$2

vivado -mode batch -source run_synth1_impl1-16_vusp.tcl -tclargs "$PROJECT_FILE" "$NUM_JOBS"

