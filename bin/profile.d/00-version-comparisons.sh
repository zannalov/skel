#!/bin/sh

function _get_version_part {
    local part="$1";
    shift 1;
    echo "$@" | awk -F. '{ printf( "%d\n" , $'"$part"' ); }';
}

function _version_compare_parts {
    local less_than_return="$1";
    local greater_than_return="$2";
    local equal_return="$3";
    local version_number_1="$4";
    local version_number_2="$5";

    if [ "$( _get_version_part 1 "$version_number_1" )" -lt "$( _get_version_part 1 "$version_number_2" )" ]; then return "$less_than_return"    ; fi
    if [ "$( _get_version_part 1 "$version_number_1" )" -gt "$( _get_version_part 1 "$version_number_2" )" ]; then return "$greater_than_return" ; fi
    if [ "$( _get_version_part 2 "$version_number_1" )" -lt "$( _get_version_part 2 "$version_number_2" )" ]; then return "$less_than_return"    ; fi
    if [ "$( _get_version_part 2 "$version_number_1" )" -gt "$( _get_version_part 2 "$version_number_2" )" ]; then return "$greater_than_return" ; fi
    if [ "$( _get_version_part 3 "$version_number_1" )" -lt "$( _get_version_part 3 "$version_number_2" )" ]; then return "$less_than_return"    ; fi
    if [ "$( _get_version_part 3 "$version_number_1" )" -gt "$( _get_version_part 3 "$version_number_2" )" ]; then return "$greater_than_return" ; fi
    if [ "$( _get_version_part 4 "$version_number_1" )" -lt "$( _get_version_part 4 "$version_number_2" )" ]; then return "$less_than_return"    ; fi
    if [ "$( _get_version_part 4 "$version_number_1" )" -gt "$( _get_version_part 4 "$version_number_2" )" ]; then return "$greater_than_return" ; fi
    if [ "$( _get_version_part 5 "$version_number_1" )" -lt "$( _get_version_part 5 "$version_number_2" )" ]; then return "$less_than_return"    ; fi
    if [ "$( _get_version_part 5 "$version_number_1" )" -gt "$( _get_version_part 5 "$version_number_2" )" ]; then return "$greater_than_return" ; fi
    return "$equal_return";
}

# Note: Returns are in bash return expectations, so ZERO is TRUE and ONE is FALSE
function _version_eq  { _version_compare_parts 1 1 0 "$1" "$2"; return $?; }
function _version_neq { _version_compare_parts 0 0 1 "$1" "$2"; return $?; }
function _version_gt  { _version_compare_parts 1 0 1 "$1" "$2"; return $?; }
function _version_gte { _version_compare_parts 1 0 0 "$1" "$2"; return $?; }
function _version_lt  { _version_compare_parts 0 1 1 "$1" "$2"; return $?; }
function _version_lte { _version_compare_parts 0 1 0 "$1" "$2"; return $?; }
