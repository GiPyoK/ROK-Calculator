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
        self.speedupListVM.calculateTrainSum()
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
                    }.padding(.leading, 4)
                    Spacer()
                        .frame(height: 4)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack {
                        HStack {
                            ForEach(speedupListVM.tSpeedups.indices) { i in
                                VStack {
                                    Text(TIMENAMES[i])
                                    TextField("#", text: self.$speedupListVM.tSpeedups[i].1, onEditingChanged: {
                                        self.speedupListVM.calculateTrainSum()
                                        if $0 { self.kGuardian.showField = 1 }
                                    }).keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .background(GeometryGetter(rect: self.$kGuardian.rects[1]))
                                }.fixedSize()
                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                .padding(.horizontal, 2)
                                .padding(.vertical, 5)
                            }
                        }.padding(.horizontal)
                        
                        GeometryReader { geometry in
                            VStack(spacing: 0) {
                                Rectangle()
                                    .foregroundColor(Color.clear)
                                    .frame(width: geometry.size.width, height: geometry.size
                                            .height/2)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                    }
                            }
                        }
                    }
                }
            }.background(Color("AbyssGreen"))
        }
    }
}
