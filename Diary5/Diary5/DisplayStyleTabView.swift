//
//  DisplayStyleTabView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DisplayStyleTabView: View {
	@StateObject var selectedItem = SelectedItem()
	
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("カレンダー", systemImage: "calendar")
                }
				.environmentObject(selectedItem)
            
            DiaryListView()
                .tabItem {
                    Label("日記", systemImage: "text.book.closed")
                }
				.environmentObject(selectedItem)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.9)
        }
    }
}

struct DisplayStyleTabView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayStyleTabView()
            .environmentObject(UserData.test())
    }
}
