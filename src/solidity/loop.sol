//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

contract Loop {
    function loop () public {
        for (uint i = 0; i < 10; i++)
        {
            if (i == 3){
                continue;
            }
            
            if (i == 5){
                break;
            }
        }

        uint j = 0;
        while(j < 10)
        {
            j++;
        }

    }
}