//
//  Date+Extension.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import Foundation

extension Date {
    func formatDateForDiary() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func formatDateForYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    
    func formatDateForMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
}
