//
//  NoIssueView.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 25/07/23.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundColor(.secondary)
        
        Button("New Issue"){
            
        }
    }
}

struct NoIssueView_Previews: PreviewProvider {
    static var previews: some View {
        NoIssueView()
    }
}
