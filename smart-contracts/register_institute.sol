// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InstituteRegistration {
    struct Institute {
        string name;
        string description;
    }

    mapping(address => Institute) public institutes;

    function isRegisteredInstitute(address walletAdd) external view returns (bool) {
        return bytes(institutes[walletAdd].name).length > 0;
    }

    function registerInstitute(string memory _name, string memory _description) public {
        require(bytes(_name).length > 0, "Name must be filled");
        require(bytes(_description).length > 0, "Description must be filled");
        require(bytes(institutes[msg.sender].name).length == 0, "Address is already registered");

        
        Institute memory newInstitute = Institute({
            name: _name,
            description: _description
        });
        institutes[msg.sender]=newInstitute;

    }
}
