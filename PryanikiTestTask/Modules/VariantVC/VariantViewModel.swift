//
//  VariantViewModel.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation

//MARK: - Protocol for view model
protocol VariantViewViewModelType: class {
    func getCount() -> Int
    func cellViewModel(indexPath: IndexPath) -> VariantViewCellViewModelType
}


//MARK: - View model
class VariantViewModel: VariantViewViewModelType {
    
    var variants: [Variant]
    
    func getCount() -> Int {
        return variants.count
    }
    
    init(variants: [Variant]) {
        self.variants = variants
    }
    
    func cellViewModel(indexPath: IndexPath) -> VariantViewCellViewModelType {
        let variant = variants[indexPath.row]
        return VariantViewCellViewModel(variant: variant)
    }
}
