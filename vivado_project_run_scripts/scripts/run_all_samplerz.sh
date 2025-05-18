#!/bin/bash

PROJECT_FILE=$1
NUM_JOBS=$2

vivado -mode batch -source run_all_samplerz_zusp.tcl -tclargs "$PROJECT_FILE" "$NUM_JOBS"
