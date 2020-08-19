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

enum TimeTypes: Int, CaseIterable {
    case min1 = 1
    case min5 = 5
    case min10 = 10
    case min15 = 15
    case min30 = 30
    case min60 = 60
    
    case hour3 = 180
    case hour8 = 480
    case hour15 = 900
    case hour24 = 1440
    
    case day3 = 4320
    case day7 = 10080
    case day30 = 43200
}

class SpeedupListViewModel: ObservableObject {
    
    @Published var allSpeedups = [SpeedUpViewModel]()
    @Published var uSpeedups = [ ("min1", ""),
                                 ("min5", ""),
                                 ("min10", ""),
                                 ("min15", ""),
                                 ("min30", ""),
                                 ("min60", ""),
                                 ("hour3", ""),
                                 ("hour8", ""),
                                 ("hour15", ""),
                                 ("hour24", ""),
                                 ("day3", ""),
                                 ("day7", ""),
                                 ("day30", "") ]
    @Published var tSpeedups = [ ("min1", ""),
                             ("min5", ""),
                             ("min10", ""),
                             ("min15", ""),
                             ("min30", ""),
                             ("min60", ""),
                             ("hour3", ""),
                             ("hour8", ""),
                             ("hour15", ""),
                             ("hour24", "") ]
    @Published var rSpeedups = [ ("min1", ""),
                             ("min5", ""),
                             ("min10", ""),
                             ("min15", ""),
                             ("min30", ""),
                             ("min60", ""),
                             ("hour3", ""),
                             ("hour8", ""),
                             ("hour15", ""),
                             ("hour24", "") ]
    @Published var bSpeedups = [ ("min1", ""),
                             ("min5", ""),
                             ("min10", ""),
                             ("min15", ""),
                             ("min30", ""),
                             ("min60", ""),
                             ("hour3", ""),
                             ("hour8", ""),
                             ("hour15", ""),
                             ("hour24", "") ]
    @Published var hSpeedups = [ ("min1", ""),
                             ("min5", ""),
                             ("min10", ""),
                             ("min15", ""),
                             ("min30", ""),
                             ("min60", ""),
                             ("hour3", ""),
                             ("hour8", ""),
                             ("hour15", ""),
                             ("hour24", "") ]
    
    // In minutes
    @Published var universalSum = 0
    @Published var trainlSum = 0
    @Published var researchSum = 0
    @Published var buildSum = 0
    @Published var healSum = 0
    
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
    
    func calculateUniversalSum() {
        self.universalSum = 0
        for i in self.uSpeedups.indices {
            let minute = Int(self.uSpeedups[i].1) ?? 0
            self.universalSum += (minute * TimeTypes.allCases[i].rawValue)
        }
    }
    
    func calculateTrainSum() {
        self.trainlSum = 0
        for i in self.tSpeedups.indices {
            let minute = Int(self.tSpeedups[i].1) ?? 0
            self.trainlSum += (minute * TimeTypes.allCases[i].rawValue)
        }
    }
    
    func calculateResearchSum() {
        self.researchSum = 0
        for i in self.rSpeedups.indices {
            let minute = Int(self.rSpeedups[i].1) ?? 0
            self.researchSum += (minute * TimeTypes.allCases[i].rawValue)
        }
    }
    
    func calculateBuildSum() {
        self.buildSum = 0
        for i in self.bSpeedups.indices {
            let minute = Int(self.bSpeedups[i].1) ?? 0
            self.buildSum += (minute * TimeTypes.allCases[i].rawValue)
        }
    }
    
    func calculateHealSum() {
        self.healSum = 0
        for i in self.hSpeedups.indices {
            let minute = Int(self.hSpeedups[i].1) ?? 0
            self.healSum += (minute * TimeTypes.allCases[i].rawValue)
        }
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
