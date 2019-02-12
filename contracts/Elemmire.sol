pragma solidity ^0.5.2;
// ERC721 adapted from https://github.com/0xcert/ethereum-erc721
import "./ERC721/tokens/nf-token-enumerable.sol";
import "./ERC721/tokens/nf-token-metadata.sol";
// import "./ERC721/ownership/ownable.sol";


contract Elemmire is NFTokenEnumerable, NFTokenMetadata {
    // features to be implemented:
    // * finer access control other than "managerOnly" / "miningOnly"
    // * upgradable
    // * able or easy to integrate with the "Trade" contract + state channels

    // for now, only 5 managers and 5 minable/burnable contracts
    address public owner;
    address[5] public mining;
    address[5] public managers;
    bool public paused = false;

    constructor() public {
        nftName = "Elemmire";
        nftSymbol = "ELEM";
        owner = msg.sender;
        managers[0] = 0xB440ea2780614b3c6a00e512f432785E7dfAFA3E;
        managers[1] = 0x4AD56641C569C91C64C28a904cda50AE5326Da41;
        managers[2] = 0x362ea687b8a372a0235466a097e578d55491d37f;
    }

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    modifier managerOnly() {
        require(msg.sender != address(0));
        require(msg.sender == managers[0] ||
                msg.sender == managers[1] ||
                msg.sender == managers[2] ||
                msg.sender == managers[3] ||
                msg.sender == managers[4]);
        _;
    }

    modifier miningOnly() {
        require(msg.sender != address(0));
        require(msg.sender == mining[0] ||
                msg.sender == mining[1] ||
                msg.sender == mining[2] ||
                msg.sender == mining[3] ||
                msg.sender == mining[4]);
        _;
    }

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused {
        require(paused);
        _;
    }

    function mint(address _to, uint256 _tokenId, string calldata _uri) external miningOnly whenNotPaused {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    function burn(uint256 _tokenId) external miningOnly {
        super._burn(_tokenId);
    }

    // additional functions
    function pause() external managerOnly whenNotPaused {
        paused = true;
    }

    function unpause() public ownerOnly whenPaused {
        // set to ownerOnly in case accounts of other managers are compromised
        paused = false;
    }

    function setMining(address miningAddress, uint8 idx) external managerOnly returns (bool) {
        require(idx < 5);  // max 5 addr can mint and burn
        //require(mining[idx] == address(0)); // comment to allow this to be changed many times
        mining[idx] = miningAddress;
        return true;
    }

    function addManager(address _newAddr, uint8 idx) external managerOnly returns (bool) {
        require(idx == 3 || idx == 4);  // cannot replace the first 3 managers in this contract!
        managers[idx] = _newAddr;
        return true;
    }

}
