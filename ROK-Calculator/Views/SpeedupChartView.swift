//
//  SpeedupChartView.swift
//  ROK-Calculator
//
//  Created by Gi Pyo Kim on 8/20/20.
//  Copyright © 2020 gipgip. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct SpeedupChartView: View {
    
    @ObservedObject var speedupListVM: SpeedupListViewModel {
        didSet {
            update()
        }
    }
    
    @State var buildSpeedups = [Double]()
    @State var trainSpeedups = [Double]()
    @State var researchSpeedups = [Double]()
    @State var healSpeedups = [Double]()
    @State var universalSpeedups = [Double]()
    
    private func update() {
        self.buildSpeedups = self.speedupListVM.allSpeedups
                                .filter { $0.name == SpeedupTypes.build.rawValue }
                                .sorted { ($0.date > $1.date) }
                                .map { Double($0.total) }
        
        self.trainSpeedups = self.speedupListVM.allSpeedups
                                .filter { $0.name == SpeedupTypes.train.rawValue }
                                .sorted { ($0.date > $1.date) }
                                .map { Double($0.total) }
        
        self.researchSpeedups = self.speedupListVM.allSpeedups
                                .filter { $0.name == SpeedupTypes.research.rawValue }
                                .sorted { ($0.date > $1.date) }
                                .map { Double($0.total) }
        
        self.healSpeedups = self.speedupListVM.allSpeedups
                                .filter { $0.name == SpeedupTypes.heal.rawValue }
                                .sorted { ($0.date > $1.date) }
                                .map { Double($0.total) }
        
        self.universalSpeedups = self.speedupListVM.allSpeedups
                                .filter { $0.name == SpeedupTypes.universal.rawValue }
                                .sorted { ($0.date > $1.date) }
                                .map { Double($0.total) }
        
        
    }
    
    var body: some View {
        MultiLineChartView(data: [(buildSpeedups, GradientColors.blu),
                                  (trainSpeedups, GradientColors.orange),
                                  (researchSpeedups, GradientColors.green),
                                  (healSpeedups, GradientColors.purple),
                                  (universalSpeedups, GradientColors.prplNeon)], title: "Speedup Totals")
    }
}

//struct SpeedupChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpeedupChartView()
//    }
//}
