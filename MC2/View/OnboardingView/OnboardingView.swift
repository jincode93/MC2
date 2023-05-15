//
//  OnboardingView.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var tabSelection = 1
    
    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                OnboardingDetailView1()
                    .tag(1)
                
                OnboardingDetailView2()
                    .tag(2)
                
                OnboardingDetailView3()
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                if tabSelection != 3 {
                    Button {
                        tabSelection += 1
                    } label: {
                        Text("다음")
                            .modifier(LongButtonModifier())
                    }
                } else {
                    Button {
                        viewRouter.currentPage = "page3"
                    } label: {
                        Text("시작하기")
                            .modifier(LongButtonModifier(backgroundColor: .pointColor, foregroundColor: .black))
                    }
                }
            }
            .padding(.top, 10)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
