//
//  SwiftUIView.swift
//  candy
//
//  Created by 賴冠宏 on 2022/5/14.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var showSecondView = false
    var body: some View {
        
        Button("START") {
            showSecondView = true
        }
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .padding()
        .background(Color.green)
        .cornerRadius(30)
        .foregroundColor(.white)
        .padding(7)
        .overlay(
            RoundedRectangle(cornerRadius:40)
                .stroke(Color.green, lineWidth: 3)
        )
        .fullScreenCover(isPresented: $showSecondView) {
            ContentView()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
