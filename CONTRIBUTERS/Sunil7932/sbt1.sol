// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import ". /institute.sol";
contract Institutes {
    struct Institute {
        string name;
        string description;
    }
    mapping(address => Institute) public institutes;
    function registerInstitute(string memory name, string memory description) public {
        require(!isInstitute(msg.sender), "Institute already registered");
        require(bytes(name).length > 0, "Name is required");
        require(bytes(description).length > 0, "Description is required");

        Institute memory newInstitute = Institute({
            name: name,
            description: description
        });

        institutes[msg.sender] = newInstitute;
    }
    function getInstitute(address instituteAddress) public view returns (Institute memory) {
        return institutes[instituteAddress];
    }

    function isInstitute(address instituteAddress) public view returns (bool) {
        return bytes(institutes[instituteAddress].name).length > 0;
    }
}

contract SoulBoundToken is ERC721URIStorage {
    Institutes public institutesContract;
    struct TokenMetadata {
        address receiverWallet;
        string experienceType;
        string title;
        string description;
        uint256 startDate;
        uint256 endDate;
        bool submitted;
    }

    mapping(uint256 => TokenMetadata) private _tokenMetadata;
    mapping(address => bool) private _registeredInstitutes; 
    Institute private instituteContract;
    constructor(address _instituteAddress) ERC721("SoulBoundToken", "SBT") {
        instituteContract = Institute(_instituteAddress);
        _registeredInstitutes[msg.sender] = true; // Assume deployer is initially a registered institute
        mintWithMetadata(
            msg.sender,
            0,
            "initialTokenURI",
            msg.sender,
            "Initial Experience Type",
            "Initial Title",
            "Initial Description",
            block.timestamp,
            block.timestamp
        );
    }
    modifier onlyRegisteredInstitute() {
        require(_registeredInstitutes[msg.sender], "Caller is not a registered institute");
        _;
    }

    function registerInstitute(address _instituteAddress) public { 
        _registeredInstitutes[_instituteAddress] = true;
    }

    function mintWithMetadata(
        address to,
        uint256 tokenId,
        string memory tokenURI,
        address receiverWallet,
        string memory experienceType,
        string memory title,
        string memory description,
        uint256 startDate,
        uint256 endDate
    ) public onlyRegisteredInstitute {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenMetadata[tokenId] = TokenMetadata(
            receiverWallet,
            experienceType,
            title,
            description,
            startDate,
            endDate,
            false
        );
    }

    function updateTokenData(uint256 tokenId, string memory newData) public {
        address owner = ownerOf(tokenId);
        require(owner == _msgSender(), "ERC721: caller is not the owner");
        tokenData[tokenId] = newData;
    }
    function burn(uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(owner == _msgSender() || isApprovedForAll(owner, _msgSender()), "ERC721: burn caller is not owner nor approved");
        _burn(tokenId);
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        require(from == address(0), "Token transfer not allowed");
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function isTokenTransferrable(uint256 tokenId) external view returns (bool) {
        address owner = ownerOf(tokenId);
        return institutesContract.isInstitute(owner);
    }
   function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public virtual override(ERC721URIStorage) {
        require(false, "safeTransferFrom not allowed");
    }
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override(ERC721URIStorage) {
        require(false, "transferFrom not allowed");
    }
    function approve(address to, uint256 tokenId) public virtual override(ERC721URIStorage) {
        require(false, "approve not allowed");
    }
    function setApprovalForAll(address operator, bool approved) public virtual override(ERC721URIStorage) {
        require(false, "setApprovalForAll not allowed");
    } 
    function getTokenMetadata(uint256 tokenId) public view returns (TokenMetadata memory) {
        return _tokenMetadata[tokenId];
    }
}
