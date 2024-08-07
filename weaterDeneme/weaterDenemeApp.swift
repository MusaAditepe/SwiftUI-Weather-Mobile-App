//
//  weaterDenemeApp.swift
//  weaterDeneme
//
//  Created by Musa Adıtepe on 6.08.2024.
//

import SwiftUI

@main
struct weaterDenemeApp: App {
    var body: some Scene {
        
        WindowGroup {
            TabView{
                ContentView().tabItem {
                    HStack{
                        Image(systemName: "thermometer").foregroundColor(.white).accentColor(.gray)
                        Text("İstanbul")
                    }
                }.ignoresSafeArea(edges: [.top])
                PlovdivScreen().tabItem {
                    HStack {
                        Image(systemName: "thermometer")
                            .foregroundColor(.gray)
                        Text("Plovdiv")
                    }
                }.ignoresSafeArea(edges: [.top])
                OtherCityScreen().tabItem {
                    HStack {
                        Image(systemName: "thermometer").foregroundColor(.gray)
                        Text("Other")
                    }
                }.ignoresSafeArea(edges: [.top])
            }.accentColor(.black)
        }
    }
}

