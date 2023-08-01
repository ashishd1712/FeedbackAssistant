//
//  SideBarViewToolbar.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 01/08/23.
//

import SwiftUI

struct SideBarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @Binding var showingAwards: Bool
    var renameNewTag: () -> Void
    var body: some View {
        Button{
            dataController.newTag()
            renameNewTag()
        }label: {
            Label("Add tag", systemImage: "plus")
        }
        
        Button{
            showingAwards.toggle()
        }label: {
            Label("Show awards", systemImage: "rosette")
        }
        
        #if DEBUG
        Button{
            dataController.deleteAll()
            dataController.createSampleData()
        }label: {
            Label("Add samples", systemImage: "flame")
        }
        #endif
    }
}

struct SideBarViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        SideBarViewToolbar(showingAwards: .constant(true), renameNewTag: {})
    }
}
