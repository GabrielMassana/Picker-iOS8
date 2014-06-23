//
//  ViewController.swift
//  Swift-Picker-iOS8
//
//  Created by Gabriel Massana on 20/06/2014.
//  Copyright (c) 2014 Gabriel Massana. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate /*, UIActionSheetDelegate*/ {
    
    var picker = UIPickerView()
    var pickerData  = NSArray()
    var countriesArray: NSMutableArray =  NSMutableArray()
    //var actionSheetPicker: UIActionSheet =  UIActionSheet()
    var actionView: UIView = UIView()
    
    @IBOutlet var countryLabel : UILabel = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.backgroundColor = UIColor.whiteColor()
        //actionSheetPicker.title = ""
        //actionSheetPicker.delegate = self
        
        actionView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 260.0)
        self.view.addSubview(actionView)
        
        var filePath =  NSBundle.mainBundle().pathForResource("countries", ofType: "plist")
        countriesArray = NSMutableArray(contentsOfFile: filePath)
        countriesArray.insertObject("", atIndex: 0)
        countriesArray.insertObject("No country", atIndex: 0)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func openPicker(sender : UIButton)
    {
        let kSCREEN_WIDTH  =    UIScreen.mainScreen().bounds.size.width
        //let kSCREEN_HEIGHT  =    UIScreen.mainScreen().bounds.size.height

        picker.frame = CGRectMake(0.0, 44.0,kSCREEN_WIDTH, 216.0)
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true;
        picker.backgroundColor = UIColor.whiteColor()

        var pickerDateToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
        pickerDateToolbar.barStyle = UIBarStyle.Black
        pickerDateToolbar.barTintColor = UIColor.blackColor()
        pickerDateToolbar.translucent = true
        
        var barItems = NSMutableArray()
        
        var labelCancel = UILabel()
        labelCancel.text = "Cancel"
        var titleCancel = UIBarButtonItem(title: labelCancel.text, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("cancelPickerSelectionButtonClicked:"))
        barItems.addObject(titleCancel)
        
        var flexSpace: UIBarButtonItem
        flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        barItems.addObject(flexSpace)

        pickerData = countriesArray
        picker.selectRow(1, inComponent: 0, animated: false)
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("countryDoneClicked:"))
        barItems.addObject(doneBtn)
        
        pickerDateToolbar.setItems(barItems, animated: true)
        
//        actionSheetPicker.addSubview(pickerDateToolbar)
//        actionSheetPicker.addSubview(picker)
//        actionSheetPicker.showInView(self.view)
//        actionSheetPicker.bounds = CGRectMake(0,0,320,464)
        
        actionView.addSubview(pickerDateToolbar)
        actionView.addSubview(picker)
        
        
        UIView.animateWithDuration(0.2, animations: {
            
            self.actionView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 260.0, UIScreen.mainScreen().bounds.size.width, 260.0)
            
            })
    }


    func cancelPickerSelectionButtonClicked(sender: UIBarButtonItem) {
        

        
        //actionSheetPicker.dismissWithClickedButtonIndex(0, animated: true)
        UIView.animateWithDuration(0.2, animations: {
            
            self.actionView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 260.0)
            
            }, completion: { _ in
                for obj: AnyObject in self.actionView.subviews {
                    if let view = obj as? UIView
                    {
                        view.removeFromSuperview()
                    }
                }
            })
        
//        for obj: AnyObject in actionSheetPicker.subviews {
//            if let view = obj as? UIView
//            {
//                view.removeFromSuperview()
//            }
//        }
        
    }
    
    func countryDoneClicked(sender: UIBarButtonItem) {
        
        
        var myRow = picker.selectedRowInComponent(0)
        countryLabel.text = pickerData.objectAtIndex(myRow) as NSString
        
        if countryLabel.text == "No country" {
            countryLabel.text = ""
        }
        
        //actionSheetPicker.dismissWithClickedButtonIndex(0, animated: false)
        
        UIView.animateWithDuration(0.2, animations: {
            
            self.actionView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 260.0)
            
            }, completion: { _ in
                for obj: AnyObject in self.actionView.subviews {
                    if let view = obj as? UIView
                    {
                        view.removeFromSuperview()
                    }
                }
            })

//        for obj: AnyObject in actionSheetPicker.subviews {
//            if let view = obj as? UIView
//            {
//                view.removeFromSuperview()
//            }
//        }
        
    }
    
    // MARK - Picker delegate
    
    func pickerView(_pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponentsInPickerView(_pickerView: UIPickerView!) -> Int {
        return 1
    }
    
        
    func pickerView(_pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
            
        return pickerData.objectAtIndex(row) as NSString
            
    }
        
    
}

