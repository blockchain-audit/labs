// https://www.cse.unsw.edu.au/~se2011/DafnyDocumentation/Dafny%20-%20Sets.pdf
// https://dafny.org/dafny/OnlineTutorial/ValueTypes
// https://www.cse.unsw.edu.au/~anymeyer/2011/lectures/SetsSequences.pdf

include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"




method Types() 
ensures Fun() == 3 {
    // explicity type declaration
    var x: int;
    x := 99;

    var a: bool;
    a := true;

    var j1: array<int>;
    j1 := new int[3][1,2,3];

    // implicity
    var b := 3;
    var c := '2';
    var d := Fun();
    var j0 := [1, 3, 4];
    assert Fun() == 3;
}


function Fun2() : int 
requires 3 == Fun(){
    9
}

function Fun() : int {
    3
}

method Met() returns (x: int) {
    return 3;
}
