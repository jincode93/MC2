//
//  MainViewCell.swift
//  MC2
//
//  Created by toughie on 2023/05/11.
//

import SwiftUI

struct MainViewCell: View {
    var music: Music
    let cellColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: music.albumArt)
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFit()
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(music.musicTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Text(music.singer)
                    .foregroundColor(.stringColor)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.stringColor)
                .padding(.trailing, 20)
        }
        .background(Color(cellColor))
        .cornerRadius(5)
    }
}
