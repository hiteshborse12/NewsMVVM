//
//  Errors.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

struct ErrorModel: Codable {
    let status: String?
    let code: String?
    let message: String?
}
