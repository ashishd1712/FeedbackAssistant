//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Ashish Dutt on 28/07/23.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAlertDetails = false
    
    var columns: [GridItem]{
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }
    
    func getAccessibilityLabel(for award: Award) -> LocalizedStringKey {
        dataController.hasEarned(award: award) ? "Unlocked" : "Locked"
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards){award in
                        Button{
                            selectedAward = award
                            showingAlertDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(color(for: award))
                        }
                        .accessibilityLabel(getAccessibilityLabel(for: award))
                    }
                }
            }
            .navigationTitle("Awards")
            .alert(awardTitle, isPresented: $showingAlertDetails){
            }message: {
                Text(selectedAward.description)
            }
        }
    }
    
    var awardTitle: String{
        if dataController.hasEarned(award: selectedAward){
            return "Unlocked: \(selectedAward.name)"
        }else{
            return "Locked"
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(DataController(inMemory: true))
    }
}
