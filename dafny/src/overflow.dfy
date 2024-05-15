include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx






// we can step up 1 point in u256 universe
function hoare24c(x: u128) : (z: u256) {
    x as u256 + 1
}
