pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./institutes.sol";

contract SBT is ERC721URIStorage, ERC721Enumerable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Institutes institutes;

    event SBTMinted(address indexed to, uint256 indexed tokenId);

    struct Skill {
        string experienceType;
        string title;
        string description;
        uint256 startDate;
        uint256 endDate;
        string industry;
        string location;
        string skills;
        uint256 expirationDate;
    }

    mapping(uint256 => Skill) public skills;

    constructor(address institutesAddress) ERC721("SBT", "Soul-Bound-Tokens") {
        institutes = Institutes(institutesAddress);
    }

    function _beforeTokenTransfer( address from, address to, uint256 tokenId ) internal override virtual { 
        require(from == address(0), "You can't transfer SBTs");
        super._beforeTokenTransfer(from, to, tokenId);
    }
    function _transfer( address from, address to, uint256 tokenId ) internal override virtual { 
        revert("You can't transfer SBTs");
    }
    function safeTransferFrom( address from, address to, uint256 tokenId ) public override virtual { 
        revert("You can't transfer SBTs");
    }
    function safeTransferFrom( address from, address to, uint256 tokenId, bytes memory _data ) public override virtual { 
        revert("You can't transfer SBTs");
    }
    function transferFrom( address from, address to, uint256 tokenId ) public override virtual { 
        revert("You can't transfer SBTs");
    }

    function tokenHasExpired(uint256 tokenId) public view returns (bool) {
        if (skills[tokenId].expirationDate == 0) {
             return false;
        }
        return skills[tokenId].expirationDate < block.timestamp;
    }

    function getSkills(address userAddress) public view returns (Skill[] memory) {
        uint256 tokenCount = balanceOf(userAddress);
        Skill[] memory skillList = new Skill[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            uint256 tokenId = tokenOfOwnerByIndex(userAddress, i);
            skillList[i] = skills[tokenId];
        }
        return skillList;
    }

    function mint(
        address to,
        string memory experienceType,
        string memory title,
        string memory description,
        uint256 memory startDate,
        uint256 memory endDate,
        string memory industry,
        string memory location,
        string memory skills,
        uint256 expirationDate
    ) public {
        require(institutes.isInstitute(msg.sender), "Only registered institutes can mint SBTs");
        require(bytes(experienceType).length > 0, "Experience type is required");
        require(bytes(title).length > 0, "Title is required");
        require(bytes(description).length > 0, "Description is required");
        require(startDate > 0, "Start date is required");
        require(endDate > 0, "End date is required");
        require(bytes(industry).length > 0, "Industry is required");
        require(bytes(location).length > 0, "Location is required");
        require(bytes(skills).length > 0, "Skills are required");
        require(expirationDate >= 0, "Expiration date is required");
        
        uint256 tokenId = _tokenIds.current();
        _mint(to, tokenId);
        _tokenIds.increment();


        Skill memory newSkill = Skill({
            experienceType: experienceType,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            industry: industry,
            location: location,
            skills: skills,
            expirationDate: expirationDate
        });

        skills[tokenId] = newSkill;

        emit SBTMinted(to, tokenId);
    }
}