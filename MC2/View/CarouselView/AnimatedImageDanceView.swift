//
//  AnimatedImageDanceView.swift
//  MC2
//
//  Created by Jin on 2023/05/15.
//

import SwiftUI
import UIKit

struct AnimatedImageDanceView: UIViewRepresentable {
    let images: [UIImage]
    let duration: TimeInterval
    // let isAnimating: Bool
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 시뮬레이터의 가로 폭과 동일한 크기로 설정
        let screenWidth = UIScreen.main.bounds.width
        view.frame.size = CGSize(width: screenWidth, height: screenWidth)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let imageView = uiView.subviews.first as? UIImageView {
            imageView.animationImages = images
            imageView.animationDuration = duration
            imageView.startAnimating()
            
//            if !isAnimating {
//                imageView.stopAnimating()
//            }
        }
    }
}
