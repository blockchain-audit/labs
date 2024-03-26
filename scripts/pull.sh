#!/bin/bash


find . -type d -name .git -execdir git pull \;
