// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import "./IKoffeeSwapRouter.sol";

import "./IUniswapV2Router02.sol";
import "./IUniswapV2Factory.sol";


contract KuDogeRouter is Ownable, IKoffeeSwapRouter{
    using Address for address;

    address private __factory;
    address private __WKCS;

    IUniswapV2Router02 public UniRouter;
    IUniswapV2Factory public UniFactory;

    constructor(address _uniRouter, address _uniFactory)  {
        UniRouter = IUniswapV2Router02(_uniRouter);
        UniFactory = IUniswapV2Factory(_uniFactory);
        __factory = _uniFactory;
        __WKCS = UniRouter.WETH();
    }  

    receive() external payable {
        assert(msg.sender == __WKCS); // only accept KCS via fallback from the WKCS contract
    }

    function factory() external override view returns (address){
        return __factory;
    }
    function WKCS() external override view returns (address){
        return __WKCS;
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external virtual override returns (uint amountA, uint amountB, uint liquidity){
        return (0,0,0);
    }
    function addLiquidityKCS(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountKCSMin,
        address to,
        uint deadline
    ) external override payable returns (uint amountToken, uint amountKCS, uint liquidity){
        IERC20(token).transferFrom(msg.sender, address(this), amountTokenDesired);

        IERC20(token).approve(address(UniRouter), amountTokenDesired);

        (amountToken, amountKCS, liquidity) = UniRouter.addLiquidityETH {value: msg.value} (token, amountTokenDesired, amountTokenMin, amountKCSMin, to, deadline);
    }
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external virtual override returns (uint amountA, uint amountB){
        return (0,0);
    }
    function removeLiquidityKCS(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountKCSMin,
        address to,
        uint deadline
    ) external virtual override returns (uint amountToken, uint amountKCS){
        return (0,0);
    }
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountA, uint amountB){
        return (0,0);
    }
    function removeLiquidityKCSWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountKCSMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountToken, uint amountKCS){
        return (0,0);
    }
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override returns (uint[] memory amounts){
        amounts = new uint[](0);
    }
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override returns (uint[] memory amounts){
        amounts = new uint[](0);
    }
    function swapExactKCSForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        virtual
        override
        payable
        returns (uint[] memory amounts){            
        amounts = new uint[](0);
    }
    function swapTokensForExactKCS(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        virtual
        override
        returns (uint[] memory amounts){
        amounts = new uint[](0);
    }
    function swapExactTokensForKCS(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        virtual
        override
        returns (uint[] memory amounts){
        amounts = new uint[](0);
    }
    function swapKCSForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        virtual
        override
        payable
        returns (uint[] memory amounts){
        amounts = new uint[](0);
    }

    function quote(uint amountA, uint reserveA, uint reserveB) external virtual override pure returns (uint amountB){
        return 0;
    }
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external virtual override pure returns (uint amountOut){
        return 0;
    }
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external virtual override pure returns (uint amountIn){
        return 0;
    }
    function getAmountsOut(uint amountIn, address[] calldata path) external virtual override view returns (uint[] memory amounts){
        amounts = new uint[](0);
    }
    function getAmountsIn(uint amountOut, address[] calldata path) external virtual override view returns (uint[] memory amounts){
        amounts = new uint[](0);
    }

    function removeLiquidityKCSSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountKCSMin,
        address to,
        uint deadline
    ) external virtual override returns (uint amountKCS){
        return 0;
    }
    function removeLiquidityKCSWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountKCSMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountKCS){
        return 0;
    }

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override{
        
    }
    function swapExactKCSForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override payable{
        
    }
    function swapExactTokensForKCSSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external override{
        IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);

        IERC20(path[0]).approve(address(UniRouter), amountIn);

        UniRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(amountIn, amountOutMin, path, to, deadline);
    }



     //fallbacks if an accident happens, contract should never store any balances
    function withdrawKCS () external onlyOwner {
		payable(owner()).transfer(address(this).balance);
	}

    function withdrawAnyToken(address _contract) external onlyOwner {
		IERC20(_contract).transfer(owner(), IERC20(_contract).balanceOf(address(this)));
	} 

    function changeRouterFactory(address _uniRouter, address _uniFactory) external onlyOwner {
        UniRouter = IUniswapV2Router02(_uniRouter);
        UniFactory = IUniswapV2Factory(_uniFactory);
        __factory = _uniFactory;
        __WKCS = UniRouter.WETH();
    }
}