//
//  AdViewController.swift
//  AI Storytime
//
//  Created by Log on 8/7/23.
//

import Foundation
import GoogleMobileAds
import UIKit

class AdViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Calculate the desired position for the ad banner
            let bannerWidth: CGFloat = bannerView.frame.size.width
            let bannerHeight: CGFloat = bannerView.frame.size.height
            let screenWidth: CGFloat = view.frame.size.width
            let screenHeight: CGFloat = view.frame.size.height
            
            let desiredX: CGFloat = (screenWidth - bannerWidth) / 2 // Center horizontally
            let desiredY: CGFloat = screenHeight - bannerHeight - view.safeAreaInsets.bottom // Above home bar
            bannerView.frame.origin = CGPoint(x: desiredX, y: desiredY)
            view.addSubview(bannerView)
        }
}
