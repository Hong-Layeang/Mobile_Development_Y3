class BankAccount {
  final int accountId;
  final String accountOwner;
  double _balance = 0.0;

  BankAccount({required this.accountId, required this.accountOwner, double? initialBalance}) {
    _balance = initialBalance ?? 0.0;
  }

  // get methods
  double get balance => _balance;

  void withdraw(double amount) {
    if (amount < 0) {
      throw ArgumentError('Withdrawal amount must be non-negative');
    }
    if (_balance - amount < 0) {
      throw Exception('Insufficient balance for withdrawal!');
    }
    _balance -= amount;
  }

  void credit(double amount) {
    if (amount < 0) {
      throw ArgumentError('Credit amount must be non-negative');
    }
    _balance += amount;
  }
}

class Bank {
  final String name;
  final List<BankAccount> _accounts = [];

  Bank({required this.name});

  BankAccount createAccount(int accountId, String accountOwner) {
    for (var acc in _accounts) {
      if (acc.accountId == accountId) {
        throw Exception('Account with ID $accountId already exists!');
      }
    }

    final account = BankAccount(accountId: accountId, accountOwner: accountOwner);
    _accounts.add(account);
    return account;
  }

  // get account by id
  BankAccount? getAccount(int accountId) {
    for (var a in _accounts) {
      if (a.accountId == accountId) return a;
    }
    return null;
  }
}
 
void main() {

  // Bank myBank = Bank(name: "CADT Bank");
  Bank myBank = Bank(name: 'CADT Bank');
  // BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  // print(ronanAccount.balance); // Balance: $0
  print('Balance: \$${ronanAccount.balance}');
  // ronanAccount.credit(100);
  ronanAccount.credit(100);
  // print(ronanAccount.balance); // Balance: $100
  print('Balance: \$${ronanAccount.balance}');
  // ronanAccount.withdraw(50);
  ronanAccount.withdraw(50);
  // print(ronanAccount.balance); // Balance: $50
  print('Balance: \$${ronanAccount.balance}');

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}

/*
UML (textual):

Bank
- name: String
- _accounts: List<BankAccount>
-- createAccount(accountId: int, accountOwner: String): BankAccount
-- getAccount(accountId: int): BankAccount?

BankAccount
- accountId: int
- accountOwner: String
- _balance: double
-- balance(): double
-- withdraw(amount: double): void
-- credit(amount: double): void

Relationship: Bank "composes" BankAccount (Bank has and manages accounts). Composition: Bank creates and owns BankAccount instances.
*/
