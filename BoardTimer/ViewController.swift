//
//  ViewController.swift
//  BoardTimer
//
//  Created by 파디오 on 13/07/2018.
//  Copyright © 2018 파디오. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {

    @IBOutlet weak var MainTimeLabel: UILabel!
    @IBOutlet weak var SubTimeLabel: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var TimeCountLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var timer = Timer()
    
    var TimeInt:[Int] = [0,0]
    
    var checkTime:Int = 0
    var checkBool:Bool = true
    
    
    let request:GADRequest = GADRequest()
    var interstitial: GADInterstitial!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        self.creatdBannerLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("TimeInt\(TimeInt)")
        
        self.navigationItem.title = "보드게임 타이머"
        
        TimeInt[0] = UserDefaults.standard.integer(forKey: "starttime")
        TimeInt[1] = UserDefaults.standard.integer(forKey: "waittime")
        MainTimeLabel.text = String(TimeInt[0])
        SubTimeLabel.text = String(TimeInt[1])
        print("TimeInt\(TimeInt)")
        
        Slider.value = 0
        Slider.tintColor = UIColor.red
        Slider.maximumValue = Float(TimeInt[0])
        TimeCountLabel.text = String(checkTime)
        
        
    }

    @IBAction func startTapBtn(_ sender: UIButton) {
        if sender.tag == 0{
            StartButton.setTitle("정지", for: .normal)
            ResetButton.setTitle("다음", for: .normal)
            StartButton.tag = 1
            ResetButton.tag = 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
        }else if sender.tag == 1{
            StartButton.setTitle("시작", for: .normal)
            ResetButton.setTitle("리셋", for: .normal)
            StartButton.tag = 0
            ResetButton.tag = 0
            timer.invalidate()
        }
    }
    @IBAction func settingTapBtn(_ sender: Any) {
        StartButton.setTitle("시작", for: .normal)
        ResetButton.setTitle("리셋", for: .normal)
        StartButton.tag = 0
        ResetButton.tag = 0
        checkTime = 0
        checkBool = true
        timer.invalidate()
        TimeCountLabel.text = String(checkTime)
        
    }
    
    @IBAction func resetTapBtn(_ sender: UIButton) {
        if sender.tag == 0{
            checkTime = 0
            Slider.value = 0
             Slider.tintColor = UIColor.red
            Slider.maximumValue = Float(TimeInt[0])
            checkBool = true
            
      
        }else if sender.tag == 1{
            timer.invalidate()
            if checkBool{
                checkTime = 0
                Slider.value = 0
                 Slider.tintColor = UIColor.blue
                Slider.maximumValue = Float(TimeInt[1])
                checkBool = false
                 timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            }else{
                checkTime = 0
                Slider.value = 0
                 Slider.tintColor = UIColor.red
                Slider.maximumValue = Float(TimeInt[0])
                checkBool = true
                 timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            }
           
        }
        TimeCountLabel.text = String(checkTime)
    }
    
    @objc func timerFunc(){
        if checkBool{
            if checkTime == TimeInt[0]{
                
                checkTime = 0
                Slider.value = 0
                Slider.maximumValue = Float(TimeInt[1])
                Slider.tintColor = UIColor.blue
                checkBool = false
                
                
            }else{
                checkTime = checkTime + 1
                Slider.value = Float(checkTime)
            }
        }else{
            if checkTime == TimeInt[1]{
                
                checkTime = 0
                Slider.value = 0
                Slider.maximumValue = Float(TimeInt[0])
                Slider.tintColor = UIColor.red
                checkBool = true
                
            }else{
                checkTime = checkTime + 1
                Slider.value = Float(checkTime)
            }
        }
        TimeCountLabel.text = String(checkTime)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        //var interstitial = GADInterstitial(adUnitID: "ca-app-pub-6173027648650894/1081581417")
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        
        
        interstitial.load(request)
        
        return interstitial
    }
    
    func creatdBannerLoad(){
        self.bannerView.delegate = self
        self.bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.bannerView.rootViewController = self
        self.bannerView.load(request)
    }
}


extension ViewController:GADInterstitialDelegate{
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        }
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}

extension ViewController:GADBannerViewDelegate{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
        
        
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
        print("tap ad click")
        
    }
}
