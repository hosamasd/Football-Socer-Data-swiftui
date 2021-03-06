//
//  StandingViewModel.swift
//  Socer swiftui
//
//  Created by hosam on 2/22/21.
//

import SwiftUI

class StandingViewModel: ObservableObject {
    
    @Published var table: [TeamStandingTable] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    @Published var notFoundData = false
//    @Published var isLoading = false
    
    var service = FootballDataService.shared
    
    func fetchLatestStanding(competitionId: Int = 2021) {
        error = nil
        isLoading = true
        notFoundData=false
        
        service.fetchLatestStandings(competitionId: competitionId) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let table):
                    self.table = table
                    self.notFoundData=false
                case .failure(let error):
                    self.error = error
                    self.notFoundData=true
                }
            }
        }
    }
}
