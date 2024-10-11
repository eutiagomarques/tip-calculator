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
    }

    struct outputPublisher {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    
    func handler(input: inputPublisher) -> outputPublisher {
        
        let result = Result(amountPerPerson: 100, totalBill: 500, totalTip: 20)
        
        return outputPublisher(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
