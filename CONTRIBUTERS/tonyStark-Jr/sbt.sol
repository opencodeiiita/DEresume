// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBT is ERC721URIStorage, Ownable {
    // InstituteRegistry contract reference
    InstituteRegistry public instituteRegistry;

    // Skill parameters
    struct Skill {
        string name;
        uint256 level;
        string description;
    }

    // Mapping from token ID to Skill
    mapping(uint256 => Skill) private _tokenSkills;

    // Event when a new skill is minted
    event SkillMinted(uint256 indexed tokenId, string name, uint256 level, string description);

    // Event when a token is transferred (disabled for SBTs)
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    constructor(address _instituteRegistry) ERC721("Soul-Bound Token", "SBT") {
        instituteRegistry = InstituteRegistry(_instituteRegistry);
    }

    /**
     * @dev Mint a new SBT with a specific skill.
     *
     * Requirements:
     * - Caller must be the owner of a registered Institute.
     * - SBTs are non-transferrable.
     */
    function mintWithSkill(
        string memory name,
        uint256 level,
        string memory description,
        string memory tokenURI
    ) external {
        require(instituteRegistry.isRegisteredInstitute(msg.sender), "Caller is not a registered Institute");
        require(owner() == msg.sender, "Caller must be the owner of the Institute");

        uint256 tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        // Set the skill parameters
        _tokenSkills[tokenId] = Skill(name, level, description);

        // Emit the SkillMinted event
        emit SkillMinted(tokenId, name, level, description);
    }

    /**
     * @dev Prevent token transfer by overriding the transfer functions.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        // SBTs are non-transferrable
        require(false, "SBTs are non-transferrable");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        // SBTs are non-transferrable
        require(false, "SBTs are non-transferrable");
    }

    /**
     * @dev Get the skill details for a given token ID.
     */
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

// InstituteRegistry contract reference
import "./contributors/names/InstituteRegistry.sol";
