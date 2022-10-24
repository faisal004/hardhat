// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public _price = 0.01 ether;
    bool public _paused;
    uint256 public maxTokenIds = 10;
    uint256 public tokenIds;

    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor (string memory baseURI) ERC721("LW3Punks","LW3P"){
        _baseTokenURI=baseURI;
    }

    function mint() public payable onlyWhenNotPaused{
        require(tokenIds<maxTokenIds,"Exceeds max LW3Punk Supply");
        require(msg.value>=_price ,"Ehters sent are not correct");
        tokenIds+=1;
        _safeMint(msg.sender,tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory){
        return _baseTokenURI;
    }
    
}
