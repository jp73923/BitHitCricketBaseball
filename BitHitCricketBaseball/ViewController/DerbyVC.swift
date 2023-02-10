//
//  DerbyVC.swift
//  BitHitCricketBaseball
//
//  Created by macOS on 10/02/23.
//

import UIKit
class cellDerby:UITableViewCell {
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
}
class DerbyVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tblDerby: UITableView!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var lblDateStack: UILabel!
    @IBOutlet weak var lbTimeStack: UILabel!
    
    //MARK: - Global Variables
    var objMatch = [String:Any]()
    var arrFilterMatches = [[String:Any]]()
    var arrFilterDerbyList = [String]()

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
        self.api_getDerbyMatches()
    }
    
    //MARK: - IBActions
    @IBAction func btnBackAction(_ sender: Any) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }

}
//MARK: - UITableViewDataSource,UITableViewDelegate
extension DerbyVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if arrFilterMatches.count > 0 {
            self.tblDerby.backgroundView = nil
            numOfSection = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: self.tblDerby.bounds.size.width, height: self.tblDerby.bounds.size.height))
            noDataLabel.text = "No derby matches found"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tblDerby.backgroundView = noDataLabel
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFilterMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblDerby.dequeueReusableCell(withIdentifier: "cellDerby") as! cellDerby
        if let objMatch =  self.arrFilterMatches[indexPath.row] as? [String:Any] {
            if let homeTeam = objMatch["homeTeam"] as? [String:Any] {
                cell.imgTeam1.sd_setImage(with: URL.init(string: "https://api.sofascore.com/api/v1/team/" + "\((homeTeam["id"] as? NSNumber ?? 0))" + "/image"), placeholderImage: UIImage.init(named: "ic_placholderTop"))
            }
            if let awayTeam = objMatch["awayTeam"] as? [String:Any] {
                cell.imgTeam2.sd_setImage(with: URL.init(string: "https://api.sofascore.com/api/v1/team/" + "\((awayTeam["id"] as? NSNumber ?? 0))" + "/image"), placeholderImage: UIImage.init(named: "ic_placholderTop"))
            }
            if let homeScore = objMatch["homeScore"] as? [String:Any] {
                if let awayScore = objMatch["awayScore"] as? [String:Any] {
                    cell.lblScore.text = "\(homeScore["normaltime"] as? NSNumber ?? 0)" + " : " + "\(awayScore["normaltime"] as? NSNumber ?? 0)"
                }
            }
        }
        return cell
    }
}
//MARK: - API Calling
extension DerbyVC {
    func api_getDerbyMatches() {
        showLoaderHUD()
        let url = URL(string: "https://api.sofascore.com/mobile/v4/unique-tournament/\(APP_DELEGATE.id)/season/\(APP_DELEGATE.seasonId)/events")
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
                    let parsedDictionary = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
                    DispatchQueue.main.async {
                        if let dictData = parsedDictionary as? [String:Any] {
                            if let arrTournamaents = dictData["tournaments"] as? [[String:Any]] {
                                if let dict = arrTournamaents[0] as? [String:Any] {
                                    if let arrEvents = dict["events"] as? [[String:Any]] {
                                        self.arrFilterMatches.removeAll()
                                        for i in 0 ..< arrEvents.count {
                                            if let objMatch =  arrEvents[i] as? [String:Any] {
                                                if let status = objMatch["status"] as? [String:Any] {
                                                    if let type = status["type"] as? String {
                                                        if type == "finished" {
                                                            if self.arrFilterDerbyList.contains("\(objMatch["id"] as? NSNumber ?? 0)"){
                                                                 self.arrFilterMatches.append(objMatch)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        self.tblDerby.reloadData()
                                    }
                                }
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
