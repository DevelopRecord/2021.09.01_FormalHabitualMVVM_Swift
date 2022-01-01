//
//  WiseSaying.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/12/31.
//

import Foundation

struct WiseSaying: Codable {
    let name: String
    let phrase: String

    enum CodingKeys: String, CodingKey {
        case name
        case phrase
    }
}

/*
struct Friend: Codable {
    let name: String
    let age: Int
    let addressInfo: Address
    
    struct Address: Codable {
        let country: String
        let city: String
    }
    
    enum CodingKeys: String, CodingKey {
        case addressInfo = "address_info"
        case name, age
    }
}
*/
