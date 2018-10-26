//
//  NetworkAdapter.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 23/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import Foundation
import Moya

struct NetworkAdapter {
    static let provider = MoyaProvider<ServerAPI>()
    
    static func request(target: ServerAPI, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    let error = NSError(domain:"com.tokenlab.guilhermehenna", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
