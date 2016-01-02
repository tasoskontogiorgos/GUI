//
//  Utils.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/16/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation



class Accessor
{
    let pos:[Int]
    let leafDr:DRIfc
    
    init( dr:DRIfc, acc:String )
    {
        let names = acc.characters.split{ $0 == "."}.map( String.init)
        var vdr = dr
        var idxs:[Int] = []
        for name in names
        {
            let index = vdr.indexOfName( name )
            idxs.append( index )
            vdr = vdr.getDR(index )
        }
        leafDr = vdr
        pos = idxs
        
    }
    
    func access( irin:IRIfc ) -> IRPrim
    {
        var ir = irin
        for i in pos
        {
            ir = ir.getIR(i)
        }
        return ir as! IRPrim
    }
    
}


class IntAcc : Accessor
{
    override init( dr:DRIfc, acc:String )
    {
        super.init(dr: dr, acc: acc)
        assert( leafDr.getName() == "int" )
    }
    func get(irin:IRIfc) -> Int
    {
         return access(irin).value as! Int
    }
    func set(irin:IRIfc, v:Int)
    {
        access(irin).value = v
    }
}

class DoubleAcc : Accessor
{
    override init( dr:DRIfc, acc:String )
    {
        super.init(dr: dr, acc: acc)
        assert( leafDr.getName() == "double" )
    }
    func get(irin:IRIfc) -> Double
    {
        return access(irin).value as! Double
    }
    func set(irin:IRIfc, v:Double)
    {
        access(irin).value = v
    }
}

class StringAcc : Accessor
{
    override init( dr:DRIfc, acc:String )
    {
        super.init(dr: dr, acc: acc)
        assert( leafDr.getName() == "string" )
    }
    func get(irin:IRIfc) -> String
    {
        return access(irin).value as! String
    }
    func set(irin:IRIfc, v:String)
    {
        access(irin).value = v
    }
}




func Pad( size:Int)->String
{
    var pad = "";
    for _ in 0..<size
    {
        pad += "   "
    }
    return pad;
}