# shared-wallet
a shared wallet that holds funds in ETH and that can be funded by an admin. The admin  provides an allowance to a few users who can then spend it as per their allowance and till a certain time limit set by the admin.

The entire flow will work as follows :
1. Admin deploys a smart contract that acts as a shared wallet
2. Admin funds the wallet with some ETH, this will be the wallet’s total balance
3. Admin authorises certain wallet addresses to spend a certain amount of ETH from the wallet within a certain time limit
4. Finally, the users can spend the ETH within their allowance and time limit, as set by the admin
