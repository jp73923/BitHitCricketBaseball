//
//  MyMixVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit
class cellMixMatch : UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var lbl1Score: UILabel!
    @IBOutlet weak var lbl2Score: UILabel!
    @IBOutlet weak var lblMatchDateTime: UILabel!
    @IBOutlet weak var lblMatchTime: UILabel!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var btnCalendar: UIButton!
}
class cellMixHeaderMatch : UITableViewCell {
    
}
class MyMixVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnTab: UIButton!
    @IBOutlet weak var tblMixMatches: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - IBActions
    @IBAction func btnSelectedCompletedAction(_ sender: Any) {
        self.btnTab.isSelected = false
        self.tblMixMatches.reloadData()
    }
    @IBAction func btnSelectedSoonAction(_ sender: Any) {
        self.btnTab.isSelected = true
        self.tblMixMatches.reloadData()
    }
    @IBAction func btnCalendarAction(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        if let arr = userDefaults.value(forKey: UD_IdFavourite) as? [String]{
            var array = [String]()
            array = arr
            if let gameId = arr[sender.tag] as? String {
                if let index = array.index(of: gameId) {
                    array.remove(at: index)
                    if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: UD_Favourite) as? NSMutableArray, arr.count > 0 {
                        arr.removeObject(at: index)
                        UserDefaultManager.setCustomArrayToUserDefaults(array: arr, key: UD_Favourite)
                    }
                }
                userDefaults.set(array, forKey: UD_IdFavourite)
            }
        }
        self.tblMixMatches.reloadData()
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
extension MyMixVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? [[String:Any]], arr.count > 0 {
            var numOfSection: NSInteger = 0
            if arr.count > 0 {
                self.tblMixMatches.backgroundView = nil
                numOfSection = 1
            } else {
                let noDataLabel: UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: self.tblMixMatches.bounds.size.width, height: self.tblMixMatches.bounds.size.height))
                noDataLabel.text = "No mix matches found"
                noDataLabel.textColor = UIColor.white
                noDataLabel.textAlignment = NSTextAlignment.center
                self.tblMixMatches.backgroundView = noDataLabel
            }
            return numOfSection
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: self.tblMixMatches.bounds.size.width, height: self.tblMixMatches.bounds.size.height))
            noDataLabel.text = "No mix matches found"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tblMixMatches.backgroundView = noDataLabel
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? [[String:Any]], arr.count > 0 {
            return arr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblMixMatches.dequeueReusableCell(withIdentifier: "cellMixMatch") as! cellMixMatch
        cell.lbl1Score.isHidden = self.btnTab.isSelected ? true : false
        cell.lbl2Score.isHidden = self.btnTab.isSelected ? true : false
        cell.btnCalendar.tag = indexPath.row
        cell.btnCalendar.addTarget(self, action: #selector(self.btnCalendarAction(_:)), for: UIControl.Event.touchUpInside)
        cell.btnCalendar.isSelected = true
        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? [[String:Any]], arr.count > 0 {
            if let objMatch = arr[indexPath.row] as? [String:Any] {
                if let homeTeam = objMatch["home"] as? [String:Any] {
                    cell.lblTeam1.text = homeTeam["name"] as? String ?? ""
                    cell.imgTeam1.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/cricket/" + "\(homeTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
                }
                if let awayTeam = objMatch["away"] as? [String:Any] {
                    cell.lblTeam2.text = awayTeam["name"] as? String ?? ""
                    cell.imgTeam2.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/cricket/" + "\(awayTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team2_placeholder"))
                }
                cell.lbl1Score.text = objMatch["score"] as? String ?? ""
                cell.lbl2Score.isHidden = true
                
                if let startTimestamp = Int(objMatch["time"] as? String ?? "") {
                    let formaor = DateFormatter()
                    formaor.dateFormat = "dd.MM.yyyy"
                    cell.lblMatchDateTime.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
                    formaor.dateFormat = "hh:mm"
                    cell.lblMatchTime.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
                }
            }
        }
        return cell
    }
}
