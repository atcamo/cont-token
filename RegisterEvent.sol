// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
 
contract RegisterEvent {
    string private storedInfo;

    event InfoChange(string oldInfo, string newInfo);

    function setInfo(string memory myInfo) external {
        emit InfoChange (storedInfo, myInfo);
        storedInfo = myInfo;
    }

    function getInfo() external view returns (string memory) {
        return storedInfo;
    }
}