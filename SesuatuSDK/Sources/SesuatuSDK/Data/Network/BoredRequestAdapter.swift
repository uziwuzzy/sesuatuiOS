//
//  RequestAdapter.swift
//  TicTacToe
//
//  Created by Wahyu Sulistyo on 10/05/22.
//

import Foundation
import Alamofire

class BoredRequestAdapter: RequestInterceptor, RequestRetrier {
    
    let BASE_URL: String = ""
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(BASE_URL), !urlString.hasSuffix("/renew") {
            if let token = accessToken {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock() ; defer { lock.unlock() }

        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
        
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken in
                    guard let strongSelf = self else { return }

                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }

                    if let accessToken = accessToken {
                        strongSelf.accessToken = accessToken
                    }

                    var retryResult = RetryResult.doNotRetry
                    if(!succeeded){
                        retryResult = RetryResult.retry
                    }
                    strongSelf.requestsToRetry.forEach { $0(retryResult) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }

    // MARK: - Private - Refresh Tokens

    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }

        isRefreshing = true

        let urlString = "\(BASE_URL)token/renew"
        let urlConvertible: URLConvertible = urlString

        AF.request(urlConvertible, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":"Bearer \(refreshToken!)"])
            .response { data in
                debugPrint(data)
            }
//        { data in
//                guard let strongSelf = self else { return }
//            }
//        { [weak self] response in
//            guard let strongSelf = self else { return }
//            if
//                let json = response.result.value as? [String: Any],
//                let accessToken = json["accessToken"] as? String
//            {
//                completion(true, accessToken)
//            } else {
//                completion(false, nil)
//            }
//            strongSelf.isRefreshing = false
//        }
    }
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void

    private let lock = NSLock()

    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    var accessToken:String? = nil
    var refreshToken:String? = nil
    static let shared = BoredRequestAdapter()

    init(){
    }


}
