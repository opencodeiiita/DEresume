// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SBToken is ERC721URIStorage {
    struct Skill {
        string experienceType;
        string skillTitle;
        string skillDescription;
        uint256 startDate;
        uint256 endDate;
        // Add more parameters as needed for the skill
    }

    mapping(uint256 => Skill) private tokenIdToSkill;
    mapping(uint256 => bool) private skillTransferable;

    uint256 private tokenIdCounter;

    constructor() ERC721("Soul-Bound Token", "SBT") {}

    function mintToken(
        address recipient,
        string memory tokenURI,
        string memory expType,
        string memory title,
        string memory description,
        uint256 start,
        uint256 end
    ) external returns (uint256) {
        uint256 newTokenId = tokenIdCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        Skill memory newSkill = Skill({
            experienceType: expType,
            skillTitle: title,
            skillDescription: description,
            startDate: start,
            endDate: end
            // Add more parameters initialization if needed
        });

        tokenIdToSkill[newTokenId] = newSkill;
        skillTransferable[newTokenId] = false; // Skill transferability set to false initially
        tokenIdCounter++;

        return newTokenId;
    }
}
