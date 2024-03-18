//
//  AdManager.swift
//  AI Storytime
//
//  Created by Log on 8/10/23.
//

import Foundation
import GoogleMobileAds

class AdManager {
    static let shared = AdManager()

    private init() {}

    func loadBannerAd(on viewController: UIViewController) -> GADBannerView {
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
        let bannerView: GADBannerView = GADBannerView(adSize: adSize)
        bannerView.adUnitID = AdUnitIDs.bannerAdID
                bannerView.rootViewController = viewController
                bannerView.load(GADRequest())
                return bannerView
    }
}
