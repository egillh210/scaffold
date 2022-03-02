pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  event SetPurpose(address sender, string purpose);
  // event PositionUpserted(address indexed trader,
  //       uint indexed positionId,
  //       Position position,
  //       int protocolFees,
  //       int realisedPnL
  //   );

  string public purpose = "Building Unstoppable Apps!!!";

  constructor() payable {
    // what should we do on deploy?
  }

  function setPurpose(string memory newPurpose) public {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      emit SetPurpose(msg.sender, purpose);
  }

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}

  // struct Position {
  //   int128 collateral; // User collateral
  //   int128 openQuantity; // total quantity to which the trader is exposed, positive for long, negative for short, always in base ccy
  //   int128 openCost; // total amount that the trader exchanged for base, positive for short, negative for long, always in quote ccy
  //   int128 protocolFees; // fees this position owes, this field is WIP and may be dropped
  //   uint8 leverage; // max leverage that was valid when this position was opened
  //   uint32 maturity;
  //   bytes1 liquiditySource;
  // }
}
