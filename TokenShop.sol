// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IERC20Minter {
    function mint(address account, uint256 amount) external;
}

contract TokenShopEth {

    IERC20Minter public token;
    uint256 public tokenPrice = 1000000000000000; //in wei, 1 token = 0.001 ETH
    address public owner;
   
    constructor(address tokenAddress) {
        token = IERC20Minter(tokenAddress);
        owner = msg.sender;
    }

    function tokenAmount(uint256 amountETH) public view returns (uint256) {
        uint256 amountToken = amountETH / tokenPrice * 10**(2);  // 2 decimal places from token
        return amountToken;
    }

    receive() external payable {
        uint256 amountToken = tokenAmount(msg.value);
        token.mint(msg.sender, amountToken);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _;
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
   
}