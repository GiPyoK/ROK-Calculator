//
//  TSpeedupView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/8/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct TSpeedupView: View {
    @ObservedObject var speedupListVM: SpeedupListViewModel
    @ObservedObject var kGuardian: KeyboardGuardian
    
    private func reset() {
        for i in speedupListVM.tSpeedups.indices {
            self.speedupListVM.tSpeedups[i].1 = ""
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image("Training_Speedup")
                    Button(action: {
                        self.reset()
                        print(self.speedupListVM.tSpeedups)
                    }) {
                        Text("Clear")
                            .padding(4)
                            .foregroundColor(Color.white)
                            .background(Color("BurntSienna"))
                            .cornerRadius(4)
                            .frame(alignment: .center)
                    }
                    Spacer()
                    .frame(height: 4)
                }
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(speedupListVM.tSpeedups.indices) { i in
                        if i < 10 {
                            VStack {
                                Text(TIMENAMES[i])
                                TextField("#", text: self.$speedupListVM.tSpeedups[i].1, onEditingChanged: {
                                    self.speedupListVM.calculateTrainSum()
                                    if $0 { self.kGuardian.showField = 1 }
                                })
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .background(GeometryGetter(rect: self.$kGuardian.rects[1]))
                            }.fixedSize()
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                .padding(.horizontal, 2)
                                .padding(.vertical, 5)
                        }
                    }
                }.padding(.horizontal)
            }
            }.background(Color("AbyssGreen"))
        }
    }
}
