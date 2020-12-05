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
    
    @ObservedObject var speedupListVM: SpeedupListViewModel
    
    var body: some View {
        ZStack {
            Color("CoolGray")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                BarChartView(data: ChartData(points: speedupListVM.buildTotals), title: "Build", legend: "total in minutes", style: Styles.barChartMidnightGreenDark, form: ChartForm.large, valueSpecifier: "%.0f")
                
                BarChartView(data: ChartData(points: speedupListVM.trainTotals), title: "Train", legend: "total in minutes", style: Styles.barChartMidnightGreenDark, form: ChartForm.large, valueSpecifier: "%.0f")
                
                BarChartView(data: ChartData(points: speedupListVM.researchTotals), title: "Research", legend: "total in minutes", style: Styles.barChartMidnightGreenDark, form: ChartForm.large, valueSpecifier: "%.0f")
                
                BarChartView(data: ChartData(points: speedupListVM.healTotals), title: "Heal", legend: "total in minutes", style: Styles.barChartMidnightGreenDark, form: ChartForm.large, valueSpecifier: "%.0f")
                
                BarChartView(data: ChartData(points: speedupListVM.universalTotals), title: "Universal", legend: "total in minutes", style: Styles.barChartMidnightGreenDark, form: ChartForm.large, valueSpecifier: "%.0f")
            }
        }
    }
}
