//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 07/07/23.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            NavigationSplitView(sidebar: {
                SideBarView()
            }, content: {
                ContentView()
            }, detail: {
                DetailView()
            })
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
