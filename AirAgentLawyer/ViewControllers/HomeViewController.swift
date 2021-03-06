//
//  HomeViewController.swift
//  AirAgentLawyer
//
//  Created by Apple on 24/11/16.
//  Copyright © 2016 cears. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblHome: UITableView!
    var agentID : String = ""
    var arrOfMention : NSMutableArray = NSMutableArray()
    var Token : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblHome.delegate = self
        tblHome.dataSource = self
        tblHome.tableFooterView = UIView(frame: CGRect.zero)
        
        let user_Data = NSUserDefaults.standardUserDefaults().objectForKey("USER_OBJECT") as? NSData
        if let userData = user_Data {
            let userObj = NSKeyedUnarchiver.unarchiveObjectWithData(userData)
            
            if let userData_val = userObj {
                
                self.agentID = String(userData_val.valueForKey("userid") as! Int)
                self.Token = userData_val.valueForKey("Token") as! String
            }
        }
        
        self.getMentionRequest()
        
    }
    
    func getMentionRequest()
    {
        var arrMention = []
        
        //API Calling
        GlobalClass.sharedInstance.startIndicator(NSLocalizedString("Loading...", comment: "comm"))
        
        let str = "Agent/AgentMentionRequest?AgentId="+self.agentID
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL+str)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.Token, forHTTPHeaderField: "Token")
        request.addValue(self.agentID, forHTTPHeaderField: "UserId")
        
        GlobalClass.sharedInstance.get(request, params: "") { (success, object) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("obj",object)
                if success
                {
                    GlobalClass.sharedInstance.stopIndicator()
                    
                    if let object = object
                    {
                        print("response object",object)
                        print("dat ",object.valueForKey("Data"))
                        if(!object.valueForKey("Data")!.isKindOfClass(NSNull))
                        {
                            print("not null")
                            arrMention = object.valueForKey("Data") as! NSArray
                            for i in 0  ..< arrMention.count
                            {
                                let mentionObj : MentionRequest = MentionRequest()
                                
                                mentionObj.AgentId = arrMention[i].valueForKey("AgentId") as? Int
                                mentionObj.ClientName = arrMention[i].valueForKey("ClientName") as? String ?? ""
                                mentionObj.CourtAddress = arrMention[i].valueForKey("CourtAddress") as? String ?? ""
                                mentionObj.CourtCity = arrMention[i].valueForKey("CourtCity") as? String ?? ""
                                mentionObj.CourtName = arrMention[i].valueForKey("CourtName") as? String ?? ""
                                mentionObj.MentionDate = arrMention[i].valueForKey("MentionDate") as? String ?? ""
                                mentionObj.MentionId = arrMention[i].valueForKey("MentionId") as? String ?? ""
                                mentionObj.Principleid = arrMention[i].valueForKey("Principleid") as? String ?? ""
                                mentionObj.Status = arrMention[i].valueForKey("Status") as? String ?? ""
                                
                                self.arrOfMention.addObject(mentionObj)
                            }
                            self.tblHome.reloadData()
                        }
                        else
                        {
                            print("no data availabel")
                            self.tblHome.reloadData()
                        }
                        
                    }
                }
                else
                {
                    GlobalClass.sharedInstance.stopIndicator()
                    if(!object!.valueForKey("Data")!.isKindOfClass(NSNull))
                    {
                        print("not null")
                    }
                    else
                    {
                        print("no data availabel")
                    }
                    self.tblHome.reloadData()
                }
            })
        }
    }

    //MARK : tableview delegate and datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(self.arrOfMention.count > 0)
        {
            return self.arrOfMention.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(self.arrOfMention.count > 0)
        {
            return 82
        }
        else
        {
            return 40
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(self.arrOfMention.count > 0)
        {
            let cell:HomeCell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeCell
            
            let mentionObj = self.arrOfMention.objectAtIndex(indexPath.row) as! MentionRequest
            print("entire obj",mentionObj)
            print(mentionObj.CourtAddress)
            
            cell.selectionStyle = .None
            
            cell.lblTitle.text = mentionObj.CourtName
            cell.lblSubtitle.text = mentionObj.ClientName
            cell.lblLocation.text = mentionObj.CourtAddress
            
            let formatter : NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dt = formatter.dateFromString(mentionObj.MentionDate)
            formatter.dateFormat = "dd/MM/yyyy"
            print(formatter.stringFromDate(dt!))
            cell.lblDate.text = formatter.stringFromDate(dt!)

            return cell
        }
        else
        {
            self.tblHome.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = NSLocalizedString("Request Not Available.", comment: "comm")
            cell.textLabel?.textColor = UIColor(red: 57/255, green: 80/255, blue: 99/255, alpha: 1.0)
            cell.textLabel?.font = UIFont.systemFontOfSize(15.0)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mentionObj = self.arrOfMention.objectAtIndex(indexPath.row) as! MentionRequest
        let vcObj = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        vcObj.obj = mentionObj
        self.navigationController?.pushViewController(vcObj, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
