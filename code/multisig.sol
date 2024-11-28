// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract SimpleMultisig {
    uint constant public MAX_OWNER_COUNT = 7;
    
    mapping(address => bool) public owners;
    uint public required;
    uint public transactionCount;
    
    struct Transaction {
        address from;      
        address to;        
        uint value;        
        bytes data;
        bool executed;
        uint confirmations;
        address token;
    }
    
    mapping(uint => Transaction) public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;
    
    event TransactionSubmitted(
        uint indexed transactionId, 
        address indexed from, 
        address indexed to, 
        uint value, 
        address token
    );
    event TransactionConfirmed(uint indexed transactionId, address indexed owner);
    event TransactionExecuted(uint indexed transactionId);
    
    modifier onlyOwner() {
        bool isOwner = false;
        isOwner = owners[msg.sender];
        require(isOwner, "Not an owner");
        _;
    }
    
    modifier transactionExists(uint transactionId) {
        require(transactions[transactionId].to != address(0), "Transaction does not exist");
        _;
    }
    
    modifier notExecuted(uint transactionId) {
        require(!transactions[transactionId].executed, "Transaction already executed");
        _;
    }
    
    modifier notConfirmed(uint transactionId) {
        require(!confirmations[transactionId][msg.sender], "Transaction already confirmed");
        _;
    }

    modifier validRequirement(uint ownerCount, uint _required) {
        require (ownerCount <= MAX_OWNER_COUNT
                && _required <= ownerCount
                && _required >= 1);
        _;
    }
    
    constructor(address[] memory _owners, uint _required) validRequirement(_owners.length, _required) {

        for (uint i = 0; i < _owners.length; i++) {
            //onwer should be distinct, and non-zero
            if (owners[_owners[i]] || _owners[i] == address(0)) {
                revert();
            }
            owners[_owners[i]] = true;
        }

        required = _required;
    }
    
    // Unified function to submit both ETH and token transfers
    function submitTransaction(
        address _to,
        uint _value,
        address _token
    ) public payable onlyOwner {
        require(_to != address(0), "Invalid recipient address");
        require(_to != msg.sender, "Cannot send to yourself");
        
        // Check if it's an ETH transfer
        if (_token == address(0)) {
            require(msg.value == _value, "Sent ETH must match value");
        } else {
            // For token transfers
            if (_value > 0) {
                // Only check balance and allowance if value is greater than 0
                require(IERC20(_token).balanceOf(msg.sender) >= _value, "Insufficient token balance");
                require(
                    IERC20(_token).allowance(msg.sender, address(this)) >= _value,
                    "Insufficient allowance for multisig contract"
                );
            }
        }

        uint transactionId = transactionCount;
        
        // Prepare transfer data for token transactions
        bytes memory data = "";
        if (_token != address(0)) {
            data = abi.encodeWithSignature(
                "transferFrom(address,address,uint256)", 
                msg.sender,
                _to,
                _value
            );
        }
        
        transactions[transactionId] = Transaction({
            from: msg.sender,
            to: _to,
            value: _value,
            data: data,
            executed: false,
            confirmations: 0,
            token: _token
        });
        
        transactionCount += 1;
        emit TransactionSubmitted(transactionId, msg.sender, _to, _value, _token);
    }
    
    function confirmTransaction(uint transactionId) 
        public 
        onlyOwner 
        transactionExists(transactionId)
        notExecuted(transactionId)
        notConfirmed(transactionId)
    {
        Transaction storage transaction = transactions[transactionId];
        transaction.confirmations += 1;
        confirmations[transactionId][msg.sender] = true;
        
        emit TransactionConfirmed(transactionId, msg.sender);
        
        if (transaction.confirmations >= required) {
            executeTransaction(transactionId);
        }
    }
    
    function executeTransaction(uint transactionId) 
        internal
        transactionExists(transactionId)
        notExecuted(transactionId)
    {
        Transaction storage transaction = transactions[transactionId];
        require(transaction.confirmations >= required, "Not enough confirmations");
        
        transaction.executed = true;

        if (transaction.token == address(0)) {
            // Execute ETH transfer
            if (transaction.value > 0) {
                (bool success,) = transaction.to.call{value: transaction.value}("");
                require(success, "ETH transfer failed");
            }
        } else {
            // Execute token transfer
            if (transaction.value > 0) {
                require(
                    IERC20(transaction.token).allowance(transaction.from, address(this)) >= transaction.value,
                    "Allowance reduced below required amount"
                );
                (bool success,) = transaction.token.call(transaction.data);
                require(success, "Token transfer failed");
            }
        }
        
        emit TransactionExecuted(transactionId);
    }

    function listTransactions() public view returns (Transaction[] memory) {
        require(transactionCount > 0, "No transactions");
        Transaction[] memory _transactions = new Transaction[](transactionCount);
        for(uint i = 0; i < transactionCount; i++) {
            _transactions[i] = transactions[i];
        }
        return _transactions;
    }
    
    receive() external payable {}
}

/*
["0x7D85288a2a3a5196Fb66aeB0e4684c47b1edE9E0", "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"]

0x0000000000000000000000000000000000000000
*/