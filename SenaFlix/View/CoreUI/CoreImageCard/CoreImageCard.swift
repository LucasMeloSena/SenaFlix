//
//  CoreImageCard.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CoreImageCard: UIImageView {
    let id: Int
    let url: URL
    @objc var imageMovieTapped: ((UITapGestureRecognizer) -> Void)?
    
    init(frame: CGRect = .zero, id: Int, url: URL, imageMovieTapped: ((UITapGestureRecognizer) -> Void)?) {
        self.id = id
        self.url = url
        self.imageMovieTapped = imageMovieTapped
        
        super.init(frame: frame)
        
        self.applyStyle()
        self.applyContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func applyStyle() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
    }
    
    private func applyContent() {
        self.kf.setImage(with: url)
        self.tag = id
        if imageMovieTapped != nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.addGestureRecognizer(tapGesture)
            self.isUserInteractionEnabled = true
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        imageMovieTapped!(sender)
    }
}
