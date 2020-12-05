//
//  UIApplication+Extension.swift
//  ROK-Calculator
//
//  Created by Gi Pyo Kim on 12/4/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
