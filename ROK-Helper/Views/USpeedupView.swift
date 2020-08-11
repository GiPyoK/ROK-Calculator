//
//  USpeedupView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/8/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct USpeedupView: View {
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    @ObservedObject var kGuardian: KeyboardGuardian
    
    func reset() {
        for i in speedupListVM.uSpeedups.indices {
            self.speedupListVM.uSpeedups[i].1 = ""
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image("Universal_Speedup")
                    Button(action: {
                        self.reset()
                        print(self.speedupListVM.uSpeedups)
                    }) {
                        Text("Clear")
                            .padding(4)
                            .foregroundColor(Color.white)
                            .background(Color("BurntSienna"))
                            .cornerRadius(4)
                    }
                    Spacer()
                        .frame(height: 4)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(speedupListVM.uSpeedups.indices) { i in
                            VStack {
                                Text(TIMENAMES[i])
                                TextField("#", text: self.$speedupListVM.uSpeedups[i].1, onEditingChanged: {
                                    self.speedupListVM.calculateUniversalSum()
                                    if $0 { self.kGuardian.showField = 0 }
                                }).keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .background(GeometryGetter(rect: self.$kGuardian.rects[0]))
                                
                                    
                            }.fixedSize()
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                .padding(.horizontal, 2)
                                .padding(.vertical, 5)
                        }
                    }.padding(.horizontal)
                }
            }.background(Color("AbyssGreen"))
        }
    }
}
