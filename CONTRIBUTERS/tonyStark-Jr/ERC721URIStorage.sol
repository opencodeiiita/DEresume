// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBT is ERC721URIStorage, Ownable {
    constructor() ERC721("Soul-Bound Token", "SBT") {}

    function mint(address to, uint256 tokenId, string memory tokenURI) external onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://example.com/api/token/";
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        _setBaseURI(baseURI);
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) external onlyOwner {
        _setTokenURI(tokenId, tokenURI);
    }
}
