//
//  File.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import UIKit


//MARK: - Protocol for view controller
protocol PictureViewControllerProtocol: class {
    func updateView(image: UIImage)
}

//MARK: - View Controller
class PictureViewController: UIViewController, PictureViewControllerProtocol {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private var url: String!
    private var text: String
    private var viewModel: PictureViewViewModelType?
    
    init(url: String, text: String) {
        self.url = url
        self.text = text
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = PictureViewModel(url: url, view: self)
        viewModel?.getImage()
    }
    
   //Setup view methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(label)
        label.backgroundColor = .orange
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        title = "Picture"

        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func updateView(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
            self.label.text = self.text
        }
  
    }
}
