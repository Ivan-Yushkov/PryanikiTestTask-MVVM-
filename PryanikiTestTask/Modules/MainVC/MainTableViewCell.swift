//
//  File.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import UIKit


class MainTableViewCell: UITableViewCell {
    
    weak var viewModel: MainViewCellViewModelType? {
        willSet(viewModel) {
            textLabel?.text = viewModel?.name
        }
    }
}
