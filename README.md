# Smart-Bank
#### A smart contract that will perform most of the functions of a traditional bank written in solidity ( Check the [PDF](https://github.com/gopal86/Smart-Bank/blob/master/DTB_assignment2.pdf) for further infotmation )

#### Instructions for Installing/running solidity (.sol file)  :
- Install [Solidity](https://app.simplenote.com/p/CGxR54)
#### OR
- Run the .sol file on [Remix](https://remix.ethereum.org) if you dont want to install Solidity :smile:

Create `user_accounts` contract.
Enter `MinBalance DepositLimit WithdrawLimit TransferLimit` while creating the contract 
##### NOTE :- The values should be comma separated.

The address with which you created the contract is the head/manager of the bank. Only that address now can add accounts.

There can be two types of accounts :- `single type account` or `joint account`.

So, If the account is Single type :- The 'second address' in `setAddUser` is `0x0` other wise the address of the second user.

Functions :
```
setAddUser :- Creating the account, but the msg.sender address should be of the head/manager as only he/she can create any user. Enter the names and initial balance with which you want to initialize the account.
getAddUser :- Can Check who all are having the accounts.
FundTransfer :- Can transfer money from one account to other persons account. The message.sender should be the person who wants to send money to other person's account
FundWithdrawl :- Can withdraw money from the account. Message.sender should be the account holder.
RemoveUser :- Is called from the DeleteUser function() . Removes the User's Accounts.
DeleteUser :- Can delete the account. Will also call RemoveUser to remove the identites from the database. Message Sender should be one whose account is going to be deleted.
```


