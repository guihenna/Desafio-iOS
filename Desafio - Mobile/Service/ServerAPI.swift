//
//  serverAPI.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 23/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import Foundation
import Moya

enum ServerAPI {
    case movies
    case details(id: Int)
    //case load
}

extension ServerAPI: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies")! }
    
    var path: String {
        switch self {
        case .movies:
            return ""
        case .details(let id):
            return "/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}
