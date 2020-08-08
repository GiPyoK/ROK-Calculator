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
        VStack{
            VStack {
                HStack {
                    Image("Universal_Speedup")
                    Text("Universal")
                }
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(speedupListVM.uSpeedups.indices) { i in
                            VStack {
                                Text(self.speedupListVM.uSpeedups[i].0)
                                TextField("#", text: self.speedupListVM.$uSpeedups[i].1)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                        }
                        
                        VStack {
                            Text("TEST")
                            //                            TextField("#", text:$universalSpeedup)
                            //                                .keyboardType(.numberPad)
                            //                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }.padding()
                            .frame(width: 100, height: 100)
                    }
                }
            }.padding()
            
            VStack {
                HStack {
                    Image("Training_Speedup")
                    Text("Training")
                }
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        VStack {
                            Text("1 min")
//                            TextField("#", text:$universalSpeedup)
//                                .keyboardType(.numberPad)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            
                        }.padding()
                            .frame(width: 100, height: 100)
                    }
                }
            }.padding()
            
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
