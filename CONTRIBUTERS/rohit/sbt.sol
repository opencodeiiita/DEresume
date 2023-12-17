// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../../smart-contracts/institutes.sol"; 

contract SBT is ERC721URIStorage {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Skill {
        string skillName;
        uint256 skillLevel;
        string description;
    }


    mapping(uint256 => Skill) public tokenSkills;

    // Counter for generating unique token IDs
    uint256 private tokenIdCounter;

    constructor() ERC721("Soul-Bound Token", "SBT") {}
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(from == address(0), "Token transfers are disabled");
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function mint(
        address to,
        string memory tokenURI,
        string memory skillName,
        uint256 skillLevel,
        string memory description
    ) public {
        require(Institutes.isInstitute(msg.sender), "Registered institutes are only allowed to mint SBTs");
        tokenId = _tokenIds.current(); // Declare tokenId here
        _mint(to, tokenId);
        _tokenIds.increment();
        Skill memory skill = Skill({
            skillName: skillName,
            skillLevel: skillLevel,
            description: description
        });
        tokenSkills[tokenId] = skill;
    }
}
