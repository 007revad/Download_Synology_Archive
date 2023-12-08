#!/usr/bin/env bash
#--------------------------------------------------------------------
# Forked from https://github.com/stopforumspam/download-synology-dsm
#--------------------------------------------------------------------
# https://github.com/007revad/Download_Synology_Archive
#
# Checked with https://shellcheck.net/
#
# Script to select arguments for clone.php
#--------------------------------------------------------------------

# Set location of get_urls.php
php_urls="/volume1/scripts/get_urls.php"

# Set location of clone.php
php_script="/volume1/scripts/clone.php"

# Set location to save clone.php log
php_log="/volume1/downloads/archive.synology.com/clone_$(date '+%Y%m%d-%H%M').log"


#--------------------------------------------------------------------

echo -e "Synology Archive Clone \n"

check_file_exists() { 
    if [[ ! -f "$1" ]]; then
        echo -e "ERROR! File missing: \n$1"; exit 2
    elif [[ ! -x "$1" ]]; then
        echo -e "ERROR! File not executable: \n$1"; exit 13
    fi
}

check_file_exists "$php_urls"
check_file_exists "$php_script"

log_path=$(dirname -- "$php_log")
if [[ ! -d "$log_path" ]]; then
    echo -e "WARNING Log directory not found: \n$log_path"
    echo -e "Skipping logging \n"; php_log=""
fi

urls_to_array() { 
    num=2
    while [[ $num -lt $((qty +1)) ]]; do
        item=$(echo "$urls" | cut -d"\"" -f$num)
        #echo "$item"  # debug
        typelist+=("$item")
        num=$((num +2))
    done
}

array_qty() { 
    qty=$(echo "$urls" | grep -o '"' | wc -l)  # Qty of " in string
    if [[ $1 != "NoAll" ]]; then
        if [[ $qty -gt "2" ]]; then
            typelist=( "All" )
        else
            typelist=()
        fi
    fi
}

# Get array of source directories
urls=$(php "$php_urls" "")
array_qty NoAll
urls_to_array

# Choose source directory
PS3="Choose download type: "
select srcdir in "${typelist[@]}"; do
    urls=$(php "$php_urls" "$srcdir")
    array_qty
    urls_to_array
    break
done
echo -e "You selected: $srcdir \n"

# Choose sub directory
PS3="Choose $srcdir type: "
select subdir in "${typelist[@]}"; do
    type="$subdir"
    break
done
echo -e "You selected: $type \n"

# Run clone.php
if [[ -n $srcdir ]] && [[ -n $type ]]; then
    if [[ -n $php_log ]]; then
        php "$php_script" "$srcdir" "$type" 2>&1 | tee "$php_log"
    else
        php "$php_script" "$srcdir" "$type"
    fi
else
    echo "args empty!"  # debug
    exit 1              # debug
fi

exit

