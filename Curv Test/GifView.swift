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
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GifView>) -> AVPlayerViewController {
        
        let playerViewController = AVPlayerViewController()
        
        let player = AVPlayer(url: self.gifURL)
        playerViewController.player = player
        playerViewController.player?.play()
        playerViewController.showsPlaybackControls = true
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
                    player.seek(to: CMTime.zero)
                    player.play()
        }
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<GifView>) {
    }
    
}
