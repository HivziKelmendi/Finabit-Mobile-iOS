//
//  PersistenceManager.swift
//  Finabit Mobile
//
//  Created by Hivzi on 19.2.22.
//

import Foundation
import CoreData
import UIKit

struct PersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
    }
    static let shared = PersistenceManager()

   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    // MARK: - Save and update users to Core Data
    
    func addUsersToCoreData(users: [User], completion: @escaping (Result<Void, Error>) -> Void) {
         var usersInSqLite = [UserInSqLite]()
        let request : NSFetchRequest<UserInSqLite> = UserInSqLite.fetchRequest()
        let userArray =  try? context.fetch(request)
        if userArray?.count == 0 {
        for user in users {
        let newUser = UserInSqLite(context: self.context)
            newUser.setValue(user.UserID, forKey: "userID")
            newUser.setValue((user.UserName), forKey: "userName")
            newUser.setValue(user.EmployeeID, forKey: "employeeID")
            newUser.setValue(user.EmployeeName, forKey: "employeeName")
            newUser.setValue(user.Options, forKey: "options")
            newUser.setValue(user.EditTran, forKey: "editTran")
            newUser.setValue(user.DepartmentID, forKey: "departmentID")
            newUser.setValue(user.DeleteTran, forKey: "deleteTran")
            newUser.setValue(user.PDAPIN, forKey: "pDAPIN")
            newUser.setValue(user.AllowSales, forKey: "allowSales")
            newUser.setValue(user.AllowOrder, forKey: "allowOrder")
            newUser.setValue(user.AllowIn, forKey: "allowIn")
            newUser.setValue(user.AllowOut, forKey: "allowOut")
            newUser.setValue(user.AllowMerchendeiser, forKey: "allowMerchendeiser")
            newUser.setValue(user.AllowService, forKey: "allowService")
            newUser.setValue(user.AllowAssets, forKey: "allowAssets")
            newUser.setValue(user.AllowEditRabat, forKey: "allowEditRabat")
            newUser.setValue(user.AllowEditNotaKreditore, forKey: "allowEditNotaKreditore")
            newUser.setValue(user.AllowEditRabatOrder, forKey: "allowEditRabatOrder")
            newUser.setValue(user.AllowEditPriceOrder, forKey: "allowEditPriceOrder")
            newUser.setValue(user.NavUserName, forKey: "navUserName")
            newUser.setValue(user.NavPassword, forKey: "navPassword")
            newUser.setValue(user.AllowInternNew, forKey: "allowInternNew")
            newUser.setValue(user.ParaqitBorxhinEKons, forKey: "paraqitBorxhinEKons")
            newUser.setValue(user.KufizimiMeCmimbaze, forKey: "kufizimiMeCmimbaze")
            newUser.setValue(user.LejoLevizjenInterne, forKey: "lejoLevizjenInterne")
            newUser.setValue(user.LejoFletehyrjen, forKey: "lejoFletehyrjen")
            newUser.setValue(user.AllowFarmersQuantityEdit, forKey: "allowFarmersQuantityEdit")
            newUser.setValue(user.ShowScales, forKey: "showScales")
            newUser.setValue(user.Allow_Pranimi_NAV, forKey: "allow_Pranimi_NAV")
            newUser.setValue(user.Allow_Dalja_NAV, forKey: "allow_Dalja_NAV")
            usersInSqLite.append(newUser)
        }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
               }
            }
        else {
          DeleteUserInSqLite()
            for user in users {
                let newUser = UserInSqLite(context: self.context)
                    newUser.setValue(user.UserID, forKey: "userID")
                    newUser.setValue((user.UserName), forKey: "userName")
                    newUser.setValue(user.EmployeeID, forKey: "employeeID")
                    newUser.setValue(user.EmployeeName, forKey: "employeeName")
                    newUser.setValue(user.Options, forKey: "options")
                    newUser.setValue(user.EditTran, forKey: "editTran")
                    newUser.setValue(user.DepartmentID, forKey: "departmentID")
                    newUser.setValue(user.DeleteTran, forKey: "deleteTran")
                    newUser.setValue(user.PDAPIN, forKey: "pDAPIN")
                    newUser.setValue(user.AllowSales, forKey: "allowSales")
                    newUser.setValue(user.AllowOrder, forKey: "allowOrder")
                    newUser.setValue(user.AllowIn, forKey: "allowIn")
                    newUser.setValue(user.AllowOut, forKey: "allowOut")
                    newUser.setValue(user.AllowMerchendeiser, forKey: "allowMerchendeiser")
                    newUser.setValue(user.AllowService, forKey: "allowService")
                    newUser.setValue(user.AllowAssets, forKey: "allowAssets")
                    newUser.setValue(user.AllowEditRabat, forKey: "allowEditRabat")
                    newUser.setValue(user.AllowEditNotaKreditore, forKey: "allowEditNotaKreditore")
                    newUser.setValue(user.AllowEditRabatOrder, forKey: "allowEditRabatOrder")
                    newUser.setValue(user.AllowEditPriceOrder, forKey: "allowEditPriceOrder")
                    newUser.setValue(user.NavUserName, forKey: "navUserName")
                    newUser.setValue(user.NavPassword, forKey: "navPassword")
                    newUser.setValue(user.AllowInternNew, forKey: "allowInternNew")
                    newUser.setValue(user.ParaqitBorxhinEKons, forKey: "paraqitBorxhinEKons")
                    newUser.setValue(user.KufizimiMeCmimbaze, forKey: "kufizimiMeCmimbaze")
                    newUser.setValue(user.LejoLevizjenInterne, forKey: "lejoLevizjenInterne")
                    newUser.setValue(user.LejoFletehyrjen, forKey: "lejoFletehyrjen")
                    newUser.setValue(user.AllowFarmersQuantityEdit, forKey: "allowFarmersQuantityEdit")
                    newUser.setValue(user.ShowScales, forKey: "showScales")
                    newUser.setValue(user.Allow_Pranimi_NAV, forKey: "allow_Pranimi_NAV")
                    newUser.setValue(user.Allow_Dalja_NAV, forKey: "allow_Dalja_NAV")
                    
                    usersInSqLite.append(newUser)
                }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Save and update departments to Core Data

    
    func addDepartmentsToCoreData(departments: [Department], completion: @escaping (Result<Void, Error>) -> Void) {
        
        var departmentsInSqLite = [DepartmentInSqlite]()
        let request : NSFetchRequest<DepartmentInSqlite> = DepartmentInSqlite.fetchRequest()
        let departmentArray =  try? context.fetch(request)
        if  departmentArray?.count == 0 {
        for department in departments {
            let newDepartment = DepartmentInSqlite(context: self.context)
            newDepartment.setValue(department.DepartmentID, forKey: "departmentID")
            newDepartment.setValue(department.DepartmentName, forKey: "departmentName")
            newDepartment.setValue(department.AllowNegative, forKey: "allowNegative")
            newDepartment.setValue(department.ShowRoutes, forKey: "showRoutes")
            newDepartment.setValue(department.StartCount, forKey: "startCount")
            newDepartment.setValue(department.EndCount, forKey: "endCount")
            newDepartment.setValue((department.DownloadPartnersByDepartment), forKey: "downloadPartnersByDepartment")
            departmentsInSqLite.append(newDepartment)
           }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        } else {
            DeleteDepartmentInSqLite()
            for department in departments {
                let newDepartment = DepartmentInSqlite(context: self.context)
                newDepartment.setValue(department.DepartmentID, forKey: "departmentID")
                newDepartment.setValue(department.DepartmentName, forKey: "departmentName")
                newDepartment.setValue(department.AllowNegative, forKey: "allowNegative")
                newDepartment.setValue(department.ShowRoutes, forKey: "showRoutes")
                newDepartment.setValue(department.StartCount, forKey: "startCount")
                newDepartment.setValue(department.EndCount, forKey: "endCount")
                newDepartment.setValue((department.DownloadPartnersByDepartment), forKey: "downloadPartnersByDepartment")
                departmentsInSqLite.append(newDepartment)
               }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
     }
    
    // MARK: - Save and update items to Core Data
    
    func addItemToCoreData(items: [Item], completion: @escaping (Result<Void, Error>) -> Void) {
         var itemsInSqLite = [ItemInSqLite]()
        let request : NSFetchRequest<ItemInSqLite> = ItemInSqLite.fetchRequest()
        let itemArray =  try? context.fetch(request)
        if itemArray?.count == 0 {
        for item in items {
        let newItem = ItemInSqLite(context: self.context)
            newItem.setValue(item.ItemID, forKey: "itemID")
            newItem.setValue(item.ItemName, forKey: "itemName")
            newItem.setValue(item.Quantity, forKey: "quantity")
            newItem.setValue(item.Price, forKey: "price")
            newItem.setValue(item.DepartmentID, forKey: "departmentID")
            newItem.setValue(item.Rabat, forKey: "rabat")
            newItem.setValue(item.Barcode, forKey: "barcode")
            newItem.setValue(item.Gratis, forKey: "gratis")
            newItem.setValue(item.Coefficient, forKey: "coefficient")
            newItem.setValue(item.VATValue, forKey: "vATValue")
            newItem.setValue(item.ItemGroupID, forKey: "itemGroupID")
            newItem.setValue(item.UnitName, forKey: "unitName")
            newItem.setValue(item.Unit1Default, forKey: "unit1Default")
            newItem.setValue(item.Coef_Quantity, forKey: "coef_Quantity")
            newItem.setValue(item.MinimalPrice, forKey: "minimalPrice")
            newItem.setValue(item.Discount, forKey: "discount")
            newItem.setValue(item.IncludeInTargetPlan, forKey: "includeInTargetPlan")
            newItem.setValue(item.ID, forKey: "iD")
            newItem.setValue(item.PriceMenuID, forKey: "priceMenuID")
            newItem.setValue(item.NotaKreditore, forKey: "notaKreditore")
            newItem.setValue(item.CustomField6, forKey: "customField6")
            newItem.setValue(item.ItemGroupName, forKey: "itemGroupName")
            newItem.setValue(item.UnitID1, forKey: "unitID1")
            newItem.setValue(item.UnitID1, forKey: "unitID1")
            newItem.setValue(item.UnitName1, forKey: "unitName1")
            newItem.setValue(item.UnitName2, forKey: "unitName2")
            newItem.setValue(item.MinimumQuantity, forKey: "minimumQuantity")
          
            itemsInSqLite.append(newItem)
        }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        } else {
            DeleteItemInSqLite()
          
            let request : NSFetchRequest<ItemInSqLite> = ItemInSqLite.fetchRequest()
            request.includesPropertyValues = false
            for item in items {
            let newItem = ItemInSqLite(context: self.context)
                newItem.setValue(item.ItemID, forKey: "itemID")
                newItem.setValue(item.ItemName, forKey: "itemName")
                newItem.setValue(item.Quantity, forKey: "quantity")
                newItem.setValue(item.Price, forKey: "price")
                newItem.setValue(item.DepartmentID, forKey: "departmentID")
                newItem.setValue(item.Rabat, forKey: "rabat")
                newItem.setValue(item.Barcode, forKey: "barcode")
                newItem.setValue(item.Gratis, forKey: "gratis")
                newItem.setValue(item.Coefficient, forKey: "coefficient")
                newItem.setValue(item.VATValue, forKey: "vATValue")
                newItem.setValue(item.ItemGroupID, forKey: "itemGroupID")
                newItem.setValue(item.UnitName, forKey: "unitName")
                newItem.setValue(item.Unit1Default, forKey: "unit1Default")
                newItem.setValue(item.Coef_Quantity, forKey: "coef_Quantity")
                newItem.setValue(item.MinimalPrice, forKey: "minimalPrice")
                newItem.setValue(item.Discount, forKey: "discount")
                newItem.setValue(item.IncludeInTargetPlan, forKey: "includeInTargetPlan")
                newItem.setValue(item.ID, forKey: "iD")
                newItem.setValue(item.PriceMenuID, forKey: "priceMenuID")
                newItem.setValue(item.NotaKreditore, forKey: "notaKreditore")
                newItem.setValue(item.CustomField6, forKey: "customField6")
                newItem.setValue(item.ItemGroupName, forKey: "itemGroupName")
                newItem.setValue(item.UnitID1, forKey: "unitID1")
                newItem.setValue(item.UnitID1, forKey: "unitID1")
                newItem.setValue(item.UnitName1, forKey: "unitName1")
                newItem.setValue(item.UnitName2, forKey: "unitName2")
                newItem.setValue(item.MinimumQuantity, forKey: "minimumQuantity")
                itemsInSqLite.append(newItem)
            }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
             }
        }
    
    
    // MARK: - Save and update partners to Core Data
    
    func addPartnerToCoreData(partners: [Partner], completion: @escaping (Result<Void, Error>) -> Void) {
         var partnersInSqLite = [PartnerInSqLite]()
        let request : NSFetchRequest<PartnerInSqLite> = PartnerInSqLite.fetchRequest()
        let partnerArray =  try? context.fetch(request)
        if partnerArray?.count == 0 {
        for partner in partners {
        let newpartner = PartnerInSqLite(context: self.context)
            newpartner.setValue(partner.PartnerID, forKey: "partnerID")
            newpartner.setValue(partner.PartnerName, forKey: "partnerName")
            newpartner.setValue(partner.PartnerBarcode, forKey: "partnerBarcode")
            newpartner.setValue(partner.PartnerRegion, forKey: "partnerRegion")
            newpartner.setValue(partner.DueDays, forKey: "dueDays")
            newpartner.setValue(partner.DueValue, forKey: "dueValue")
            newpartner.setValue(partner.DueValueMaximum, forKey: "dueValueMaximum")
            newpartner.setValue(partner.Longitude, forKey: "longitude")
            newpartner.setValue(partner.Latitude, forKey: "latitude")
            newpartner.setValue(partner.FiscalNo, forKey: "fiscalNo")
            newpartner.setValue(partner.BusinessNo, forKey: "businessNo")
            newpartner.setValue(partner.Address, forKey: "address")
            newpartner.setValue(partner.DiscountPercent, forKey: "discountPercent")
            newpartner.setValue(partner.DiscountLevel, forKey: "discountLevel")
            newpartner.setValue(partner.PlaceName, forKey: "placeName")
            newpartner.setValue(partner.ItemID, forKey: "itemID")
            newpartner.setValue(partner.MinimumValueForDiscount, forKey: "minimumValueForDiscount")
            newpartner.setValue(partner.DiscountPercent2, forKey: "discountPercent2")
            newpartner.setValue(partner.RouteOrderID, forKey: "routeOrderID")
            newpartner.setValue(partner.Day, forKey: "day")
            newpartner.setValue(partner.MerchSecondaryPlacement, forKey: "merchSecondaryPlacement")
            newpartner.setValue(partner.MerchDescription, forKey: "merchDescription")
            newpartner.setValue(partner.DefaultPartner, forKey: "defaultPartner")
            newpartner.setValue(partner.VatNo, forKey: "vatNo")
            newpartner.setValue(partner.OwnerName, forKey: "ownerName")
            newpartner.setValue(partner.PricemenuID, forKey: "pricemenuID")
            newpartner.setValue(partner.PartnerTypeID, forKey: "partnerTypeID")
            partnersInSqLite.append(newpartner)
        }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
        else {
            DeletePartnerInSqLite()
            for partner in partners {
            let newpartner = PartnerInSqLite(context: self.context)
                newpartner.setValue(partner.PartnerID, forKey: "partnerID")
                newpartner.setValue(partner.PartnerName, forKey: "partnerName")
                newpartner.setValue(partner.PartnerBarcode, forKey: "partnerBarcode")
                newpartner.setValue(partner.PartnerRegion, forKey: "partnerRegion")
                newpartner.setValue(partner.DueDays, forKey: "dueDays")
                newpartner.setValue(partner.DueValue, forKey: "dueValue")
                newpartner.setValue(partner.DueValueMaximum, forKey: "dueValueMaximum")
                newpartner.setValue(partner.Longitude, forKey: "longitude")
                newpartner.setValue(partner.Latitude, forKey: "latitude")
                newpartner.setValue(partner.FiscalNo, forKey: "fiscalNo")
                newpartner.setValue(partner.BusinessNo, forKey: "businessNo")
                newpartner.setValue(partner.Address, forKey: "address")
                newpartner.setValue(partner.DiscountPercent, forKey: "discountPercent")
                newpartner.setValue(partner.DiscountLevel, forKey: "discountLevel")
                newpartner.setValue(partner.PlaceName, forKey: "placeName")
                newpartner.setValue(partner.ItemID, forKey: "itemID")
                newpartner.setValue(partner.MinimumValueForDiscount, forKey: "minimumValueForDiscount")
                newpartner.setValue(partner.DiscountPercent2, forKey: "discountPercent2")
                newpartner.setValue(partner.RouteOrderID, forKey: "routeOrderID")
                newpartner.setValue(partner.Day, forKey: "day")
                newpartner.setValue(partner.MerchSecondaryPlacement, forKey: "merchSecondaryPlacement")
                newpartner.setValue(partner.MerchDescription, forKey: "merchDescription")
                newpartner.setValue(partner.DefaultPartner, forKey: "defaultPartner")
                newpartner.setValue(partner.VatNo, forKey: "vatNo")
                newpartner.setValue(partner.OwnerName, forKey: "ownerName")
                newpartner.setValue(partner.PricemenuID, forKey: "pricemenuID")
                newpartner.setValue(partner.PartnerTypeID, forKey: "partnerTypeID")
    
                partnersInSqLite.append(newpartner)
            }
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
//            print(partnersInSqLite[0].dueValue)
            }
        }
    
    // MARK: - Save visits to Core Data
    
    func addVisitToCoreData(visit: Visit) {
        let newVisit = VisitInSqLite(context: self.context)
        newVisit.visitId = Int32(visit.visitId)
        newVisit.updatePartnerCoords = Int32(visit.updatePartnerCoords ?? 0)
        newVisit.syncID = Int32(visit.syncID ?? 0)
        newVisit.setPartnerPosition = Int32(visit.setPartnerPosition ?? 0)
        newVisit.setPartnerPicture = Int32(visit.setPartnerPicture ?? 0)
        newVisit.partnerID = Int32(visit.partnerID ?? 0)
        newVisit.memoID = Int32(visit.memoID ?? 0)
        newVisit.longitudeEnd = visit.longitudeEnd
        newVisit.longitudeBegin = visit.longitudeBegin
        newVisit.latitudeEnd = visit.latitudeEnd
        newVisit.latitudeBegin = visit.latitudeBegin
        newVisit.isSynchronized = Int32(visit.isSynchronized ?? 0)
        newVisit.insBy = Int32(visit.insBy ?? 0)
        newVisit.hasErrorSync = Int32(visit.hasErrorSync ?? 0)
        newVisit.endingDate = visit.endingDate
        newVisit.beginningDate = visit.beginningDate
        newVisit.departmentId = Int32(visit.departmentId ?? 0)
        newVisit.partnerName = visit.partnerName
        newVisit.dueVaule = Double(visit.dueValue ?? 0)
        newVisit.discontPercent = Double(visit.discontPercent ?? 0)
        newVisit.partnerPicture = visit.partnerPicture as Data?
        do {
            try context.save()
          
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Save transactions to Core Data
    
    func addTransactionToCoreData(transaction: Transaction) {
        let newTransaction = TransactionInSqLite(context: self.context)
        newTransaction.iD = transaction.iD
        newTransaction.transactionNo = transaction.transactionNo
        newTransaction.invoiceNo = transaction.invoiceNo
        newTransaction.transactionType = transaction.transactionType ?? 0
        newTransaction.transactionDate = transaction.transactionDate
        newTransaction.partnerId = transaction.partnerId ?? 0
        newTransaction.visitId = transaction.visitId ?? 0
        newTransaction.departmentId = transaction.departmentId ?? 0
        newTransaction.insDate = transaction.insDate
        newTransaction.insBY = transaction.insBY ?? 0
        newTransaction.employeeId = transaction.employeeId ?? 0
        newTransaction.iSynchronized = transaction.iSynchronized ?? 0
        newTransaction.vATPrecentId = transaction.vATPrecentId ?? 0
        newTransaction.dueDays = transaction.dueDays ?? 0
        newTransaction.paymentVaule = transaction.paymentVaule ?? 0
        newTransaction.allValue = transaction.allValue ?? 0
        newTransaction.longitude = transaction.longitude
        newTransaction.latitude = transaction.latitude
        newTransaction.serviceTypeID = transaction.serviceTypeID ?? 0
        newTransaction.assetId = transaction.assetId ?? 0
        newTransaction.bl = transaction.bl ?? 0
        newTransaction.memo = transaction.memo
        newTransaction.llogaria_NotaKreditore = transaction.llogaria_NotaKreditore
        newTransaction.vlera_NotaKreditore = transaction.vlera_NotaKreditore ?? 0
        newTransaction.isPrintFiscalInvoice = transaction.isPrintFiscalInvoice ?? 0
        newTransaction.isPriceFromPartner = transaction.IsPriceFromPartner ?? 0
        newTransaction.nrIFatBlerje = transaction.nrIFatBlerje
        newTransaction.internalDepartmentID = transaction.internalDepartmentID ?? 0
        newTransaction.verifyFiscal = transaction.verifyFiscal ?? 0
        newTransaction.partnerName = transaction.partnerName ?? ""
        do {
            try context.save()
          
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Save transactionDetails to Core Data
    func addTransactionDetailsToCoreData(transactionDetails: [TransactionDetails]) {
        var transactionDetailsInSqLite = [TransactionDetalisInSqLite]()
        for transactionDetail in transactionDetails {
            let newtransactionDetail = TransactionDetalisInSqLite(context: self.context)
            newtransactionDetail.setValue(transactionDetail.id, forKey: "iD")
            newtransactionDetail.setValue(transactionDetail.itemId, forKey: "itemId")
            newtransactionDetail.setValue(transactionDetail.itemName, forKey: "itemName")
            newtransactionDetail.setValue(transactionDetail.quantity, forKey: "quantity")
            newtransactionDetail.setValue(transactionDetail.price, forKey: "price")
            newtransactionDetail.setValue(transactionDetail.value, forKey: "value")
            newtransactionDetail.setValue(transactionDetail.transactionid, forKey: "transactionid")
            newtransactionDetail.setValue(transactionDetail.rabat, forKey: "rabat")
            newtransactionDetail.setValue(transactionDetail.rabat2, forKey: "rabat2")
            newtransactionDetail.setValue(transactionDetail.priceMenuID, forKey: "priceMenuID")
            newtransactionDetail.setValue(transactionDetail.barcode, forKey: "barcode")
            newtransactionDetail.setValue(transactionDetail.unitId, forKey: "unitId")
            newtransactionDetail.setValue(transactionDetail.coefficient, forKey: "coefficient")
//            transactionDetailsInSqLite.append(newtransactionDetail)
            do {
                try context.save()
              
            } catch {
                print(error.localizedDescription)
            }
          }
        }
      
    
    // MARK: - Fetching users from Core Data
    
    func fetchingUserFromSqLite( completion: @escaping (Result<[UserInSqLite], Error>) -> Void) {
        let request: NSFetchRequest<UserInSqLite> = UserInSqLite.fetchRequest()
        
        do {
            let users = try context.fetch(request)
            completion(.success(users))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching departments from Core Data
    
    func fetchingDepartmentFromSqLite( completion: @escaping (Result<[DepartmentInSqlite], Error>) -> Void) {
        let request: NSFetchRequest<DepartmentInSqlite> = DepartmentInSqlite.fetchRequest()
        
        do {
            let departments = try context.fetch(request)
            completion(.success(departments))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching items from Core Data
    
    func fetchingItemFromSqLite( completion: @escaping (Result<[ItemInSqLite], Error>) -> Void) {
        let request: NSFetchRequest<ItemInSqLite> = ItemInSqLite.fetchRequest()
        
        do {
            let items = try context.fetch(request)
            print(items.count)
            completion(.success(items))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching partners from Core Data
    
    func fetchingPartnerFromSqLite( completion: @escaping (Result<[PartnerInSqLite], Error>) -> Void) {
        let request: NSFetchRequest<PartnerInSqLite> = PartnerInSqLite.fetchRequest()
        
        do {
            let partners = try context.fetch(request)
            completion(.success(partners))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching partner by id from Core Data
    
    func fetchingPartnerById(partnerData: Int,  completion: @escaping (Result<[PartnerInSqLite], Error>) -> Void) {
        let request: NSFetchRequest<PartnerInSqLite> = PartnerInSqLite.fetchRequest()
        request.predicate = NSPredicate(format: "partnerName ==%@", partnerData)
        do {
            let partner = try context.fetch(request)
            completion(.success(partner))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching Visits that aren't sincronised from Core Data

     func fetchingVisitsForUpload( completion: @escaping (Result<[VisitInSqLite], Error>) -> Void) {
     let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        request.predicate = NSPredicate(format: "isSynchronized == %@ AND endingDate != %@ ", "0", "nil")
        do {
         let visitsToUpload = try context.fetch(request)
            completion(.success(visitsToUpload))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching Traansactions that aren't sincronised from Core Data

     func fetchingTransactionsForUpload( completion: @escaping (Result<[TransactionInSqLite], Error>) -> Void) {
     let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        request.predicate = NSPredicate(format: "iSynchronized == %@", "0")
        do {
         let transactionsToUpload = try context.fetch(request)
            completion(.success(transactionsToUpload))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching Order Traansactions by date

     func fetchingOrderTransactionsByDate( completion: @escaping (Result<[TransactionInSqLite], Error>) -> Void) {
     let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        let currentDate = getDate()
        request.predicate = NSPredicate(format: "transactionDate CONTAINS %@ AND transactionType = %@", currentDate, "15")
        do {
         let transactionsToUpload = try context.fetch(request)
            
            completion(.success(transactionsToUpload))
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    // MARK: - Fetching Purchase Traansactions by date

    func fetchingPurcheasTransactionsByDate( completion: @escaping (Result<[TransactionInSqLite], Error>) -> Void) {
    let request : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
       let currentDate = getDate()
       request.predicate = NSPredicate(format: "transactionDate CONTAINS %@ AND transactionType = %@", currentDate, "2")
       do {
        let transactionsToUpload = try context.fetch(request)
           
           completion(.success(transactionsToUpload))
           
       } catch {
           completion(.failure(DatabaseError.failedToFetchData))
       }
   }
    // MARK: - Fetching TraansactionDetails that aren't sincronised from Core Data

     func fetchingTransactionsDetails( completion: @escaping (Result<[TransactionDetalisInSqLite], Error>) -> Void) {
        
            let request: NSFetchRequest<TransactionDetalisInSqLite> = TransactionDetalisInSqLite.fetchRequest()
            
            do {
                let transactionDetails = try context.fetch(request)
                completion(.success(transactionDetails))
            } catch {
                completion(.failure(DatabaseError.failedToFetchData))
            }
    }
  
    // MARK: - Fetching TraansactionDetails that aren't sincronised from Core Data

     func SynchronizeData() {
        let request : NSFetchRequest<VisitInSqLite> = VisitInSqLite.fetchRequest()
        do {
           let visits =  try context.fetch(request)
            for visit in visits {
                visit.setValue(1, forKey: "isSynchronized")
            }
        } catch {
        }
        saveContext()
       
        let request1 : NSFetchRequest<TransactionInSqLite> = TransactionInSqLite.fetchRequest()
        do {
           let transactions =  try context.fetch(request1)
            for transaction in transactions {
                transaction.setValue(1, forKey: "iSynchronized")
            }
        
        } catch {
        }
        saveContext()
        
//        let request2: NSFetchRequest<TransactionDetalisInSqLite> = TransactionDetalisInSqLite.fetchRequest()
//        do {
//           let transactionDetails =  try context.fetch(request2)
//        for transactionDetail in transactionDetails {
//                transactionDetail.setValue(1, forKey: "isSynchronized")
//            }
//        
//        } catch {
//        }
//        saveContext()

    }

    // MARK: - Delete users to Core Data
    
    func DeleteUserInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: UserInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Delete departments to Core Data
    
    func DeleteDepartmentInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: DepartmentInSqlite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Delete partners to Core Data
    
    func DeletePartnerInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: PartnerInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Delete items  to Core Data
    
    func DeleteItemInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: ItemInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    
    // MARK: - Delete visits  to Core Data
    
    func DeleteVisitInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: VisitInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    
    // MARK: - Delete transactions  to Core Data
    
    func DeleteTransactionInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: TransactionInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - Delete transactions  to Core Data
    
    func DeleteTransactionDetailsInSqLite() -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: TransactionDetalisInSqLite.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    func saveContext() {
        do {
            try context.save()
          
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDate() -> String {
    let currentDateTime = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let result = formatter.string(from: currentDateTime)
        return result
    }
 }

