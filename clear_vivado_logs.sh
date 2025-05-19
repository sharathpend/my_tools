#!/bin/sh

# Additional cleanup if -a flag is specified
if [ "$1" = "-a" ]; then
    echo "Performing extended cleanup..."
    find . -name "*vivado*.log" -type f -delete
    find . -name "*vivado*.jou" -type f -delete
else
    echo "Performing standard cleanup..."
    find . -name "*vivado_*.log" -type f -delete
    find . -name "*vivado_*.jou" -type f -delete
fi

# Default cleanup
find . -name "*vivado_*.str" -type f -delete
find . -name "*vivado_*.debug" -type f -delete
