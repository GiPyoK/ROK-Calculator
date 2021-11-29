//
//  SplashScreen.swift
//  ROK-Calculator
//
//  Created by Gi Pyo Kim on 7/4/21.
//  Copyright © 2021 gipgip. All rights reserved.
//

import SwiftUI

struct SplashScreen<Content: View, Title: View, Logo: View>: View {
    
    var content: Content
    var titleView: Title
    var logoView: Logo
    
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder titleView: @escaping () -> Title, @ViewBuilder logoView: @escaping () -> Logo) {
        
        self.content = content()
        self.titleView = titleView()
        self.logoView = logoView()
    }
    
    // Animation Properties
    @State var textAnimation = false
    @State var imageAnimation = false
    @State var endAnimation = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Color("DeepOrange")
                    .edgesIgnoringSafeArea(.all)
                
                logoView
                
                titleView
                    .offset(y: 120)
            }
        }
        .onAppear {
            // Start animation with some delay
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
