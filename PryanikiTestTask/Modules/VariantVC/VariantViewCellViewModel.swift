//
//  VariantViewCellViewModel.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation

//MARK: - protocol for cell view model
protocol VariantViewCellViewModelType: class {
    var title: String { get }
    var id: String { get }
}


//MARK: - protocol for cell view model
class VariantViewCellViewModel: VariantViewCellViewModelType {

    var title: String {
        return variant.text
    }
    var id: String {
        return String(variant.id)
    }
    
    private var variant: Variant

    init(variant: Variant) {
        self.variant = variant
    }
}
