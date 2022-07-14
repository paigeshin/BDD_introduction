# Document

[https://dannorth.net/introducing-bdd/](https://dannorth.net/introducing-bdd/)

[https://docs.microsoft.com/en-us/archive/msdn-magazine/2010/december/msdn-magazine-bdd-primer-behavior-driven-development-with-specflow-and-watin](https://docs.microsoft.com/en-us/archive/msdn-magazine/2010/december/msdn-magazine-bdd-primer-behavior-driven-development-with-specflow-and-watin)

# Behavior Driven Development

- BDD is a set of software engineering practices to design teams build a better software.
- Provide Context
- BDD is based on the Scenario
- TDD works on isolation
- TDD (Model Tests ⇒ Controller Tests ⇒ Integration Tests) ⇒ inside out
- BDD
- BDD (Integration Tests ⇒ Controller Tests ⇒ Model Tests) ⇒ outside in
- BDD is for Business Values

### TDD Way

```swift
func test_withdrawFromInsufficientBalance() {

}

func test_withdrawFunds() {

}

func test_initialBalanceZero() {

}
```

### BDD Way

```swift
class When_creating_a_bank_account: XCTestCase {
    
    func test_should_initialize_the_account_with_zero_balance() {

    }    

}

class When_making_a_deposit_to_bank_account: XCTestCase {
    
    func test_should_make_sure_amount_deposited_succesfully() {

    }    

}

class When_withdrawing_funds_from_account: XCTestCase {
    
    func test_should_make_sure_amount_is_deducted_succesfully() {

    }

    func test_should_throw_exception_when_insufficient_funds() {

    }

}
```

⇒ Descriptive Name For The Tests  

⇒ Provide more context 

⇒ class with context of tests 

### BDD Characteristics

- Test becomes behavior
- Clarity
- Easier to maintain

---

# GHERKIN

- Domain specific language which helps you to describe business behavior without the need to go into detail of implementation

### Gherkin Syntax

- Feature: Tile of the Scenario
- Given: [Preconditions or Initial Context]
- When: [Event or Trigger]
- Then: [Expected output]

### Important Terms used in Gherkin

- Feature
- Background
- Scenario
- Given
- When
- Then
- And
- But

### Example 1)

- Feature: Login functionality of social networking site Facebook.
- Given: I am a facebook user
- When: I enter username as username
- And I enter the password as the password
- Then I should be redirected to the home page of facebook

### Example 2)

- Feature: User Authentication Background:
- Given the user is already registered to the website Scenario:
- Given the user is on the login page
- When the user inputs the correct email address
- And the user inputs the correct password
- And the user clicks the Login button
- Then the user should be authenticated
- And the user should be redirected to their dashboard
- And the user should be presented with a success message

---

# Benefits of BDD

1. Reduced Waste
    - Promotes clear communication between developers, testers and business people
    - Discourages reworking the feature since teams are focused on solving the business needs
    - Enables faster and useful feedback to the users
2. Reduced Cost
    - Reduced waste is directly proportional to reduced cost
    - Features that produce business value
    - Reduced delivery time
3. Easier and Safer Changes
    - BDD makes it easier to change your application
    - Specifications act as a technical documentation
    - BDD practices product automated acceptance and unit tests
4. Faster Release

---

# Challenges of BDD

1. BDD requires high business engagement and collaboration 
2. BDD works best in an Agile or iterative context 
3. BDD does not work well in a silo
4. Poorly written tests can lead to higher test-maintenance costs 

---

# TDD

```swift
import XCTest
@testable import WritingFirstTest

class BankAppTests: XCTestCase {
    
    private var account: Account!
    
    override func setUp() {
        super.setUp()
        self.account = Account()
    }
    
    func test_InitialBalanceZero() {
        XCTAssertTrue(account.balance == 0, "Balance is not zero!")
    }
    
    func test_DepositFunds() {
        account.deposit(100)
        XCTAssertEqual(100.0, account.balance)
    }
    
    func test_WithdrawFunds() {
        self.account.deposit(100)
        try! self.account.withdraw(50)
        XCTAssertEqual(50, self.account.balance)
    }
    
    func test_WithdrawFromInsufficientFunds() {
        self.account.deposit(100)
        XCTAssertThrowsError(try self.account.withdraw(300)) { error in
            XCTAssertEqual(error as! AccountError, AccountError.insufficientFunds)
        }
        XCTAssertEqual(100, self.account.balance)
    }
    
    override func tearDown() {
        super.tearDown()
        self.account = nil
    }
    
}
```

---

# BDD

```swift
import XCTest
@testable import WritingFirstTest

class Setup_Account: XCTestCase {
    
    var account: Account!
    
    override func setUp() {
        self.account = Account()
    }
    
}

class When_creating_a_bank_account: Setup_Account {
    
    func test_should_initialize_the_account_with_zeo_balance() {
        XCTAssertEqual(0, self.account.balance)
    }
    
}

class When_depositing_money_into_bank_account: Setup_Account {
    
    func test_should_deposit_succesfully() {
        account.deposit(100)
        XCTAssertEqual(100, self.account.balance)
    }
    
}

class When_withdrawing_funds_from_account: Setup_Account {
    
    func test_should_make_sure_amount_is_deducted_successfully() {
        self.account.deposit(100)
        try! self.account.withdraw(50)
        XCTAssertEqual(50, self.account.balance)
    }
    
    func test_should_throw_exception_when_insufficient_funds() {
        self.account.deposit(100)
        XCTAssertThrowsError(try self.account.withdraw(300)) { error in
            XCTAssertEqual(error as! AccountError, AccountError.insufficientFunds)
        }
    }
    
}
```
