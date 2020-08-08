//
//  ContentView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/2/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    // https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui
    // Good keyboard animation
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    
    init() {
        self.speedupListVM = SpeedupListViewModel()
    }
    
    var body: some View {
        ZStack {
            Color("CoolGray")
                .edgesIgnoringSafeArea(.all)
            VStack {
                USpeedupView(uSpeedups: speedupListVM.$uSpeedups)
            }
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
