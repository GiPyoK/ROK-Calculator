//
//  USpeedupView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/8/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct USpeedupView: View {
    
    @Binding var uSpeedups: [(String, String)]
    
    var body: some View {
            VStack {
                HStack {
                    Image("Universal_Speedup")
                    Text("Universal")
                        .foregroundColor(Color("PaleSepia"))
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack  {
                        Color("AbyssGreen")
                            .edgesIgnoringSafeArea(.all)
                        HStack {
                            ForEach(uSpeedups.indices) { i in
                                VStack {
                                    Text(self.uSpeedups[i].0)
                                    TextField("#", text: self.$uSpeedups[i].1)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }.fixedSize()
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .padding(.horizontal, 2)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
            
        }
    .background(Color("AbyssGreen"))
    }
}

struct USpeedupView_Previews: PreviewProvider {
    
    @State static var defaultSpeedups = [ ("min1", "0"),
                                   ("min5", "0"),
                                   ("min10", "0"),
                                   ("min15", "0"),
                                   ("min30", "0"),
                                   ("min60", "0"),
                                   ("hour3", "0"),
                                   ("hour8", "0"),
                                   ("hour15", "0"),
                                   ("hour25", "0"),
                                   ("day3", "0"),
                                   ("day7", "0"),
                                   ("day30", "0") ]
    
    static var previews: some View {
        USpeedupView(uSpeedups: $defaultSpeedups)
    }
}
