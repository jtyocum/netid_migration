#!/bin/bash
./get_filtered_groups.sh | tr '[:upper:]' '[:lower:]'| tr '_' '-'
