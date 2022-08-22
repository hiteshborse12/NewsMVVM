//
//  ApiHandler.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import Alamofire
import PromiseKit

// MARK: - Abstraction for NetworkManager
protocol NetworkManagerProtocol {
    /**
        FetchData: fetchData data from server
     - Parameter request: ApiRequest
     - Returns: If Promise fulfill then T else error
     */
    func fetchData<T: Decodable>(request: ApiRequest)->Promise<T>
}
// MARK: - Genericnetworking class that will send request to the server and parse the response
class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() { }
    //MARK: fetchData from server using Alamofire
    func fetchData<T: Decodable>(request: ApiRequest)->Promise<T> {
        return Promise { seal in
            getRequestData(request: request).validate(statusCode: 200...300).responseData { [weak self] response in
                guard let self = self else { return }
                firstly {
                    self.handleResponse(response: response, mappingClass: T.self)
                }
                .done { response in
                    seal.fulfill(response)
                }
                .catch { error in
                    seal.reject(error)
                }
            }
        }
    }
}

private extension NetworkManager {
    //MARK: get DataRequest
    private func getRequestData(request: ApiRequest) -> DataRequest {
        let requestData = AF.request(request.baseURL + request.path,
                                     method: request.method,
                                     parameters: request.parameters,
                                     encoding: request.encoding,
                                     headers: request.headers)
        return requestData
    }
    //MARK: handle server response using JSONDecoder
    private func handleResponse<T: Decodable> (response: DataResponse<Data, AFError>, mappingClass: T.Type) -> Promise<T> {
        return Promise { seal in
            
            guard let jsonResponse = response.data else {
                return seal.reject(ErrorHandler.generalError)
            }
            switch response.result {
            case .success:
                do {
                    let decodedObj = try JSONDecoder().decode(T.self, from: jsonResponse)
                    return seal.fulfill(decodedObj)
                } catch  {
                    return seal.reject(ErrorHandler.generalError)
                }
                
            case .failure:
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: jsonResponse)
                    return seal.reject(ErrorHandler.custom(errorModel.message ?? ""))
                } catch {
                    return seal.reject(error)
                }
            }
            
        }
    }
}
