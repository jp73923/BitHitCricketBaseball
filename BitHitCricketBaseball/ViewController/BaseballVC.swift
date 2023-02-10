//
//  BaseballVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 09/02/23.
//

import UIKit
class cellBaseMatch : UITableViewCell {
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
class cellBaseHeaderMatch : UITableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
}
class BaseballVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnTab: UIButton!
    @IBOutlet weak var tblBaseballMatch: UITableView!
    
    //MARK: - Global Variables
    var arrMatchId = ["2759","2131","347","15340","349","2016","24486","11235","18871","225","17711" ,"1723"]
    var arrTournamentNames = ["Australian Baseball League","Dominican Republic LIDOM","Japan NPB","Japan NPB Reserve League","Korean KBO","Mexico Liga Del Pacifico","Nicaragua LBPN","CPBL","Arizona Fall League","MLB","Triple A Minor League" ,"Venezuela Liga Professional"]
    var arrAustralian = [[String:Any]]()
    var arrDominican = [[String:Any]]()
    var arrJapan = [[String:Any]]()
    var arrNepal = [[String:Any]]()
    var arrJapanNPB = [[String:Any]]()
    var arrKorean = [[String:Any]]()
    var arrMexico = [[String:Any]]()
    var arrNicaragua = [[String:Any]]()
    var arrCPBL = [[String:Any]]()
    var arrArizona = [[String:Any]]()
    var arrMLB = [[String:Any]]()
    var arrTriple = [[String:Any]]()
    var arrVenezuela = [[String:Any]]()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clearAllArr()
        self.callPastAPI()
    }
    
    //MARK: - Custom Functions
    func callPastAPI() {
        self.api_getPastMatches(id: "2759")
        self.api_getPastMatches(id: "2131")
        self.api_getPastMatches(id: "347")
        self.api_getPastMatches(id: "15340")
        self.api_getPastMatches(id: "349")
        self.api_getPastMatches(id: "2016")
        self.api_getPastMatches(id: "24486")
        self.api_getPastMatches(id: "11235")
        self.api_getPastMatches(id: "18871")
        self.api_getPastMatches(id: "225")
        self.api_getPastMatches(id: "17711")
        self.api_getPastMatches(id: "1723")
    }
    func callUpcomingAPI() {
        self.api_getUpcomingMatches(id: "2759")
        self.api_getUpcomingMatches(id: "2131")
        self.api_getUpcomingMatches(id: "347")
        self.api_getUpcomingMatches(id: "15340")
        self.api_getUpcomingMatches(id: "349")
        self.api_getUpcomingMatches(id: "2016")
        self.api_getUpcomingMatches(id: "24486")
        self.api_getUpcomingMatches(id: "11235")
        self.api_getUpcomingMatches(id: "18871")
        self.api_getUpcomingMatches(id: "225")
        self.api_getUpcomingMatches(id: "17711")
        self.api_getUpcomingMatches(id: "1723")
    }
    func clearAllArr() {
        arrAustralian.removeAll()
        arrDominican.removeAll()
        arrJapan.removeAll()
        arrNepal.removeAll()
        arrJapanNPB.removeAll()
        arrKorean.removeAll()
        arrMexico.removeAll()
        arrCPBL.removeAll()
        arrArizona.removeAll()
        arrMLB.removeAll()
        arrTriple.removeAll()
        arrVenezuela.removeAll()
    }
    
    //MARK: - IBActions
    @IBAction func btnSelectedCompletedAction(_ sender: Any) {
        self.btnTab.isSelected = false
        self.clearAllArr()
        self.callPastAPI()
        self.tblBaseballMatch.reloadData()
    }
    @IBAction func btnSelectedSoonAction(_ sender: Any) {
        self.btnTab.isSelected = true
        self.clearAllArr()
        self.callUpcomingAPI()
        self.tblBaseballMatch.reloadData()
    }
    @IBAction func btnCalendarAction(_ sender: UIButton) {
        let section = Int(sender.accessibilityIdentifier ?? "0") ?? 0
        var objMatchData = [String:Any]()
        switch arrTournamentNames[section] {
        case "Australian Baseball League":
            if arrAustralian.count > 0{
                if let dict = arrAustralian[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Dominican Republic LIDOM":
            if arrDominican.count > 0 {
                if let dict = arrDominican[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB":
            if arrJapan.count > 0 {
                if let dict = arrJapan[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB Reserve League":
            if arrJapanNPB.count > 0 {
                if let dict = arrJapanNPB[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Korean KBO":
            if arrKorean.count > 0 {
                if let dict = arrKorean[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Mexico Liga Del Pacifico":
            if arrMexico.count > 0 {
                if let dict = arrMexico[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nicaragua LBPN":
            if arrNicaragua.count > 0 {
                if let dict = arrNicaragua[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "CPBL":
            if arrCPBL.count > 0 {
                if let dict = arrCPBL[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Arizona Fall League":
            if arrArizona.count > 0 {
                if let dict = arrArizona[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "MLB":
            if arrMLB.count > 0 {
                if let dict = arrMLB[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Triple A Minor League":
            if arrTriple.count > 0 {
                if let dict = arrTriple[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Venezuela Liga Professional":
            if arrVenezuela.count > 0 {
                if let dict = arrVenezuela[sender.tag] as? [String:Any] {
                    objMatchData = dict
                }
            }
        default:
            break
        }
        
        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? NSMutableArray, arr.count > 0 { } else {
            var arr = NSMutableArray()
            arr.add(objMatchData)
            UserDefaultManager.setCustomArrayToUserDefaults(array: arr, key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite)
        }
        
        let userDefaults = UserDefaults.standard
        if let arr = userDefaults.value(forKey: UD_IdFavourite) as? [String]{
            var array = [String]()
            array = arr
            if let gameId = objMatchData["game_id"] as? String {
                if array.contains(gameId) {
                    if let index = array.index(of: gameId) {
                        array.remove(at: index)
                        if let arr = UserDefaultManager.getCustomArrayFromUserDefaults(key: self.btnTab.isSelected ? UD_SoonFavourite : UD_Favourite) as? NSMutableArray, arr.count > 0 {
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
        self.tblBaseballMatch.reloadData()
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
extension BaseballVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrTournamentNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch arrTournamentNames[section] {
        case "Australian Baseball League":
            return arrAustralian.count
        case "Dominican Republic LIDOM":
            return arrDominican.count
        case "Japan NPB":
            return arrJapan.count
        case "Japan NPB Reserve League":
            return arrJapanNPB.count
        case "Korean KBO":
            return arrKorean.count
        case "Mexico Liga Del Pacifico":
            return arrMexico.count
        case "Nicaragua LBPN":
            return arrNicaragua.count
        case "CPBL":
            return arrCPBL.count
        case "Arizona Fall League":
            return arrArizona.count
        case "MLB":
            return arrMLB.count
        case "Triple A Minor League":
            return arrTriple.count
        case "Venezuela Liga Professional":
            return arrVenezuela.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblBaseballMatch.dequeueReusableCell(withIdentifier: "cellBaseMatch") as! cellBaseMatch
        cell.lbl1Score.isHidden = self.btnTab.isSelected ? true : false
        cell.lbl2Score.isHidden = self.btnTab.isSelected ? true : false
        var objMatchData = [String:Any]()
        switch arrTournamentNames[indexPath.section] {
        case "Australian Baseball League":
            if arrAustralian.count > 0{
                if let dict = arrAustralian[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Dominican Republic LIDOM":
            if arrDominican.count > 0 {
                if let dict = arrDominican[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB":
            if arrJapan.count > 0 {
                if let dict = arrJapan[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB Reserve League":
            if arrJapanNPB.count > 0 {
                if let dict = arrJapanNPB[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Korean KBO":
            if arrKorean.count > 0 {
                if let dict = arrKorean[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Mexico Liga Del Pacifico":
            if arrMexico.count > 0 {
                if let dict = arrMexico[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nicaragua LBPN":
            if arrNicaragua.count > 0 {
                if let dict = arrNicaragua[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "CPBL":
            if arrCPBL.count > 0 {
                if let dict = arrCPBL[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Arizona Fall League":
            if arrArizona.count > 0 {
                if let dict = arrArizona[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "MLB":
            if arrMLB.count > 0 {
                if let dict = arrMLB[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Triple A Minor League":
            if arrTriple.count > 0 {
                if let dict = arrTriple[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Venezuela Liga Professional":
            if arrVenezuela.count > 0 {
                if let dict = arrVenezuela[indexPath.row] as? [String:Any] {
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
                cell.imgTeam1.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/baseball/" + "\(homeTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
            }
            if let awayTeam = objMatch["away"] as? [String:Any] {
                cell.lblTeam2.text = awayTeam["name"] as? String ?? ""
                cell.imgTeam2.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/baseball/" + "\(awayTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team2_placeholder"))
            }
            if (objMatch["score"] as? String ?? "") != "" {
                cell.lbl1Score.text = (objMatch["score"] as? String ?? "").components(separatedBy: ":")[0]
                cell.lbl2Score.text = (objMatch["score"] as? String ?? "").components(separatedBy: ":")[1]
            }

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var objMatchData = [String:Any]()
        switch arrTournamentNames[indexPath.section] {
        case "Australian Baseball League":
            if arrAustralian.count > 0{
                if let dict = arrAustralian[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Dominican Republic LIDOM":
            if arrDominican.count > 0 {
                if let dict = arrDominican[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB":
            if arrJapan.count > 0 {
                if let dict = arrJapan[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Japan NPB Reserve League":
            if arrJapanNPB.count > 0 {
                if let dict = arrJapanNPB[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Korean KBO":
            if arrKorean.count > 0 {
                if let dict = arrKorean[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Mexico Liga Del Pacifico":
            if arrMexico.count > 0 {
                if let dict = arrMexico[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Nicaragua LBPN":
            if arrNicaragua.count > 0 {
                if let dict = arrNicaragua[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "CPBL":
            if arrCPBL.count > 0 {
                if let dict = arrCPBL[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Arizona Fall League":
            if arrArizona.count > 0 {
                if let dict = arrArizona[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "MLB":
            if arrMLB.count > 0 {
                if let dict = arrMLB[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Triple A Minor League":
            if arrTriple.count > 0 {
                if let dict = arrTriple[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        case "Venezuela Liga Professional":
            if arrVenezuela.count > 0 {
                if let dict = arrVenezuela[indexPath.row] as? [String:Any] {
                    objMatchData = dict
                }
            }
        default:
            break
        }
        
        if self.btnTab.isSelected == false{
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idUpcomingMatchDetailsVC) as! UpcomingMatchDetailsVC
            vc.objMatchData = objMatchData
            vc.isCricket = false
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        } else {
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idPastMatchDetailsVC) as! PastMatchDetailsVC
            vc.objMatchData = objMatchData
            vc.isCricket = false
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tblBaseballMatch.dequeueReusableCell(withIdentifier: "cellBaseHeaderMatch") as! cellBaseHeaderMatch
        cell.lblHeader.text = arrTournamentNames[section]
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

//MARK: - API Calling
extension BaseballVC {
    func api_getPastMatches(id:String){
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=enddata&sport=baseball&league=" + id,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getPastMatches(id: id)
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                if let arrTable = dicData["games_end"] as? [[String:Any]] {
                    if id == "2759" {
                        self.arrAustralian.append(contentsOf: arrTable)
                    }
                    if id == "2131" {
                        self.arrDominican.append(contentsOf: arrTable)
                    }
                    if id == "347" {
                        self.arrJapan.append(contentsOf: arrTable)
                    }
                    if id == "15340" {
                        self.arrJapanNPB.append(contentsOf: arrTable)
                    }
                    if id == "349" {
                        self.arrKorean.append(contentsOf: arrTable)
                    }
                    if id == "2016" {
                        self.arrMexico.append(contentsOf: arrTable)
                    }
                    if id == "24486" {
                        self.arrNicaragua.append(contentsOf: arrTable)
                    }
                    if id == "11235" {
                        self.arrCPBL.append(contentsOf: arrTable)
                    }
                    if id == "18871" {
                        self.arrArizona.append(contentsOf: arrTable)
                    }
                    if id == "225" {
                        self.arrMLB.append(contentsOf: arrTable)
                    }
                    if id == "17711" {
                        self.arrTriple.append(contentsOf: arrTable)
                    }
                    if id == "1723" {
                        self.arrVenezuela.append(contentsOf: arrTable)
                    }
                    self.tblBaseballMatch.reloadData()
                }
            }
        }
    }
    
    func api_getUpcomingMatches(id:String){
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=predata&sport=baseball&league=" + id,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getUpcomingMatches(id: id)
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                if let arrTable = dicData["games_end"] as? [[String:Any]] {
                    if id == "2759" {
                        self.arrAustralian.append(contentsOf: arrTable)
                    }
                    if id == "2131" {
                        self.arrDominican.append(contentsOf: arrTable)
                    }
                    if id == "347" {
                        self.arrJapan.append(contentsOf: arrTable)
                    }
                    if id == "15340" {
                        self.arrJapanNPB.append(contentsOf: arrTable)
                    }
                    if id == "349" {
                        self.arrKorean.append(contentsOf: arrTable)
                    }
                    if id == "2016" {
                        self.arrMexico.append(contentsOf: arrTable)
                    }
                    if id == "24486" {
                        self.arrNicaragua.append(contentsOf: arrTable)
                    }
                    if id == "11235" {
                        self.arrCPBL.append(contentsOf: arrTable)
                    }
                    if id == "18871" {
                        self.arrArizona.append(contentsOf: arrTable)
                    }
                    if id == "225" {
                        self.arrMLB.append(contentsOf: arrTable)
                    }
                    if id == "17711" {
                        self.arrTriple.append(contentsOf: arrTable)
                    }
                    if id == "1723" {
                        self.arrVenezuela.append(contentsOf: arrTable)
                    }
                    self.tblBaseballMatch.reloadData()
                }
            }
        }
    }
}
