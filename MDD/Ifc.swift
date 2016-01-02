//
//  Ifc.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/17/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation


class DRInterface : DRStruct
{
    var impl : IfcImpl!
    
    override func kindName() -> String { return "Interface" }
    
    override func shortDesc() -> String {
        var s = "{ "
        let sz = size()
        for i in 0 ..< sz
        {
            let semi = ( i > 0 ) ? ", " : ""
            s += semi + "\(getNameAt(i))"
        }
        s += " }"
        return s
    }

    
    override func produceIR() -> IRIfc
    {
        return IRInterface( dr: self )
    }
    
    func add( fun: DRFunc )
    {
        let m = Member( name: fun.name, dr: fun )
        add( m )
    }
    
    override func format( depth:Int ) -> String
    {
        let pad1 = Pad( depth )
        let pad2 = "\n"  + Pad( depth + 1 )
        
        
        var s = pad1 + "interface \( name ) {"
        
        for i in 0..<count
        {
            
            s +=  pad2 + "\( getDRAt(i).format( depth+1 ) );"
        };
        s += pad1 + "\n}\n"
        
        return s
    }
    
    
    
    
    override func promote() {
        // nothing ... functions are no types
    }
}


class IRInterface : IRStruct
{
    
    override func populateVals()
    {
        for i in 0..<count
        {
            value.append( dr.getDRAt(i ).produceIR() )
        }
    }
    
    override func setIR( index:Int, ir:IRIfc )
    {
        super.setIR( index, ir: ir )
        // print( " Calling : \( ir.desc )" )
        let impl = ( getDR() as! DRInterface ).impl
        impl.Call( ir as! IRFunc )
    }
    
    override func format( depth:Int ) -> String
    {
        let pad1 = Pad( depth )
        let pad2 = "\n"  + Pad( depth + 1 )
        
        
        var s = pad1 + "\( dr.name ){"
        
        for i in 0..<count
        {
            let v = getValueAt( i ).format( depth + 1 )
            
            s +=  pad2 + "\( v );"
        };
        s += ( "\n" + pad1 ) + "}\n"
        
        return s
    }
    
    
}