//
//  IssueViewToolbar.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 01/08/23.
//

import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    var body: some View {
        Menu{
            Button{
                UIPasteboard.general.string = issue.title
            }label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }
            
            Button{
                issue.completed.toggle()
                dataController.save()
            }label: {
                Label(issue.completed ? "Re-open Issue" : "Close Issue", systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            
            
        }label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
}

struct IssueViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        IssueViewToolbar(issue: Issue.exampleIssue)
    }
}
