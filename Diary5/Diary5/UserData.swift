//
//  UserData.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import Foundation

class UserData: ObservableObject {
    @Published var diaries: [DiaryItem]
    @Published var changedDiary: DiaryItem?
    
    init(diaries: [DiaryItem]) {
        self.diaries = diaries
    }
    
    // プレビュー用
    static func test() -> UserData {
        let diariesForPreviews = [
            DiaryItem(decoration: .circle, date: Date(), text1: "テスト1", text2: "test1"),
            DiaryItem(decoration: .star, date: Date().advanced(by: 60 * 60), text1: "テスト2", text2: "test2"),
            DiaryItem(decoration: .heart, date: Date().advanced(by: 60 * 60 * 24 * 2), text1: "テスト3", text2: "test3"),
            DiaryItem(decoration: .circle, date: Date().advanced(by: 60 * 60 * 24 * -365), text1: "テスト4", text2: "test4"),
            DiaryItem(decoration: .star, date: Date().advanced(by: 60 * 60 * 24 * (365 + 30)), text1: "テスト5", text2: "test5"),
            DiaryItem(decoration: .heart, date: Date().advanced(by: 60 * 60 * 24 * (365 + 90)), text1: "テスト6", text2: "test6")
        ]

        return UserData(diaries: diariesForPreviews)
    }
    
    
//    func saveDiaries() {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let archive = "data.archive"
//        let archiveUrl = documentDirectory.appendingPathComponent(archive)
//
//        do {
//            let jsonData = try JSONEncoder().encode(diaries)
//            try jsonData.write(to: archiveUrl)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
//    func loadDiaries() {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let archive = "data.archive"
//        let archiveUrl = documentDirectory.appendingPathComponent(archive)
//
//        do {
//            let jsonData = try Data(contentsOf: archiveUrl)
//            diaries = try JSONDecoder().decode([DiaryItem].self, from: jsonData)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        if diaries.isEmpty {
//            print("No saved diaries.")
//        } else {
//            print(diaries)
//        }
//    }
}
