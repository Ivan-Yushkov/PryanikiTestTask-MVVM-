//
//  NetworkService.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Foundation
import Alamofire
import RxSwift


protocol NetworkServiceProtocol: class {
    func getPryaniky() -> Single<[Pryanik]?>
    func downloadImage(urlString: String, completionHandler: @escaping (_ image: UIImage) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    
    //MARK: - Pass data with RX
    func getPryaniky() -> Single<[Pryanik]?> {
        let data = [String: Any]()
       
        let routing = PryanikRouter.getPryanikyData(data)
        return Single.create { (single) -> Disposable in
            let request = AF.request(routing).responseData { (response) in
                let statusCode = response.response?.statusCode
                print(statusCode ?? 0)
                switch response.result {
                case .success(let value):
                    do {
                        let jsonObject = try JSONDecoder().decode(PryanikyDataForParse.self, from: value)
                        print(jsonObject)
                        var pryaniky = [Pryanik]()
                        for i in 0..<jsonObject.data.count {
                            guard let type = Types(rawValue: jsonObject.data[i].name) else { fatalError() }
                            let object = jsonObject.data[i]
                            let pryanik = Pryanik(type: type, data: object)
                            pryaniky.append(pryanik)
                        }
                        let sortedPryaniky = Pryanik.sortPryaniky(pryaniky: pryaniky, sequence: jsonObject.view)
                        single(.success(sortedPryaniky))
                    } catch let error {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    //MARK:- Pass data with closure
    func downloadImage(urlString: String, completionHandler: @escaping (_ image: UIImage) -> Void) {
        AF.request(urlString).responseData { (responseData) in
            switch responseData.result {
            case.success(let data):
                guard let image = UIImage(data: data) else { return }
                completionHandler(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


