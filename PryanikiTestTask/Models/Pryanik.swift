//
//  File.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation

enum Types: String {
    case hz = "hz"
    case selector = "selector"
    case picture = "picture"
}


struct Pryanik {
    
    let name: String
    let text: String?
    let url: String?
    let selectedId: Int?
    let varinats: [Variant]?
    
    init(type: Types, data: Datum) {
        switch type {
        case .hz:
            text = data.data.text
            name = data.name
            url = nil
            selectedId = nil
            varinats = nil
        case .selector:
            name = data.name
            selectedId = data.data.selectedID
            varinats = data.data.variants
            text = nil
            url = nil
        case .picture:
            self.name = data.name
            self.url = data.data.url
            self.text = data.data.text
            varinats = nil
            selectedId = nil
        }
    }
    
    static func sortPryaniky(pryaniky: [Pryanik], sequence: [String]) -> [Pryanik] {
        var sortedPryaniky = [Pryanik]()
        for view in sequence {
            for i in 0..<pryaniky.count {
                if view == pryaniky[i].name {
                    sortedPryaniky.append(pryaniky[i])
                }
            }
        }
        return sortedPryaniky
    }
}



