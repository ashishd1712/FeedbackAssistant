//
//  IssueViewMenu.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 01/08/23.
//

import SwiftUI

struct IssueViewMenu: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Menu{
            //show selected tags
            ForEach(issue.issueTag){tag in
                Button{
                    issue.removeFromTags(tag)
                }label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }
            
            //show unselected tags
            let otherTags = dataController.missingTags(from: issue)
            if otherTags.isEmpty == false{
                Divider()
                
                Section("Add Tags"){
                    ForEach(otherTags){tag in
                        Button(tag.tagName){
                            issue.addToTags(tag)
                        }
                        
                    }
                }//:SECTION
            }
        }label: {
            Text(issue.issueTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
                .animation(nil, value: issue.issueTagsList)
        }//:MENU
    }
}

struct IssueViewMenu_Previews: PreviewProvider {
    static var previews: some View {
        IssueViewMenu(issue: .exampleIssue)
            .environmentObject(DataController(inMemory: true))
    }
}
