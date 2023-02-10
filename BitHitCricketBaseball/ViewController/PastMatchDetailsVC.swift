//
//  PastMatchDetailsVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit

class PastMatchDetailsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblMatchDateTime: UILabel!
    @IBOutlet weak var lblMatchTime: UILabel!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    
    @IBOutlet weak var lblStadium: UILabel!
    @IBOutlet weak var lblCapacity: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblHomeManager: UILabel!
    
    //MARK: - Global Variables
    var objMatchData = [String:Any]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let objMatch = objMatchData as? [String:Any] {
            if let homeTeam = objMatch["home"] as? [String:Any] {
                self.lblTeam1.text = homeTeam["name"] as? String ?? ""
                self.imgTeam1.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/cricket/" + "\(homeTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
            }
            if let awayTeam = objMatch["away"] as? [String:Any] {
                self.lblTeam2.text = awayTeam["name"] as? String ?? ""
                self.imgTeam2.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/cricket/" + "\(awayTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team2_placeholder"))
            }
            
            if let startTimestamp = Int(objMatch["time"] as? String ?? "") {
                let formaor = DateFormatter()
                formaor.dateFormat = "dd.MM.yyyy"
                self.lblMatchDateTime.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
                formaor.dateFormat = "hh:mm"
                self.lblMatchTime.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
            }
            self.api_getStats(gameId: objMatch["game_id"] as? String ?? "")
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackAction(_ sender: Any) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
    @IBAction func btnDerbyAction(_ sender: Any) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idDerbyVC) as! DerbyVC
        vc.objMatch = objMatchData
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    @IBAction func btnHistoryAction(_ sender: Any) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idMatchHistoryVC) as! MatchHistoryVC
        vc.objMatch = objMatchData
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
}

//MARK: - API Calling
extension PastMatchDetailsVC {
    func api_getStats(gameId:String) {
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=eventdata&game_id=\(gameId)",
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getStats(gameId: gameId)
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                if let result = dicData["results"] as? [[String:Any]] , !result.isEmpty {
                    if let extra = result[0]["extra"] as? [String:Any] {
                        self.lblStadium.text = " - "
                        self.lblCapacity.text = " - "
                        self.lblCity.text = " - "
                        self.lblCountry.text = " - "
                        self.lblHomeManager.text = " - "
                        if let homemanage = extra["home_manager"] as? [String:Any] {
                            self.lblHomeManager.text = homemanage["name"] as? String ?? ""
                        }

                        if let stadium = extra["stadium_data"] as? [String:Any] {
                            self.lblStadium.text = stadium["name"] as? String ?? ""
                            self.lblCapacity.text = stadium["capacity"] as? String ?? ""
                            self.lblCity.text = stadium["city"] as? String ?? ""
                            self.lblCountry.text = stadium["country"] as? String ?? ""
                        }
                    }
                }
            }
        }
    }
}
