//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./BlockdemyLootAttributes.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./Base64.sol";

contract BlockdemyLoot is
    ERC721Enumerable,
    BlockdemyLootAttributes,
    ReentrancyGuard
{
    using Base64 for bytes;
    using Strings for uint256;

    // Variables
    uint256 public idCounter;
    uint256 public maxSupply;

    // Modifier
    modifier onlyExistent(uint256 tokenId) {
        require(
            tokenId <= idCounter,
            "Blockdemy Loot: Query non existent token"
        );
        _;
    }

    // Constructor
    constructor(uint256 _maxSupply) ERC721("Blockdemy Loot", "BDMLOOT") {
        maxSupply = _maxSupply;
    }

    // Funciones
    function mint(address _to, uint256 _tokenId) public nonReentrant {
        require(
            idCounter < maxSupply - 1,
            "Blockdemy Loot: There are not Blockdemys available"
        );

        idCounter += 1;
        _safeMint(_to, _tokenId);
    }

    function profile(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getProfile(tokenId);
    }

    function instructor(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getInstructor(tokenId);
    }

    function communityFriend(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getCommunityFriend(tokenId);
    }

    function leverage(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getLeverage(tokenId);
    }

    function exchange(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getExchange(tokenId);
    }

    function shitcoin(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getShitcoin(tokenId);
    }

    function tokenProject(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getTokenProject(tokenId);
    }

    function program(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        returns (string memory)
    {
        return getProgram(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        onlyExistent(tokenId)
        returns (string memory)
    {
        string[17] memory parts;
        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = getProfile(tokenId);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = getInstructor(tokenId);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = getCommunityFriend(tokenId);

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = getLeverage(tokenId);

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = getExchange(tokenId);

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = getShitcoin(tokenId);

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = getTokenProject(tokenId);

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = getProgram(tokenId);

        parts[16] = "</text></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6],
                parts[7],
                parts[8]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[9],
                parts[10],
                parts[11],
                parts[12],
                parts[13],
                parts[14],
                parts[15],
                parts[16]
            )
        );

        string memory json = abi
            .encodePacked(
                '{"name": "Tribe #',
                tokenId.toString(),
                '", "description": "Blockdemy Loot is a set of randomized Blockchain Academy Tribe attributes. Images are omitted intentionally for others to interpret. Feel free to use in any way you want. Perhaps to build next unicorn?", "image": "data:image/svg+xml;base64,',
                bytes(output).encode(),
                '"}'
            )
            .encode();

        output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }
}
