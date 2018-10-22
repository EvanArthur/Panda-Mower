//
//  SoundManager.swift
//  RainCat
//
//  Created by Evan Arthur on 7/5/18.
//  Copyright © 2018 EvanArthur. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager: NSObject, AVAudioPlayerDelegate{
    static let sharedInstance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    var trackPosition = 0
    private(set) var isMuted = false
    
    static let tracks = ["nightSky"]
    
    private override init(){
        trackPosition = Int(arc4random_uniform(UInt32(SoundManager.tracks.count)))
        let defaults = UserDefaults.standard
        isMuted = defaults.bool(forKey: "MuteKey")
    }
    
    public func startPlaying(){
        if !isMuted && (audioPlayer == nil || audioPlayer?.isPlaying == false){
            let soundURL = Bundle.main.url(forResource: SoundManager.tracks[trackPosition], withExtension: "mp3")
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer?.delegate = self
                
                let audioSession = AVAudioSession.sharedInstance()
                do{
                    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                } catch let sessionError{
                        print(sessionError)
                }
                
            } catch {
                print("audio player failed to load")
                startPlaying()
            }
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            trackPosition = (trackPosition + 1) % SoundManager.tracks.count
        } else {
            print("audio player is already Playing!")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        startPlaying()
    }
    
    func toggleMute() -> Bool{
        isMuted = !isMuted

        let defaults = UserDefaults.standard
        defaults.set(isMuted, forKey: "MuteKey")
        defaults.synchronize()

        if isMuted{
            audioPlayer?.stop()
        } else {
            startPlaying()
        }
        return isMuted
    }
}

