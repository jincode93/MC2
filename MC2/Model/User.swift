//
//  User.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import Foundation

struct User: Identifiable {
    var id: String
    var email: String
    var nickName: String
    var recentMusic: String
    var recentPart: Int
    var userMusics: [UserMusic]
}
