// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@5.0.1/access/Ownable.sol";

contract UmerNFT is ERC721, ERC721Enumerable, Ownable {
    uint256 private _nextTokenId;
    uint256 public mintRate=0.001 ether;
    uint public MAXSUPPLY =1000;

    constructor(address initialOwner)
        ERC721("UmerNFT", "UNFT")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "  https://api.umernft.com/tokens/";
    }

    function safeMint(address to) public payable  {
        require(msg.value >= mintRate,"Not enough ethers");
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    function withdraw() public onlyOwner{
        require(address(this).balance> 0,"balance is 0");
        payable(owner()).transfer(address(this).balance);
    }


}
