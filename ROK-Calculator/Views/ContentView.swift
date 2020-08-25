//
//  ContentView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/2/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

let TIMENAMES = ["1m", "5m", "10m", "15m", "30m", "60m", "3h", "8h", "15h", "24h", "3d", "7d", "30d"]

struct ContentView: View {
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 5)
    
    @State private var showingAlert = false
    @State private var presentChart = false
    
    init() {
        self.speedupListVM = SpeedupListViewModel()
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        Background {
            ZStack {
                Color("CoolGray")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical) {
                
                VStack(spacing: 8) {
                    Text("Speedup Calculator")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color("DeepOrange"))
                        .padding(.top, 32)
                    
                    HStack {
                        Button(action: {
                            self.speedupListVM.SaveAndUpdateTotals()
                            self.showingAlert = true
                        }) {
                            Text("Save")
                        }.alert(isPresented: self.$showingAlert) {
                            Alert(title: Text("All speedups saved!"), message: Text("Check out the charts!"), dismissButton: .default(Text("R\"OK\"")))
                        }
                        
                        Button(action: {
                            self.speedupListVM.UpdateAllTotals()
                            self.presentChart = true
                        }) {
                            Text("Chart")
                        }.sheet(isPresented: self.$presentChart) {
                            SpeedupChartView(speedupListVM: self.speedupListVM)
                        }
                        
                    }
                    
                    
                    BSpeedupView(speedupListVM: self.speedupListVM, kGuardian: self.kGuardian)
                        .cornerRadius(8)
                    TSpeedupView(speedupListVM: self.speedupListVM, kGuardian: self.kGuardian)
                        .cornerRadius(8)
                    RSpeedupView(speedupListVM: self.speedupListVM, kGuardian: self.kGuardian)
                        .cornerRadius(8)
                    HSpeedupView(speedupListVM: self.speedupListVM, kGuardian: self.kGuardian)
                        .cornerRadius(8)
                    USpeedupView(speedupListVM: self.speedupListVM, kGuardian: self.kGuardian)
                        .cornerRadius(8)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    SpeedupTotalView(speedupListVM: self.speedupListVM)
                        .padding(.bottom, 16)
                }.offset(y: self.kGuardian.slide).animation(.easeInOut(duration: 0.3))
                }
            }.onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }
        }.onTapGesture {
            self.endEditing()
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
