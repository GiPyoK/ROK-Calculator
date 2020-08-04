//
//  SpeedUp.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/3/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation

struct SpeedUp: Codable {
    let min1 : Int
    let min5 : Int
    let min10 : Int
    let min15 : Int
    let min30 : Int
    let min60 : Int
    
    let hour3 : Int
    let hour8 : Int
    let hour15 : Int
    let hour24 : Int
    
    let day3 : Int
    let day7 : Int
    let day24 : Int
}
