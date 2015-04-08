#/bin/bash
SPECIFIED_HASHSIZE=$1
CURRENT_HASHSIZE=`cat /sys/module/nf_conntrack/parameters/hashsize`

if [ "$CURRENT_HASHSIZE" != "$SPECIFIED_HASHSIZE" ]; then
    echo "$SPECIFIED_HASHSIZE" > /sys/module/nf_conntrack/parameters/hashsize;
    echo 'CHANGED';
else
    echo 'NO CHANGE';
fi
