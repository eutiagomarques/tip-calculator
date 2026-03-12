//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 11/03/26.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func play()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func play() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error loading audio file")
        }
    }
}
