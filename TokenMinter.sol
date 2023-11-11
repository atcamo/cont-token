// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IERC20Minter {
    function mint(address account, uint256 amount) external;
}

contract TokenMinter {  
    IERC20Minter public token;
   
    constructor(address tokenAddress) {
        token = IERC20Minter(tokenAddress);
    }
 
    function mint(address account, uint256 amount) public {
        token.mint(account, amount);
    }
}