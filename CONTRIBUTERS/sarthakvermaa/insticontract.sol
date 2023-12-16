// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

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

    function isRegisteredInstitute(address instituteAddress) public view returns (bool) {
        return bytes(institutes[instituteAddress].name).length > 0;
    }
}

contract SBToken is ERC721 {
    Institutes public institutesContract;

    constructor(address _institutesAddress) ERC721("Soul-Bound Token", "SBT") {
        institutesContract = Institutes(_institutesAddress);
    }

    function mintToken(address recipient, string memory tokenURI) external {
        require(institutesContract.isRegisteredInstitute(msg.sender), "SBToken: Only registered institutes can mint tokens");
        uint256 newTokenId = totalSupply();
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(from == address(0) || to == address(0), "SBToken: Tokens are non-transferrable");
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
