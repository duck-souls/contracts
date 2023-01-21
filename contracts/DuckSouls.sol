// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DuckSouls is ERC721EnumerableUpgradeable, OwnableUpgradeable {
    function initialize() public initializer {
        __ERC721_init("Duck Souls", "DUCKS");
        __Ownable_init();
    }
}
