// These are the following parameters
                 // Receiver wallet address
                 // experienceType
                 // title
                 // description
                 // startDate
                 // endDate
                 // submit

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SoulBoundToken is ERC721URIStorage {
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

    constructor() ERC721("SoulBoundToken", "SBT") {
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
    ) public {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenMetadata[tokenId] = TokenMetadata(receiverWallet, experienceType, title, description, startDate, endDate, false);
    }

    function getTokenMetadata(uint256 tokenId) public view returns (TokenMetadata memory) {
        return _tokenMetadata[tokenId];
    }
}