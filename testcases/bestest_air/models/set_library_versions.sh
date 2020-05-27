# This file is used by unit testing to specify library versions.
# Commands here should maintain alignment with the environment generated in 
# testing/Dockerfile.

# Set modelica library commits here
# =================================
IBPSA_COMMIT=20348095e407933816a90d5beff307ac1d491887
BUILDINGS_COMMIT=a31228ee424e954ac59d4a12e26a21d732c11c30
# =================================

# Executes corresponding git checkout
cd $MODELICAPATH/IBPSA && git checkout $IBPSA_COMMIT
cd $MODELICAPATH/Buildings && git checkout $BUILDINGS_COMMIT
