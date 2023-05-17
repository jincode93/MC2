//
//  GalleryDetailView.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI
import UIKit

struct GalleryDetailView: UIViewRepresentable {
    let images: [UIImage]
    @Binding var duration: TimeInterval
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let imageView = uiView.subviews.first as? UIImageView {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3 / 2).scaledBy(x: -1, y: 1)
            imageView.layer.cornerRadius = 10

            imageView.frame = CGRect(x: 0, y: 0, width: uiView.frame.width, height: uiView.frame.height)
            
            imageView.animationImages = images
            imageView.animationDuration = duration
            imageView.startAnimating()
        }
    }
}
