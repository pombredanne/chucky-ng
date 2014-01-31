#!/bin/bash

source chucky/chucky.conf

if [ ! -f "$NEIGHBORS_FILE" ]; then
    printf 'No neighbors file found.\n'
    printf 'Run chucky/neighborhood-detection.sh first.\n'
    printf 'Exiting now.\n'
    exit 1
fi

if [ -d "$TAINT_DIR" ]; then
    printf 'Tainting data already exists.\n'
    printf 'Exiting now.\n'
    exit 1
fi

#
# Lightweight tainting
#
cat $NEIGHBORS_FILE | \
awk -v s=$SYMBOL '{
	printf("queryNodeIndex(\047%s AND code:%s AND type:Symbol\047).taint()\n",$1,s)
}' | \
python/query.py -a functionId code | \
awk 'BEGIN {FS=OFS="\t"} { split($2,a,":"); split($3,b,":"); print a[2], b[2] }' | \
demux.py --outputDir $TAINT_DIR
