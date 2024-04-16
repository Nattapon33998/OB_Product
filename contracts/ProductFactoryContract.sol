//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@opengsn/contracts/src/BasePaymaster.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ProductContract.sol";
import "./interfaces/IProductContract.sol";

contract ProductFactoryContract {
    event ContractDeployed(address indexed newContractAddress);

    constructor() {}

    function deployProductContract() public returns (address) {
        require(relayHub != address(0), "Require RelayHub");
        require(forwarder != address(0), "Require Forwarder");

        // Deploy new paymaster
        ProductContract newProductContract = new ProductContract();
        emit ContractDeployed(address(newProductContract));

        // Setup paymaster
        IProductContract productContract = IProductContract(
            address(newWhitelistPymaster)
        );
        productContract.transferOwnership(msg.sender);

        return address(newWhitelistPymaster);
    }
}
