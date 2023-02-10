//
//  CricketVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit
class cellMatch : UITableViewCell {
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
class cellHeaderMatch : UITableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
}
class CricketVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnTab: UIButton!
    @IBOutlet weak var tblMatches: UITableView!
    
    //MARK: - Global Variables
    var arrMatchId = ["26430","12526","22762","31969","149","32179","32226","28929","30044","32244","15792" ,"31754","32181"]
    var arrTournamentNames = ["Big Bash","One Day Match","Bangladesh Premier League","Nepal T20","Sheffield Shield","SA20","International League T20","Sharjah CBFS T10 League","Emirates D20","1st ODI","3rd ODI" ,"ODI","T10"]
    var arrBigBash = [[String:Any]]()
    var arrOneDayMatch = [[String:Any]]()
    var arrBangladesh = [[String:Any]]()
    var arrNepal = [[String:Any]]()
    var arrSheffield = [[String:Any]]()
    var arrSA20 = [[String:Any]]()
    var arrInternational = [[String:Any]]()
    var arrSharjah = [[String:Any]]()
    var arrEmirates = [[String:Any]]()
    var arr1st = [[String:Any]]()
    var arr3rd = [[String:Any]]()
    var arrODI = [[String:Any]]()
    var arrT10 = [[String:Any]]()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearAllArr()
        self.callPastAPI()
    }
    
    //MARK: - Custom Functions
    func callPastAPI() {
        self.api_getPastMatches(id: "26430")
        self.api_getPastMatches(id: "12526")
        self.api_getPastMatches(id: "22762")
        self.api_getPastMatches(id: "31969")
        self.api_getPastMatches(id: "149")
        self.api_getPastMatches(id: "32179")
        self.api_getPastMatches(id: "32226")
        self.api_getPastMatches(id: "28929")
        self.api_getPastMatches(id: "30044")
        self.api_getPastMatches(id: "32244")
        self.api_getPastMatches(id: "15792")
        self.api_getPastMatches(id: "31754")
        self.api_getPastMatches(id: "32181")
    }
    func callUpcomingAPI() {
        self.api_getUpcomingMatches(id: "26430")
        self.api_getUpcomingMatches(id: "12526")
        self.api_getUpcomingMatches(id: "22762")
        self.api_getUpcomingMatches(id: "31969")
        self.api_getUpcomingMatches(id: "149")
        self.api_getUpcomingMatches(id: "32179")
        self.api_getUpcomingMatches(id: "32226")
        self.api_getUpcomingMatches(id: "28929")
        self.api_getUpcomingMatches(id: "30044")
        self.api_getUpcomingMatches(id: "32244")
        self.api_getUpcomingMatches(id: "15792")
        self.api_getUpcomingMatches(id: "31754")
        self.api_getUpcomingMatches(id: "32181")
    }
    func clearAllArr() {
        arrBigBash.removeAll()
        arrOneDayMatch.removeAll()
        arrBangladesh.removeAll()
        arrNepal.removeAll()
        arrSheffield.removeAll()
        arrSA20.removeAll()
        arrInternational.removeAll()
        arrSharjah.removeAll()
        arrEmirates.removeAll()
        arr1st.removeAll()
        arr3rd.removeAll()
        arrODI.removeAll()
        arrT10.removeAll()
    }
    
    //MARK: - IBActions
    @IBAction func btnSelectedCompletedAction(_ sender: Any) {
        self.btnTab.isSelected = false
        self.clearAllArr()
        self.callPastAPI()
        self.tblMatches.reloadData()
    }
    @IBAction func btnSelectedSoonAction(_ sender: Any) {
        self.btnTab.isSelected = true
        self.clearAllArr()
        self.callUpcomingAPI()
        self.tblMatches.reloadData()
    }
    @IBAction func btnCalendarAction(_ sender: UIButton) {
        let section = Int(sender.accessibilityIdentifier ?? "0") ?? 0
        var objMatchData = [String:Any]()
        switch arrTournamentNames[section] {
        case "Big Bash":
            if arrBigBash.count > 0{
                if let dict = arrBigBash[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "One Day Match":
            if arrOneDayMatch.count > 0 {
                if let dict = arrOneDayMatch[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Bangladesh Premier League":
            if arrBangladesh.count > 0 {
                if let dict = arrBangladesh[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nepal T20":
            if arrNepal.count > 0 {
                if let dict = arrNepal[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sheffield Shield":
            if arrSheffield.count > 0 {
                if let dict = arrSheffield[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "SA20":
            if arrSA20.count > 0 {
                if let dict = arrSA20[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "International League T20":
            if arrInternational.count > 0 {
                if let dict = arrInternational[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sharjah CBFS T10 League":
            if arrSharjah.count > 0 {
                if let dict = arrSharjah[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Emirates D20":
            if arrEmirates.count > 0 {
                if let dict = arrEmirates[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "1st ODI":
            if arr1st.count > 0 {
                if let dict = arr1st[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "3rd ODI":
            if arr3rd.count > 0 {
                if let dict = arr3rd[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "ODI":
            if arrODI.count > 0 {
                if let dict = arrODI[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "T10":
            if arrT10.count > 0 {
                if let dict = arrT10[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        default:
            break
        }
        
        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? NSMutableArray, arr.count > 0 { } else {
            var arr = NSMutableArray()
            arr.add(objMatchData)
            UserDefaultManager.setCustomArrayToUserDefaults(array: arr, key: UD_SoonFavourite)
            self.tblMatches.reloadData()
        }
        
        let userDefaults = UserDefaults.standard
        if let arr = userDefaults.value(forKey: self.btnTab.isSelected ? UD_SoonIdFavourite : UD_IdFavourite) as? [String]{
            var array = [String]()
            array = arr
            if let gameId = objMatchData["game_id"] as? String {
                if array.contains(gameId) {
                    if let index = array.index(of: gameId) {
                        array.remove(at: index)
                        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key:self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? NSMutableArray, arr.count > 0 {
                            arr.removeObject(at: index)
                            UserDefaultManager.setCustomArrayToUserDefaults(array: arr, key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite)
                        }
                    }
                } else {
                    array.append(gameId)
                    if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? NSMutableArray, arr.count > 0 {
                        arr.add(objMatchData)
                        UserDefaultManager.setCustomArrayToUserDefaults(array: arr, key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite)
                    }
                }
            }
            userDefaults.set(array, forKey: self.btnTab.isSelected ? UD_SoonIdFavourite : UD_IdFavourite)
        } else {
            var array = [String]()
            if let gameId = objMatchData["game_id"] as? String {
                array.append(gameId)
            }
            userDefaults.set(array, forKey: self.btnTab.isSelected ? UD_SoonIdFavourite : UD_IdFavourite)
        }
        self.tblMatches.reloadData()
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
extension CricketVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrTournamentNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch arrTournamentNames[section] {
        case "Big Bash":
            return arrBigBash.count
        case "One Day Match":
            return arrOneDayMatch.count
        case "Bangladesh Premier League":
            return arrBangladesh.count
        case "Nepal T20":
            return arrNepal.count
        case "Sheffield Shield":
            return arrSheffield.count
        case "SA20":
            return arrSA20.count
        case "International League T20":
            return arrInternational.count
        case "Sharjah CBFS T10 League":
            return arrSharjah.count
        case "Emirates D20":
            return arrEmirates.count
        case "1st ODI":
            return arr1st.count
        case "3rd ODI":
            return arr3rd.count
        case "ODI":
            return arrODI.count
        case "T10":
            return arrT10.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblMatches.dequeueReusableCell(withIdentifier: "cellMatch") as! cellMatch
        cell.lbl1Score.isHidden = self.btnTab.isSelected ? true : false
        cell.lbl2Score.isHidden = self.btnTab.isSelected ? true : false
        
        var objMatchData = [String:Any]()
        switch arrTournamentNames[indexPath.section] {
        case "Big Bash":
            if arrBigBash.count > 0{
                if let dict = arrBigBash[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "One Day Match":
            if arrOneDayMatch.count > 0 {
                if let dict = arrOneDayMatch[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Bangladesh Premier League":
            if arrBangladesh.count > 0 {
                if let dict = arrBangladesh[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nepal T20":
            if arrNepal.count > 0 {
                if let dict = arrNepal[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sheffield Shield":
            if arrSheffield.count > 0 {
                if let dict = arrSheffield[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "SA20":
            if arrSA20.count > 0 {
                if let dict = arrSA20[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "International League T20":
            if arrInternational.count > 0 {
                if let dict = arrInternational[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sharjah CBFS T10 League":
            if arrSharjah.count > 0 {
                if let dict = arrSharjah[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Emirates D20":
            if arrEmirates.count > 0 {
                if let dict = arrEmirates[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "1st ODI":
            if arr1st.count > 0 {
                if let dict = arr1st[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "3rd ODI":
            if arr3rd.count > 0 {
                if let dict = arr3rd[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "ODI":
            if arrODI.count > 0 {
                if let dict = arrODI[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "T10":
            if arrT10.count > 0 {
                if let dict = arrT10[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        default:
            break
        }
        
        if let objMatch = objMatchData as? [String:Any] {
            let userDefaults = UserDefaults.standard
            if let arr = userDefaults.value(forKey: self.btnTab.isSelected ? UD_SoonIdFavourite : UD_IdFavourite) as? [String]{
                if arr.contains((objMatch["game_id"] as? String ?? "0")) {
                    cell.btnCalendar.isSelected = true
                } else {
                    cell.btnCalendar.isSelected = false
                }
            } else {
                cell.btnCalendar.isSelected = false
            }
            cell.btnCalendar.tag = indexPath.row
            cell.btnCalendar.accessibilityIdentifier = "\(indexPath.section)"
            cell.btnCalendar.addTarget(self, action: #selector(self.btnCalendarAction(_:)), for: UIControl.Event.touchUpInside)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tblMatches.dequeueReusableCell(withIdentifier: "cellHeaderMatch") as! cellHeaderMatch
        cell.lblHeader.text = arrTournamentNames[section]
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var objMatchData = [String:Any]()
        switch arrTournamentNames[indexPath.section] {
        case "Big Bash":
            if arrBigBash.count > 0{
                if let dict = arrBigBash[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "One Day Match":
            if arrOneDayMatch.count > 0 {
                if let dict = arrOneDayMatch[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Bangladesh Premier League":
            if arrBangladesh.count > 0 {
                if let dict = arrBangladesh[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nepal T20":
            if arrNepal.count > 0 {
                if let dict = arrNepal[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sheffield Shield":
            if arrSheffield.count > 0 {
                if let dict = arrSheffield[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "SA20":
            if arrSA20.count > 0 {
                if let dict = arrSA20[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "International League T20":
            if arrInternational.count > 0 {
                if let dict = arrInternational[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Sharjah CBFS T10 League":
            if arrSharjah.count > 0 {
                if let dict = arrSharjah[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Emirates D20":
            if arrEmirates.count > 0 {
                if let dict = arrEmirates[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "1st ODI":
            if arr1st.count > 0 {
                if let dict = arr1st[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "3rd ODI":
            if arr3rd.count > 0 {
                if let dict = arr3rd[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "ODI":
            if arrODI.count > 0 {
                if let dict = arrODI[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "T10":
            if arrT10.count > 0 {
                if let dict = arrT10[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        default:
            break
        }
        
        if self.btnTab.isSelected {
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idPastMatchDetailsVC) as! PastMatchDetailsVC
            vc.objMatchData = objMatchData
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        } else {
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idUpcomingMatchDetailsVC) as! UpcomingMatchDetailsVC
            vc.objMatchData = objMatchData
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - API Calling
extension CricketVC {
    func api_getPastMatches(id:String){
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=enddata&sport=cricket&league=" + id,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getPastMatches(id: id)
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                if let arrTable = dicData["games_end"] as? [[String:Any]] {
                    if id == "26430" {
                        self.arrBigBash.append(contentsOf: arrTable)
                    }
                    if id == "12526" {
                        self.arrOneDayMatch.append(contentsOf: arrTable)
                    }
                    if id == "22762" {
                        self.arrBangladesh.append(contentsOf: arrTable)
                    }
                    if id == "31969" {
                        self.arrNepal.append(contentsOf: arrTable)
                    }
                    if id == "149" {
                        self.arrSheffield.append(contentsOf: arrTable)
                    }
                    if id == "32179" {
                        self.arrSA20.append(contentsOf: arrTable)
                    }
                    if id == "32226" {
                        self.arrInternational.append(contentsOf: arrTable)
                    }
                    if id == "28929" {
                        self.arrSharjah.append(contentsOf: arrTable)
                    }
                    if id == "30044" {
                        self.arrEmirates.append(contentsOf: arrTable)
                    }
                    if id == "32244" {
                        self.arr1st.append(contentsOf: arrTable)
                    }
                    if id == "15792" {
                        self.arr3rd.append(contentsOf: arrTable)
                    }
                    if id == "31754" {
                        self.arrODI.append(contentsOf: arrTable)
                    }
                    if id == "32181" {
                        self.arrT10.append(contentsOf: arrTable)
                    }
                    self.tblMatches.reloadData()
                }
            }
        }
    }
    
    func api_getUpcomingMatches(id:String){
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=predata&sport=cricket&league=" + id,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getUpcomingMatches(id: id)
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                if let arrTable = dicData["games_pre"] as? [[String:Any]] {
                    if id == "26430" {
                        self.arrBigBash.append(contentsOf: arrTable)
                    }
                    if id == "12526" {
                        self.arrOneDayMatch.append(contentsOf: arrTable)
                    }
                    if id == "22762" {
                        self.arrBangladesh.append(contentsOf: arrTable)
                    }
                    if id == "31969" {
                        self.arrNepal.append(contentsOf: arrTable)
                    }
                    if id == "149" {
                        self.arrSheffield.append(contentsOf: arrTable)
                    }
                    if id == "32179" {
                        self.arrSA20.append(contentsOf: arrTable)
                    }
                    if id == "32226" {
                        self.arrInternational.append(contentsOf: arrTable)
                    }
                    if id == "28929" {
                        self.arrSharjah.append(contentsOf: arrTable)
                    }
                    if id == "30044" {
                        self.arrEmirates.append(contentsOf: arrTable)
                    }
                    if id == "32244" {
                        self.arr1st.append(contentsOf: arrTable)
                    }
                    if id == "15792" {
                        self.arr3rd.append(contentsOf: arrTable)
                    }
                    if id == "31754" {
                        self.arrODI.append(contentsOf: arrTable)
                    }
                    if id == "32181" {
                        self.arrT10.append(contentsOf: arrTable)
                    }
                    self.tblMatches.reloadData()
                }
            }
        }
    }
}
