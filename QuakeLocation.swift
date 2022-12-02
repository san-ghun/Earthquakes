//
//  QuakeLocation.swift
//  EarthquakesTests
//
//  Created by Sanghun Park on 02.12.22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

struct QuakeLocation: Decodable {
    var latitude: Double { properties.products.origins.first!.properties.latitude }
    var longitude: Double { properties.products.origins.first!.properties.longitude }
    private var properties: RootProperties
    
    struct RootProperties: Decodable {
        var products: Products
    }
    struct Products: Decodable {
        var origins: [Origin]
    }
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    struct OriginProperties {
        var latitude: Double
        var longitude: Double
    }
}

extension QuakeLocation.OriginProperties: Decodable {
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
        let latitude = try container.decode(String.self, forKey: .latitude)
        let longitude = try container.decode(String.self, forKey: .longitude)
        guard let latitude = Double(latitude), let longitude = Double(longitude) else { throw QuakeError.missingData }
        self.latitude = latitude
        self.longitude = longitude
    }
}
