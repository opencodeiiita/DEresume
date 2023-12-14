// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Institutes {
    struct Institute {
        string name;
        string description;
    }

    mapping(address => Institute) public institutes;

    function registerInstitute(string memory name, string memory description) public {
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
