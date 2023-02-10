//
//  MatchHistoryVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 10/02/23.
//

import UIKit
class cellMatchHistory:UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblScore2: UILabel!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
}
class MatchHistoryVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tblHistory: UITableView!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var lblDateStack: UILabel!
    @IBOutlet weak var lbTimeStack: UILabel!
    @IBOutlet weak var tblH2H: UITableView!
    
    //MARK: - Global Variables
    var objMatch = [String:Any]()
    var arrh2h = [[String:Any]]()
    var arrhomeaway = [[String:Any]]()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
            formaor.dateFormat = "dd MMM"
            self.lblDateStack.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
            formaor.dateFormat = "hh:mm"
            self.lbTimeStack.text = formaor.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: NSNumber(value: startTimestamp))) as Date)
        }
        if let gameId = objMatch["game_id"] as? String {
            self.api_getH2hMatches(gameId: gameId)
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackAction(_ sender: Any) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
}
//MARK: - UITableViewDataSource,UITableViewDelegate
extension MatchHistoryVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrh2h.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblHistory.dequeueReusableCell(withIdentifier: "cellMatchHistory") as! cellMatchHistory
        if let dict = self.arrh2h[indexPath.row] as? [String:Any] {
            cell.lblScore.text = dict["ss"] as? String ?? ""
            if let dictHome = dict["home"] as? [String:Any] {
                if let img1 = dictHome["id"] as? String {
                    cell.lblTeam2.text = dictHome["name"] as? String ?? ""
                    cell.imgTeam1.sd_setImage(with: NSURL.init(string: String.init(format: "https://spoyer.com/api/team_img/cricket/%@.png", img1)) as URL?, placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
                }
            }
            if let dictaway = dict["away"] as? [String:Any] {
                if let img1 = dictaway["id"] as? String {
                    cell.lblTeam2.text = dictaway["name"] as? String ?? ""
                    cell.imgTeam2.sd_setImage(with: NSURL.init(string: String.init(format: "https://spoyer.com/api/team_img/cricket/%@.png", img1)) as URL?, placeholderImage: UIImage.init(named: "ic_team2_placeholder"))
                }
            }
            cell.lblScore.text = (dict["ss"] as? String ?? "").components(separatedBy: "-")[0]
            cell.lblScore2.text = (dict["ss"] as? String ?? "").components(separatedBy: "-")[1]
        }
        return cell
    }
}

//MARK: - API Calling Methods
extension MatchHistoryVC {
    func api_getH2hMatches(gameId:String) {
        showLoaderHUD()
        let urlString = "https://spoyer.com/api/en/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=h2h&game_id=" + gameId
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with:request) { (data, response, error) in
            DispatchQueue.main.async {
                hideLoaderHUD()
            }
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    let parsedDictionaryArray = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
                    DispatchQueue.main.async {
                        if let dictData = parsedDictionaryArray as? [String:Any] {
                            if let results = dictData["results"] as? [String:Any] {
                                if let h2h = results["h2h"] as? [[String:Any]] {
                                    self.arrh2h = h2h
                                }
                                self.tblH2H.reloadData()
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
}
