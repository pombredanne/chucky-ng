#!/bin/bash

source chucky/chucky.conf

#
# Anomaly detection (prints anomaly score for each neighbor function)
#
python/anomaly-score.py -e -d $FUNCTIONS_DIR -f $FUNCTIONS_DIR/TOC