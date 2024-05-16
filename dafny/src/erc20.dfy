
include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx


class ERC20 {
    // a 160-bit unsigned integer that uniquely identifies the address. However,
    // this value is not directly used as the external representation, that is in u256
    var balances:  mapping<u160,u256>
    var allowance: mapping<u160, mapping<u160,u256>>

    constructor() {
        balances := Map(map[], 0);
        allowance := Map(map[], Map(map[],0));
    }

    method fallback(msg: Transaction) returns (r: Result<()>)
    modifies this`balances {
        r := deposit(msg);
    }

    // allow users to deposit tokens into their account, updating their balances.
    // in dafny, the modifies clause is used to specify which state components a
    // method can change. This is part of Dafny's support for formal verification,
    // ensuring that methods only modify the state in ways that are explicitly allowed.
    // we assume that the current balance of the sender (msg.sender) plus the value
    // being deposited does not exceed the max value of a u256 type as a safety check
    // to prevent overflow.
    method deposit(msg: Transaction) returns (r: Result<()>)
    modifies this`balances {
        assume {:axiom} (MAX_U256 as u256 - balances.Get(msg.sender)) >= msg.value;
        balances := balances.Set(msg.sender, balances.Get(msg.sender) + msg.value);
        return Ok(());
    }

    // allow users to withdraw tokens into their account, updating their balances.
    method withdraw(msg: Transaction, wad: u256) returns (r: Result<()>)
    modifies this`balances
    requires msg.value == 0 {
        if balances.Get(msg.sender) < wad { return Revert; }
        balances := balances.Set(msg.sender, balances.Get(msg.sender) - wad);

        var executed := Tx.transfer(msg.sender, wad);
        if executed == Revert { return Revert; }

        return Ok(());
    }

    method approve(msg: Transaction, guy: u160, wad: u256) returns (r: Result<bool>)
    modifies this`allowance {
        var a := allowance.Get(msg.sender).Set(guy, wad);
        allowance := allowance.Set(msg.sender, a);
        return Ok(true);
    }

    method transfer(msg: Transaction, dst: u160, wad: u256) returns (r: Result<bool>)
    modifies this`balances
    modifies this`allowance
    requires this.balances.default == 0
    requires msg.sender in balances.Keys()
    requires dst in balances.Keys()
    requires msg.value == 0 {  // non-payable
        r := transferFrom(msg, msg.sender, dst, wad);
    }


    // instead of assuming I added a dst_bal require
    // assume (old(balanceOf).Get(dst) as nat) + (wad as nat) <= MAX_U256;
    // safe, once wad is bounded by balances[src]
    method transferFrom(msg: Transaction, src: u160, dst: u160, wad: u256) returns (r: Result<bool>)
    modifies this`balances, this`allowance
    requires this.balances.default == 0
    requires src in balances.Keys() && dst in balances.Keys()
    requires msg.value == 0
    ensures r != Revert ==> sum(old(this.balances.Items())) == sum(this.balances.Items()) {
        assume {:axiom} (old(balances).Get(dst) as nat) + (wad as nat) <= MAX_U256;
        if balances.Get(src) < wad { return Revert; }

        if src != msg.sender && allowance.Get(src).Get(msg.sender) != (MAX_U256 as u256) {
            if allowance.Get(src).Get(msg.sender) < wad { return Revert; }
            var a := allowance.Get(src);
            allowance := allowance.Set(src,a.Set(msg.sender, a.Get(msg.sender) -wad));
        }

        // accounting
        balances := balances.Set(src, balances.Get(src) - wad);
        balances := balances.Set(dst, balances.Get(dst) + wad);

        validate_transfer(old(balances), balances, src, dst, wad);

        r := Result<bool>.Ok(true);

    }

    lemma validate_transfer(prior: mapping<u160,u256>, after: mapping<u160,u256>, src: u160, dst: u160, wad: u256)
    requires prior.Get(src) >= wad                              // enough bal
    requires (prior.Get(dst) as nat + wad as nat) <= MAX_U256   // memory space to transfer
    requires after.data[src := 0][dst := 0] == prior.data[src := 0][dst := 0] // only mod src/dst
    requires {src,dst} <= prior.Keys() && prior.Keys() == after.Keys()  // min diff in keys
    requires (dst == src) || prior.data[src] - wad == after.data[src]   // src acc decreased
    requires (dst == src) || prior.data[dst] + wad == after.data[dst]   // dst acc increased
    requires (dst != src) || after == prior
    ensures sum(prior.Items()) == sum(after.Items()) {
        var b1 := (src, prior.data[src]);
        var b2 := (dst, prior.data[dst]);
        var a1 := (src, after.data[src]);
        var a2 := (dst, after.data[dst]);
        if dst == src {
            // there are cases it will crash
        } else {
            var b_base := prior.Items() - {b1,b2};
            var a_base := after.Items() - {a1,a2};
            // fixme: why assumtion here?
            assume a_base == b_base;
            // base case
            set_as_union(b1,b2);
            set_as_union(a1,a2);
            assert sum({b1,b2}) == sum({a1,a2});
            assert prior.Items() == b_base + {b1,b2};
            assert after.Items() == b_base + {a1,a2};
            union_sum_as_units(b_base, {b1,b2});
            union_sum_as_units(b_base, {a1,a2});
        }
    }


