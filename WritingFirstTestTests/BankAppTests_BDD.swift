//
//  BankAppTests_BDD.swift
//  WritingFirstTestTests
//
//  Created by paige shin on 2022/07/15.
//

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
