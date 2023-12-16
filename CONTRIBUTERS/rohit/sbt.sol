pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol"; 

contract SBT is ERC721URIStorage {
    using SafeMath for uint256;

    struct Skill {
        string skillName;
        uint256 skillLevel;
        string description;
    }

    mapping(uint256 => Skill) public tokenSkills;

    uint256 private tokenIdCounter;

    constructor() ERC721("Soul-Bound Token", "SBT") {}
    function mint(
        uint256 tokenId,
        address to,
        string memory tokenURI,
        string memory skillName,
        uint256 skillLevel,
        string memory description
    ) public {
      _mint(to,tokenId);

        Skill memory skill = Skill({
          skillName:skillName, skillLevel:skillLevel, description:description
          }
          );
        tokenSkills[tokenId] = skill;
    }
    
  }

