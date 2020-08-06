//
//  CoreDataManager.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/5/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    // MARK: Init
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: May need to implement this function
    //private func fetchSpeedups()
    
    func getAllSpeedups() -> [Speedup] {
        var speedups = [Speedup]()
        let speedupRequest: NSFetchRequest<Speedup> = Speedup.fetchRequest()
        
        do {
            speedups = try self.moc.fetch(speedupRequest)
        } catch let error as NSError {
            // TODO: Handle fetch error
            print(error)
        }
        
        return speedups
    }
    
    func saveSpeedup(name: String, date: Date,
                     min1: Int, min5: Int, min10: Int, min15: Int, min30: Int, min60: Int,
                     hour3: Int, hour8: Int, hour15: Int, hour24: Int,
                     day3: Int, day7: Int, day30: Int) {
        
        let speedup = Speedup(context: self.moc)
        speedup.name = name
        speedup.date = date
        speedup.min1 = Int32(min1)
        speedup.min5 = Int32(min5)
        speedup.min10 = Int32(min10)
        speedup.min15 = Int32(min15)
        speedup.min30 = Int32(min30)
        speedup.min60 = Int32(min60)
        speedup.hour3 = Int32(hour3)
        speedup.hour8 = Int32(hour8)
        speedup.hour15 = Int32(hour15)
        speedup.hour24 = Int32(hour24)
        speedup.day3 = Int32(day3)
        speedup.day7 = Int32(day7)
        speedup.day30 = Int32(day30)
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            // TODO: Handle the save error
            print(error)
        }
    }
}
