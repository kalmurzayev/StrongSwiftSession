//
//  StatementDataManager.swift
//  StrongSwiftSession
//
//  Created by Azamat Kalmurzayev on 2/25/19.
//  Copyright © 2019 SkyBank. All rights reserved.
//

import Foundation
@objc protocol StatementDataManagerProtocol: class {
    /// Сервисный метод, возвращающий список сущностей BankStatementItemModel
    ///
    /// - Returns: Список сущностей BankStatementItemModel
    func getStatement() -> [BankStatementItemModel]
}

@objc class StatementDataManager: NSObject, StatementDataManagerProtocol {
    static let deserializationFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func getStatement() -> [BankStatementItemModel] {
        guard let jsonArray = readJsonHelper(filename: "statement") as? [[String: Any]] else {
            return []
        }
        return jsonArray.compactMap(mapToItemModel(obj:))
    }
    
    /// Утилитный метод для опционального маппинга из Swift dictionary в бизнес модель BankStatementItemModel
    ///
    /// - Parameter obj: Примитивный Swift dictionary
    /// - Returns: Сконвертированная BankStatementItemModel сущность
    private func mapToItemModel(obj: [String: Any]) -> BankStatementItemModel? {
        guard let ident = obj["id"] as? String,
            let title = obj["title"] as? String,
            let amount = obj["amount"] as? Double,
            let dateRaw = obj["date"] as? String,
            let date = StatementDataManager.deserializationFormat.date(from: dateRaw)
            else { return nil }
        return BankStatementItemModel(ident: ident, title: title, amountValue: amount, date: date)
    }
    
    private func readJsonHelper(filename: String) -> Any? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return result
        } catch {
            return nil
        }
    }
}
