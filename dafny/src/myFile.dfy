include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


method met () returns (set2:set<int> , arr:array<int>)
ensures set2 == {1,2,3}{

    var set1 := {1,2,3};

    // set2 :set<int>;
    set2 := {1,1,2,3};

    // var arr : array<int>;
    arr := new[3][1,2,3];
    
}