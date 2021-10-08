//
//  HabitualViewModel.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/10/08.
//

import Foundation

struct HabitualViewModel {
    
    private let habitual: Habitual
    
    var title: String { return habitual.title }
    
    var selectedTime: String { return habitual.selectedTime }
    
    init(habitual: Habitual) {
        self.habitual = habitual
    }
}
