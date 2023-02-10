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
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
}
class MatchHistoryVC: UIViewController {
    //MARK: - IBOutlets
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
    var isCricket = false

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        var cric = isCricket ? "cricket/" : "baseball/"
        if let homeTeam = objMatch["home"] as? [String:Any] {
            self.lblTeam1.text = homeTeam["name"] as? String ?? ""
            self.imgTeam1.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/" + cric + "\(homeTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
        }
        if let awayTeam = objMatch["away"] as? [String:Any] {
            self.lblTeam2.text = awayTeam["name"] as? String ?? ""
            self.imgTeam2.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/" + cric + "\(awayTeam["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team2_placeholder"))

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
//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension MatchHistoryVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if arrh2h.count > 0 {
            self.tblH2H.backgroundView = nil
            numOfSection = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: self.tblH2H.bounds.size.width, height: self.tblH2H.bounds.size.height))
            noDataLabel.text = "No match history found"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tblH2H.backgroundView = noDataLabel
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrh2h.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblH2H.dequeueReusableCell(withIdentifier: "cellMatchHistory") as! cellMatchHistory
        if let dict = self.arrh2h[indexPath.row] as? [String:Any] {
            cell.lblScore.text = dict["ss"] as? String ?? ""
            var cric = isCricket ? "cricket/" : "baseball/"
            if let dictahome = dict["home"] as? [String:Any] {
                cell.lblTeam1.text = dictahome["name"] as? String ?? ""
                cell.imgTeam1.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/" + cric + "\(dictahome["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team1_placeholder-1"))
            }
            if let dictaway = dict["away"] as? [String:Any] {
                cell.lblTeam2.text = dictaway["name"] as? String ?? ""
                cell.imgTeam2.sd_setImage(with: URL.init(string: "https://spoyer.com/api/team_img/" + cric + "\(dictaway["id"] as? String ?? "")" + ".png"), placeholderImage: UIImage.init(named: "ic_team2_placeholder"))
            }
            return cell
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
                                if let h2h = results["home"] as? [[String:Any]] {
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
