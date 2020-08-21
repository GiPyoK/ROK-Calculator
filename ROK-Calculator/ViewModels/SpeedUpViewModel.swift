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
    case build
    case train
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
    
    // In minutes
    @Published var buildSum = 0
    @Published var trainlSum = 0
    @Published var researchSum = 0
    @Published var healSum = 0
    @Published var universalSum = 0
    
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
        
        calculateBuildSum()
        calculateTrainSum()
        calculateResearchSum()
        calculateHealSum()
        calculateUniversalSum()
    }
    
    func fetchAllSpeedups() {
        self.speedups = CoreDataManager.shared.getAllSpeedups().map(SpeedUpViewModel.init)
    }
    
    func saveAllSpeedups() {
        
        let allSpeedups = changeSpeedupTuplesToArray(build: self.bSpeedups, train: self.tSpeedups, research: self.rSpeedups, heal: self.hSpeedups, universal: self.uSpeedups)
        
        for speedup in allSpeedups {
            speedup.saveSpeedup()
        }
    }
    
    func changeSpeedupTuplesToArray(build: [(String, String)],
                                    train: [(String, String)],
                                    research: [(String, String)],
                                    heal: [(String, String)],
                                    universal: [(String, String)] ) -> [SpeedUpViewModel] {
        
        var speedupVM = [SpeedUpViewModel]()
        speedupVM.append(SpeedUpViewModel(name: SpeedupTypes.build.rawValue, tuples: build, total: self.buildSum))
        speedupVM.append(SpeedUpViewModel(name: SpeedupTypes.train.rawValue, tuples: train, total: self.trainlSum))
        speedupVM.append(SpeedUpViewModel(name: SpeedupTypes.research.rawValue, tuples: research, total: self.researchSum))
        speedupVM.append(SpeedUpViewModel(name: SpeedupTypes.heal.rawValue, tuples: heal, total: self.healSum))
        speedupVM.append(SpeedUpViewModel(name: SpeedupTypes.universal.rawValue, tuples: universal, total: self.universalSum))
        
        return speedupVM
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
        if let build = allSpeedups.first(where: { $0.name == SpeedupTypes.build.rawValue }) {
            speedups.append(build)
        }
        
        if let train = allSpeedups.first(where: { $0.name == SpeedupTypes.train.rawValue }) {
            speedups.append(train)
        }
        
        if let research = allSpeedups.first(where: { $0.name == SpeedupTypes.research.rawValue }) {
            speedups.append(research)
        }
        
        if let heal = allSpeedups.first(where: { $0.name == SpeedupTypes.heal.rawValue }) {
            speedups.append(heal)
        }
        
        if let universal = allSpeedups.first(where: { $0.name == SpeedupTypes.universal.rawValue}) {
            speedups.append(universal)
        }
    }
    
    private func getSpeedupTimes(name: SpeedupTypes) -> [(String, String)]? {
        var timePairs = [(String, String)]()
        
        for speedup in self.speedups {
            if speedup.name == name.rawValue {
                let mirror = Mirror(reflecting: speedup)
                
                for case let (label, value) in mirror.children {
                    guard let label = label else { return nil }
                    if !(["name", "date", "total"].contains(label)) {
                        guard let value = value as? Int else { return nil }
                        
                        if [SpeedupTypes.build, SpeedupTypes.train, SpeedupTypes.research, SpeedupTypes.heal].contains(name) {
                            if ["hour24", "day3", "day7", "day30"].contains(label) {
                                continue
                            }
                        }
                        
                        timePairs.append((label, String(value)))
                    }
                }
                return timePairs
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
    
    var total = 0
    
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
        self.total = Int(speedup.total)
    }
    
    init(name: String, tuples: [(String, String)], total: Int) {
        self.name = name
        self.date = Date()
        
        self.min1 = tuples.indices.contains(0) ? Int(tuples[0].1) ?? 0 : 0
        self.min5 = tuples.indices.contains(1) ? Int(tuples[1].1) ?? 0 : 0
        self.min10 = tuples.indices.contains(2) ? Int(tuples[2].1) ?? 0 : 0
        self.min15 = tuples.indices.contains(3) ? Int(tuples[3].1) ?? 0 : 0
        self.min30 = tuples.indices.contains(4) ? Int(tuples[4].1) ?? 0 : 0
        self.min60 = tuples.indices.contains(5) ? Int(tuples[5].1) ?? 0 : 0
        self.hour3 = tuples.indices.contains(6) ? Int(tuples[6].1) ?? 0 : 0
        self.hour8 = tuples.indices.contains(7) ? Int(tuples[7].1) ?? 0 : 0
        self.hour15 = tuples.indices.contains(8) ? Int(tuples[8].1) ?? 0 : 0
        self.hour24 = tuples.indices.contains(9) ? Int(tuples[9].1) ?? 0 : 0
        self.day3 = tuples.indices.contains(10) ? Int(tuples[10].1) ?? 0 : 0
        self.day7 = tuples.indices.contains(11) ? Int(tuples[11].1) ?? 0 : 0
        self.day30 = tuples.indices.contains(12) ? Int(tuples[12].1) ?? 0 : 0
        
        self.total = total
    }
    
    func saveSpeedup() {
        CoreDataManager.shared.saveSpeedup(name: name, date: date, min1: min1, min5: min5, min10: min10, min15: min15, min30: min30, min60: min60, hour3: hour3, hour8: hour8, hour15: hour15, hour24: hour24, day3: day3, day7: day7, day30: day30, total: total)
    }
}
