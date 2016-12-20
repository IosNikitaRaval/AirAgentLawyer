//
//  MyScheduleViewController.swift
//  AirAgentLawyer
//
//  Created by cears infotech on 11/26/16.
//  Copyright © 2016 cears. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController,RSDFDatePickerViewDelegate , RSDFDatePickerViewDataSource  {

    @IBOutlet var calenderView : RSDFDatePickerView!
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var scheduleEventView : UIView!
    
    var datesToMark : NSMutableArray = NSMutableArray()
    var arrName : NSMutableArray = NSMutableArray()
    var arrStatus : NSMutableArray = NSMutableArray()
    
    let calendar = NSCalendar.currentCalendar()
    var today : NSDate!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calenderView.delegate = self
        calenderView.dataSource = self
        calenderView.pagingEnabled = true
        
        self.datesToMark.addObject("2016-08-05")
        self.datesToMark.addObject("2016-08-08")
        self.datesToMark.addObject("2016-08-13")
        self.datesToMark.addObject("2016-08-17")
        
        scheduleEventView.hidden = true

    }
    
    //MARK: RSDFLowLayout Delegate Datasource
    
    func todayDate() -> NSDate
    {
        let todayComponents: NSDateComponents = self.calendar.components(([.Year, .Month, .Day]), fromDate: NSDate())
        self.today = self.calendar.dateFromComponents(todayComponents)
        print("date format today",self.today)
        return self.today
    }
    
    func datePickerView(view: RSDFDatePickerView, shouldHighlightDate date: NSDate) -> Bool
    {
        return true
    }
    
    func datePickerView(view: RSDFDatePickerView, shouldSelectDate date: NSDate) -> Bool {
        
        return true
    }
    
    func datePickerView(view: RSDFDatePickerView, shouldMarkDate date: NSDate) -> Bool
    {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateVal :String  = dateFormat.stringFromDate(date)
        print(dateVal)
        print("date to makr" , self.datesToMark)
        print("tru/false", self.datesToMark.containsObject(dateVal))
        return self.datesToMark.containsObject(dateVal)
    }
    
    func datePickerView(view: RSDFDatePickerView, didSelectDate date: NSDate)
    {
        print("selected date" , date)
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateVal :String  = dateFormat.stringFromDate(date)
        
        for(var i : Int = 0 ; i < self.datesToMark.count ; i++)
        {
            if(self.datesToMark[i] as! String  == dateVal)
            {
//                self.eventName = self.arrName[i] as! String
//                self.status = self.arrStatus[i] as! String
                
            }
            
        }
//        print("event name",self.eventName)
//        print("status",self.status)
        //self.tblEvent.reloadData()
    }
    
    func datePickerView(view: RSDFDatePickerView, markImageColorForDate date: NSDate) -> UIColor {
        
        
        return UIColor(red: 102/255, green: 172/255, blue: 237/255, alpha: 1.0)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
