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

    // implicity
    var b := 3;
    var c := '2';
    var d := Fun();
    assert Fun() == 3;


    var j := [1, 3, 4];
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
