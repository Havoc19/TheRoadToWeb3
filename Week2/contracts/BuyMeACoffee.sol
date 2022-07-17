// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


//Deployed to Georli at 0x276F6aF556d63B57f5d680121e5141Da73ef4206
contract BuyMeACoffee { 
    event NewMemo(
        address indexed from,
        uint256 timeStamp,
        string name,
        string message
    );

    struct Memo{
        address from;
        uint256 timeStamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);        
    }

    modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

    function changeOwner(address payable _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public{
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
