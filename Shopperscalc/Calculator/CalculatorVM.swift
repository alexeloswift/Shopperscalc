//
//  CalculatorVM.swift
//  Shopperscalc
//
//  Created by Alexis Diaz on 4/5/22.
//

import Foundation
import CoreData

class CalculatorVM: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    //    Input
    @Published var discountPercentage: Int = 20
    @Published var price: String = ""
    @Published var taxPercentage: Double = 0.07
    
    //    Output
    @Published var priceAfterDiscountWithTax: Double = 0.0
    @Published var priceAfterDiscount: Double = 0.0
    @Published var taxesAmountAfterDiscount: Double = 0.0
    
    //    Arrays Holding Persisted Data
    @Published var listNames = [ListName]()
    @Published var calculation = [Calculation]()
    
    let persistenceController: PersistenceController
    var listNameController: NSFetchedResultsController <ListName>
    var calculationController: NSFetchedResultsController<Calculation>
    
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        
        let calculationRequest: NSFetchRequest<Calculation> = Calculation.fetchRequest()
        calculationRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Calculation.fullPrice, ascending: true)]
        calculationController = NSFetchedResultsController(fetchRequest: calculationRequest,
                                                           managedObjectContext: persistenceController.container.viewContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName:  nil)
        
        let request: NSFetchRequest<ListName> = ListName.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ListName.listTitle, ascending: true)]
        listNameController = NSFetchedResultsController(fetchRequest: request,
                                                        managedObjectContext: persistenceController.container.viewContext,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
        super.init()
        listNameController.delegate = self
        calculationController.delegate = self
        do {
            try calculationController.performFetch()
            try listNameController.performFetch()
            calculation = calculationController.fetchedObjects ?? []
            listNames = listNameController.fetchedObjects ?? []
        } catch {
            print("Failed fetch")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController <NSFetchRequestResult>) {
        if let newCalculations = controller.fetchedObjects as? [Calculation] {
            calculation = newCalculations
        } else if let newListNames = controller.fetchedObjects as? [ListName] {
            listNames = newListNames
        }
    }
    
    func addListCalculation(fullPrice: String, newTotal: Double, discountPercentage: Int16) {
        let newListCalculation = ListCalculation(context: persistenceController.container.viewContext)
        
        newListCalculation.newTotal = newTotal
        newListCalculation.fullPrice = fullPrice
        newListCalculation.discountPercentage = discountPercentage
        
        persistenceController.save()
    }
    
    func addCalculation(fullPrice: String, newTotal: Double, discountPercentage: Int16) {
        let newCalculation = Calculation(context: persistenceController.container.viewContext)
        
        newCalculation.newTotal = newTotal
        newCalculation.fullPrice = fullPrice
        newCalculation.discountPercentage = discountPercentage
        
        persistenceController.save()
    }
    
    func deleteCalculation(at offsets: IndexSet) {
        offsets.forEach { index in
            let moc = persistenceController.container.viewContext
            let calculation = self.calculation[index]
            moc.delete(calculation)
        }
        persistenceController.save()
    }
    
    func deleteAllCalculations() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Calculation")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let moc = persistenceController.container.viewContext
        
        do {
            try moc.executeAndMergeChanges(using: batchDeleteRequest)
        } catch {
            print("could not delete calculations and save")
        }
    }
    
    func calculateNewTotal(price: String, discountPercentage: Int) -> Double {
        let priceAsDouble = Double(price) ?? 0.0
        let discountPercentageAsDouble = Double(discountPercentage)
        
        let amountOff = priceAsDouble / 100 * discountPercentageAsDouble
        let priceCalculatedWithoutTax = priceAsDouble - amountOff
        
        return priceCalculatedWithoutTax
    }
    
    func calculateTaxAmount(price: String, discountPercentage: Int, taxPercentage: Double) -> Double {
        let priceAsDouble = Double(price) ?? 0.0
        let discountPercentageAsDouble = Double(discountPercentage)
        
        let amountOff = priceAsDouble / 100 * discountPercentageAsDouble
        let taxCalculated = (priceAsDouble - amountOff) * taxPercentage
        
        return taxCalculated
    }
    
    func calculateNewTotalWithTax(price: String, discountPercentage: Int, taxPercentage: Double) -> Double {
        let priceAsDouble = Double(price) ?? 0.0
        let discountPercentageAsDouble = Double(discountPercentage)
        
        let amountOff = priceAsDouble / 100 * discountPercentageAsDouble
        let taxCalculated = (priceAsDouble - amountOff) * taxPercentage
        let priceCalculatedWithoutTax = priceAsDouble - amountOff
        let priceCalculatedWithTax = priceCalculatedWithoutTax + taxCalculated
        
        return priceCalculatedWithTax
    }
    
    func presentCalculation() {
        priceAfterDiscount = calculateNewTotal(price: price, discountPercentage: discountPercentage)
        priceAfterDiscountWithTax = calculateNewTotalWithTax(price: price, discountPercentage: discountPercentage, taxPercentage: taxPercentage)
        taxesAmountAfterDiscount = calculateTaxAmount(price: price, discountPercentage: discountPercentage, taxPercentage: taxPercentage)
    }
    
    func reset() {
        price = ""
        priceAfterDiscount = 0.0
        priceAfterDiscountWithTax = 0.0
        taxesAmountAfterDiscount = 0.0
    }
}
