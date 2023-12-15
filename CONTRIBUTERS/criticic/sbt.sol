// Implement the ERC-721 standard for the Soul-Bound Token (SBT) contract using OpenZeppelin's ERC721URIStorage.sol.
// Make the solidity file in your names folder inside the contributors folder. You can add the skill parameters by observing the frontend page for sbtissue in the frontend folder.
// NOTE:-you only have to make an ERC-721 token which can be used as a professional skill credential not a SBT .You will only name the file as sbt.sol.
// should have the following parameters
                    // experienceType
                    // title
                    // description
                    // startDate
                    // endDate
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