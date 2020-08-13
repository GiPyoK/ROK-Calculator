//
//  Background.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/10/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import Foundation
import SwiftUI

//https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}
