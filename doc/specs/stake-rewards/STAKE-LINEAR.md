## Discrete staking rewards with linearly increasing stake

* [question](https://ethereum.stackexchange.com/questions/139823/discrete-staking-rewards-with-linearly-increasing-stake)

I am implementing a Staking Pool of ERC20 tokens. Users can deposit any number of tokens, but only until a predefined block number when the staking actually starts. They do not earn any rewards until that block has passed, which locks deposits.

Rewards given to stakers are in another ERC20 token and arrive in a discrete manner from another contract at arbitrary times. Meaning that, at any given block, a certain number of reward tokens (possibly 0) are deposited on the staking pool contract, and they should be distributed to stakers for claiming/harvesting proportionally to their amount of staked tokens at that point in time.

Up until here, the contract could easily be derived from Solidity by Example's Discrete Staking Rewards.

### The twist is...
At the beginning of staking (predefined block number D), not 100% of user's tokens are immediately staked, but only a predefined ratio B%. After that date, an affine function is used, unlocking and staking A% per block without the need for user intervention, and until all deposited tokens are staked.

**General timeline:**

- at block D+0, B% of all users' deposits are staked;
- at block D+i, (B + i*A)% of all user's deposits are staked, with 0 < i < (100-B)/A;
- at block D+(100-B)/A and from then on, all user's deposits are entirely staked.

Users can also withdraw all or part of their staked tokens at any time, and it only affects their rewards: the A% per block unlock is still computed from their original investment at block D.

**Example:**

Let's say that the contract is deployed with parameters D = block 1000, A = 1%/block and B = 50%.
You deposit 200 ERC20 tokens on block 999 or before. I also deposit 300 ERC20 tokens.

- at block D+0 = 1000, a total of (200 + 300) * 50% = 250 tokens are staked.
- at block D+10 = 1010, a total of (200 + 300) * (50% + 10 * 1%) = 300 tokens are staked.
- on the same block, 10000 reward tokens are deposited. You earn 4000, I earn 6000.
- at block D+20 = 1020, I withdraw 100 out of my maximum of 300 * (50% + 20 * 1%) = 210 staked tokens. I am left with 110 staked tokens and 90 pending tokens.
- on the same block, 1000 reward tokens are deposited. You earn 560, I earn 440.
- at block D+30 = 1030, a total of (200 + 300) * (50% + 30 * 1%) - 100 = 300 ERC20 tokens are staked.
- at block D+50 = 1050, all remaining tokens are finally staked: (200 + 300) * (50% + 50 * 1%) - 100 = 400.
- on the same block, 1000 reward tokens are deposited. We each earn 500.
- on the next block, we both withdraw all of our 200 staked tokens each.


Question: how can I compute a user's rewards ?

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingPool {
    uint256 public constant MULTIPLIER = 1e18;

    IERC20 public immutable stakedToken;
    IERC20 public immutable rewardToken;

    uint256 public immutable stakingStartBlock;
    uint256 public immutable initialStakingRatio;
    uint256 public immutable progressiveStakingBlocks;

    struct InvestorInfo {
        uint256 depositedAmount;
        uint256 withdrawedAmount;
        uint256 claimedRewardIndex;
    }

    mapping(address => InvestorInfo) private investorInfo;
    uint256 private rewardIndex;
    uint256 private totalDepositedAmount;
    uint256 private totalWithdrawedAmount;

    constructor(
        address _stakedToken,
        address _rewardToken,
        uint256 _stakingStartBlock,
        uint256 _initialStakingRatio,
        uint256 _progressiveStakingBlocks
    ) {
        stakedToken = IERC20(_stakedToken);
        rewardToken = IERC20(_rewardToken);

        stakingStartBlock = _stakingStartBlock;
        initialStakingRatio = _initialStakingRatio;
        progressiveStakingBlocks = _progressiveStakingBlocks;
    }

    function deposit(uint256 amount) external {
        require(block.number < stakingStartBlock, "deposit phase has ended");

        stakedToken.transferFrom(msg.sender, address(this), amount);

        investorInfo[msg.sender].depositedAmount += amount;
        totalDepositedAmount += amount;
    }

    function withdraw(uint256 amount) external {
        require(
            block.number >= stakingStartBlock,
            "staking phase hasn't started"
        );

        _claim();

        require(amount <= stakeOf(msg.sender), "insufficient stake");

        investorInfo[msg.sender].withdrawedAmount += amount;
        totalWithdrawedAmount += amount;

        stakedToken.transfer(msg.sender, amount);
    }

    function updateRewards(uint256 rewards) external {
        require(
            block.number >= stakingStartBlock,
            "staking phase hasn't started"
        );

        rewardToken.transferFrom(msg.sender, address(this), rewards);

        rewardIndex += (rewards * MULTIPLIER) / totalStake();
    }

    function claim() external {
        require(
            block.number >= stakingStartBlock,
            "staking phase hasn't started"
        );

        require(_claim() != 0, "no rewards to claim");
    }

    function totalStake() public view returns (uint256) {
        if (block.number < stakingStartBlock) return 0;

        uint256 elapsed = block.number - stakingStartBlock;
        if (elapsed >= progressiveStakingBlocks)
            return totalDepositedAmount - totalWithdrawedAmount;

        uint256 initialStake = (totalDepositedAmount * initialStakingRatio) /
            MULTIPLIER;

        uint256 linearStake = ((totalDepositedAmount - initialStake) *
            elapsed) / progressiveStakingBlocks;

        return initialStake + linearStake - totalWithdrawedAmount;
    }

    function stakeOf(address user) public view returns (uint256) {
        if (
            block.number < stakingStartBlock ||
            investorInfo[user].depositedAmount == 0
        ) return 0;

        uint256 elapsed = block.number - stakingStartBlock;
        if (elapsed >= progressiveStakingBlocks)
            return
                investorInfo[user].depositedAmount -
                investorInfo[user].withdrawedAmount;

        uint256 initialStake = (investorInfo[user].depositedAmount *
            initialStakingRatio) / MULTIPLIER;

        uint256 linearStake = ((investorInfo[user].depositedAmount -
            initialStake) * elapsed) / progressiveStakingBlocks;

        return initialStake + linearStake - investorInfo[user].withdrawedAmount;
    }

    function rewardsOf(address user) public view returns (uint256) {
        return
            (stakeOf(user) *
                (rewardIndex - investorInfo[user].claimedRewardIndex)) /
            MULTIPLIER;
    }

    function _claim() private returns (uint256) {
        require(
            block.number >= stakingStartBlock,
            "staking phase hasn't started"
        );

        uint256 rewards = rewardsOf(msg.sender);
        investorInfo[msg.sender].claimedRewardIndex = rewardIndex;

        if (rewards != 0) rewardToken.transfer(msg.sender, rewards);

        return rewards;
    }
}
```


The function rewardsOf above is incorrect because it uses the stakeOf value at the time of claim, and not at the time where rewardIndex was computed. So its value may have increased in between.



## Answer


Answering my own question, as I was able to find a solution which solves the issue in the question and passes all tests that I threw at it (for now).

Instead of using totalStake() as denominator when updating rewards, one can use totalShares = totalDepositedAmount - totalWithdrawedAmount.
When claiming, we then use the similar formula shares = depositedAmount - withdrawedAmount as numerator.

This new shares value only changes when a user withdraws tokens (or deposits, but in the case of this implementation, no-one can deposit in the middle of staking).
So, from what I can see, this has the drawback that ALL rewards MUST be claimed before depositing and withdrawing, otherwise rewards are skewed.
But that was already the case in my implementation anyways, so it is definitely not an issue for me.

Here are the changes I made:



```solidity
@@ -15,14 +15,1 @@ contract StakingPool {
     uint256 public immutable progressiveStakingBlocks;

     struct InvestorInfo {
         uint256 depositedAmount;
-        uint256 withdrawedAmount;
+        uint256 shares;
         uint256 claimedRewardIndex;
     }

     mapping(address => InvestorInfo) private investorInfo;
     uint256 private rewardIndex;
     uint256 private totalDepositedAmount;
-    uint256 private totalWithdrawedAmount;
+    uint256 private totalShares;

     constructor(
         address _stakedToken,
@@ -45,7 +45,9 @@ contract StakingPool {
         stakedToken.transferFrom(msg.sender, address(this), amount);

         investorInfo[msg.sender].depositedAmount += amount;
+        investorInfo[msg.sender].shares += amount;
         totalDepositedAmount += amount;
+        totalShares += amount;
     }

     function withdraw(uint256 amount) external {
@@ -56,10 +58,10 @@ contract StakingPool {

         _claim();

-        require(amount <= stakeOf(msg.sender), "insufficient stake");
+        require(amount <= balanceOf(msg.sender), "insufficient stake");

-        investorInfo[msg.sender].withdrawedAmount += amount;
-        totalWithdrawedAmount += amount;
+        investorInfo[msg.sender].shares -= amount;
+        totalShares -= amount;

         stakedToken.transfer(msg.sender, amount);
     }
@@ -72,7 +74,7 @@ contract StakingPool {

         rewardToken.transferFrom(msg.sender, address(this), rewards);

-        rewardIndex += (rewards * MULTIPLIER) / totalStake();
+        rewardIndex += (rewards * MULTIPLIER) / totalShares;
     }

     function claim() external {
@@ -84,33 +86,17 @@ contract StakingPool {
         require(_claim() != 0, "no rewards to claim");
     }

-    function totalStake() public view returns (uint256) {
-        if (block.number < stakingStartBlock) return 0;
-
-        uint256 elapsed = block.number - stakingStartBlock;
-        if (elapsed >= progressiveStakingBlocks)
-            return totalDepositedAmount - totalWithdrawedAmount;
-
-        uint256 initialStake = (totalDepositedAmount * initialStakingRatio) /
-            MULTIPLIER;
-
-        uint256 linearStake = ((totalDepositedAmount - initialStake) *
-            elapsed) / progressiveStakingBlocks;
-
-        return initialStake + linearStake - totalWithdrawedAmount;
+    function sharesOf(address user) public view returns (uint256) {
+        return investorInfo[user].shares;
     }

-    function stakeOf(address user) public view returns (uint256) {
-        if (
-            block.number < stakingStartBlock ||
-            investorInfo[user].depositedAmount == 0
-        ) return 0;
+    function balanceOf(address user) public view returns (uint256) {
+        if (block.number < stakingStartBlock || investorInfo[user].shares == 0)
+            return 0;

         uint256 elapsed = block.number - stakingStartBlock;
         if (elapsed >= progressiveStakingBlocks)
-            return
-                investorInfo[user].depositedAmount -
-                investorInfo[user].withdrawedAmount;
+            return investorInfo[user].shares;

         uint256 initialStake = (investorInfo[user].depositedAmount *
             initialStakingRatio) / MULTIPLIER;
@@ -118,12 +104,15 @@ contract StakingPool {
         uint256 linearStake = ((investorInfo[user].depositedAmount -
             initialStake) * elapsed) / progressiveStakingBlocks;

-        return initialStake + linearStake - investorInfo[user].withdrawedAmount;
+        uint256 withdrawedAmount = investorInfo[user].depositedAmount -
+            investorInfo[user].shares;
+
+        return initialStake + linearStake - withdrawedAmount;
     }

     function rewardsOf(address user) public view returns (uint256) {
         return
-            (stakeOf(user) *
+            (investorInfo[user].shares *
                 (rewardIndex - investorInfo[user].claimedRewardIndex)) /
             MULTIPLIER;
     }
```

