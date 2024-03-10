module Math {

    function max(x: nat, y: nat) : nat {
        if x > y then x
                 else y
    }

    function {:opaque} power2(n: nat) : nat
    ensures power2(n) >= 1
    ensures n >= 1 ==> power2(n) >= 2
    decreases n {
        if n == 0 then 1 else 2 * power2(n - 1)
    }



    // (2^n) * (2^n) == 2 ^(n + 1)
    // 2 * 2^n == 2^n * 2 == 2^(n + 1)
    lemma {:induction n} {:opaque} power2Lemmas(n : nat)
    ensures power2(n) + power2(n) == power2(n + 1)
    ensures 2 * power2(n) == power2(n) * 2 == power2(n + 1) {
        reveal_power2();
    }


    // 2^(n + 1) / 2 == 2^n
    lemma {:induction n} power2Div2(n: nat)
    requires n >= 1
    ensures power2(n) / 2 == power2(n - 1) {
        reveal_power2();
    }


}
