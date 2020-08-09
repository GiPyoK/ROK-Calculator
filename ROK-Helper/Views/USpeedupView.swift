//
//  USpeedupView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/8/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct USpeedupView: View {
    
    @State var uSpeedups: [(String, String)]
    @ObservedObject var kGuardian: KeyboardGuardian
    
    private func reset() {
        for i in uSpeedups.indices {
            self.uSpeedups[i].1 = ""
        }
    }
    
    var body: some View {
        VStack {
            
            HStack {
                VStack {
                    Image("Universal_Speedup")
                    Button(action: {
                        self.reset()
                        print(self.uSpeedups)
                    }) {
                        Text("Clear")
                    }

                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(uSpeedups.indices) { i in
                            VStack {
                                Text(TIMENAMES[i])
                                TextField("#", text: self.$uSpeedups[i].1, onEditingChanged: { if $0 { self.kGuardian.showField = 0 } })
                                    .keyboardType(.numberPad)
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

//struct USpeedupView_Previews: PreviewProvider {
//
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
//        USpeedupView(uSpeedups: $defaultSpeedups)
//    }
//}
