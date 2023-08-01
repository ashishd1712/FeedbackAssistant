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
    
    @State private var showingAwards = false
    
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
    
    func delete(_ filter: Filter){
        guard let tag = filter.tag else { return }
        dataController.delete(tag)
        dataController.save()
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
    
    func deleteUnnamedTag(){
        for filter in tagFilters{
            if filter.tag?.tagName == ""{
                delete(filter)
            }
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters"){
                ForEach(smartFilters, content: SmartFilterRow.init)
            }
            
            Section("Tags"){
                ForEach(tagFilters) { filter in
                    UserFilterRow(filter: filter, rename: rename, delete: delete)
                }
                .onDelete(perform: delete)
            }
        }
        .toolbar{
            SideBarViewToolbar(showingAwards: $showingAwards, renameNewTag: renameNewTag)
        }
        .alert("Rename tag", isPresented: $renamingTag){
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel){
                deleteUnnamedTag()
            }
            TextField("New tag name", text: $tagName)
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)
        .navigationTitle("Filters")
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
            .environmentObject(DataController.preview)
    }
}
