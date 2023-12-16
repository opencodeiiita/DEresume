// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SBToken is ERC721URIStorage {
    uint256 private tokenIdCounter;

    constructor() ERC721("Soul-Bound Token", "SBT") {}

    function mintToken(address recipient, string memory tokenURI) external returns (uint256) {
        uint256 newTokenId = tokenIdCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenIdCounter++;
        return newTokenId;
    }

    function transferToken(address to, uint256 tokenId) external {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(_msgSender(), to, tokenId, "");
    }

    function getTokenOwner(uint256 tokenId) external view returns (address) {
        return ownerOf(tokenId);
    }

    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        return tokenURI(tokenId);
    }
}
