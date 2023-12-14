// SPDX-License-Identifier: UNLICENSED
 pragma solidity ^0.8.9;

 contract Institutes {
     struct Institute {
         string name;
         string description;
     }

     mapping(address => Institute) public institutes;

     function registerInstitute(string memory name, string memory description) public {
        require(!isInstitute(msg.sender), "Institute already registered");
        require(bytes(name).length > 0, "Name is required");
        require(bytes(description).length > 0, "Description is required");

         Institute memory newInstitute = Institute({
             name: name,
             description: description
         });

         institutes[msg.sender] = newInstitute;
     }

     function getInstitute(address instituteAddress) public view returns (Institute memory) {
         return institutes[instituteAddress];
     }

     function isInstitute(address instituteAddress) public view returns (bool) {
         return bytes(institutes[instituteAddress].name).length > 0;
     }
 }