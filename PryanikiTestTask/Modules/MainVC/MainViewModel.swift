//
//  MainViewModel.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation
import RxSwift

//MARK: - Protocol for view model
protocol MainViewViewModelType: class {
    func getCount() -> Int?
    func cellViewModel(indexPath: IndexPath) -> MainViewCellViewModelType
    func getData()
    var view: MainViewControllerProtocol { get set }
    var pryaniky: [Pryanik]? { get }
}


//MARK: - View model
class MainViewModel: MainViewViewModelType {
   
    var view: MainViewControllerProtocol
    var pryaniky: [Pryanik]?
    var disposeBag = DisposeBag()
    var networkService: NetworkServiceProtocol = DI.resolve()
    
    init(view: MainViewControllerProtocol) {
        self.view = view
    }
    
    func getCount() -> Int? {
        return pryaniky?.count
    }
    
    func getData() {
        networkService = DI.resolve()
        _ = networkService.getPryaniky()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                //self?.view.stopRefreshing()
                switch event {
                case .success(let pryaniky):
                    self?.pryaniky = pryaniky
                    self?.view.reloadView()
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
    
    
    func cellViewModel(indexPath: IndexPath) -> MainViewCellViewModelType {
        guard let pryanik = pryaniky?[indexPath.row] else { fatalError("unable to extract value") }
        return MainViewCellViewModel(pryanik: pryanik)
    }
}
