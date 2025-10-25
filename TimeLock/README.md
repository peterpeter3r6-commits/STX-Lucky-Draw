# 🔐 TimeLock – Simple STX Vault with Unlock Time

> "Not everything should be spent today. Some treasures belong to tomorrow." ⏳  

This project is called **TimeLock**.  
It’s a **minimal yet powerful Clarity contract** that lets a user lock STX tokens until a chosen future block-height.  
Once the unlock time is reached, the user can withdraw their tokens.  

It’s simple, useful, and beautiful — **a blockchain-native piggy bank**.  
---

## ✨ Features
- 🔒 **Lock your STX** with an unlock block-height  
- ⏳ **Time-based release** – funds cannot be withdrawn early  
- 💎 **Secure & Fair** – only the locker can withdraw  
- 🌐 **Universal Use** – savings, allowances, future commitments  

---

## 🚀 How It Works

1. **Lock STX**

```clarity
(contract-call? .timelock lock u12345)
```

Locks the tokens you sent with this call until block 12,345.

2. **Withdraw STX**

```clarity
(contract-call? .timelock withdraw)
```

After block 12,345 you can withdraw your funds.

3. **Check Vault**

```clarity
(contract-call? .timelock get-vault tx-sender)
```

See your locked amount and unlock block.

---

## 🎨 Why TimeLock?

```clarity
(contract-call? .timelock get-vault tx-sender)
```

See your locked amount and unlock block.

---

## 🎨 Why TimeLock?

* 🌟 **Memorable:** Instead of a generic transfer, it tells a *story* of patience and planning.
* 🏦 **Practical:** Savings account, delayed allowance, or a smart escrow.
* 💡 **Simple:** Just \~40 lines of clean Clarity code.
* ⛓️ **Universal:** Works for anyone, anywhere, no complexity.
* 🕰️ **Timeless:** The concept of saving for the future is universally understood.
* 🔒 **Secure:** Only the locker can withdraw, and only after the unlock time.
* 📚 **Educational:** A great example for new Clarity developers to learn from.
* 🚀 **Demo-ready:** Perfect for quick presentations and hackathons.
* 🌍 **Real-world impact:** Encourages saving and financial discipline.
* 🧩 **Composable:** Can be integrated into larger DeFi or dApp ecosystems.
* 🛠️ **Extensible:** Can be enhanced with features like multi-user vaults or interest accrual.

TimeLock checks all the boxes.
In just one minute, you can demo locking coins, waiting a block, and withdrawing them.
It’s simple but **powerful**, and has real-world impact: *the blockchain as a savings vault.*

---

## 🌌 Vision

One day, people will use contracts like TimeLock to:

* Save for school fees
* Hold funds until a wedding day
* Delay access to inheritance
* Build discipline by holding their future selves accountable

This contract shows that **sometimes the best code is the simplest code**.

```
---
## 📜 License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
---


