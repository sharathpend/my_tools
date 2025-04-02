#!/bin/bash

# $1 is the .runs folder in Vivado Project

for d in $1/impl_*/; do
    echo "=== $d ==="
    grep -A 7 "Design Timing Summary" "$d"/*timing_summary_routed.rpt 2>/dev/null
done > output_file.txt

