// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBT is ERC721URIStorage, Ownable {
    InstituteRegistry public instituteRegistry;

    struct Skill {
        string name;
        uint256 level;
        string description;
    }

    mapping(uint256 => Skill) private _tokenSkills;

    event SkillMinted(uint256 indexed tokenId, string name, uint256 level, string description);

    constructor(address _instituteRegistry) ERC721("Soul-Bound Token", "SBT") {
        instituteRegistry = InstituteRegistry(_instituteRegistry);
    }

 
    function mintWithSkill(
        address to,
        string memory name,
        uint256 level,
        string memory description,
        string memory tokenURI
    ) external onlyOwner {
        require(instituteRegistry.isRegisteredInstitute(msg.sender), "Caller is not a registered Institute");

        uint256 tokenId = totalSupply() + 1;

        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        _tokenSkills[tokenId] = Skill(name, level, description);

        emit SkillMinted(tokenId, name, level, description);
    }


    function getSkill(uint256 tokenId)
        external
        view
        returns (string memory name, uint256 level, string memory description)
    {
        require(_exists(tokenId), "Token ID does not exist");
        Skill storage skill = _tokenSkills[tokenId];
        return (skill.name, skill.level, skill.description);
    }
}

import "./contributors/names/InstituteRegistry.sol";
