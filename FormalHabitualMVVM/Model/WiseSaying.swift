//
//  WiseSaying.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/12/31.
//

import Foundation

struct WiseSayingResponse: Codable {
    let quotes: [WiseSaying]
}

struct WiseSaying: Codable {
    let quote: String?
    let author: String?
}

/**
 
 {
     "quotes": [

 {
        "quote":"Life isn’t about getting and having, it’s about giving and being.",
        "author":"Kevin Kruse"
 
 },
 {
        "quote":"Whatever the mind of man can conceive and believe, it can achieve.",
        "author":"Napoleon Hill"
 
 },
 {
        "quote":"Strive not to be a success, but rather to be of value.","author":"Albert Einstein"},
 {
        "quote":"Two roads diverged in a wood, and I—I took the one less traveled by, And that has made all the difference.","author":"Robert Frost"},
 {
        "quote":"I attribute my success to this: I never gave or took any excuse.","author":"Florence Nightingale"},
 */
