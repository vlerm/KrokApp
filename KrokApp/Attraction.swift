//
//  Attraction.swift
//  KrokApp
//
//  Created by Вадим Лавор on 2.08.22.
//

import Foundation

struct Attraction: Decodable {
    
    var logo: String?
    var name: String?
    var city_id: Int?
    var text: String?
    var sound: String?
    var images: [String]?
    var creation_date: String?
   
}
