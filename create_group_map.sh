#!/bin/bash

RTMP=$$

FILTERED=filtered_groups.${RTMP}
FORMATTED=formatted_groups.${RTMP}

./get_filtered_groups.sh|sort > ${FILTERED}
./get_formatted_groups.sh|sort >  ${FORMATTED}

paste ${FILTERED} ${FORMATTED} | awk -e '{print $1,$2}' | tr ' ' ':'

rm ${FILTERED}
rm ${FORMATTED}
