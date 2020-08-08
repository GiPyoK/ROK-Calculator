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

enum SpeedupTypes: String {
    case train
    case build
    case research
    case heal
    case universal
}

enum TimeTypes: String, CaseIterable {
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
    @State var uSpeedups = [ ("min1", "0"),
                             ("min5", "0"),
                             ("min10", "0"),
                             ("min15", "0"),
                             ("min30", "0"),
                             ("min60", "0"),
                             ("hour3", "0"),
                             ("hour8", "0"),
                             ("hour15", "0"),
                             ("hour25", "0"),
                             ("day3", "0"),
                             ("day7", "0"),
                             ("day30", "0") ]
    @State var tSpeedups = [ ("min1", "0"),
                             ("min5", "0"),
                             ("min10", "0"),
                             ("min15", "0"),
                             ("min30", "0"),
                             ("min60", "0"),
                             ("hour3", "0"),
                             ("hour8", "0"),
                             ("hour15", "0"),
                             ("hour25", "0"),
                             ("day3", "0"),
                             ("day7", "0"),
                             ("day30", "0") ]
    @State var rSpeedups = [ ("min1", "0"),
                             ("min5", "0"),
                             ("min10", "0"),
                             ("min15", "0"),
                             ("min30", "0"),
                             ("min60", "0"),
                             ("hour3", "0"),
                             ("hour8", "0"),
                             ("hour15", "0"),
                             ("hour25", "0"),
                             ("day3", "0"),
                             ("day7", "0"),
                             ("day30", "0") ]
    @State var bSpeedups = [ ("min1", "0"),
                             ("min5", "0"),
                             ("min10", "0"),
                             ("min15", "0"),
                             ("min30", "0"),
                             ("min60", "0"),
                             ("hour3", "0"),
                             ("hour8", "0"),
                             ("hour15", "0"),
                             ("hour25", "0"),
                             ("day3", "0"),
                             ("day7", "0"),
                             ("day30", "0") ]
    @State var hSpeedups = [ ("min1", "0"),
                             ("min5", "0"),
                             ("min10", "0"),
                             ("min15", "0"),
                             ("min30", "0"),
                             ("min60", "0"),
                             ("hour3", "0"),
                             ("hour8", "0"),
                             ("hour15", "0"),
                             ("hour25", "0"),
                             ("day3", "0"),
                             ("day7", "0"),
                             ("day30", "0") ]
    
    private var speedups = [SpeedUpViewModel]()
    
    init() {
        fetchAllSpeedups()
        getRecentSpeedups()
        if let uSpeedups = getSpeedupTimes(name: .universal) {
            self.uSpeedups = uSpeedups
        }
        if let tSpeedups = getSpeedupTimes(name: .train) {
            self.tSpeedups = tSpeedups
        }
        if let rSpeedups = getSpeedupTimes(name: .research) {
            self.rSpeedups = rSpeedups
        }
        if let bSpeedups = getSpeedupTimes(name: .build) {
            self.bSpeedups = bSpeedups
        }
        if let hSpeedups = getSpeedupTimes(name: .heal) {
            self.hSpeedups = hSpeedups
        }
    }
    
    func fetchAllSpeedups() {
        self.speedups = CoreDataManager.shared.getAllSpeedups().map(SpeedUpViewModel.init)
    }
    
    private func getRecentSpeedups() {
        if let universal = allSpeedups.first(where: { $0.name == SpeedupTypes.universal.rawValue}) {
            speedups.append(universal)
        }
        
        if let train = allSpeedups.first(where: { $0.name == SpeedupTypes.train.rawValue }) {
            speedups.append(train)
        }
        
        if let research = allSpeedups.first(where: { $0.name == SpeedupTypes.research.rawValue }) {
            speedups.append(research)
        }
        
        if let build = allSpeedups.first(where: { $0.name == SpeedupTypes.build.rawValue }) {
            speedups.append(build)
        }
        if let heal = allSpeedups.first(where: { $0.name == SpeedupTypes.heal.rawValue }) {
            speedups.append(heal)
        }
    }
    
    private func getSpeedupTimes(name: SpeedupTypes) -> [(String, String)]? {
        var timeDict = [(String, String)]()
        
        for speedup in self.speedups {
            if speedup.name == name.rawValue {
                let mirror = Mirror(reflecting: speedup)
                
                for case let (label, value) in mirror.children {
                    guard let label = label else { return nil }
                    if !(["name", "date"].contains(label)) {
                        guard let value = value as? Int else { return nil }
                        timeDict.append((label, String(value)))
                    }
                }
                return timeDict
            }
        }
        return nil
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
