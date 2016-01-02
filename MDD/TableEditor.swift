//
//  TableEditor.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/25/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa


let renderers = Renderers()


class TableEditor: NSWindowController {
    
    
    @IBOutlet var MyWindow: NSWindow!
    @IBOutlet weak var KindName: NSTextField!
    @IBOutlet weak var ShortDesc: NSTextField!
    @IBOutlet weak var Table: NSTableView!
    @IBOutlet weak var PopButton: NSButton!
    
    @IBAction func PopAction(sender: AnyObject) {
        m_stack.pop()
        refresh()
    }
    
    var stringInput:CustomRenderer?
    
    @IBAction func PushAction(sender: AnyObject) {
        let dr = m_stack.top().dr
        let i = Table.selectedRow
        m_stack.pushByName( dr.getNameAt(i))
        
        
        let topDrName = m_stack.top().dr.getName()
        if renderers.has( topDrName )
        {
            
            let strIn = renderers.get( topDrName )
            let tir = self.m_stack.top().ir
            let title = "\(tir.getDR().getName()) \(dr.getNameAt(i))"
            strIn.setContext(parent: self.window!, title: title, ir: tir )
            
            
            self.window?.beginSheet( strIn.getWindow(), completionHandler: { response in

                self.PopAction( sender )
            })
        }

        
        
        refresh()
    }
    @IBOutlet var TableCtrl: NSArrayController!
    
    var top:[ ContolElement ] = []
    
    var  m_stack: MDDStack!
    var  m_scenario = ""
    
    func set( dr: DRIfc )
    {
        m_stack = MDDStack(dr: dr )
    }
    
    func set( ir: IRIfc )
    {
        m_stack = MDDStack( ir:ir )
    }

    
    class ContolElement : NSObject
    {
        var name: String
        var type: String
        
        init(name:String, type: String )
        {
            self.name = name
            self.type = type
        }
        
        var desc: String
            {
                return "(name=\"\(name)\", type=\"\(type)\")";
        }
    }
    
    func valof( ir: IRIfc ) -> String
    {
        if let f = ir as? IRFunc
        {
            if let r = f.result
            {
                return r.shortDesc()
            }
            return "Not called yet ..."
        }
        return ir.shortDesc()
    }
    
    func nameof( dr: DRIfc ) -> String
    {
        if let _ = dr as? DRFunc
        {
            return ""
        }
        return dr.getName() + " -> "
    }
    
    
    func refresh()
    {
        if m_stack == nil
        {
            return
        }
        let dr = m_stack.top().dr
        let ir = m_stack.top().ir
        let sz = dr.size()
        
        KindName.stringValue = "\(dr.kindName()) \( dr.getName())"
        ShortDesc.stringValue = dr.shortDesc()
        top.removeAll()
        
        for i in 0 ..< sz
        {
            let t = "\( nameof(dr.getDR(i)) )\(valof(  ir.getIR(i) ))"
            let n = dr.getNameAt(i)
            
            top.append(ContolElement( name:n , type:t ))
        }
        
        TableCtrl.content = top
        
        if( m_stack.size() <= 1 )
        {
            PopButton.enabled = false
        } else
        {
            PopButton.enabled = true
        }
        
    }
    
    

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        refresh()
    }
    
}
