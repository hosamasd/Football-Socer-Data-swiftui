//
//  TeamHeaderView.swift
//  Socer swiftui
//
//  Created by hosam on 2/22/21.
//

import SwiftUI

struct TeamHeaderView: View {
    let team: Team
    @StateObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if team.crestUrl != nil {
                    
                    
                    WebView(urlString: team.crestUrl!)
                        .frame(width:90,height: 90)
                }
                else {
                    RoundedRectangle(cornerRadius: 120)
                        .foregroundColor(.gray)
                        .frame(width: 240, height: 240)
                }
                Text("\(team.name) (\(team.tla ?? team.name))")
                    .font(.headline)
                Text(team.area?.name ?? "")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.vertical)
        .onAppear {
            guard let crest = self.team.crestUrl else {
                return
            }
            self.imageLoader.downloadImage(url: crest, teamId: self.team.id)
        }
    }
}
