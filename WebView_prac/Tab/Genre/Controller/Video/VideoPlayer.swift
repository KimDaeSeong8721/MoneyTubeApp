//
//  VideoPlayer.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/02.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class VideoPlayer : UIViewController, YTPlayerViewDelegate {
    
    var videoID : String!

    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        playerView.load(withVideoId: videoID, playerVars: ["playsinline": 1])
        self.navigationController?.navigationBar.tintColor = .white
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

}
