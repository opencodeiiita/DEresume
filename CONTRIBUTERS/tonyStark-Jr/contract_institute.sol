
pragma solidity ^0.8.0;

contract InstituteRegistry {
    struct Institute {
        string name;
        string description;
        address walletAddress;
    }

    mapping(address => Institute) public institutes;

    event InstituteRegistered(address indexed walletAddress, string name, string description);

    function registerInstitute(string memory _name, string memory _description) external {
        require(institutes[msg.sender].walletAddress == address(0), "Institute already registered");
        
        Institute storage newInstitute = institutes[msg.sender];
        newInstitute.name = _name;
        newInstitute.description = _description;
        newInstitute.walletAddress = msg.sender;

        emit InstituteRegistered(msg.sender, _name, _description);
    }

    function isRegisteredInstitute(address _walletAddress) external view returns (bool) {
        return institutes[_walletAddress].walletAddress != address(0);
    }
}
