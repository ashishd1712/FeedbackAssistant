//
//  IssueView.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 25/07/23.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Form{
            Section{
                VStack(alignment: .leading) {
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter the Issue title here"))
                        .font(.title)
                    
                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")
                        .foregroundColor(.secondary)
                    
                    Text("**Status:** \(issue.issueStatus)")
                        .foregroundColor(.secondary)
                }//:VSTACK
                
                Picker("Priority", selection: $issue.priority){
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }//:PICKER
                
                IssueViewMenu(issue: issue)
            }//:SECTION
            
            Section{
                VStack(alignment: .leading) {
                    Text("Basic Information")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    TextField("Description", text: $issue.issueContent, prompt: Text("Enter the issue description here"), axis: .vertical)
                }//:VSTACK
            }//:SECTION
        }//:FORM
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit {
            dataController.save()
        }
        .toolbar{
            IssueViewToolbar(issue: issue)
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView(issue: .exampleIssue)
            .environmentObject(DataController(inMemory: true))
    }
}
