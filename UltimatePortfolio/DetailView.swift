//
//  DetailView.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 11/07/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController
    var body: some View {
        VStack{
            if let issue = dataController.selectedIssue{
                IssueView(issue: issue)
            }else{
                NoIssueView()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
