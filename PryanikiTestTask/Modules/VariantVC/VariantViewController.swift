//
//  VariantViewController.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import UIKit

class VariantViewController: UIViewController {
    
    private var tableView = UITableView()
    private var variants: [Variant]
    private var viewModel: VariantViewViewModelType?
    private let reuseIdentifier = "VariantCell"
    
    init(variants: [Variant]) {
        self.variants = variants
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VariantViewModel(variants: variants)
        setupView()
    }
    
    //Setup view
    private func setupView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VariantTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        title = "Variant"
    }
}

//MARK: - Table View data source & delegate methods
extension VariantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? VariantTableViewCell
        else { fatalError("Unable to create cell") }
        let cellViewModel = viewModel?.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}
