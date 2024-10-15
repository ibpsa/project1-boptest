within IDEAS.Experimental.Electric.Data.Grids.DirectCurrent;
record TestGrid2Nodes "2 Node test grid"
 /*
   Simple 2 nodes grid to test components easily.
 */

   extends Interfaces.DirectCurrent.GridType(
    nNodes=2,
    nodeMatrix=[-1,0; 1,-1],
    LenVec={0,48},
    CabTyp={Cables.DirectCurrent.PvcAl35(),Cables.DirectCurrent.PvcAl35()});
end TestGrid2Nodes;
