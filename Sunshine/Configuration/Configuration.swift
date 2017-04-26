//
//  Configuration.swift
//  Sunshine
//
//  Created by Mikołaj Skawiński on 18.02.2017.
//  Copyright © 2017 Mikołaj Skawiński. All rights reserved.
//

import Foundation

struct API {
    
    static let APIKey = "5fdda570d9d16e229ca4e377cb06baa4"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
}

struct Defaults {
    
    static let Latitude: Double = 37.8267
    static let Longitude: Double = -122.423
}
