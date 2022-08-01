//
//  Partner.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.8.22.
//

import Foundation

struct Partner: Codable {
    var PartnerID: Int?
    var PartnerName: String?
    var PartnerBarcode: Double?
    var PartnerRegion: Int?
    var DueDays: Int?
    var DueValue: Double?
    var DueValueMaximum: Double?
    var Longitude: Double?
    var Latitude: Double?
    var FiscalNo: String?
    var BusinessNo: String?
    var Address: String?
    var DiscountPercent: Double?
    var DiscountLevel: Int?
    var PlaceName: String?
    var ItemID: Int?
    var MinimumValueForDiscount: Int?
    var DiscountPercent2: Int?
    var RouteOrderID: Int?
    var Day: Int?
    var MerchSecondaryPlacement: Int?
    var MerchDescription: Int?
    var DefaultPartner: String?
    var VatNo: String?
    var OwnerName: String?
    var PricemenuID: Int?
    var PartnerTypeID: Int?
}
