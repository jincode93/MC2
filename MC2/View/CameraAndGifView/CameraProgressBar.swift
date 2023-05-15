//
//  CameraProgressBar.swift
//  MC2
//
//  Created by Jin on 2023/05/12.
//

import SwiftUI

struct CameraProgressBar: View {
    @EnvironmentObject var cameraStore: CameraModel
    
    var body: some View {
        HStack {
            ForEach(0...7, id: \.self) { index in
                Rectangle()
                    .fill(cameraStore.progressCheck >= index ? Color.pointColor : Color.white)
                    .frame(height: 10)
                    .tag(index)
                
                if index <= 6 {
                    Spacer()
                }
            }
        }
    }
}

struct CameraProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CameraProgressBar()
    }
}
