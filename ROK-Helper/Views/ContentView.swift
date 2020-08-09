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
    
    var body: some View {
        ZStack {
            Color("CoolGray")
                .edgesIgnoringSafeArea(.all)
            VStack {
                USpeedupView(uSpeedups: speedupListVM.uSpeedups, kGuardian: kGuardian)
                TSpeedupView(tSpeedups: speedupListVM.tSpeedups, kGuardian: kGuardian)
                RSpeedupView(rSpeedups: speedupListVM.rSpeedups, kGuardian: kGuardian)
                BSpeedupView(bSpeedups: speedupListVM.bSpeedups, kGuardian: kGuardian)
                HSpeedupView(hSpeedups: speedupListVM.hSpeedups, kGuardian: kGuardian)
                VStack {
                    Text(speedupListVM.uSpeedups[0].0)
                    Text(speedupListVM.uSpeedups[0].1)
                }
            }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
        }.onAppear { self.kGuardian.addObserver() }
        .onDisappear { self.kGuardian.removeObserver() }
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
