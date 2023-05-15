//
//  ProgressMusic.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import Foundation

struct UserMusic: Identifiable {
    var id: String
    var musicTitle: String
    var singer: String
    var danceLevel: String
    var userDanceParts: [UserDancePart]
}
