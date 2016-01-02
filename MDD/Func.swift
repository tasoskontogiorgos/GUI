//
//  Func.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/16/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation



class DRFunc : DRStruct
{
    var result:Member
    
    init(name: String, resultType:String)
    {
        result = Member(name:Result, type:resultType )
        super.init(name: name)
        
    }
    
    override func kindName() -> String {
        return "Func"
    }
    
    
    override func produceIR() -> IRIfc
    {
        return IRFunc( dr: self )
    }
    
    override func format( depth:Int ) -> String
    {
        
        var s = result.typedName.name
        
        s += " \( name )( "
        
        for i in 0 ..< count
        {
            let comma = i > 0 ? ", " : ""
            
            s +=  "\( comma )\( getTypeNameAt(i) ) \( getNameAt(i) )"
        };
        s += " )"
        
        return s
    }


    
    
    override func promote() {
        // nothing ... functions are no types
    }
}


class IRFunc : IRStruct
{
  
    var result:IRIfc?
    
    override func format( depth:Int ) -> String
    {
        let pad1 = Pad( depth )
        let pad2 = "\n"  + Pad( depth + 1 )
        
        var s = ""
        
        let fdr:DRFunc = dr as! DRFunc
        
        s += "\( fdr.result.typedName.name ) \( dr.name )( "
        
        for i in 0 ..< count
        {
            s += pad2 + "\( getNameAt(i) ) = \( getValueAt( i ).format(depth+1) )"
        };
        s += "\n" + pad1 + "}"
        
        return s
    }

    
    
    
    
}