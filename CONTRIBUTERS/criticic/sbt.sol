// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../../smart-contracts/institutes.sol";

contract SBT is ERC721URIStorage {
    Institutes institutes;

    struct Skill {
        string experienceType;
        string title;
        string description;
        string startDate;
        string endDate;
    }

    mapping(uint256 => Skill) public skills;

    constructor(address institutesAddress) ERC721("SBT", "Soul-Bound-Tokens") {
        institutes = Institutes(institutesAddress);
    }

    function mint(
        address to,
        uint256 tokenId,
        string memory experienceType,
        string memory title,
        string memory description,
        string memory startDate,
        string memory endDate
    ) public {
        require(institutes.isInstitute(msg.sender), "Only registered institutes can mint SBTs");
        _mint(to, tokenId);

        Skill memory newSkill = Skill({
            experienceType: experienceType,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate
        });

        skills[tokenId] = newSkill;
    }
}