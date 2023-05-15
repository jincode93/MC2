//
//  MainViewSegment.swift
//  MC2
//
//  Created by toughie on 2023/05/11.
//

import SwiftUI

struct segmentControl: View {
    @Binding var isSelected: DanceLevel
    
    let divider: Double = 5
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                //배경색
                Color.black
                    .frame(height: UIScreen.main.bounds.height / 15)
                
                //배경 밑줄
                VStack(alignment: .center) {
                    VStack {
                        Text("BackLine")
                            .foregroundColor(Color.clear)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 2)
                    }
                    .frame(height: UIScreen.main.bounds.height / 15)
                }
                
                HStack {
                    //ALL
                    VStack(alignment: .center) {
                        Text("ALL")
                            .foregroundColor(isSelected == .ALL ? .pointColor : .gray)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isSelected = .ALL
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pointColor)
                            .opacity(isSelected == .ALL ? 1 : 0)
                            .frame(width: 300 / divider, height: 2)
                    }
                    .frame(height: UIScreen.main.bounds.height / 15)
                    
                    Spacer()
                    
                    //EASY
                    VStack(alignment: .center) {
                        Text("EASY")
                            .foregroundColor(isSelected == .EASY ? .pointColor : .gray)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isSelected = .EASY                                }
                            }
                        
                        Rectangle()
                            .fill(Color.pointColor)
                            .opacity(isSelected == .EASY ? 1 : 0)
                            .frame(width: 380 / divider, height: 2)
                    }
                    
                    Spacer()
                    
                    //Normal
                    VStack(alignment: .center) {
                        Text("NORMAL")
                            .foregroundColor(isSelected == .NORMAL ? .pointColor : .gray)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isSelected = .NORMAL
                                }
                            }
                        Rectangle()
                            .fill(Color.pointColor)
                            .opacity(isSelected == .NORMAL ? 1 : 0)
                            .frame(width: 500 / divider, height: 2)
                        
                    }
                    
                    Spacer()
                    
                    //Hard
                    VStack(alignment: .center) {
                        Text("HARD")
                            .foregroundColor(isSelected == .HARD ? .pointColor : .gray)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isSelected = .HARD
                                }
                            }
                        Rectangle()
                            .fill(Color.pointColor)
                            .opacity(isSelected == .HARD ? 1 : 0)
                            .frame(width: 380 / divider, height: 2)
                    }
                }
            }
        }
        .padding(.bottom, 40)
    }
}
