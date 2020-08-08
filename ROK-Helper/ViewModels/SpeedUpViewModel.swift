//
//  SpeedUpViewModel.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/4/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

enum sUpName: String {
    case train
    case build
    case research
    case universal
}

enum timeName: String {
    case min1
    case min5
    case min10
    case min15
    case min30
    case min60
    
    case hour3
    case hour8
    case hour15
    case hour24
    
    case day3
    case day7
    case day30
}

class SpeedupListViewModel: ObservableObject {
    
    @Published var allSpeedups = [SpeedUpViewModel]()
    @Published var uSpeedups = [String : Int]()
    @Published var tSpeedups = [String : Int]()
    @Published var rSpeedups = [String : Int]()
    @Published var bSpeedups = [String : Int]()
    
    private var speedups = [SpeedUpViewModel]()
    
    init() {
        fetchAllSpeedups()
        getRecentSpeedups()
        self.uSpeedups = getSpeedupTimes(name: .universal)
        self.tSpeedups = getSpeedupTimes(name: .train)
        self.rSpeedups = getSpeedupTimes(name: .research)
        self.bSpeedups = getSpeedupTimes(name: .build)
    }
    
    func fetchAllSpeedups() {
        self.speedups = CoreDataManager.shared.getAllSpeedups().map(SpeedUpViewModel.init)
    }
    
    private func getRecentSpeedups() {
        if let universal = allSpeedups.first(where: { $0.name == sUpName.universal.rawValue}) {
            speedups.append(universal)
        }
        
        if let train = allSpeedups.first(where: { $0.name == sUpName.train.rawValue }) {
            speedups.append(train)
        }
        
        if let research = allSpeedups.first(where: { $0.name == sUpName.research.rawValue }) {
            speedups.append(research)
        }
        
        if let build = allSpeedups.first(where: { $0.name == sUpName.build.rawValue }) {
            speedups.append(build)
        }
    }
    
    private func getSpeedupTimes(name: sUpName) -> [String : Int] {
        var timeDict = [String : Int]()
        
        for speedup in self.speedups {
            if speedup.name == name.rawValue {
                let mirror = Mirror(reflecting: speedup)
                
                for case let (label, value) in mirror.children {
                    guard let label = label else { return timeDict }
                    if !(["name", "date"].contains(label)) {
                        guard let value = value as? Int else { return timeDict }
                        timeDict[label] = value
                    }
                }
                return timeDict
            }
        }
        return timeDict
    }
    
}

class SpeedUpViewModel {
    var name = ""
    var date = Date()
    
    var min1 = 0
    var min5 = 0
    var min10 = 0
    var min15 = 0
    var min30 = 0
    var min60 = 0
    
    var hour3 = 0
    var hour8 = 0
    var hour15 = 0
    var hour24 = 0
    
    var day3 = 0
    var day7 = 0
    var day30 = 0
    
    init(speedup: Speedup) {
        self.name = speedup.name!
        self.date = speedup.date!
        self.min1 = Int(speedup.min1)
        self.min5 = Int(speedup.min5)
        self.min10 = Int(speedup.min10)
        self.min15 = Int(speedup.min15)
        self.min30 = Int(speedup.min30)
        self.min60 = Int(speedup.min60)
        self.hour3 = Int(speedup.hour3)
        self.hour8 = Int(speedup.hour8)
        self.hour15 = Int(speedup.hour15)
        self.hour24 = Int(speedup.hour24)
        self.day3 = Int(speedup.day3)
        self.day7 = Int(speedup.day7)
        self.day30 = Int(speedup.day30)
    }
    
    func saveSpeedup() {
        CoreDataManager.shared.saveSpeedup(name: name, date: date, min1: min1, min5: min5, min10: min10, min15: min15, min30: min30, min60: min60, hour3: hour3, hour8: hour8, hour15: hour15, hour24: hour24, day3: day3, day7: day7, day30: day30)
    }
}
