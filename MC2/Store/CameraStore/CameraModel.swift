//
//  CameraModel.swift
//  MC2
//
//  Created by Jin on 2023/05/08.
//

import SwiftUI
import Combine
import AVFoundation

final class CameraModel: ObservableObject {
    private let service = CameraService()
    
    @Published var photo: Photo!
    @Published var showAlertError = false
    @Published var isFlashOn = false
    @Published var willCapturePhoto = false
    @Published var counter = "5"
    @Published var textOpacity = 0.0
    @Published var images: [UIImage] = []
    @Published var progressCheck: Int = 0
    @Published var guideViewToggle: Bool = true
    @Published var pageControl: Bool = true
    
    var alertError: AlertError!
    var session: AVCaptureSession
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo = pic
        }
        .store(in: &self.subscriptions)
        
        service.$shouldShowAlertView.sink { [weak self] (val) in
            self?.alertError = self?.service.alertError
            self?.showAlertError = val
        }
        .store(in: &self.subscriptions)
        
        service.$flashMode.sink { [weak self] (mode) in
            self?.isFlashOn = mode == .on
        }
        .store(in: &self.subscriptions)
        
        service.$willCapturePhoto.sink { [weak self] (val) in
            self?.willCapturePhoto = val
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        service.checkForPermissions()
        service.configure()
    }
    
    func capturePhoto() {
        service.capturePhoto()
    }
    
    func textChanger() {
        self.counter = "5"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.counter = "4"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.counter = "3"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.counter = "2"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.counter = "1"
        }
    }
    
    func startPhotoCapture(timer: Double) {
        self.textChanger()
        self.textOpacity = 1.0
        
        for i in 1...8 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (timer * Double(i))) {
                self.service.capturePhoto()
                print("@Log capturePhoto")
                self.progressCheck += 1
                if i <= 7 {
                    self.textChanger()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (timer * 8.0) + 4.0) {
            self.images = self.service.images
            print("@Log images push")
        }
    }
}
