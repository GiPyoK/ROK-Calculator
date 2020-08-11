//
//  SpeedupTotalView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/10/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct SpeedupTotalView: View {
    
    @State var universalIsOn = true
    @State var trainIsOn = false
    @State var researchIsOn = false
    @State var buildIsOn = false
    @State var healIsOn = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.universalIsOn.toggle()
            }) {
                Image("Universal_Speedup")
                    .opacity(self.universalIsOn ? 1.0 : 0.5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.trainIsOn.toggle()
            }) {
                Image("Training_Speedup")
                    .opacity(self.trainIsOn ? 1.0 : 0.5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.researchIsOn.toggle()
            }) {
                Image("Research_Speedup")
                    .opacity(self.researchIsOn ? 1.0 : 0.5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.buildIsOn.toggle()
            }) {
                Image("Building_Speedup")
                    .opacity(self.buildIsOn ? 1.0 : 0.5)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.healIsOn.toggle()
            }) {
                Image("Healing_Speedup")
                    .opacity(self.healIsOn ? 1.0 : 0.5)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct SpeedupTotalView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedupTotalView()
    }
}
