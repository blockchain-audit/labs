
include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx


class Friend {
    var protocolFeeDst: u160
    var protocolFeePer: u256
    var subjectsFeePer: u256

    var balance: map<u160, map<u160,u256>>
    var supply:  map<u160, u256>

    constructor() {
        protocolFeeDst := 1;
    }

    method setFeeDst(fee: u160) 
    modifies this {
        protocolFeeDst := fee;
    }

    method setProtocolFeePer(fee: u256) 
    modifies this {
        protocolFeePer := fee;
    }

    method setSubjectsFeePer(fee: u256) 
    modifies this {
        subjectsFeePer := fee;
    }

    method getPrice(supply: u256, amount: u256) returns (r: u256) {

        return 22;
    }



}
