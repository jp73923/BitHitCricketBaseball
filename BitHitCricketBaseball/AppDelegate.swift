//
//  AppDelegate.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appNavigation:UINavigationController?
    var id = "34"
    var seasonId = "42273"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initialVC()
        return true
    }
    
    //MARK: - InitialVC Method
    func initialVC() {
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: loadVC(strStoryboardId: SB_MAIN, strVCId: idTabVC))
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = true
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
    }
}

