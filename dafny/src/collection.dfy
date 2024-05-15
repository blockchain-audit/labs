// https://www.cse.unsw.edu.au/~se2011/DafnyDocumentation/Dafny%20-%20Sets.pdf
// https://dafny.org/dafny/OnlineTutorial/ValueTypes
// https://www.cse.unsw.edu.au/~anymeyer/2011/lectures/SetsSequences.pdf

include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"



// in general, sets can be of almost any type, including objects.
// Concrete sets can be specified by using display notation
method simple() {
    var s1: set<int> := {};

    var s2 := {1, 2, 3};
    assert s2 == {1,1,2,2,3,3,3,1}; // must have 1,2,3
    assert s2 != {1,1,2,2,3,3,3,4}; // has also 4
    assert s2 != {0,1,2,2,3,3,3,3}; // has also 0

    var s3, s4 := {1,2}, {1,4};
}


// two sets are equal if they have exactly the same elements, new sets can
// be created from existing ones using the common set operations
method joins() {
    var s1 : set<int> := {};
    var s2 := {1,2,3};
    var s3 := {1,2};
    var s4 := {3,4};

    assert s2 + s4 == {1,2,3,4};  // union
    assert s2 * s3 == {1,2};      // intersection
    assert s2 * s4 == {3};        // intersection
    assert s2 - s3 == {3};        // diffference
    assert s2 - s4 == {1,2};      // difference
}

// note that because sets can only contain at most one of each element,
// the union does not count repeated elements more than once.
// These operators will result in a finite set if both operands are finite,
// so they cannot generate an infinite set. Unlike the arithmetic operators,
// the set operators are always defined. In addition to set forming operators,
// there are comparison operators with their usual meanings:
method comparison() {
    // subset
    assert {1}     <= {1,2};
    assert {1,2}   <= {1,2};
    assert {1,1}   <= {1,2};
    assert {1}     <= {1,2,3,4};
    assert {1,2,3} <= {1,2,3,4,5};

    // strict
    assert {}      < {1,2};
    assert {1,2}   < {1,2,3,4};
    assert {2,1}   < {0,1,2,3,4};
    assert !({2,1} < {0,1,3,4});
    assert !({1}   < {1,1});

    // not subsets
    assert !({1,2} <= {1,4});
    assert !({1,4} <= {1});

    // equality
    assert {1,2} == {1,2};

    // non-equality
    assert {1,3} != {1,2};
}


method membership() {
    assert 5 in {1,2,3,4,5};
    assert 1 in {1,2,3,4,5};
    assert 2 !in {1,3,4,5};
    assert forall x: int :: x !in {};
    assert exists x: int :: x !in {};
}


method lenght() {
    var a: set<int> := {1,2,3,4};
    var b: set<int> := {4,3,2,1,1,2,3,4};
    assert |a| == |b| == 4;   // same length
    assert a - b == {};       // same sets
}


// This defines a set in a manner reminiscent of a universal quantifier
// (forall). As with quantifiers, the type can usually be inferred.
// In contrast to quantifiers, the bar syntax (|) is required to separate
// the predicate (p) from the bound variable (x). The type of the elements
// of the resulting set is the type of the return value of f(x).
// The values in the constructed set are the return values of f(x): x
// itself acts only as a bridge between the predicate p and the function f.
// It usually has the same type as the resulting set, but it does not need to.

method comprehension() {
    assert (set x | x in {0,1,2} :: x + 0) == {0,1,2};
    assert (set x | x in {0,1,2,3,4,5} && x < 3) == {0,1,2};
    assert (set x | x in {0,1,2,3,4,5} && x < 2) == {0,1};
    assert (set x | x in {0,1,2,3,4,5} && x > 9) == {};
    // assert (set x | x in {0,1,2} :: x * 1) == {0,1,2}; // potential infinite set
}

