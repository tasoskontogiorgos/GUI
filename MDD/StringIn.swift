//
//  StringIn.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/26/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa

class StringIn: NSWindowController, CustomRenderer {
    
    var parent : NSWindow?
    var title = ""
    var oldVal = ""
    var ir:IRPrim!
   
    @IBOutlet weak var Message: NSTextField!
    @IBOutlet weak var Value: NSTextField!
    
    func setContext( parent parent: NSWindow, title:String, ir:IRIfc )
    {
        self.parent = parent
        self.title = title
        self.ir = ir as! IRPrim
        self.oldVal = "\( self.ir.value )"
        
        if let m = Message
        {
            m.stringValue = self.title
        }
        
        if let v = Value
        {
            v.stringValue = self.oldVal
        }
    }

    func getWindow() -> NSWindow
    {
        return self.window!
    }
    
    var strValue = ""
    
    
    @IBAction func ValueEntered(sender: AnyObject) {
        strValue = Value.stringValue
    }
    
    
    override var windowNibName: String {
        return "StringIn"
    }
    
    @IBAction func okayButtonClicked(button: NSButton) {
        strValue = Value.stringValue
        ir.value = strValue
        parent!.endSheet(self.window!, returnCode: NSModalResponseOK )
    }
    
    @IBAction func cancelButtonClicked(button: NSButton) {
        parent!.endSheet(self.window!, returnCode: NSModalResponseCancel )
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        Message.stringValue = title
        Value.stringValue = oldVal
     }
    
}
