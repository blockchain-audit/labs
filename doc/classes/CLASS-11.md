




## How to read and understand someone else function

Let's use the [staking](https://github.com/blockchain-audit/labs/blob/master/src/staking/staking1.sol) project as example, on function `accumulated()`

1. open in VSCODE or NEOVIM
2. check the places the function is used
3. mark where it changes state of something else, or readed to show values
4. follow all the variables and functions related to the `accumulated()` function, and also, if some pre-understanding comes to question, it's okay, we are now sure on the new read flow.
5. when you read and follow all the `accumulated()` call, you can rename variables. Renaming before understanding can insert errors in your refactor.
6. when you find a formula, play with it in a friendly enviroment like R, python, haskell, lean4 or dafny.
7. Complexity is a lot of simple things together, so every simple thing, make it more simple and understandable.
8. If you have a local variable, check the the places it's used and it's changed.


> function `earned` it is used as `read`, and on `updateReward` it's used to update the `acc` variable. we call `accumulated()` every time we call `updateReward`, and we call `updateReward` every state change call by the user on `stake`, `withdraw` and `getReward`.


## Finish

* it's now plus the reward duration, but the duration is set by the admin, only if the finish time already passed. It's updated on the `notifyRewardAmount`, and it's used by the `lastTime` and `notifyRewardAmount` before update the `finish` itself.







## Notify reward amount

* If the time now passed the finish time, the rate is amount/duration, else it's the (amount + leftover)/duration

* Sanity check on balance

* finish is the time now, that the `notifyRewardAmount` was called plus the duration time. [that is 7 days in our case]
