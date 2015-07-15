//
//  Catboard.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 9/24/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

import UIKit
import VerbalExpressions

/*
This is the demo keyboard. If you're implementing your own keyboard, simply follow the example here and then
set the name of your KeyboardViewController subclass in the Info.plist file.
*/

let kRobberLanugageTypeEnabled = "kBannerTypeEnabled"

class CustomKeyboard: KeyboardViewController {
    
    //let takeDebugScreenshot: Bool = false

    let vowels = "aeiouy"
    let consonants = "bcdfghjklmnpqrstvwxz"

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        NSUserDefaults.standardUserDefaults().registerDefaults([kCatTypeEnabled: true])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func keyPressed(key: Key) {
        if let textDocumentProxy = self.textDocumentProxy as? UITextDocumentProxy {
            let keyOutput = key.outputForCase(self.shiftState.uppercase())
            
            let robberLanguageOn = NSUserDefaults.standardUserDefaults().boolForKey(kRobberLanugageTypeEnabled)
//            if !NSUserDefaults.standardUserDefaults().boolForKey(kCatTypeEnabled) {
//                textDocumentProxy.insertText(keyOutput)
//                return
//            }

            let consonantsPattern = VerEx().withAnyCase(enabled: true).anyOf(consonants)

            if  robberLanguageOn && keyOutput =~ consonantsPattern  {
                textDocumentProxy.insertText(keyOutput+"o"+key.lowercaseOutput!)
                return
            }
            textDocumentProxy.insertText(keyOutput)
        }
    }
    
    override func createBanner() -> ExtraView? {
        return RobberLanguageboardBanner(globalColors: self.dynamicType.globalColors, darkMode: false, solidColorMode: self.solidColorMode())
    }
}
