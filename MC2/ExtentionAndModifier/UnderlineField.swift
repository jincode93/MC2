//
//  UnderlineTextField.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct UnderlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .padding(.vertical, 14)
                .padding(.leading, 10)
                .overlay(Rectangle().fill(Color.stringColor).frame(height: 1).padding(.top, 36))
                .foregroundColor(.white)
                .padding(.horizontal, 4)
        }
    }
}
