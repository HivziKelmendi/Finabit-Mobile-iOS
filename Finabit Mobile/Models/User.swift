//
//  User.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.8.22.
//

import Foundation

struct User:Codable {
    var UserID: Int?
    var UserName: String?
    var EmployeeID: Int?
    var EmployeeName: String?
    var DepartmentID: Int?
    var Options: String?
    var EditTran: String?
    var DeleteTran: String?
    var PDAPIN: Int?
    var AllowSales: String?
    var AllowOrder: String?
    var AllowIn: String?
    var AllowOut: String?
    var AllowMerchendeiser: String?
    var AllowService: String?
    var AllowAssets: String?
    var AllowEditRabat: String?
    var AllowEditNotaKreditore: String?
    var AllowEditRabatOrder: String?
    var AllowEditPriceOrder: String?
    var NavUserName: String?
    var NavPassword: String?
    var AllowInternNew: String?
    var ParaqitBorxhinEKons: String?
    var KufizimiMeCmimbaze: String?
    var LejoLevizjenInterne: String?
    var LejoFletehyrjen: String?
    var AllowFarmersQuantityEdit: String?
    var ShowScales: String?
    var Allow_Pranimi_NAV: String?
    var Allow_Dalja_NAV: String?
}
