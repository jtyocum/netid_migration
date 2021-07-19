#!/bin/bash

cat ${1} | sed 's/:/:uw_sph_deohs_netid_/' | awk -v 'FS=:' -v 'OFS=:' '{print $2,$1}' | sed 's/:/: /'
