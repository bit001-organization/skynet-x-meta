// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title VetoProtocol
 * @dev Smart contract to block unethical funding requests
 */
contract VetoProtocol {
    address public oracle;

    mapping(bytes32 => bool) public vetoedActions;

    event ActionVetoed(bytes32 indexed actionId, string reason);
    event ActionApproved(bytes32 indexed actionId);

    modifier onlyOracle() {
        require(msg.sender == oracle, "Only oracle can veto");
        _;
    }

    constructor(address _oracle) {
        oracle = _oracle;
    }

    function vetoAction(bytes32 actionId, string memory reason) external onlyOracle {
        vetoedActions[actionId] = true;
        emit ActionVetoed(actionId, reason);
    }

    function isVetoed(bytes32 actionId) external view returns (bool) {
        return vetoedActions[actionId];
    }
}
