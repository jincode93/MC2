//
//  Music.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import SwiftUI

struct Music: Identifiable {
    var id: String
    var danceLevel: String
    var musicTitle: String
    var singer: String
    var albumArt: UIImage
    var dancePartArr: [DancePart]
}
