//
//  MainViewCell.swift
//  MC2
//
//  Created by toughie on 2023/05/11.
//

import SwiftUI

struct MainViewCell: View {
    var music: Music
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: music.albumArt)
                .resizable()
                .frame(width: 80, height: 80)
                .scaledToFit()
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(music.musicTitle)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Text(music.singer)
                    .foregroundColor(.stringColor)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.stringColor)
                .padding(.trailing, 20)
        }
        .background(Color.mainColor)
        .cornerRadius(5)
    }
}
