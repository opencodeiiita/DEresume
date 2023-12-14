// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InstituteRegistration {
    struct Institute {
        string name;
        string description;
    }

    mapping(address => Institute) public institutes;

    event InstituteRegistered(address indexed walletAddress, string name, string description);

    function isRegisteredInstitute(address walletAdd) external view returns (bool) {
        return bytes(institutes[walletAdd].name).length > 0;
    }

    function registerInstitute(string memory _name, string memory _description) external {
        require(bytes(_name).length > 0, "Name must be filled");
        require(bytes(_description).length > 0, "Description must be filled");
        require(bytes(institutes[msg.sender].name).length == 0, "Address is already registered");

        Institute memory newInstitute = Institute(_name, _description);
        institutes[msg.sender] = newInstitute;

        emit InstituteRegistered(msg.sender, _name, _description);
    }
}
