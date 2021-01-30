//
//  PryanikyDataForParse.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//



import Foundation

struct PryanikyDataForParse: Codable {
    let data: [Datum]
    let view: [String]
}


struct Datum: Codable {
    let name: String
    let data: DataClass
}


struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}


struct Variant: Codable {
    let id: Int
    let text: String
}

