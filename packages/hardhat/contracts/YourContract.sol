pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  event SetPurpose(address sender, string purpose);

  event PositionUpserted(address indexed trader,
    uint indexed positionId,
    Position position
  );

  event InstrumentCreated(
    bytes32 base,
    bytes32 quote,
    bytes32 symbol,
    uint32 maturity
  );

  string public purpose = "Nothing at all";
  uint public nextPositionId = 1;
  mapping(uint => Position) public positions;

  constructor() payable {
    // what should we do on deploy?
  }

  function setPurpose(string memory newPurpose) public {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      emit SetPurpose(msg.sender, purpose);
  }

  function createPosition(int quantity, uint collateral)
  external returns (uint positionId) {
    positionId = nextPositionId++;
    Position storage position = positions[positionId];
    position.collateral = collateral;
    position.openQuantity = quantity;

    emit PositionUpserted(msg.sender, positionId, position);
  }

  function modifyPosition(uint positionId, int quantity, uint collateral)
  external {
    Position memory position = positions[positionId];
    position.collateral += collateral;
    position.openQuantity += quantity;

    emit PositionUpserted(msg.sender, positionId, position);
  }

  function createInstrument(bytes32 symbol, bytes32 base, bytes32 quote, uint32 maturity) external {
    emit InstrumentCreated(base, quote, symbol, maturity);
  }

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}

  struct Position {
    uint collateral; // User collateral
    int openQuantity; // total quantity to which the trader is exposed, positive for long, negative for short, always in base ccy
  }
}
