//
//  File.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation

//MARK: - protocol for cell view model
protocol MainViewCellViewModelType: class {
    var name: String { get }
}

//MARK: - protocol for cell view model
class MainViewCellViewModel: MainViewCellViewModelType {
    
    var name: String {
        return pryanik.name
    }
    
    private var pryanik: Pryanik


    init(pryanik: Pryanik) {
        self.pryanik = pryanik

    }
}
