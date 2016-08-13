//
//  RedactedViewController.swift
//  [Redacted]
//
//  Created by [Redacted] on [Redacted]-[Redacted]-[Redacted].
//  Copyright (c) 2015 [Redacted] All rights reserved.
//  THIS VERSION EXISTS SOLELY FOR /r/pokemondev
//

import UIKit

internal class RedactedViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    internal var pickerData: [[String]]

    internal var prefix: String

    internal var suffix: String

    @IBOutlet weak internal var redactedLabel: UILabel!

    @IBOutlet weak internal var pickRedacted: UIPickerView!

    @IBOutlet weak internal var redactedShow: UITextView!

    @IBOutlet weak internal var redactedType: UISegmentedControl!

    @IBAction internal func shareHistory(sender: AnyObject)

    @IBAction internal func clearHistory(sender: AnyObject)

    @IBAction internal func changeType(sender: AnyObject)

    internal let redacted: Redacted_Redacted.RedactedBrain

    override internal func viewDidLoad()

    internal func regenerate()

    @IBAction internal func generateRedacted()

    @IBAction internal func saveRedacted()

    internal func resetPickerSelection()

    internal func updateLabel()

    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int

    internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int

    internal func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?

    internal func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}
