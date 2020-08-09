//
//  NSManagedObjectContext+Extension.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/5/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
