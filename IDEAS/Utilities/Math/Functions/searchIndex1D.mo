within IDEAS.Utilities.Math.Functions;
function searchIndex1D
  "Find the index value i in a vector x for the desired abscissa a so that x[i] < a < x[i+1]"
  input Real x[:]
    "Abscissa table vector (strict monotonically increasing values required)";
  input Real xi "Desired abscissa value";
  input Integer iLast=1 "Index used in last search";
  input Boolean ensureMonotonicity=false
    "chech that the vector x is strict monotonically increasing)";
  output Real test;
  output Integer iNew=1 "xi is in the interval x[iNew] <= xi < x[iNew+1]";
protected
  Integer i;
  Integer nx=size(x, 1);
algorithm
  assert(nx > 0, "The table vectors must have at least 1 entry.");
  if ensureMonotonicity then
    assert(isMonotonic(x),  "The input vector x should be monotomic");
  end if;
  if nx == 1 then
    i:=1;
  else
    // Search interval
    i := min(max(iLast, 1), nx - 1);
    if xi >= x[i] then
      // search forward
      while i < nx and xi >= x[i] loop
        i := i + 1;
      end while;
      i := i - 1;
    else
      // search backward
      while i > 1 and xi < x[i] loop
        i := i - 1;
      end while;
    end if;
    iNew := i;
  end if;
  test :=i;

end searchIndex1D;
