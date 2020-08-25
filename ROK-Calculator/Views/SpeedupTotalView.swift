//
//  SpeedupTotalView.swift
//  ROK-Helper
//
//  Created by Gi Pyo Kim on 8/10/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI

struct SpeedupTotalView: View {
    
    enum TimeUnit: String, CaseIterable, Identifiable {
        case day
        case hour
        case minute
        
        var id: String { self.rawValue}
    }
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    
    @State var timeUnit: TimeUnit = .hour
    
    @State var universalIsOn = true
    @State var trainIsOn = false
    @State var researchIsOn = false
    @State var buildIsOn = false
    @State var healIsOn = false
    
    private func calculateTotal(unit: TimeUnit) -> String {
        var total: Float = 0.0
        
        if universalIsOn { total += Float(speedupListVM.universalSum) }
        if trainIsOn { total += Float(speedupListVM.trainSum) }
        if researchIsOn { total += Float(speedupListVM.researchSum) }
        if buildIsOn { total += Float(speedupListVM.buildSum) }
        if healIsOn { total += Float(speedupListVM.healSum) }
        
        if timeUnit == .day {
            total /= 1440.0
            return String(format: "%.2f", total)
        } else if timeUnit == .hour {
            total /= 60.0
            return String(format: "%.2f", total)
        } else {
            return String(format: "%.0f", total)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.buildIsOn.toggle()
                }) {
                    Image("Building_Speedup")
                        .opacity(self.buildIsOn ? 1.0 : 0.5)
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
                    self.healIsOn.toggle()
                }) {
                    Image("Healing_Speedup")
                        .opacity(self.healIsOn ? 1.0 : 0.5)
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.universalIsOn.toggle()
                }) {
                    Image("Universal_Speedup")
                        .opacity(self.universalIsOn ? 1.0 : 0.5)
                }.buttonStyle(PlainButtonStyle())
            }.padding(4)
            
            
            Picker("Time Unit", selection: $timeUnit) {
                Text("Day").tag(TimeUnit.day)
                Text("Hour").tag(TimeUnit.hour)
                Text("Minute").tag(TimeUnit.minute)
            }.pickerStyle(SegmentedPickerStyle())
                .padding(4)
            
            
            HStack(alignment: .center) {
                Text("Total:")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("\(calculateTotal(unit: timeUnit))")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("DeepOrange"))
                    .minimumScaleFactor(0.5)
                
                Text("\(timeUnit.rawValue)s")
                    .font(.title)
                .foregroundColor(.white)
                
            }.padding(4)
        }
    }
}
