//
//  Bundle+Extensions.swift
//  Hearthstone
//
//  Created by NJ Development on 21/07/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
    
    var scheme: String {
        object(forInfoDictionaryKey: "SCHEME") as? String ?? ""
    }
    
    var host: String {
        object(forInfoDictionaryKey: "HOST") as? String ?? ""
    }
    
    var endpoint: String {
        object(forInfoDictionaryKey: "ENDPOINT") as? String ?? ""
    }
    
    var headerKeyField: String {
        object(forInfoDictionaryKey: "HEADER_KEY_FIELD") as? String ?? ""
    }
    
    var headerHostField: String {
        object(forInfoDictionaryKey: "HEADER_HOST_FIELD") as? String ?? ""
    }
    
    var title: String {
        object(forInfoDictionaryKey: "TITLE") as? String ?? ""
    }
}