    // recursive ghost function that calculates the sum of the second elements of all tuples
    // in a given set. It uses pattern matching to extract elements from the set and
    // recursively processes the remaining elements until the set is empty.
    // :| operator, which is a form of pattern matching in Dafny. This operator allows
    // you to destructure the set and extract an element.
    ghost function sum(m:set<(u160,u256)>) : nat {
        if m == {} then 0               // stop recursive calls
        else
            var pair :| pair in m;      // selects a tuple 'pair' from 'm' pattern matching
            var rhs  := pair.1 as nat;  // extract and cast the second element from the 'pair'
            rhs + sum(m -{pair})        // recursive call with the updated set m - {pair},
                                        // which removes the selected tuple from the set,
    }                                   // and adds the casted value to the result of the recursive call



    // Prove that the sum of the elements in the union of two sets is equal
    // to the sum of the elements in each set individually. Example:
    // s1 contains the elements { (1, 2), (3, 4) }
    // s2 contains the elements { (5, 6), (7, 8) }
    // union of s1 and s2 is { (1, 2), (3, 4), (5, 6), (7, 8) }
    // sum of the second elements of s1 is 2 + 4 = 6
    // sum of the second elements of s2 is 6 + 8 = 14
    // sum of the second elements of the union is 6 + 14 = 20
    // so the lemma states that sum(s1 + s2) == sum(s1) + sum(s2),
    // which is 20 == 6 + 14, and this is true.
    lemma set_as_union(p1: (u160,u256), p2: (u160,u256))
    ensures sum({p1,p2}) == (p1.1 as nat) + (p2.1 as nat) {
        union_sum_as_units({p1},{p2});  // compare the sum of sets with individual tuples.
        assert {p1,p2} == {p1} + {p2};  // asserts that creating a set with p1 and p2 is equivalent to the union of sets {p1} and {p2}.
    }

    // Prove a property about the sum of elements in two sets of tuples, where each tuple
    // contains a u160 and a u256, it ensures that the sum of the elements in the union
    // of two sets (s1 and s2) is equal to the sum of the elements in each set individually. Ex:
    // s1 - contains the tuples: {(1, 2), (3, 4)}
    // s2 - contains the tuples: {(5, 6), (7, 8)}
    // the lemma states that the sum of the elements in the union of s1 and s2
    // is equal to the sum of the elements in each set individually.
    // let's calculate the sum of the elements in s1 and s2 individually:
    // sum of s1: 2 + 4 = 6
    // sum of s2: 6 + 8 = 14
    // let's calculate the sum of the elements in the union of s1 and s2:
    // union of s1 and s2: {(1, 2), (3, 4), (5, 6), (7, 8)}
    // sum of the union: 2 + 4 + 6 + 8 = 20
    // according to the lemma, the sum of the elements in the union of s1 and s2 should be equal
    // to the sum of the elements in each set individually. In this case:
    // sum of s1 + sum of s2 = 6 + 14 = 20
    // this matches the sum of the elements in the union of s1 and s2, demonstrating that
    // this lemma holds true for this example.
    lemma union_sum_as_units(s1: set<(u160, u256)>, s2: set<(u160, u256)>)
    ensures sum(s1 + s2) == sum(s1) + sum(s2) {
        if s1 == {} {
            assert sum({}) == 0;                 // base case: if s1 is an empty set, its sum is 0.
            assert sum(s1 + s2) == sum({} + s2); // the sum of s1 union s2 is the same as the sum of an empty set union s2.
            assert {}+s2 == s2;                  // the union of an empty set with s2 is simply s2.
            assert sum(s1 + s2) == sum(s2);      // hence, sum of s1 + s2 is the same as the sum of s2, given s1 is empty.
        } else {
            assume {:axiom} sum(s1 + s2) == sum(s1) + sum(s2); // for non-empty s1, it is assumed (without proof)
        }                                             // that the sum of the union is the sum of individual sets.
    }

}

