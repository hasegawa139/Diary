//
//  DiaryItem.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var decoration: Decoration
    var date: Date
    var text1: String
    var text2: String
    
    enum Decoration: Int, CaseIterable, Codable {
        case circle = 1
        case star = 2
        case heart = 3
        
        var icon: String {
            switch self {
            case .circle:
                return "circle.fill"
            case .star:
                return "star.fill"
            case .heart:
                return "heart.fill"
            }
        }
    }
}
