//
//  Renderers.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/29/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa

protocol CustomRenderer
{
    func setContext( parent parent: NSWindow, title:String, ir:IRIfc )
    func getWindow() -> NSWindow
}


class Renderers
{
    
    var all: [String: CustomRenderer] = [String: CustomRenderer]()
    
    func add( name:String, renderer:CustomRenderer )
    {
        all[ name ] = renderer
    }
    
    
    func get( name:String ) -> CustomRenderer
    {
        return all[ name ]!
    }
    
    func has( name:String ) -> Bool
    {
        if let _ = all[ name ]
        {
            return true
        }
        return false
    }
    
    init()
    {
        add( "int", renderer: StringIn() )
        add( "double", renderer: StringIn() )
        add( "string", renderer: StringIn() )
        add( "Rect2", renderer: Rect2Renderer() )
        
    }
}