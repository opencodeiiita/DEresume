// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Institutes is ERC721("SecurityToken", "SBT") {
    struct Institute {
        string name;
        string description;
        bool isRegistered;
        string experienceType; 
        string title; 
        string descriptionSkill; 
        uint256 startDate; 
        uint256 endDate; 
    }

    mapping(address => Institute) public institutes;
    mapping(uint256 => bool) public isTokenMinted;

    modifier onlyRegisteredInstitute() {
        require(institutes[msg.sender].isRegistered, "Only registered institutes can call this function");
        _;
    }

    function registerInstitute(
        string memory name,
        string memory description,
        string memory experienceType,
        string memory title,
        string memory descriptionSkill,
        uint256 startDate,
        uint256 endDate
    ) external {
        require(!institutes[msg.sender].isRegistered, "Institute already registered");
        require(bytes(name).length > 0, "Name is required");
        require(bytes(description).length > 0, "Description is required");

        Institute memory newInstitute = Institute({
            name: name,
            description: description,
            isRegistered: true,
            experienceType: experienceType,
            title: title,
            descriptionSkill: descriptionSkill,
            startDate: startDate,
            endDate: endDate
        });

        institutes[msg.sender] = newInstitute;
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        revert("SBTs are non-transferrable");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override {
        revert("SBTs are non-transferrable");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override {
        revert("SBTs are non-transferrable");
    }
}
