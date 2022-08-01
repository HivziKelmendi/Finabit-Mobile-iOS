//
//  Visit.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.8.22.
//

import Foundation

struct Visit {
    var visitId: Int
    var updatePartnerCoords: Int?
    var syncID: Int?
    var setPartnerPosition: Int?
    var setPartnerPicture: Int?
    var partnerPicture: NSData?
    var partnerID: Int16?
    var memoID: Int?
    var longitudeEnd: String?
    var longitudeBegin: String?
    var latitudeEnd: String?
    var latitudeBegin: String?
    var isSynchronized: Int?
    var insBy: Int?
    var hasErrorSync: Int?
    var endingDate: String?
    var beginningDate: String?
    var departmentId: Int?
    var partnerName: String?
    var dueValue:  Double?
    var discontPercent: Double?
}
