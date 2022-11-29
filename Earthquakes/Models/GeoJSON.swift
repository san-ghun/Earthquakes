//
//  GeoJSON.swift
//  EarthquakesTests
//
//  Created by Sanghun Park on 29.11.22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featuresContainer.isAtEnd {
            let propertiesConatiner = try featuresContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? propertiesConatiner.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
