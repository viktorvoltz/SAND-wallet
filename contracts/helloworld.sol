pragma solidity ^0.8.11;

contract HelloWorld {
    string public yourName;
    constructor() public {
        yourName = "Unknown";
    }

    function setName(string memory nm) public{
		yourName = nm ;
    }

}
