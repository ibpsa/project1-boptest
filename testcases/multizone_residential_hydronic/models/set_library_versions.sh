# This file is used by unit testing to specify library versions.
# Commands here should maintain alignment with the environment generated in 
# testing/Dockerfile.

# Set modelica library commits here
# =================================
IBPSA_COMMIT=master
BUILDINGS_COMMIT=v6.0.0
# =================================

# Executes corresponding git checkout
cd $MODELICAPATH/IBPSA && git checkout $IBPSA_COMMIT
cd $MODELICAPATH/Buildings && git checkout $BUILDINGS_COMMIT
