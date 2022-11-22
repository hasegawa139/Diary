//
//  DiaryFormView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryFormView: View {
    @Binding var decoration: DiaryItem.Decoration
    @Binding var date: Date
    @Binding var text1: String
    @Binding var text2: String
    @State var totalChars1: Int
    @State var totalChars2: Int
    
    var body: some View {
        VStack {
            HStack {
                Picker("アイコン", selection: $decoration) {
                    ForEach(DiaryItem.Decoration.allCases, id: \.self) { decoration in
                        Image(systemName: decoration.icon)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                DatePicker(selection: $date) {
                    Text("")
                }
                .padding()
                .environment(\.locale, Locale(identifier: "ja_JP"))
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text1)
                    .border(.selection, width: 1)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                if text1.isEmpty {
                    Text("テキストを入力（第一言語）")
                        .foregroundColor(.gray)
                        .padding(10)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            Text("\(totalChars1) / 200 ")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .onChange(of: text1) { _ in
                    totalChars1 = text1.count
                }
                .onChange(of: text1) { newValue in
                    if newValue.count > 200 {
                        text1.removeLast(text1.count - 200)
                    }
                }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text2)
                    .border(.selection, width: 1)
                if text2.isEmpty {
                    Text("テキストを入力（第二言語）")
                        .foregroundColor(.gray)
                        .padding(10)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            Text("\(totalChars2) / 200 ")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .onChange(of: text2) { _ in
                    totalChars2 = text2.count
                }
                .onChange(of: text2) { newValue in
                    if newValue.count > 200 {
                        text2.removeLast(text2.count - 200)
                    }
                }
        }
    }
}

struct DiaryFormView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryFormView(decoration: .constant(DiaryItem.Decoration.circle), date: .constant(Date()), text1: .constant(""), text2: .constant(""), totalChars1: 0, totalChars2: 0)
    }
}
