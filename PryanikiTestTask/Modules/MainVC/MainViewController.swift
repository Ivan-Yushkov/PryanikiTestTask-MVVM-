//
//  ViewController.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import UIKit

//MARK: - Protocol for view controller
protocol MainViewControllerProtocol {
    func reloadView()
}


//MARK: - View Controller
class MainViewController: UIViewController, MainViewControllerProtocol {

    private var viewModel: MainViewViewModelType!
    private var tableView = UITableView()
    private let reuseIdentifier = "Cell"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(view: self)
        viewModel?.getData()
        setupView()
    }

    //Setup view methods
    public func reloadView() {
        tableView.reloadData()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Method to create alert view controller
    private func createAlert(text: String) {
        let ac = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(action)
        present(ac, animated: true, completion: nil)
    }
}

//MARK: - Table View data source & delegate methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MainTableViewCell
        else { fatalError("unable to create cell") }
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pryanik = viewModel.pryaniky?[indexPath.row]
        switch pryanik?.name {
        case "hz":
            createAlert(text: pryanik?.text ?? "")
        case "picture":
            guard let url = pryanik?.url else { fatalError() }
            present(PictureViewController(url: url, text: pryanik?.text ?? ""), animated: true, completion: nil)
        case "selector":
            guard let variants = pryanik?.varinats else { fatalError() }
            present(VariantViewController(variants: variants), animated: true, completion: nil)
        default:
            break
        }
    }
    
  
}
