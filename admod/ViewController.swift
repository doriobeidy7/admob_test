//
//  ViewController.swift
//  admod
//
//  Created by Dori on 5/27/20.
//  Copyright © 2020 obeidy. All rights reserved.
//

import GoogleMobileAds
import UIKit

class ViewController: UIViewController, GADInterstitialDelegate,  GADRewardedAdDelegate  {
    @IBOutlet weak var counter: UILabel!
    @IBAction func btn_banner(_ sender: Any) {
      
          bannerView.load(GADRequest())
    }
    
    var nbr_counter = 0

    var rewardedAd: GADRewardedAd?
    
    @IBAction func ShowAdsRewards(sender: UIButton) {
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    
    @IBAction func ShowInterstitial(_ sender: AnyObject) {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    /// The interstitial ad.
    var interstitial: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
                bannerView.rootViewController = self
        
        
        rewardedAd = GADRewardedAd(adUnitID: "/6499/example/rewarded-video")
        rewardedAd?.load(GADRequest()) { error in
            if error != nil {
                // Handle ad failed to load case.
                print("error")
            } else {
                print("successfully loaded")
                // Ad successfully loaded.
            }
        }
        
        
        rewardedAd = createAndLoadRewardedAd()
        // In this case, we instantiate the banner with desired ad size.
        //    bannerView.delegate = self
        interstitial = DFPInterstitial(adUnitID: "/6499/example/interstitial")
        let request = DFPRequest()
        interstitial.load(request)
        
        
        
  
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
        
        
    }
    func createAndLoadInterstitial() -> DFPInterstitial {
        let interstitial = DFPInterstitial(adUnitID: "/6499/example/interstitial")
        interstitial.delegate = self
        interstitial.load(DFPRequest())
        return interstitial
    }
    
    private func interstitialDidDismissScreen(_ ad: DFPInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadRewardedAd() -> GADRewardedAd? {
        rewardedAd = GADRewardedAd(adUnitID: "/6499/example/rewarded-video")
        rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                print("Loading failed: \(error)")
            } else {
                print("Loading Succeeded")
            }
        }
        return rewardedAd
    }
    
     func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.rewardedAd = createAndLoadRewardedAd()
    }
    
}



extension ViewController {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: DFPInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: DFPInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: DFPInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: DFPInterstitial) {
        print("interstitialWillDismissScreen")
        
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        interstitial = createAndLoadInterstitial()
        
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: DFPInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        nbr_counter = nbr_counter + 1
        counter.text = nbr_counter.description
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
  
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}
