include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx

// Safe math
// https://github.com/dapphub/ds-math/blob/master/src/math.sol
module Safe {



}

// module Lending {
//     import opened Number
//     import opened Math
//     function Proportion(num1: real, num2: real): bool
//         requires num2 != 0.0
//         ensures Proportion(num1, num2) == (num1 / num2 <= 0.8)
//     {
//         num1 / num2 <= 0.8
//     }
// }