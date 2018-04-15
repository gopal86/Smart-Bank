pragma solidity ^0.4.18;

contract Bank {
    address public Manager;
    // uint NoOfUsers=0;
    uint MinBalance;
    uint DepositLimit;
    uint WithdrawLimit;
    uint TransferLimit;
    
    
    function Bank() {
        Manager = msg.sender;
    }
    
    modifier Ifmanager() {
        require(msg.sender == Manager);
        _;
    }
        
    struct AccountInformation {
        string[] UserName;
        uint Balance;
        bool used;
    }
    
    mapping (bytes32 => AccountInformation) accounts;
    address[2][] public Users;

    
}

contract user_accounts is Bank {
    
    function user_accounts(uint MinBalance1 , uint DepositLimit1, uint WithdrawLimit1,uint TransferLimit1){
        MinBalance=MinBalance1;
        DepositLimit=DepositLimit1;
        WithdrawLimit=WithdrawLimit1;     
        TransferLimit=TransferLimit1;
    }
    
    event print(address _add1 , address _add2 , bytes32 _add , uint bala , bool ans);
    event prints(address _add1 , address _add2 , uint bala , uint val);

    function getLimit() constant returns(uint , uint , uint , uint ){
        return(MinBalance , DepositLimit , WithdrawLimit , TransferLimit);
    }
    
    function setAddUsers(address _address1 , address _address2 , string name1, string name2 , uint bal) Ifmanager {

        if(bal >= MinBalance){
            print(_address1 , _address2 , keccak256(_address1,_address2) , bal,accounts[keccak256(_address1,_address2)].used);
            
            if(accounts[keccak256(_address1,_address2)].used!=true){
                
                var account = accounts[keccak256(_address1,_address2)];
                
                account.UserName.push(name1) ;
                account.UserName.push(name2) ;
                account.Balance = bal;
                account.used = true;
                Users.push([_address1,_address2]) -1;
            }
            else{
                revert();
            }
        }
        else{
            revert();
        }
    }
    
    function getAddusers() view public returns(address[2][]){
        return (Users);
    }
    
    function getuserbalance(address _address1, address _address2)  view public returns(uint) {
        return(accounts[keccak256(_address1,_address2)].Balance);
        
    }
    
    
    function FundDeposit(address _address) payable
    {

        if(msg.value > DepositLimit){
            revert();
        }
        
        if(accounts[keccak256(msg.sender,_address)].Balance + msg.value < accounts[keccak256(msg.sender,_address)].Balance){
            revert();            
        }

        accounts[keccak256(msg.sender,_address)].Balance+=msg.value;
            
    }
    
    function FundWithdrawl(address _to1 , address _to2 , uint value ){
        prints(_to1,_to2 , accounts[keccak256(_to1,_to2)].Balance , value );
        if( (msg.sender != _to1) && (msg.sender != _to2)){
            revert();
        }
        if(value > WithdrawLimit || value < 0 ){
            revert();
        }
        if(accounts[keccak256(_to1,_to2)].Balance - value < MinBalance){
            revert();
        }
        accounts[keccak256(_to1,_to2)].Balance -=value;
    }
    
    
    
    function FundTransfer (address _from , address _to1  ,address _to2 , uint value ) {
        if(value >= TransferLimit) throw;
        if( accounts[keccak256(msg.sender,_from)].Balance < value ) throw;
        if( accounts[keccak256(msg.sender,_from)].Balance - value < MinBalance ) throw;
        if( accounts[keccak256(_to1,_to2)].Balance + value < accounts[keccak256(_to1,_to2)].Balance) throw;
        
        accounts[keccak256(msg.sender,_from)].Balance-=value;
        accounts[keccak256(_to1,_to2)].Balance+=value;
    
    }
    function DeleteUser(address _address1 , address _address2){
        if(msg.sender == _address1 || msg.sender == _address2){
            delete accounts[keccak256(_address1 , _address2)];
            Users = RemoveUser(_address1 , _address2);
        }
        else{
            revert();
        }
    }
    
    // event printing(address _add1 , address _add2 , address bala , uint8 index );
    
    
    function RemoveUser( address _address1, address _address2 ) returns(address[2][]){
        var index = uint256(-1);    
        
        for(uint i=0 ; i <Users.length;i++)
        {
            if(Users[i][0] == _address1 && Users[i][1] == _address2){
                index = i;
                break;
            }
        }
        for(uint j=index;j<Users.length-1;j++)
        {
            Users[j][0]=Users[j+1][0];
            Users[j][1]=Users[j+1][1];
        }
        delete Users[Users.length-1];
        Users.length--;
        return Users;
    //     printing(_address1 , _address2 , Users[2][1] , index);        
        
        
    }
}
