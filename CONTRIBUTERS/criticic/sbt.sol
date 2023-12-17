// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../../smart-contracts/institutes.sol";

contract SBT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
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


    // Override ERC721 functions to prevent transfers
    function _beforeTokenTransfer( address from, address to, uint256 tokenId ) internal override virtual { 
        require(from == address(0), "You can't transfer SBTs");
        super._beforeTokenTransfer(from, to, tokenId);
    }
    function _transfer( address from, address to, uint256 tokenId ) internal override virtual { 
        revert("You can't transfer SBTs");
    }
    function transferFrom(address from, address to, uint256 tokenId) public override virtual {
        revert("You can't transfer SBTs");
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) public override virtual {
        revert("You can't transfer SBTs");
    }
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override virtual {
        revert("You can't transfer SBTs");
    }
    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal override virtual {
        revert("You can't transfer SBTs");
    }


    function mint(
        address to,
        string memory experienceType,
        string memory title,
        string memory description,
        string memory startDate,
        string memory endDate
    ) public {
        require(institutes.isInstitute(msg.sender), "Only registered institutes can mint SBTs");
        tokenId = _tokenIds.current();
        _mint(to, tokenId);
        _tokenIds.increment();


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