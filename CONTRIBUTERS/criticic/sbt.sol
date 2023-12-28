pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./institutes.sol";

contract SBT is ERC721URIStorage {
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
        string skillDetails;
        uint256 expirationDate;
    }

    mapping(uint256 => Skill) public skills;

    constructor(address institutesAddress) ERC721("SBT", "Soul-Bound-Tokens") {
        institutes = Institutes(institutesAddress);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        require(from == address(0), "You can't transfer SBTs");

        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override(ERC721, IERC721) {
        require(from == address(0), "You can't transfer SBTs");

        super.safeTransferFrom(from, to, tokenId, _data);
    }

    function tokenHasExpired(uint256 tokenId) public view returns (bool) {
        if (skills[tokenId].expirationDate == 0) {
             return false;
        }
        return skills[tokenId].expirationDate < block.timestamp;
    }
    function mint(
        address to,
        string memory experienceType,
        string memory title,
        string memory description,
        uint256 startDate,
        uint256 endDate,
        string memory industry,
        string memory location,
        string memory skillDetails,
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
        require(bytes(skillDetails).length > 0, "Skills are required");
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
            skillDetails: skillDetails,
            expirationDate: expirationDate
        });

        skills[tokenId] = newSkill;

        emit SBTMinted(to, tokenId);
    }
}