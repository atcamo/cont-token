// SPDX-License-Identifier: None
pragma solidity 0.8.21;

contract UserCrudString {

  struct UserStruct {
    string userEmail;
    uint userAge;
    uint index;
  } 
  mapping(address => UserStruct) private userStructs;
  address[] private userIndex;

  event LogNewUser   (address indexed userAddress, uint index, string userEmail, uint userAge);
  event LogUpdateUser(address indexed userAddress, uint index, string userEmail, uint userAge);
  event LogDeleteUser(address indexed userAddress, uint index);

  function isUser(address userAddress) public view returns(bool isIndeed) 
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].index] == userAddress);
  }

  function insertUser(
    address userAddress, 
    string memory userEmail, 
    uint    userAge) 
    external 
    returns(uint index)
  {
    require(!isUser(userAddress), "Already exists");
    userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].userAge   = userAge;
    userIndex.push(userAddress);
    userStructs[userAddress].index     = userIndex.length-1;
    emit LogNewUser(
        userAddress, 
        userStructs[userAddress].index, 
        userEmail, 
        userAge);
    return userIndex.length-1;
  }
  
  function getUser(address userAddress) external view
    returns(string memory userEmail, uint userAge, uint index)
  {
    require(isUser(userAddress), "User not found");
    return(
      userStructs[userAddress].userEmail, 
      userStructs[userAddress].userAge, 
      userStructs[userAddress].index);
  }
  
  function updateUserEmail(address userAddress, string memory userEmail) 
    external
    returns(bool success) 
  {
    require(isUser(userAddress), "User not found");
    userStructs[userAddress].userEmail = userEmail;
    emit LogUpdateUser(
      userAddress, 
      userStructs[userAddress].index,
      userEmail, 
      userStructs[userAddress].userAge);
    success = true;
    return success;
  }
  
  function updateUserAge(address userAddress, uint userAge) 
    external
    returns(bool success) 
  {
    require(isUser(userAddress), "User not found");
    userStructs[userAddress].userAge = userAge;
    emit LogUpdateUser(
      userAddress, 
      userStructs[userAddress].index,
      userStructs[userAddress].userEmail, 
      userAge);
    return true;
  }

function deleteUser(address userAddress) 
    external 
    returns(uint index)
  {
    require(isUser(userAddress), "User not found");
    uint rowToDelete = userStructs[userAddress].index;
    address keyToMove = userIndex[userIndex.length-1];
    userIndex[rowToDelete] = keyToMove;
    userStructs[keyToMove].index = rowToDelete; 
    userIndex.pop();
    emit LogDeleteUser(userAddress, rowToDelete);
    emit LogUpdateUser(keyToMove, rowToDelete, 
        userStructs[keyToMove].userEmail, 
        userStructs[keyToMove].userAge);
    return rowToDelete;
  }  

  function getUserCount() external view returns(uint count)
  {
    return userIndex.length;
  }

  function getUserAtIndex(uint index) external view returns(address userAddress)
  {
    return userIndex[index];
  }

}