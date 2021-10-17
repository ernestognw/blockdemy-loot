//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./Base64.sol";
import "./BlockdemyLootAttributes.sol";

contract BlockdemyLoot is
    ERC721Enumerable,
    BlockdemyLootAttributes,
    ReentrancyGuard,
    VRFConsumerBase,
    Ownable
{
    using Base64 for bytes;
    using Strings for uint256;

    // Constants
    bytes32 private constant KEY_HASH =
        0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
    uint256 private constant FEE = 1 * (10**17); // 0.1 LINK
    address private constant VRF_COORDINATOR =
        0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B;
    address private constant LINK_ADDRESS = 0x01BE23585060835E02B77ef475b0Cc51aA1e0709;

    // Variables
    uint256 public maxSupply;
    mapping(uint256 => bool) public exists;
    bool revealed;

    // Modifier
    modifier onlyRevealed() {
        require(revealed, "Blockdemy Loot: Non revealed");
        _;
    }

    modifier onlyExistent(uint256 tokenId) {
        require(exists[tokenId], "Blockdemy Loot: Query non existent token");
        _;
    }

    // Constructor
    constructor(uint256 _maxSupply)
        ERC721("Blockdemy Loot", "BDMLOOT")
        VRFConsumerBase(VRF_COORDINATOR, LINK_ADDRESS)
    {
        maxSupply = _maxSupply;
    }

    // Funciones
    function mint(address _to, uint256 _tokenId) public nonReentrant {
        require(
            totalSupply() < maxSupply - 1,
            "Blockdemy Loot: There are not Blockdemys available"
        );

        exists[_tokenId] = true;
        _safeMint(_to, _tokenId);
    }

    function reveal() public onlyOwner returns (bytes32) {
        require(!revealed, "Blockdemy Loot: Already revealed");
        require(
            LINK.balanceOf(address(this)) >= FEE,
            "Not enough LINK - fill contract with faucet"
        );
        return requestRandomness(KEY_HASH, FEE);
    }

    function fulfillRandomness(bytes32, uint256 randomness)
        internal
        override
    {
        revealed = true;
        setRandom(randomness);
    }

    function profile(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getProfile(tokenId);
    }

    function instructor(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getInstructor(tokenId);
    }

    function communityFriend(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getCommunityFriend(tokenId);
    }

    function leverage(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getLeverage(tokenId);
    }

    function exchange(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getExchange(tokenId);
    }

    function shitcoin(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getShitcoin(tokenId);
    }

    function tokenProject(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
        returns (string memory)
    {
        return getTokenProject(tokenId);
    }

    function program(uint256 tokenId)
        public
        view
        onlyExistent(tokenId)
        onlyRevealed
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
        string memory image;

        if (revealed) {
            string memory output;

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

            output = string(
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

            image = string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    bytes(output).encode()
                )
            );
        } else {
            image = "https://pbs.twimg.com/profile_images/1372328154233253891/pay6uADW_400x400.png";
        }

        string memory json = abi
            .encodePacked(
                '{"name": "Tribe #',
                tokenId.toString(),
                '", "description": "Blockdemy Loot is a set of randomized Blockchain Academy Tribe attributes. Images are omitted intentionally for others to interpret. Feel free to use in any way you want. Perhaps to build next unicorn?", "image": "',
                image,
                '"}'
            )
            .encode();

        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
