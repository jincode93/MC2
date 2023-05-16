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
    @State private var description: [String] = ["추고 싶은 하이라이트 안무를 골라보세요!",
                                                "어려운 안무, 한 동작씩 포즈로 쪼개서 익혀봐요!",
                                                "실루엣에 맞추어 동작을 따라해 보세요!",
                                                "결과물을 합치면 DDOK DDAK Dance 완성!"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Step \(tabSelection)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.pointColor)
                    .padding(.vertical, 10)
                
                VStack() {
                    Text(description[tabSelection - 1])
                }
                .foregroundColor(.white)
                .padding(.bottom, 30)
                
                TabView(selection: $tabSelection) {
                    OnboardingDetailView1()
                        .tag(1)
                    
                    OnboardingDetailView2()
                        .tag(2)
                    
                    OnboardingDetailView3()
                        .tag(3)
                    
                    OnboardingDetailView4()
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle())
                
                if tabSelection != 4 {
                    Text("시작하기")
                        .modifier(LongButtonModifier(backgroundColor: .mainColor, foregroundColor: .stringColor))
                        .padding(.bottom, 10)
                } else {
                    Button {
                        viewRouter.currentPage = "page4"
                    } label: {
                        Text("시작하기")
                            .modifier(LongButtonModifier(backgroundColor: .pointColor, foregroundColor: .black))
                    }
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
