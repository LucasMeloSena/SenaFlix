//
//  TrailerWidget.swift
//  SenaFlix
//
//  Created by Lucas Sena on 22/06/24.
//

import Foundation
import UIKit
import SnapKit
import youtube_ios_player_helper

class TrailerWidget: UIView {
    let videoUrl: String?
    
    init(videoUrl: String?) {
        self.videoUrl = videoUrl
        
        super.init(frame: .zero)
        
        setup()
        loadConstraints()
        applyStyle()
        applyContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var youtubePlayer: YTPlayerView = {
        let youtubePlayer = YTPlayerView()
        youtubePlayer.layer.masksToBounds = true
        youtubePlayer.layer.cornerRadius = 15
        return youtubePlayer
    }()
    
    //MARK: - ACTIONS
    private func setup() {
        self.addSubview(youtubePlayer)
    }
    
    private func loadConstraints() {
        youtubePlayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(300)
        }
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
    
    private func applyStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

