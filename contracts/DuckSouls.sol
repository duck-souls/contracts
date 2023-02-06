// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DuckSouls is ERC721EnumerableUpgradeable, OwnableUpgradeable {
    struct Duck {
        uint256 value;
        uint256 lastInteraction;
        uint8 hp;
        bool alive;
    }

    mapping(uint256 => Duck) public ducks;

    function initialize() external initializer {
        __ERC721_init("Duck Souls", "DUCKS");
        __Ownable_init();
    }

    function mint() external payable onlyOwner {
        require(msg.value == 0.1 ether, "wrong value");
        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);
        ducks[tokenId] = Duck(0.1 ether, block.timestamp, 3, true);
    }

    function shoot(uint256 _duckId) external {
        require(
            ducks[_duckId].lastInteraction < block.timestamp + 12 hours,
            "not ready"
        );
        ducks[_duckId].hp -= 1;
        ducks[_duckId].lastInteraction = block.timestamp;
    }

    function action(uint256 _duckId) external payable {
        require(
            ducks[_duckId].lastInteraction < block.timestamp + 8 hours,
            "not ready"
        );
        require(msg.value == 0.1 ether, "wrong value");
        require(msg.sender == ownerOf(_duckId), "not owner");
        ducks[_duckId].value += 0.1 ether;
        ducks[_duckId].lastInteraction = block.timestamp;
    }

    function kill(uint256 _duckId) external {
        require(ducks[_duckId].hp == 0, "not dead");
        ducks[_duckId].value = ducks[_duckId].value / 2;
        payable(msg.sender).transfer(ducks[_duckId].value / 10);
    }

    function withdraw(uint256 _duckId) external {
        require(ducks[_duckId].hp != 0, "dead");
        require(msg.sender == ownerOf(_duckId), "not owner");
        transferFrom(
            msg.sender,
            0x000000000000000000000000000000000000dEaD,
            _duckId
        );
        (bool sent, ) = msg.sender.call{value: ducks[_duckId].value}("");
        require(sent, "Failed to send Ether");
    }
}
