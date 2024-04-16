//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@opengsn/contracts/src/BasePaymaster.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ProductContract.sol";
import "./interface/IProductContract.sol";

contract ProductFactoryContract {
    event ContractDeployed(address indexed newContractAddress);

    // address public forwarder;

    // constructor(address _forwarder) {
    //     forwarder = _forwarder;
    // }
    constructor() {}

    function deployProductContract() public returns (address) {
        // Deploy new product
        ProductContract newProductContract = new ProductContract(
            "https://example.com/api/token/{id}.json"
        );
        emit ContractDeployed(address(newProductContract));

        // Setup paymaster
        IProductContract productContract = IProductContract(
            address(newProductContract)
        );
        productContract.transferOwnership(msg.sender);

        return address(newProductContract);
    }
}
