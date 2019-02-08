pragma solidity ^0.5.2;
// ERC721 adapted from https://github.com/0xcert/ethereum-erc721
import "./ERC721/tokens/nf-token-enumerable.sol";
import "./ERC721/tokens/nf-token-metadata.sol";
import "./ERC721/ownership/ownable.sol";

contract Elemmire is NFTokenEnumerable, NFTokenMetadata, Ownable {
    constructor() public {
        nftName = "Elemmire";
        nftSymbol = "ELEM";
        ceoAddress = msg.sender;
    }

    // modifier onlyCEO() {
    //     require(msg.sender == ceoAddress);
    //     _;
    // }

    // (possible) features to be implemented:
    // * finer access control other than "onlyOwner"
    // * able to "pause"/"un-pause" the generation of NFT
    // * make it upgradable (may need the ability to "pause")
    // * how to integrate it with the "Trade" contract + state channels?
    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    function burn(uint256 _tokenId) external onlyOwner{
        super._burn(_tokenId);
    }

}
