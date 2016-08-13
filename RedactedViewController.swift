//
//  RedactedViewController.swift
//  [Redacted]
//
//  Created by [Redacted] on [Redacted]-[Redacted]-[Redacted].
//  Copyright (c) 2015 [Redacted] All rights reserved.
//  THIS VERSION EXISTS SOLELY FOR /r/pokemondev
//

import UIKit


class RedactedViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var pickerData: [[String]] = [[""],[""]]
    var prefix: String = ""
    var suffix: String = ""
    
    
    @IBOutlet weak var redactedLabel: UILabel!
    @IBOutlet weak var pickRedacted: UIPickerView!
    @IBOutlet weak var redactedShow: UITextView!
    @IBOutlet weak var redactedType: UISegmentedControl!
    
    
    @IBAction func shareHistory(sender: AnyObject) {
        let list: String = redacted.showSavedList()
        let controller = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // action to clear the history/list
    @IBAction func clearHistory(sender: AnyObject) {
        redacted.savedReadacted = [""]
        updateLabel()
    }
    
    // action to update display based on type change
    @IBAction func changeType(sender: AnyObject) {
        switch redactedType.selectedSegmentIndex
        {
        case 0:
            pickRedacted.dataSource = self
            pickRedacted.delegate = self
            pickerData = redacted.sendCombinedList()
            resetPickerSelection()
            pickRedacted.reloadAllComponents()
            updateLabel()
            ;
        case 1:
            fallthrough;
        case 2:
            fallthrough;
        case 3:
            pickRedacted.dataSource = self
            pickRedacted.delegate = self
            pickerData = redacted.sendPrefixList()
            pickRedacted.reloadAllComponents()
            resetPickerSelection()
            updateLabel()
            ;
        default:
            break; 
        }
    }
    
    
    let redacted = RedactedBrain()
    
    override func viewDidLoad() {
        pickerData = redacted.sendCombinedList()
        super.viewDidLoad()
        pickRedacted.dataSource = self
        pickRedacted.delegate = self
        pickRedacted.reloadAllComponents()
    }
    
    // action to generate a redacted while ensuring it keeps track of the tab you are in
    func regenerate() {
        prefix = pickerData[0][pickRedacted.selectedRowInComponent(0)]
        
        if redactedType.selectedSegmentIndex == 0 {
            suffix = pickerData[1][pickRedacted.selectedRowInComponent(1)]
            
            if prefix == "" && suffix == "" {
                prefix = redacted.generatePrefixRedacted()
                suffix = redacted.generateSuffixRedacted()
            } else if prefix == "" && suffix != "" {
                prefix = redacted.generatePrefixRedacted()
            } else if prefix != "" && suffix == "" {
                suffix = redacted.generateSuffixRedacted()
            } else if prefix != "" && suffix != "" {
                resetPickerSelection()
                prefix = redacted.generatePrefixRedacted()
                suffix = redacted.generateSuffixRedacted()
            }
        } else if redactedType.selectedSegmentIndex == 1 {
            suffix = "kit"
            if prefix == "" {
                prefix = redacted.generatePrefixRedacted()
            } else if prefix != "" {
                resetPickerSelection()
                prefix = redacted.generatePrefixRedacted()
            }
        } else if redactedType.selectedSegmentIndex == 2 {
            suffix = "paw"
            if prefix == "" {
                prefix = redacted.generatePrefixRedacted()
            } else if prefix != "" {
                resetPickerSelection()
                prefix = redacted.generatePrefixRedacted()
            }
        } else if redactedType.selectedSegmentIndex == 3 {
            suffix = "star"
            if prefix == "" {
                prefix = redacted.generatePrefixRedacted()
            } else if prefix != "" {
                resetPickerSelection()
                prefix = redacted.generatePrefixRedacted()
            }
        }
        
        redactedLabel.text = prefix + suffix
    }
    
    // action to activate redacted generation from button
    @IBAction func generateRedacted() {
        regenerate()
    }
    
    // action to write to the "History" Log
    @IBAction func saveRedacted() {
        // This "if" needs to be replaced with seperate function. It's current purpose is to ensure no garbage is written to savedRedacteds list
        if redactedLabel.text != "" && redactedLabel.text != " " && redactedLabel.text != "Press Generate" && redactedLabel.text != nil && prefix != "" && suffix != "" && redacted.savedRedacteds.contains(redactedLabel.text!) != true{
        let redactedDisplay = redactedLabel.text
        redacted.savedRedacteds.append(redactedDisplay!)
        redactedShow.text = "\(redacted.showSavedList())"
        }
    }
    // action to move the picker back to "" if there are 2 parts of a redacted already selected BEFORE generation
    func resetPickerSelection() {
        if pickRedacted.numberOfComponents == 1 {
            pickRedacted.selectRow(0, inComponent: 0, animated: true)
        } else if pickRedacted.numberOfComponents == 2 {
            pickRedacted.selectRow(0, inComponent: 0, animated: true)
            pickRedacted.selectRow(0, inComponent: 1, animated: true)
        }
        
        
    }
    
    //MARK -Instance Methods
    
    func updateLabel() {
        prefix = pickerData[0][pickRedacted.selectedRowInComponent(0)]
        
        if redactedType.selectedSegmentIndex == 0 {
            suffix = pickerData[1][pickRedacted.selectedRowInComponent(1)]
            
//            pickerData = redacted.sendCombinedList()
//            pickRedacted.reloadAllComponents()
            if prefix + suffix != "" {
                redactedLabel.text = prefix + suffix
            } else {
                redactedLabel.text = "Press Generate"
            }
        } else if redactedType.selectedSegmentIndex == 1 {
            suffix = "kit"
            
//            pickerData = redacted.sendPrefixList()
//            pickRedacted.reloadAllComponents()
            if prefix != "" {
                redactedLabel.text = prefix + suffix
            } else {
                redactedLabel.text = "Press Generate"
            }
            
        } else if redactedType.selectedSegmentIndex == 2 {
            suffix = "paw"
//            pickerData = redacted.sendPrefixList()
//            pickRedacted.reloadAllComponents()
            if prefix != "" {
                redactedLabel.text = prefix + suffix
            } else {
                redactedLabel.text = "Press Generate"
            }
            
        } else if redactedType.selectedSegmentIndex == 3 {
            suffix = "star"
//            pickerData = redacted.sendPrefixList()
//            pickRedacted.reloadAllComponents()
            if prefix != "" {
                redactedLabel.text = prefix + suffix
            } else {
                redactedLabel.text = "Press Generate"
            }
            
        }
        
        if redacted.dirty == true {
            redactedShow.text = redacted.showSavedList()
            redacted.dirty = false
        }
    
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }

    
    
    
}

