//
//  StatementItemModel.swift
//  StrongSwiftSession
//
//  Created by Azamat Kalmurzayev on 2/25/19.
//  Copyright © 2019 SkyBank. All rights reserved.
//

import Foundation
@objc class StatementItemModel: NSObject {
    /// Идентификатор транзакции
    var ident: String
    /// Описание транзакции
    var title: String
    /// Сумма, на которую провели транзакцию (отриц - снятие, полож - пополнение)
    var amountValue: Double
    /// Дата и время проведения транзакции
    var date: Date
    required init(ident: String, title: String, amountValue: Double, date: Date) {
        self.ident = ident
        self.title = title
        self.amountValue = amountValue
        self.date = date
    }
}
