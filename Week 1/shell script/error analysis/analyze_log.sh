#!/bin/bash

# File to analyze
logfile="error_log.log"

echo "Analyzing log file: $logfile"

# Count occurrences of each log level
echo "Count of ERRORs:"
grep -c 'ERROR' $logfile

echo "Count of WARNINGs:"
grep -c 'WARNING' $logfile

echo "Count of INFOs:"
grep -c 'INFO' $logfile

# List ERROR messages
echo "List of ERROR messages:"
grep 'ERROR' $logfile
