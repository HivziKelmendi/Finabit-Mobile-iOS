//
//  Item.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.8.22.
//

import Foundation

struct Item : Codable {
    var ItemID: String?
    var ItemName: String?
    var Quantity: String?
    var Price: Double?
    var DepartmentID: Int?
    var Rabat: Double?
    var Barcode: String?
    var Gratis: String?
    var Coefficient: Double?
    var VATValue: Double?
    var ItemGroupID: Int?
    var UnitName: String?
    var Unit1Default: String?
    var Coef_Quantity: Double?
    var MinimalPrice: Double?
    var Discount: Double?
    var IncludeInTargetPlan: String?
    var ID: Int?
    var PriceMenuID: Int?
    var NotaKreditore: Double?
    var CustomField6: String?
    var ItemGroupName: String?
    var UnitID1: Int?
    var UnitID2: Int?
    var UnitName1: String?
    var UnitName2: String?
    var MinimumQuantity: Int?
}
