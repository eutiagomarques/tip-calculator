//
//  MainViewModel.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/10/24.
//

import Foundation
import Combine
import CombineCocoa

class MainViewModel {
    
    struct inputPublisher {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoTapPublisher: AnyPublisher<Void, Never>
    }

    struct outputPublisher {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resultCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayer: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayer
    }
    
    
    func handler(input: inputPublisher) -> outputPublisher {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher)
            .map { bill, tip, split in
                let totalTip = self.getTipValue(bill: bill, tip: tip)
                let totalBill = self.getTotalBill(bill: bill, tip: tip)
                let amountPerPerson = totalBill / Double(split)
                return Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: totalTip)
            }.eraseToAnyPublisher()
        
        let resultCalculatorPublisher = input.logoTapPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.play()
        }).flatMap {
            return Just($0)
        }.eraseToAnyPublisher()
                
        return outputPublisher(updateViewPublisher: updateViewPublisher,
                               resultCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTotalBill(bill: Double, tip: Tip) -> Double {
        return bill + getTipValue(bill: bill, tip: tip)
    }
    
    private func getTipValue(bill: Double,tip: Tip) -> Double {
        switch tip {
        case .tenPercent:
            return bill * 0.10
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .custom(let value):
            let tipPercentage = Double(value) / 100
            return bill * tipPercentage
        case .none:
            return 0
        }
    }
}
