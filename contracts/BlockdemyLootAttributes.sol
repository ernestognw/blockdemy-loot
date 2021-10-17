//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract BlockdemyLootAttributes {
    using Strings for uint256;

    string[] private _profile = ["Trader", "Consultant", "Dev", "Lawyer"];

    string[] private _instructor = [
        "Mark Munoz",
        "Ernesto Garcia",
        "Jorge Tavares",
        "Isaac Lopez"
    ];

    string[] private _communityFriend = [
        "Camila Pineda",
        "Fer Saldivar",
        "Juan Salas",
        "Claudia Melendez",
        "Abraham Leon",
        "Diego De Leon"
    ];

    string[] private _leverage = [
        "2x",
        "3x",
        "5x",
        "10x",
        "15x",
        "20x",
        "50x",
        "125x"
    ];

    string[] private _exchange = [
        "Coinbase",
        "Bitso",
        "Uniswap"
        "Buda",
        "Kraken",
        "Binance"
    ];

    string[] private _shitcoin = ["SHIBA", "DOGE", "XYO", "CATE"];

    string[] private _tokenProject = [
        "Gaming",
        "Real State",
        "Casino",
        "Stocks",
        "Art",
        "Memes"
    ];

    string[] private _program = [
        "Code and Hacks",
        "Crypto Webinar Series",
        "Blockdemy Legal",
        "Trading Nights",
        "Crypto News"
    ];

    function deterministicNoise(string memory input)
        internal
        pure
        returns (uint256)
    {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getAttribute(
        uint256 tokenId,
        string memory keyPrefix,
        string[] memory sourceArray
    ) private pure returns (string memory) {
        uint256 noise = deterministicNoise(
            string(abi.encodePacked(keyPrefix, tokenId.toString()))
        );
        return sourceArray[noise % sourceArray.length];
    }

    function getProfile(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "PROFILE", _profile);
    }

    function getInstructor(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "INSTRUCTOR", _instructor);
    }

    function getCommunityFriend(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "COMMUNITY_FRIEND", _communityFriend);
    }

    function getLeverage(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "LEVERAGE", _leverage);
    }

    function getExchange(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "EXCHANGE", _exchange);
    }

    function getShitcoin(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "SHITCOIN", _shitcoin);
    }

    function getTokenProject(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "TOKEN_PROJECT", _tokenProject);
    }

    function getProgram(uint256 tokenId) internal view returns (string memory) {
        return getAttribute(tokenId, "PROGRAM", _program);
    }
}
