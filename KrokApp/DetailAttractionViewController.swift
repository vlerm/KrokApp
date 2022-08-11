//
//  DetailAttractionViewController.swift
//  KrokApp
//
//  Created by Вадим Лавор on 1.08.22.
//

import UIKit
import AVKit

class DetailAttractionViewController: UIViewController {
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var attractionNameLabel: UILabel!
    @IBOutlet weak var attractionDescriptionLabel: UILabel!
    @IBOutlet weak var dateOfPublicationLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imagesStringUrl = [String]()
    var attractionName = String()
    var attractionDescription = String()
    var dateOfPublication = String()
    var frame = CGRect.zero
    var soundUrl = String()
    var players: AVPlayer!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePageControl.numberOfPages = imagesStringUrl.count
        attractionNameLabel.text = attractionName
        attractionDescriptionLabel.text = attractionDescription
        dateOfPublicationLabel.text = dateOfPublication
        setupImages()
        scrollView.delegate = self
        setupDefaultSettings()
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        play(url: soundUrl)
        playButton.alpha = 0
        stopButton.alpha = 1
        playButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func stopButtonClicked(_ sender: UIButton) {
        players.pause()
        stopButton.alpha = 0
        playButton.alpha = 1
        stopButton.isEnabled = false
        playButton.isEnabled = true
    }
    
    func setupDefaultSettings(){
        playButton.setTitle(String(), for: .normal)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        stopButton.alpha = 0
        playButton.alpha = 1
        stopButton.setTitle(String(), for: .normal)
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopButton.isEnabled = false
    }
    
    func play(url: String) {
        let url = URL(string: soundUrl)
        do {
            let play = try AVPlayer(url: (url ?? URL(string: Utilities.defaultMelody))!)
            self.players = play
            players.volume = 1.0
            players.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupImages() {
        for index in 0..<imagesStringUrl.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            let url = URL(string: imagesStringUrl[index])!
            do {
                let imageData = try Data(contentsOf: url as URL)
                imageView.image = UIImage(data: imageData)!
                self.scrollView.addSubview(imageView)
            } catch {
                print(Utilities.errorDataLoading)
            }
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(imagesStringUrl.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
}

extension DetailAttractionViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        imagePageControl.currentPage = Int(pageNumber)
    }
    
}

