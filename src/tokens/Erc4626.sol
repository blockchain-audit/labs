// SPDX-License-Identifier: MIT
pragma solidity >=0.5.11;

import "openzeppelin-tokens/ERC20/ERC20.sol";

contract ERC4626 is ERC20{

        mapping(address account => mapping(address spender => uint256)) private _allowances;

    event Deposit(address indexed caller , address indexed owner, uint assets,uint shares);

    event Withdraw(
        address indexed caller,
        address indexed reciver,
        address indexed owner,
        uint assets,
        uint shares
    );

    ERC20 public immutable asset;

    constructor (ERC20  _asset,string memory _name, string memory symbol)
    ERC20(_name,symbol){
        asset = _asset;
    }

    function depositByAsset(uint amountAsset, address receiver) public returns(uint shares){
        shares = previewDepositByAsset(amountAsset);
        require( shares  !=0,"zero_shares");

        asset.transferFrom(msg.sender,address(this),amountAsset);

        _mint(receiver, shares);

        emit Deposit(msg.sender,receiver,amountAsset,shares);
    }

    function depositByShares(uint amountShares, address receiver) public returns(uint amountAsset){
        amountAsset = previewDepositByShares(amountShares);

        asset.transferFrom(msg.sender,address(this),amountAsset);

        _mint(receiver, amountShares);

        emit Deposit(msg.sender,receiver, amountAsset,amountShares);
    }

    function withdrawByAsset(uint amountAsset,address receiver, address owner)public returns(uint amountShares){
        amountShares = previewWithdrawByAsset(amountAsset);

        if(msg.sender != owner){
            uint allowed = allowance(owner,msg.sender);

            if(allowed != type(uint).max)
                _allowances[owner][msg.sender] = allowed - amountShares;
        }

        _burn(owner,amountShares);

        emit Withdraw(msg.sender,receiver,owner,amountAsset, amountShares);

        asset.transfer(receiver,amountAsset);

    }


    function withdrawByShares(uint amountShares,address receiver,address owner)public returns(uint amountAsset){

        if(msg.sender != owner){

            uint allowed = allowance(owner,msg.sender);

            if(allowed != type(uint).max){
                _allowances[owner][msg.sender]-= amountShares;
            }

        }
        amountAsset = previewWithdrawByShares(amountShares);
        require(amountAsset != 0,"ZERO");

        _burn(owner,amountShares);
        
        emit Withdraw(msg.sender, receiver, owner, amountAsset, amountShares);

        asset.transfer(receiver,amountAsset);

    }

    function totalAsset () public view returns(uint){
        return asset.totalSupply();
    }

    function convertAssetToShares(uint amountAsset) public view returns(uint){
        if(totalSupply() == 0){
            return amountAsset;
        }
        return amountAsset * (totalSupply()  / totalAsset());
    }

    function convertSharesToAsset(uint amountShares) public view returns(uint){
        if(totalSupply() == 0){
            return amountShares;
        }
        return amountShares * (totalAsset()/totalSupply());
    }

    function previewDepositByAsset(uint amountAsset) public view returns(uint){
        return convertAssetToShares(amountAsset);
    }

    function previewDepositByShares(uint amountShares) public view returns(uint){
         if(totalSupply() == 0){
            return amountShares;
        }
        uint mod = amountShares * totalAsset() % totalSupply();
        return mod >0 ?1:0 + amountShares * totalAsset() / totalSupply();
    }

    function previewWithdrawByAsset(uint amountAsset)public view returns(uint){
          if(totalSupply() == 0){
            return amountAsset;
        }
        uint mod = amountAsset * totalSupply() % totalAsset();
        return mod >0 ?1:0 + amountAsset * totalSupply() / totalAsset();
    }

    function previewWithdrawByShares(uint amountShares) public view returns(uint){
        return convertSharesToAsset(amountShares);
    }

    function maxWithdrawByAsset(address owner) public view returns(uint){
        return convertSharesToAsset(balanceOf(owner));
    }

    function maxWithdrawByShares(address owner) public view returns(uint){
        return balanceOf(owner);
    }





}