pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBT is ERC721URIStorage, Ownable {
    constructor() ERC721("Soul-Bound Token", "SBT") {}

    function mint(address to, uint256 tokenId, string memory tokenURI) external onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function burn(uint256 tokenId) external onlyOwner {
        _burn(tokenId);
    }

    function updateTokenURI(uint256 tokenId, string memory newTokenURI) external onlyOwner {
        _setTokenURI(tokenId, newTokenURI);
    }
}
