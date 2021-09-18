//
//  ContentView.swift
//  SliderGame
//
//  Created by slava on 18.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var target = { Float.random(in: 0...100) }()
    @State var current = { Float.random(in: 0...100) }()
    @State var alertPresented = false
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер ближе к числу: \(lround(Double(target)))")
                .padding()
            CustomSlider(currentValue: $current, alpha: CGFloat( computeScore())/100)
                .padding()
            Button("Проверь меня") {
                alertPresented = true
            }.padding()
            .alert(isPresented: $alertPresented) {
                return Alert(title: Text("Ваш результат"), message: Text("Очки: \(computeScore())"), dismissButton: .cancel())
            }
            Button("Начать заново") {
                target = Float.random(in: 0...100)
            }.padding()
        }
        
    }
    
    private func computeScore() -> Int {
        let currentValue = Double(current)
        let targetValue = Double(target)
        let difference = abs(targetValue - currentValue)
        
        return 100 - Int(difference)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
