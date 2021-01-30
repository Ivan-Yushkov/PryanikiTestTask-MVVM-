//
//  VariantTableViewCell.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import UIKit

class VariantTableViewCell: UITableViewCell {
    
    weak var viewModel: VariantViewCellViewModelType? {
        willSet(viewModel) {
            textLabel?.text = "\(viewModel?.title ?? "") with id \(viewModel?.id ?? "")"
        }
    }
    
}
