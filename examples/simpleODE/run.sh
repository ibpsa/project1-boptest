#!/bin/bash
set -e
cd author
echo "Exporting fmu"
./export.sh
cd ../simulate
echo "Simulating fmu"
./simulate.sh
