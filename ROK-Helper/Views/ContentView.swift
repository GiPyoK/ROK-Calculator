//
//  ContentView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/2/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

let TIMENAMES = ["1m", "5m", "10m", "15m", "30m", "60m", "3h", "8h", "15h", "25h", "3d", "7h", "30h"]

struct ContentView: View {
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 5)

    
    init() {
        self.speedupListVM = SpeedupListViewModel()
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        Background {
            ZStack {
                Color("CoolGray")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 8) {
                    USpeedupView(uSpeedups: self.speedupListVM.uSpeedups, kGuardian: self.kGuardian)
                    TSpeedupView(tSpeedups: self.speedupListVM.tSpeedups, kGuardian: self.kGuardian)
                    RSpeedupView(rSpeedups: self.speedupListVM.rSpeedups, kGuardian: self.kGuardian)
                    BSpeedupView(bSpeedups: self.speedupListVM.bSpeedups, kGuardian: self.kGuardian)
                    HSpeedupView(hSpeedups: self.speedupListVM.hSpeedups, kGuardian: self.kGuardian)
                }.offset(y: self.kGuardian.slide).animation(.easeInOut(duration: 0.3))
            }.onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }
        }.onTapGesture {
            self.endEditing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
