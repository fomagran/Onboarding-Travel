//
//  HolidayViewController.swift
//  Onboarding Travel
//
//  Created by Fomagran on 2020/12/16.
//

import UIKit
import AVFoundation
import Combine

class HolidayViewController: UIViewController {
    
    //MARK: Propperties
    @IBOutlet weak var dartkView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    private var player:AVPlayer?
    private var playerLayer:AVPlayerLayer?
    private var videoEventSubscribers = [AnyCancellable]()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUpPlayerIfNeeded()
        restartVideo()
        observeVideoEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeVideoEventSubscribers()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    //MARK:Helpers
    private func configure() {
        dartkView.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
    }

    private func setPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func setPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func setUpPlayerIfNeeded() {
        player = setPlayer()
        playerLayer = setPlayerLayer()
        if let layer = self.playerLayer,view.layer.sublayers?.contains(layer) == false {
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    
    private func removePlayer() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    //MARK:Combine Functions
    
    //무한반복 하게 하기
    private func observeVideoEvents() {
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self]_ in
            self?.restartVideo()
        }.store(in: &videoEventSubscribers)
        
        //앱이 인액티브상태가 될때
        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self]_ in
            self?.pauseVideo()
        }.store(in: &videoEventSubscribers)
        //앱이 다시 액티브 상태가 될때
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self]_ in
            self?.playVideo()
        }.store(in: &videoEventSubscribers)
    }
    
    //서브스크라이버 없애기
    private func removeVideoEventSubscribers() {
        videoEventSubscribers.forEach { subscriber in
            subscriber.cancel()
        }
    }
    
    
    //MARK: Acionts
    @IBAction func handleStartButton(_ sender: Any) {
        //MainAppViewController로 이동하기
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainAppViewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
