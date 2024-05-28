## FriendtechShares Contract: User Stories and Acceptance Criteria

Based on the provided FriendtechShares V1 contract code, here are some user stories and acceptance criteria:

**User Roles:**

* **Shares Subject:** Represents the entity issuing the shares (e.g., company, project).
* **Trader:** Represents an individual buying or selling shares.

**User Stories:**

**1. As a Shares Subject, I want to set the fee destination for protocol and subject fees.**

* **Acceptance Criteria:**
    * Owner can set the `protocolFeeDestination` address.
    * Owner can set the `protocolFeePercent`.
    * Owner can set the `subjectFeePercent`.
    * Changes are reflected in the respective variables.

**2. As a Trader, I want to see the buy and sell price of a specific share.**

* **Acceptance Criteria:**
    * `getBuyPrice` and `getSellPrice` functions return the correct price based on the share's supply and amount.
    * Prices are calculated using the provided pricing formula.

**3. As a Trader, I want to see the buy and sell price considering fees.**

* **Acceptance Criteria:**
    * `getBuyPriceAfterFee` and `getSellPriceAfterFee` functions return the correct price adjusted for protocol and subject fees.
    * Fee calculations are accurate based on the set percentages.

**4. As a Trader, I want to buy shares of a specific subject.**

* **Acceptance Criteria:**
    * `buyShares` function allows buying shares with sufficient ETH payment.
    * Shares are correctly credited to the trader's balance.
    * Share supply is updated accordingly.
    * Protocol and subject fees are deducted and sent to respective destinations.
    * `Trade` event is emitted with relevant details.
    * Transaction reverts if payment is insufficient, share subject doesn't exist, or share purchase violates rules (e.g., buying the last share).

**5. As a Trader, I want to sell shares of a specific subject.**

* **Acceptance Criteria:**
    * `sellShares` function allows selling shares owned by the trader.
    * Shares are deducted from the trader's balance.
    * Share supply is updated accordingly.
    * Protocol and subject fees are deducted and sent to respective destinations.
    * Trader receives ETH based on the selling price after fees.
    * `Trade` event is emitted with relevant details.
    * Transaction reverts if trader doesn't own enough shares, selling violates rules (e.g., selling the last share).

**Additional Notes:**

* These are just some basic user stories, and more can be added to cover other functionalities or edge cases.
* Acceptance criteria can be further detailed and quantified based on specific requirements.
* The provided code snippet doesn't include event definitions or final pricing model details, so some acceptance criteria might need adjustments based on the complete implementation.


