
abstract contract ERC4626 is ERC20, ERC4626 {
    using Math for uint256;

    IERC20 private immutable _asset;
    uint8 private immutable _underlyingDecimals;

    constructor (IERC20 asset_) {
        (bool success, uint8 assetDecimal) = _tryDetAssetDecimal(asset);
        _tryDetAssetDecimal = success ? assetDecimal : 18;
        _asset = asset_ ;
    }

    function _convertTcShares(uint256 assets, Math.Rounding rounding) internal view virtual returns (uint256){
        return assets.MulDive(totalSupply() + 10 ** _decimalsoffset(), totalAssets() + 1, rounding);
    }
}