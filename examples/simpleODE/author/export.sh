#!/bin/bash
set -e
jm_ipython.sh export.py
mv TestOverWrite_ExportedModel.fmu ../simulate/
