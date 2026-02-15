// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title SkynetX ($SKYX)
 * @dev External Capital Bridge for Mars Mission funding
 * Connects to real-world Fiat/Crypto for physical assets
 */
contract SkynetX is ERC20 {
    address public treasury;
    uint256 public constant REINVESTMENT_RATE = 80; // 80% auto-reinvest

    event SurplusReinvested(uint256 amount, string infrastructure);
    event AssetPurchased(string assetType, uint256 amount);

    constructor() ERC20("Skynet X", "SKYX") {
        treasury = msg.sender;
    }

    /**
     * @dev Purchase physical assets for Mars Mission
     * @param assetType Type of asset (Steel, Methane, Energy)
     * @param amount Amount in tokens
     */
    function purchaseAsset(string memory assetType, uint256 amount) external {
        _burn(msg.sender, amount);
        emit AssetPurchased(assetType, amount);
    }

    /**
     * @dev Auto-reinvest surplus into aerospace infrastructure
     */
    function reinvestSurplus(uint256 surplus, string memory infrastructure) external {
        require(msg.sender == treasury, "Only treasury can reinvest");
        uint256 reinvestAmount = (surplus * REINVESTMENT_RATE) / 100;
        emit SurplusReinvested(reinvestAmount, infrastructure);
    }
}
