// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {PBTSimple} from "@chiru-pbt/PBTSimple.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BoundNFT is PBTSimple, Ownable {
    uint256 public supply;
    bool public canMint;

    string private _baseTokenURI;

    constructor(string memory name_, string memory symbol_) PBTSimple(name_, symbol_) {}

    function mintPbt(bytes calldata signatureFromChip, uint256 blockNumberUsedInSig) external {
        _mintTokenWithChip(signatureFromChip, blockNumberUsedInSig);
        unchecked {
            ++supply;
        }
    }

    function seedChipToTokenMapping(
        address[] calldata chipAddresses,
        uint256[] calldata tokenIds,
        bool throwIfTokenAlreadyMinted
    )
        external
        onlyOwner
    {
        _seedChipToTokenMapping(chipAddresses, tokenIds, throwIfTokenAlreadyMinted);
    }

    function updateChips(address[] calldata chipAddressesOld, address[] calldata chipAddressesNew) external onlyOwner {
        _updateChips(chipAddressesOld, chipAddressesNew);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }
}
