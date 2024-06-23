//
//  TrailerWidget.swift
//  SenaFlix
//
//  Created by Lucas Sena on 22/06/24.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class TrailerWidget: UIView {
    let videoUrl: String?
    
    init(videoUrl: String?) {
        self.videoUrl = videoUrl
        
        super.init(frame: .zero)
        
        setup()
        loadConstraints()
        applyContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var youtubePlayer: YTPlayerView = {
        let youtubePlayer = YTPlayerView()
        return youtubePlayer
    }()
    
    //MARK: - ACTIONS
    private func setup() {
        self.addSubview(youtubePlayer)
    }
    
    private func loadConstraints() {
        
    }
    
    private func getYoutubeId(from url: String) -> String {
        return URLComponents(string: url)?.queryItems?.first(where: { $0.name == "v" })?.value ?? ""
    }
    
    private func applyContent() {
        if let video = videoUrl {
            let videoId = getYoutubeId(from: video)
            youtubePlayer.load(withVideoId: videoId)
        } else {
            print("No trailer provided.")
        }
    }
}

