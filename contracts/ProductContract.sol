// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@opengsn/contracts/src/ERC2771Recipient.sol";

contract ProductContract is ERC1155, Ownable {
    mapping(uint256 => uint256) private hardCap;
    mapping(uint256 => uint256) private tokenSupply;
    mapping(uint256 => string) private tokenUri;

    // uri example: "https://example.com/api/token/{id}.json"
    // constructor(string memory _uri, address forwarder) ERC1155(_uri) {
    //     _setTrustedForwarder(forwarder);
    // }
    constructor(string memory _uri) ERC1155(_uri) {}

    function mintNewToken(
        uint256 tokenId,
        uint256 amount,
        string memory uri,
        bytes memory data
    ) external onlyOwner {
        if (hardCap[tokenId] > 0) {
            require(
                tokenSupply[tokenId] + amount <= hardCap[tokenId],
                "Exceeds hard cap for this token ID"
            );
        }
        _mint(msg.sender, tokenId, amount, data);
        tokenSupply[tokenId] += amount;
        tokenUri[tokenId] = uri;
    }

    function mintExistingToken(
        uint256 tokenId,
        uint256 amount
    ) external onlyOwner {
        if (hardCap[tokenId] > 0) {
            require(
                tokenSupply[tokenId] + amount <= hardCap[tokenId],
                "Exceeds hard cap for this token ID"
            );
        }
        _mint(msg.sender, tokenId, amount, "");
        tokenSupply[tokenId] += amount;
    }

    function burn(
        address account,
        uint256 tokenId,
        uint256 amount
    ) external onlyOwner {
        _burn(account, tokenId, amount);
    }

    function burnBatch(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory amounts
    ) external onlyOwner {
        _burnBatch(account, tokenIds, amounts);
    }

    function setHardCap(uint256 tokenId, uint256 cap) external onlyOwner {
        require(
            cap >= tokenSupply[tokenId],
            "New cap less than current supply"
        );
        hardCap[tokenId] = cap;
    }

    function getHardCap(uint256 tokenId) external view returns (uint256) {
        return hardCap[tokenId];
    }

    function getTokenSupply(uint256 tokenId) external view returns (uint256) {
        return tokenSupply[tokenId];
    }

    function getTokenUri(
        uint256 tokenId
    ) external view returns (string memory) {
        return tokenUri[tokenId];
    }
}
