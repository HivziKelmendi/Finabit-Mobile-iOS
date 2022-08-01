//
//  Transaction.swift
//  Finabit Mobile
//
//  Created by Hivzi on 1.8.22.
//

import Foundation


struct Transaction {
    var iD: Int32
    var transactionNo: String?
    var invoiceNo: String?
    var transactionType: Int32?
    var transactionDate: String?
    var partnerName: String?
    var partnerId: Int32?
    var visitId: Int32?
    var departmentId: Int16?
    var insDate: String?
    var insBY: Int32?
    var employeeId: Int32?
    var iSynchronized: Int32?
    var vATPrecentId: Int32?
    var dueDays: Int32?
    var paymentVaule: Double?
    var allValue: Double?
    var longitude: String?
    var latitude: String?
    var serviceTypeID: Int32?
    var assetId: Int32?
    var bl: Int32?
    var memo: String?
    var llogaria_NotaKreditore: String?
    var vlera_NotaKreditore: Double?
    var isPrintFiscalInvoice: Int32?
    var IsPriceFromPartner: Int32?
    var nrIFatBlerje: String?
    var internalDepartmentID: Int32?
    var verifyFiscal: Int32?
}
