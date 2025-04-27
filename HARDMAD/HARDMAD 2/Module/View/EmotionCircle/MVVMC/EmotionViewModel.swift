//
//  EmotionViewModel.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//


import UIKit

class EmotionViewModel {
    
    private var colors: [ColorDesc] = [
        ColorDesc(clr: .lred, desc: "Ярость"),
        ColorDesc(clr: .lred, desc: "Напряжение"),
        ColorDesc(clr: .lorange, desc: "Возбуждение"),
        ColorDesc(clr: .lorange, desc: "Восторг"),
        ColorDesc(clr: .lred, desc: "Зависть"),
        ColorDesc(clr: .lred, desc: "Беспокойство"),
        ColorDesc(clr: .lorange, desc: "Счастье"),
        ColorDesc(clr: .lorange, desc: "Уверенность"),
        ColorDesc(clr: .lblue, desc: "Выгорание"),
        ColorDesc(clr: .lblue, desc: "Усталость"),
        ColorDesc(clr: .lgreen, desc: "Спокойствие"),
        ColorDesc(clr: .lgreen, desc: "Удовлетворение"),
        ColorDesc(clr: .lblue, desc: "Депрессия"),
        ColorDesc(clr: .lblue, desc: "Апатия"),
        ColorDesc(clr: .lgreen, desc: "Благодарность"),
        ColorDesc(clr: .lgreen, desc: "Защищенность")
    ]
    
    var selectedEmotion: ColorDesc? 
    
    func getColors() -> [ColorDesc] {
        return colors
    }
    
    func updateSelectedEmotion(row: Int, col: Int) {
        let index = row * 4 + col
        if index < colors.count {
            selectedEmotion = colors[index]
        }
    }
}
