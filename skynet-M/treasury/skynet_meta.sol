// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title SkynetMeta ($SKYM)
 * @dev Internal Compute Currency for simulation cycles
 * Location: Off-chain / Layer 3
 */
contract SkynetMeta is ERC20 {
    address public controller;

    constructor() ERC20("Skynet Meta", "SKYM") {
        controller = msg.sender;
    }

    /**
     * @dev Mint tokens for simulation cycle payments
     */
    function mintForSimulation(address agent, uint256 cycles) external {
        require(msg.sender == controller, "Only controller can mint");
        _mint(agent, cycles * 1e18);
    }

    /**
     * @dev Burn tokens when simulation cycles are consumed
     */
    function consumeCycles(uint256 cycles) external {
        _burn(msg.sender, cycles * 1e18);
    }
}
