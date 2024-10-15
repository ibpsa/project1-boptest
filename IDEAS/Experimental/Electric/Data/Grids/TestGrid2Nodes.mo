within IDEAS.Experimental.Electric.Data.Grids;
record TestGrid2Nodes "2 Node test grid"
  /*
   Simple 2 nodes grid to test components easily.
 */

  extends IDEAS.Experimental.Electric.Data.Interfaces.GridType(
    nNodes=2,
    nodeMatrix={{-1,0},{1,-1}},
    LenVec={0,48},
    CabTyp={Cables.PvcAl35(),Cables.PvcAl35()});
end TestGrid2Nodes;
