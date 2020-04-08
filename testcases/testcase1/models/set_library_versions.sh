# This file is used by unit testing to specify library versions.
# Commands here should maintain alignment with the environment generated in 
# testing/Dockerfile.

# Set modelica library commits here
# =================================
IBPSA_COMMIT=master
BUILDINGS_COMMIT=master
# =================================

# Executes corresponding git checkout
cd $HOME/git/ibpsa/modelica-ibpsa && git checkout $IBPSA_COMMIT
cd $HOME/git/buildings/modelica-buildings && git checkout $BUILDINGS_COMMIT
