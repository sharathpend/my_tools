#!/bin/bash

# Author: Sharath Pendyala - spendya@ncsu.edu - sharathpawan@gmail.com
VERSION='1.0'

# $1 is the .runs folder in Vivado Project

# If no argument is given, display usage
if [ $# -eq 0 ]; then
    echo "Usage: $0 <path_to_runs_folder>"
    exit 1
fi

# If more than one argument is given, display usage
if [ $# -gt 1 ]; then
    echo "Usage: $0 <path_to_runs_folder>"
    exit 1
fi

# Check if the argument is a directory
if [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory."
    exit 1
fi

for d in $1/impl_*/; do
    echo "=== $d (Post Route Phys Opt) ==="
    grep -A 7 "Design Timing Summary" "$d"/*timing_summary_postroute_physopted.rpt 2>/dev/null
done > extracted_timing_summary_postroute_phyopt.txt

for d in $1/impl_*/; do
    echo "=== $d (Routed) ==="
    grep -A 7 "Design Timing Summary" "$d"/*timing_summary_routed.rpt 2>/dev/null
done > extracted_timing_summary_routed.txt

