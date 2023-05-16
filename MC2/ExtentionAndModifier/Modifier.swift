//
//  Modifier.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct LongButtonModifier: ViewModifier {
    var backgroundColor: Color = .mainColor
    var foregroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(foregroundColor)
            .bold()
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

struct SortButtonModifier: ViewModifier {
    var backgroundColor: Color = .mainColor
    var foregroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(foregroundColor)
            .bold()
            .frame(width: UIScreen.main.bounds.width * 0.46, height: UIScreen.main.bounds.height * 0.06)
            .background(backgroundColor)
            .cornerRadius(15)
    }
}

struct ScriptModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
            .bold()
            .multilineTextAlignment(.center)
    }
}

struct PointScriptModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.pointColor)
            .bold()
            .multilineTextAlignment(.center)
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
            .bold()
    }
}

struct NavItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.stringColor)
    }
}

struct NavigationBarModifier: ViewModifier {
    let backgroundColor: UIColor
    
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct NavigationTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func navigationTitleStyle() -> some View {
        self.modifier(NavigationTitle())
    }
}

