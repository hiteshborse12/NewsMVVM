//
//  Encodable+Ext.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//
import Foundation

extension Encodable {
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self), options: .allowFragments)) as? [String: Any] ?? [:]
    }
}
