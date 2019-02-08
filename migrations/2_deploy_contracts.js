var ownable = artifacts.require("ERC721/ownership/ownable.sol");
var addressUtils = artifacts.require("ERC721/utils/address-utils.sol");
var supportsInterface = artifacts.require("ERC721/utils/supports-interface.sol");
var safeMath = artifacts.require("ERC721/math/safe-math.sol");

var nfToken = artifacts.require("ERC721/tokens/nf-token.sol");
var nfTokenEnumerable = artifacts.require("ERC721/tokens/nf-token-enumerable.sol");
var nfTokenMetadata = artifacts.require("ERC721/tokens/nf-token-metadata.sol");
var ERT = artifacts.require("ERT.sol");

module.exports = function(deployer) {
    deployer.deploy(ownable);
    deployer.deploy(addressUtils);
    deployer.deploy(supportsInterface);
    deployer.deploy(safeMath);

    deployer.link(addressUtils, nfToken);
    deployer.link(supportsInterface, nfToken);
    deployer.link(safeMath, nfToken);
    deployer.deploy(nfToken);

    deployer.link(nfToken, [nfTokenEnumerable, nfTokenMetadata]);
    deployer.deploy(nfTokenEnumerable);
    deployer.deploy(nfTokenMetadata);

    deployer.link(addressUtils, ERT);
    deployer.link(nfTokenEnumerable, ERT);
    deployer.link(nfTokenMetadata, ERT);
    deployer.deploy(ERT);
};
