//
//  PictureViewModel.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation
import RxSwift

//MARK: - Protocol for view model
protocol PictureViewViewModelType: class {
    var image: UIImage? { get }
    func getImage()
}


//MARK: - View model
class PictureViewModel: PictureViewViewModelType {
    
    private var networkService: NetworkServiceProtocol = DI.resolve()
    private var url: String
    var view: PictureViewControllerProtocol
    public var image: UIImage?
    
    init(url: String, view: PictureViewController) {
        self.url = url
        self.view = view
    }
    
    
    func getImage() {
        DispatchQueue.global().async {
            self.networkService.downloadImage(urlString: self.url, completionHandler: { (image) in
                self.image = image
                self.view.updateView(image: image)
            })
        }
        
    }
}
