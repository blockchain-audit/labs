



// This method m takes a non-empty set of natural numbers (items) as input and returns a
// natural number (r). It retrieves and returns an arbitrary element from the set items.
// |items| denotes the cardinality of the set, which represents the number of elements in the set.
method m(items: set<nat>) returns (r:nat)
requires |items| > 0 {
    var item :| item in items;
    return item;
}


function m2(s: set<int>) : (z:int)
  requires s != {}  {
  has_minimum(s);
  var z :| z in s && forall y :: y in s ==> z <= y;
  z
}

lemma has_minimum(s: set<int>)
  requires s != {}
  ensures exists z :: z in s && forall y :: y in s ==> z <= y {
  var z :| z in s;
  if s == {z} {
    // the mimimum of a singleton set is its only element
  } else if forall y :: y in s ==> z <= y {
    // we happened to pick the minimum of s
  } else {
    // s-{z} is a smaller, nonempty set and it has a minimum
    var s' := s - {z};
    has_minimum(s');
    var z' :| z' in s' && forall y :: y in s' ==> z' <= y;
    // the minimum of s' is the same as the miminum of s
    forall y | y in s
      ensures z' <= y {
      if
      case y in s' =>
        assert z' <= y;  // because z' in minimum in s'
      case y == z =>
        var k :| k in s && k < z;  // because z is not minimum in s
        assert k in s';  // because k != z
    }
  }
}
