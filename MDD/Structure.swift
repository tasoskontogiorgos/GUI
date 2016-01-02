//
//  Structure.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/14/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation



class DRStruct : DRIfc
{
    
    let name : String
    var members : Members
    
    
    func kindName() -> String { return "Struct" }
    
    func shortDesc() -> String {
        var s = "{ "
        let sz = size()
        for i in 0 ..< sz
        {
            let semi = ( i > 0 ) ? ", " : ""
            s += semi + "\( getDR(i ).getName()) \(getNameAt(i))"
        }
        s += " }"
        return s
    }
    
    init( name:String )
    {
        self.name = name
        self.members = Members()
    }
    
    func getDR( index:Int )-> DRIfc
    {
        return members.memberAt(index).dr
    }
    func getDR( name:String )-> DRIfc
    {
        return members.memberAt(name).dr
    }
    
    func indexOfName( name: String ) -> Int
    {
        return members.indexOfName(name )
    }
    
    func size() -> Int
    {
        return members.count
    }
    

    func getName() -> String
    {
        return name
    }
    
    func add( member:Member )
    {
        self.members.add( member )
    }
    
    func getNameAt( i:Int ) -> String
    {
        return members.getNameAt( i )
    }
    
    func getTypeNameAt( i:Int ) -> String
    {
        return members.getTypeNameAt( i )
    }
    
    func getDRAt( i:Int ) -> DRIfc
    {
        return members.memberAt(i).dr
    }

    
    
    func format( depth:Int ) -> String
    {
        let pad1 = Pad( depth )
        let pad2 = "\n"  + Pad( depth + 1 )
        
        var s = ""
        
        s += "struct \( name )\n" + pad1 + "{"
        
        for i in 0..<count
        {
            s += pad2 + "\( getTypeNameAt(i) )  \( getNameAt(i) ); "
        };
        s += "\n" + pad1 + "}\n"
        
        return s
    }

    
    var desc : String
    {
        return format(0)
    }
    
    func isType() -> Bool
    {
        return true
    }
    func isPrimitive() -> Bool
    {
        return false;
    }
    
    func produceIR() -> IRIfc
    {
        return IRStruct( dr: self )
    }
    
    var count : Int
    {
        return members.count
    }
    
    func promote()
    {
        Types.AddType(name, type: self )
    }
}


class IRStruct : IRIfc
{
    var dr: DRStruct
    var value: [ IRIfc ] = []
    
    
    func kindName() -> String { return dr.kindName() }
    
    func shortDesc() -> String {
        var s = "{ "
        let sz = size()
        for i in 0 ..< sz
        {
            let semi = ( i > 0 ) ? ", " : ""
            s += semi + "\( dr.getNameAt(i)) = \(getValueAt(i).shortDesc())"
        }
        s += " }"
        return s
    }

    
    

    init( dr:DRStruct)
    {
        self.dr = dr
        populateVals()
    }
    
    func size() -> Int
    {
        return dr.size()
    }
    
    func populateVals()
    {
    
        for i in 0..<count
        {
            value.append( getTypeAt(i ).produceIR() )
        }
    }
    
    func getNameAt( i:Int ) -> String
    {
        return dr.getNameAt( i )
    }
    
    func getTypeNameAt( i:Int ) -> String
    {
        return dr.getTypeNameAt( i )
    }

    
    func getTypeAt( i:Int ) -> DRIfc
    {
        return Types.GetType( dr.getTypeNameAt( i ) )
    }

    
    
    func indexOfName( name : String ) -> Int
    {
        
        return self.dr.members.indexOfName(name )
    }
    
    
    func getValueAt( index: Int )-> IRIfc
    {
        return value[ index ]
    }
    
    
    func getValueAt( name : String ) -> IRIfc
    {
        return getValueAt( indexOfName(name ))
    }
    
    func getIR( index:Int )-> IRIfc
    {
        return getValueAt(index )
    }
    
    func getIR( name:String )-> IRIfc
    {
        return getValueAt(name )
    }
    
    func setIR( index:Int, ir:IRIfc )
    {
        value[ index ] = ir
    }
     
    
    func setIR( name:String, ir:IRIfc )
    {
        setIR( dr.indexOfName( name ), ir: ir )
    }

    
    var count: Int
    {
        return dr.count
    }
    
    
    func format( depth:Int ) -> String
    {
        let pad1 = Pad( depth )
        let pad2 = "\n"  + Pad( depth + 1 )
        
        var s = ""
        
        s += "struct \( dr.name )\n" + pad1 + "{"
        
        for i in 0..<count
        {
            s += pad2 + "\( getNameAt(i) ) = \( getValueAt( i ).format(depth+1) )"
        };
        s += "\n" + pad1 + "}\n"
        
        return s
    }
    
    
    
    var desc: String
    {
         return format(0)
    }
    
    func getDR() -> DRIfc
    {
        return self.dr
    }

    
}







