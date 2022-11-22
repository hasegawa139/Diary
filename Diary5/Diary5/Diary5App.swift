//
//  Diary5App.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

@main
struct Diary5App: App {
    var body: some Scene {
        WindowGroup {
            DisplayStyleTabView()
                .environmentObject(UserData(diaries: []))
                .environmentObject(SelectedItem())
        }
    }
}
