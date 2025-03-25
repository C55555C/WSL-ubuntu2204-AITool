#!/bin/bash
function info()  { echo -e "\033[1;34m[INFO]\033[0m $1"; }
function warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
function error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }
function ok()    { echo -e "\033[1;32m[OK]\033[0m $1"; }
