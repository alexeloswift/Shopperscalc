//
//  CalculatorTests.swift
//  ShopperscalcTests
//
//  Created by Alexis Diaz on 5/4/22.
//

import XCTest
@testable import Shopperscalc

class CalculatorTests: XCTestCase {
    
    let viewmodel = CalculatorVM(persistenceController: PersistenceController())
    
    
    func testcalculateNewTotal() {
        
        // testing initial state
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.discountPercentage, 20)
        
        let newTotal = viewmodel.calculateNewTotal(price: "10", discountPercentage: 20)
        
        XCTAssertEqual(newTotal, 8)
    }
    
    func testcalculateTaxAmount() {
        
        // testing initial state
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.discountPercentage, 20)
        XCTAssertEqual(viewmodel.taxPercentage, 0.07)
        
        let taxAmount = viewmodel.calculateTaxAmount(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        XCTAssertEqual(taxAmount, 0.56)
        
    }
    
    func testcalculateNewTotalWithTax() {
        
        // testing initial state
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.discountPercentage, 20)
        XCTAssertEqual(viewmodel.taxPercentage, 0.07)
        
        let newTotalWithTax = viewmodel.calculateNewTotalWithTax(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        XCTAssertEqual(newTotalWithTax, 8.56)
        
    }
    
    func testpresentCalculation() {
        
        // testing initial state
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.discountPercentage, 20)
        XCTAssertEqual(viewmodel.taxPercentage, 0.07)
        
        let newTotal = viewmodel.calculateNewTotal(price: "10", discountPercentage: 20)
        let taxAmount = viewmodel.calculateTaxAmount(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        let newTotalWithTax = viewmodel.calculateNewTotalWithTax(price: "10", discountPercentage: 20, taxPercentage: 0.07)
        
        
        viewmodel.priceAfterDiscount = newTotal
        viewmodel.priceAfterDiscountWithTax = newTotalWithTax
        viewmodel.taxesAmountAfterDiscount = taxAmount
        
        
        XCTAssertEqual(viewmodel.priceAfterDiscount, 8)
        XCTAssertEqual(viewmodel.priceAfterDiscountWithTax, 8.56)
        XCTAssertEqual(viewmodel.taxesAmountAfterDiscount, 0.56)
        
        
        
    }
    
    func testreset() {
        
        // testing initial state
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.discountPercentage, 20)
        XCTAssertEqual(viewmodel.taxPercentage, 0.07)
        
        viewmodel.reset()
        
        XCTAssertEqual(viewmodel.price, "")
        XCTAssertEqual(viewmodel.priceAfterDiscount, 0.0)
        XCTAssertEqual(viewmodel.priceAfterDiscountWithTax, 0.0)
        XCTAssertEqual(viewmodel.taxesAmountAfterDiscount, 0.0)
        
    }
    
}

