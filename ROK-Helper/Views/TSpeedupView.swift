//
//  TSpeedupView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/8/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct TSpeedupView: View {
    @Binding var tSpeedups: [(String, String)]
    @ObservedObject var kGuardian: KeyboardGuardian

    
    var body: some View {
        VStack {
            HStack {
                Image("Training_Speedup")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tSpeedups.indices) { i in
                        VStack {
                            Text(TIMENAMES[i])
                            TextField("#", text: self.$tSpeedups[i].1, onEditingChanged: { if $0 { self.kGuardian.showField = 1 } })
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(GeometryGetter(rect: self.$kGuardian.rects[1]))
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

//struct TSpeedupView_Previews: PreviewProvider {
//    @State static var defaultSpeedups = [ ("min1", "0"),
//                                          ("min5", "0"),
//                                          ("min10", "0"),
//                                          ("min15", "0"),
//                                          ("min30", "0"),
//                                          ("min60", "0"),
//                                          ("hour3", "0"),
//                                          ("hour8", "0"),
//                                          ("hour15", "0"),
//                                          ("hour25", "0"),
//                                          ("day3", "0"),
//                                          ("day7", "0"),
//                                          ("day30", "0") ]
//    
//    static var previews: some View {
//        TSpeedupView(tSpeedups: $defaultSpeedups)
//    }
//}
