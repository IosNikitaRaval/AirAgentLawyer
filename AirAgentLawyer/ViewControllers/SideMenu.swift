//
//  SideMenu.swift
//  FoodLa
//
//  Created by Admin on 27/10/16.
//  Copyright © 2016 cearsinfotech. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func didFinishTask(sender: SideMenu, index : Int)
}

class SideMenuCell: UITableViewCell {
    
    @IBOutlet var lblName : UILabel!
    @IBOutlet var imgIcon : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class SideMenu: UIViewController {

    weak var delegate:DetailViewControllerDelegate?
    
    @IBOutlet var tblMenu : UITableView!
    
    var ArrUserMenu : NSMutableArray = ["Home", "My Schedule", "Chat", "My Profile", "Logout"]
    var ArrUserMenuImage : NSMutableArray = ["ic_drawer_home","ic_drawer_calendar","ic_drawer_chat","ic_drawer_profile","ic_drawer_logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMenu.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrUserMenu.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let identifier = "MenuCell"
        var cell: SideMenuCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? SideMenuCell
        if cell == nil {
            tableView.registerNib(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? SideMenuCell
        }
        
        cell.lblName.text = ArrUserMenu.objectAtIndex(indexPath.row) as? String
        cell.imgIcon.image = UIImage(named: ArrUserMenuImage.objectAtIndex(indexPath.row) as! String)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell #\(indexPath.row)!")
        delegate?.didFinishTask(self, index: indexPath.row)
    }
}
