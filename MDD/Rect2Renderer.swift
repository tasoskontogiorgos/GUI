//
//  Rect2Renderer.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/29/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa

class Rect2Renderer: NSWindowController , CustomRenderer {
    
    var parent : NSWindow?
    var title = ""
    var oldVal = ""
    var ir:IRIfc!
    
    
    var origin_x:IntAcc!
    var origin_y:IntAcc!
    var corner_x:IntAcc!
    var corner_y:IntAcc!

    
    func setContext( parent parent: NSWindow, title:String, ir:IRIfc )
    {
        self.parent = parent
        self.title = title
        self.ir = ir
        
        
        origin_x = IntAcc( dr: ir.getDR(), acc: "origin.x")
        origin_y = IntAcc( dr: ir.getDR(), acc: "origin.y")
        corner_x = IntAcc( dr: ir.getDR(), acc: "corner.x")
        corner_y = IntAcc( dr: ir.getDR(), acc: "corner.y")
        
        refresh()
        
    }
    
    
    func refresh()
    {
        
        if let m = Message
        {
            m.stringValue = self.title
        }
        
        if let ox = OX
        {
            ox.stringValue = "\( origin_x.get( ir ))"
        }
        if let oy = OY
        {
            oy.stringValue = "\( origin_y.get( ir ))"
        }
        if let cx = CX
        {
            cx.stringValue = "\( corner_x.get( ir ))"
        }
        if let cy = CY
        {
            cy.stringValue = "\( corner_y.get( ir ))"
        }

    }

    func getWindow() -> NSWindow
    {
        return self.window!
    }
    
    override var windowNibName: String {
        return "Rect2Renderer"
    }
    
    
    @IBOutlet weak var Message: NSTextField!
    
    
    @IBOutlet weak var OX: NSTextField!
    
    @IBOutlet weak var OY: NSTextField!
    
    @IBOutlet weak var CX: NSTextField!

    @IBOutlet weak var CY: NSTextField!
    
    
    @IBAction func Cancel(sender: AnyObject) {
        parent!.endSheet(self.window!, returnCode: NSModalResponseCancel )

    }
    @IBAction func Ok(sender: AnyObject) {
        
        origin_x.set(ir, v: OX.integerValue )
        origin_y.set(ir, v: OY.integerValue )
        corner_x.set(ir, v: CX.integerValue )
        corner_y.set(ir, v: CY.integerValue )
        
        parent!.endSheet(self.window!, returnCode: NSModalResponseOK )

    }
    override func windowDidLoad() {
        super.windowDidLoad()
        refresh()


        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
