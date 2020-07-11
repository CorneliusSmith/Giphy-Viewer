//
//  gifPlayer.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit
import SwiftUI

struct GifView: UIViewControllerRepresentable{
    var gifURL : URL
    var showPlayerControls : Bool
    
    /// Creates the view controller for the player to play gifs
    func makeUIViewController(context: UIViewControllerRepresentableContext<GifView>) -> AVPlayerViewController {
        
        let playerViewController = AVPlayerViewController()
        
        /// Creates an AVPlayer and sets it to autoplay when it's presented
        let player = AVPlayer(url: self.gifURL)
        playerViewController.player = player
        playerViewController.player?.play()
        playerViewController.showsPlaybackControls = self.showPlayerControls
        
        /// When the end of the gif is reached, seek back to the start to loop it
        self.loopGif(player: player)
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<GifView>) {
    }
    
    
    /// A function that made to loop a gif once its played for its entire length
    /// - Parameter player: The AVPlayer that will play the gif meant to be looper
    
    func loopGif(player: AVPlayer){
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
                    player.seek(to: CMTime.zero)
                    player.play()
        }
    }
}

