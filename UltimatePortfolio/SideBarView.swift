//
//  SideBarView.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 11/07/23.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    @State private var tagToRename: Tag?
    @State private var renamingTag = false
    @State private var tagName = ""
    
    var tagFilters: [Filter]{
        tags.map { tag in
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }
    }
    
    func delete(_ offsets: IndexSet){
        for offset in offsets{
            let item = tags[offset]
            dataController.delete(item)
        }
    }
    
    func rename(_ filter: Filter){
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }
    
    func completeRename(){
        tagToRename?.name = tagName
        dataController.save()
    }
    
    func renameNewTag(){
        for filter in tagFilters{
            if filter.tag?.tagName == "" {
                rename(filter)
            }
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filter"){
                ForEach(smartFilters) {filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
            
            Section("Tags"){
                ForEach(tagFilters) { filter in
                    NavigationLink(value: filter) { 
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.tag?.tagActiveIssue.count ?? 0)
                            .contextMenu{
                                Button{
                                    rename(filter)
                                } label: {
                                    Label("Rename", systemImage: "pencil")
                                }
                            }
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .toolbar{
            Button{
                dataController.newTag()
                renameNewTag()
            }label: {
                Label("Add tag", systemImage: "plus")
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
        .alert("Rename tag", isPresented: $renamingTag){
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel){ }
            TextField("New tag name", text: $tagName)
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
            .environmentObject(DataController.preview)
    }
}
