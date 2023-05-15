//
//  DancePart.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import SwiftUI

struct DancePart: Identifiable {
    var id: String
    var partIndex: Int
    var partMusic: String
    var dancePauseImage: [UIImage]
    var danceFrameImage: [UIImage]
    var danceVideo: String
}
