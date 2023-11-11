// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Base64.sol";

contract EthKipuNFT is ERC721URIStorage {
    using Strings for uint256;
    
    uint256 public tokenId;
    
    //Runners NFT
    string[] characters = [
        "https://ipfs.io/ipfs/QmTgqnhFBMkfT9s8PHKcdXBn1f5bG3Q5hmBaR4U6hoTvb1?filename=Chainlink_Elf.png",
        "https://ipfs.io/ipfs/QmZGQA92ri1jfzSu61JRaNQXYg1bLuM7p8YT83DzFA2KLH?filename=Chainlink_Knight.png",
        "https://ipfs.io/ipfs/QmW1toapYs7M29rzLXTENn3pbvwe8ioikX1PwzACzjfdHP?filename=Chainlink_Orc.png",
        "https://ipfs.io/ipfs/QmPMwQtFpEdKrUjpQJfoTeZS1aVSeuJT6Mof7uV29AcUpF?filename=Chainlink_Witch.png"
    ];

    constructor() ERC721("EthKipuNFT", "KipuNFT") {
        mint(msg.sender);
    }
    
    function mint(address to) public {
        uint256 charId = tokenId % 4;

        string memory uri = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "EthKipu NFT",',
                        '"description": "This is your EthKipu NFT",',
                        '"image": "', characters[charId], '",'
                        '"attributes": [',
                        ']}'
                    )
                )
            )
        );
        // Create token URI
        string memory finalTokenURI = string(
            abi.encodePacked("data:application/json;base64,", uri)
        );
        _safeMint(to, tokenId);
        setTokenURI(tokenId, finalTokenURI);
        unchecked {
            tokenId++;
        }
    }

    function setTokenURI(uint256 id, string memory tokenURI) public {
        _setTokenURI(id, tokenURI);
    }
}