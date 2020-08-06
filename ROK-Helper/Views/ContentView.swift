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
    
    @State var universalSpeedup: String = ""

    @State var yOffset : CGFloat = 0
    
    var body: some View {
        VStack{
        VStack {
            HStack {
                Image("Universal_Speedup")
                Text("Universal")
            }
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    VStack {
                        Text("1 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("5 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("10 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("15 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

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
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())


                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("5 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("10 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("15 min")
                        TextField("#", text:$universalSpeedup)
                            .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    }.padding()
                        .frame(width: 100, height: 100)
                }
            }
        }.padding()
            
        }.onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { key in
                let value = key.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                self.yOffset = value.height
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { key in
                self.yOffset = 0
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
