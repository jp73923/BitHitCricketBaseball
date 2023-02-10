//
//  TabVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit

class TabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.invalidateIntrinsicContentSize()
        tabBar.superview?.setNeedsLayout()
        tabBar.superview?.layoutSubviews()
    }

}

//MARK: - UITabbar Methods
extension TabVC {
    func setTabBarItems() {
        UITabBar.appearance().selectionIndicatorImage = UIImage.init(named: "ic_selected_tab" )
        UITabBarItem.appearance().setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for:.selected)
    }
    
    func setupScreen() {
        self.setTabBarItems()
        navigationController?.isNavigationBarHidden = true
        self.selectedIndex = 0
        self.delegate = self
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.8535686731, green: 0.5053369403, blue: 0.09782124311, alpha: 1)
    }
}

//MARK: - UITabBarController Delegate Methods
extension TabVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

@available(iOS 13.0, *)
class TabBar: UITabBar {
    private var cachedSafeAreaInsets = UIEdgeInsets.zero

    let keyWindow = UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .compactMap { $0 as? UIWindowScene }
        .first?.windows
        .filter { $0.isKeyWindow }
        .first
    
    override var safeAreaInsets: UIEdgeInsets {
        if let insets = keyWindow?.safeAreaInsets {
            if insets.bottom < bounds.height {
                cachedSafeAreaInsets = insets
            }
        }
        return cachedSafeAreaInsets
    }
}

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x:0,y:0,width:size.width,height:size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
