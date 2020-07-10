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

class GifView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    init(frame: CGRect, url: URL, previewLength:Double) {
        super.init(frame: frame)
        
        // Create the video player using the URL passed in.
        let player = AVPlayer(url: url)
        player.volume = 0 // Will play audio if you don't set to zero
        player.play() // Set to play once created
        
        // Add the player to our Player Layer
        playerLayer.player = player
        playerLayer.videoGravity = .resize // Resizes content to fill whole video layer.
        playerLayer.backgroundColor = UIColor.black.cgColor
        
        // Loops gif when it is finished playing
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
                    player.seek(to: CMTime.zero)
                    player.play()
        }
        

        layer.addSublayer(playerLayer)
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
}

struct VideoView: UIViewRepresentable {
    
    var videoURL:URL
    var previewLength:Double?
    
    func makeUIView(context: Context) -> UIView {
        return GifView(frame: .zero, url: videoURL, previewLength: previewLength ?? 15)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
