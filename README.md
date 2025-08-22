# STX Lucky Draw
 # 🎲 STX Lucky Draw

A **decentralized lottery** built on Stacks.  
Players buy tickets using STX, and when the draw is called, one lucky player wins **the entire jackpot**.  

---

## ✨ Features
- 🎟️ **Buy Tickets** with STX  
- 💰 **Jackpot Pot** grows as more people join  
- 🎉 **Random Winner Selection** via block height  
- 🔄 **Auto Reset** for new rounds  
- 🔒 **Transparent & On-Chain**  

---

## 🚀 Example Flow

### 1. Buy a Ticket
```clarity
(contract-call? .lucky-draw buy-ticket)

