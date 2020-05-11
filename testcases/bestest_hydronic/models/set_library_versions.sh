# This file is used by unit testing to specify library versions.
# Commands here should maintain alignment with the environment generated in 
# testing/Dockerfile.

# Set modelica library commits here
# =================================
IDEAS_COMMIT=master
# =================================

# Executes corresponding git checkout
cd $MODELICAPATH/IDEAS && git checkout $IDEAS_COMMIT
