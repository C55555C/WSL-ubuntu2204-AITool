#!/bin/bash
function print_print_info()  { echo -e "\033[1;34m[INFO]\033[0m $1"; }
function print_warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
function print_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }
function print_ok()    { echo -e "\033[1;32m[OK]\033[0m $1"; }
