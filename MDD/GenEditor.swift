//
//  GenEditor.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/22/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa

class GenEditor: NSWindowController {
    
    
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
    
    
    
    
  
    @IBOutlet var ScenarioText: NSTextView!
    
    
    @IBOutlet var OutputText: NSTextView!
    
    
    @IBOutlet weak var ValueText: NSTextField!
    @IBAction func ValueEntered(sender: AnyObject) {
        SetTop( sender )
    }
    
    
    
    @IBOutlet weak var PopButton: NSButton!
    
    @IBAction func Pop(sender: AnyObject) {
        m_stack.pop()
        m_scenario += "\tTheStack.pop()\n"
        
        refresh()
    }
    
    
    @IBOutlet weak var StackIndex: NSPopUpButton!
 
    @IBAction func StackIndexSelected(sender: AnyObject) {
        Push( sender )
    }
    
    
    func SetTop(sender: AnyObject) {
        let prim = m_stack.top().ir as! IRPrim
        let v = ValueText.intValue
        prim.value = Int( v )
        assignVal( Int( v))
        ValueText.stringValue = ""
        Pop( sender )
        refresh()
        
    }
    
    var AssignCounter = 0
    
    func assignVal( v:AnyObject )
    {
        if( AssignCounter == 0 )
        {
            m_scenario += "\tvar prim = TheStack.top().ir as! IRPrim\n"
        }else
        {
            m_scenario += "\tprim = TheStack.top().ir as! IRPrim\n"
        }
        m_scenario += "\tprim.value = \( v )\n"
        AssignCounter++
    }
    
    func Push(sender: AnyObject) {
        
        let str = StackIndex.titleOfSelectedItem!
        m_stack.pushByName( str )
        m_scenario += "\tTheStack.pushByIndex( \"\( str )\")\n"
        refresh()
        
    }
    
   
    
    func refresh()
    {
        StackIndex.removeAllItems()
        let size = m_stack.top().ir.size()
        if( size > 0 )
        {
            var stackSel:[String] = []
            
            for i in 0 ..< size
            {
                stackSel.append( m_stack.top().dr.getNameAt( i ) )
            }
            StackIndex.addItemsWithTitles(stackSel )
            StackIndex.enabled = true
            ValueText.enabled = false
        } else
        {
            StackIndex.enabled = false
            ValueText.enabled = true
        }
        OutputText.string = m_stack.top().ir.desc
        ScenarioText.string = m_scenario
        if( m_stack.size() == 1 )
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
