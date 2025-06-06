//
//  Message.swift
//  AIChatApp
//
//  Created by Yassine Lamtalaa on 5/28/25.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    var text: String
    let isUser: Bool
}
