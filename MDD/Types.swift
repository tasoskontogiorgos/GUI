//
//  Types.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/12/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation


class Types
{
    static var All = Types()
    
    var allTypes = [String: DRIfc]()
    
    func addPrimitive( primitive:PrimitiveKind )
    {
        let name = primitive.nameOf()
        let dr = DRPrim( kind: primitive )
        
        allTypes[ name ] = dr
    }
    
    static func GetType( name:String ) -> DRIfc
    {
        if All.allTypes[ name ] == nil
        {
            print( "unknown type name:\"\( name )\"" )
        }
        return All.allTypes[ name ]!
    }
    static func AddType( name: String, type: DRIfc )
    {
        All.addType( name, type: type)
    }

    
    func addType( name: String, type: DRIfc )
    {
        if let _ =  allTypes[ name ]
        {
            print( "attempt to redefine \( name )")
            return
        }
        if !type.isType()
        {
            print( "attempt to register non type \( name )")
            return
        }
        allTypes[ name ] = type
    }
    
    init()
    {
        for p in PrimitiveKind.allValues
        {
            addPrimitive(p)
        }
    }
    
    var desc: String
    {
        var s = ""
        
        for ( k, v ) in allTypes
        {
            s += "\( k ) -> \( v.desc )\n"
        }
        
        return s
    }
    
}