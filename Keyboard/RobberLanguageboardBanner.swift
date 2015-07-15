//
//  CatboardBanner.swift
//  TastyImitationKeyboard
//
//  Created by Alexei Baboulevitch on 10/5/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

import UIKit

/*
This is the demo banner. The banner is needed so that the top row popups have somewhere to go. Might as well fill it
with something (or leave it blank if you like.)
*/

class RobberLanguageboardBanner: ExtraView {
    
    var robberSwitch: UISwitch = UISwitch()
    var robberLabel: UILabel = UILabel()
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
        
        self.addSubview(self.robberSwitch)
        self.addSubview(self.robberLabel)
        
        self.robberSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(kCatTypeEnabled)
        self.robberSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        self.robberSwitch.addTarget(self, action: Selector("respondToSwitch"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.updateAppearance()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.robberSwitch.center = self.center
        self.robberLabel.center = self.center
        self.robberLabel.frame.origin = CGPointMake(self.robberSwitch.frame.origin.x + self.robberSwitch.frame.width, self.robberLabel.frame.origin.y)
    }
    
    func respondToSwitch() {
        NSUserDefaults.standardUserDefaults().setBool(self.robberSwitch.on, forKey: kRobberLanugageTypeEnabled)
        self.updateAppearance()
    }
    
    func updateAppearance() {
        if self.robberSwitch.on {
            self.robberLabel.text = "😏"
        }
        else {
            self.robberLabel.text = "😇"
        }
        
        self.robberLabel.sizeToFit()
    }
}
