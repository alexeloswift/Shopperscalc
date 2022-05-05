//
//  CalculatorTests.swift
//  ShopperscalcTests
//
//  Created by Alexis Diaz on 5/4/22.
//

import XCTest
@testable import Shopperscalc

class CalculatorTests: XCTestCase {
    
    let calculatorViewModel = CalculatorVM()
    
    
    func testcalculateNewTotal() {
        
        // testing initial state
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.discountPercentage, 20)
        
        let newTotal = calculatorViewModel.calculateNewTotal(price: "10", discountPercentage: 20)
        
        XCTAssertEqual(newTotal, 8)
    }
    
    func testcalculateTaxAmount() {
        
        // testing initial state
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.discountPercentage, 20)
        XCTAssertEqual(calculatorViewModel.taxPercentage, 0.07)
        
        let taxAmount = calculatorViewModel.calculateTaxAmount(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        XCTAssertEqual(taxAmount, 0.56)
        
    }
    
    func testcalculateNewTotalWithTax() {
        
        // testing initial state
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.discountPercentage, 20)
        XCTAssertEqual(calculatorViewModel.taxPercentage, 0.07)
        
        let newTotalWithTax = calculatorViewModel.calculateNewTotalWithTax(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        XCTAssertEqual(newTotalWithTax, 8.56)
        
    }
    
    func testpresentCalculation() {
        
        // testing initial state
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.discountPercentage, 20)
        XCTAssertEqual(calculatorViewModel.taxPercentage, 0.07)
        
        let newTotal = calculatorViewModel.calculateNewTotal(price: "10", discountPercentage: 20)
        let taxAmount = calculatorViewModel.calculateTaxAmount(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        let newTotalWithTax = calculatorViewModel.calculateNewTotalWithTax(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        
        calculatorViewModel.priceAfterDiscount = newTotal
        calculatorViewModel.priceAfterDiscountWithTax = newTotalWithTax
        calculatorViewModel.taxesAmountAfterDiscount = taxAmount
        
        
        XCTAssertEqual(calculatorViewModel.priceAfterDiscount, 8)
        XCTAssertEqual(calculatorViewModel.priceAfterDiscountWithTax, 8.56)
        XCTAssertEqual(calculatorViewModel.taxesAmountAfterDiscount, 0.56)
        
        
        
    }
    
    func testreset() {
        
        // testing initial state
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.discountPercentage, 20)
        XCTAssertEqual(calculatorViewModel.taxPercentage, 0.07)
        
        calculatorViewModel.reset()
        
        XCTAssertEqual(calculatorViewModel.price, "")
        XCTAssertEqual(calculatorViewModel.priceAfterDiscount, 0.0)
        XCTAssertEqual(calculatorViewModel.priceAfterDiscountWithTax, 0.0)
        XCTAssertEqual(calculatorViewModel.taxesAmountAfterDiscount, 0.0)
        
    }
    
}

