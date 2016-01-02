//
//  DRs.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/12/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation



class DRPrim : DRIfc
{
    var kind:PrimitiveKind
    
    func kindName() -> String { return "Primitive" }
    
    func shortDesc() -> String {
        return name
    }

    
    var desc : String
        {
            return "Primitive(\( kind.nameOf()))"
    }
    
    func size() -> Int
    {
        return 0
    }
    
    func format( depth:Int ) -> String
    {
        let s = desc
        return s
    }
    func getDR( index:Int )-> DRIfc
    {
        return self // Hmmm ....
    }
    func getDR( name:String )-> DRIfc
    {
        return self // Hmmm ....
    }
    
    func indexOfName( name:String ) -> Int
    {
        return 0; // Hmmm ...
    }
    
    func getName() -> String
    {
        return name
    }
    
    func getNameAt( index : Int ) -> String
    {
        return "Value" // hmmmm ....
    }

    
    var name: String
    {
        return kind.nameOf()
    }
    
    init(kind:PrimitiveKind)
    {
        self.kind = kind
    }
    
    
    func isType() -> Bool
    {
        return true
    }
    func isPrimitive() -> Bool
    {
        return true;
    }
    
    func produceIR() -> IRIfc
    {
        return IRPrim( dr: self )
    }

    
}


class IRPrim : IRIfc
{
    var dr: DRPrim
    var _value: AnyObject
    
    
    func kindName() -> String { return "Primitive" }
    
    func shortDesc() -> String {
        return desc
    }
    
    func size() -> Int {
        return dr.size()
    }
    
    var desc : String
    {
        return "\(dr.name)(\(self._value))"
    }
    
    func format( depth:Int ) -> String
    {
        let s = desc
        return s
    }

    func getIR( index:Int )-> IRIfc
    {
        return self // Hmmm ....
    }
    func getIR( name:String )-> IRIfc
    {
        return self // Hmmm ....
    }


    
    init( dr:DRPrim )
    {
        self.dr = dr;
        switch self.dr.kind
        {
            
        case PrimitiveKind.float:
            
            self._value = Float( 0.0 )
            
        case PrimitiveKind.int:
            
            self._value = Int( 0 )
            
        case PrimitiveKind.string:
            
            self._value = ""
            
        case PrimitiveKind.date:
            
            self._value = "1/1/2000"
            
        case PrimitiveKind.double:
            
            self._value = Double( 0.0 )
            
            
        }
        
    }
    
    func getDR() -> DRIfc {
        return self.dr
    }
    
    func setIR( index:Int, ir:IRIfc )
    {
        print( "Error !" )
    }
     
    func setIR( name:String, ir:IRIfc )
    {
        print( "Error !" )
    }
    
    var value: AnyObject
    {
        get {
            
            return self._value
            
        }
        
        set {
            
            if newValue is String
            {
                let str = newValue as! String
                if self.dr.kind == PrimitiveKind.int
                {
                    self._value = Int( str )!
                    return
                }
                
                if self.dr.kind == PrimitiveKind.float
                {
                    self._value = Float( str )!
                    return
                }
                if self.dr.kind == PrimitiveKind.double
                {
                    self._value = Double( str )!
                    return
                }
                if self.dr.kind == PrimitiveKind.string
                {
                    self._value = str
                    return
                }
                 
                if newValue is String && self.dr.kind == PrimitiveKind.date
                {
                    self._value = newValue
                    return
                }

            }
            
            if newValue is Int && self.dr.kind == PrimitiveKind.int
            {
                self._value = newValue
                return
            }
            
            if newValue is Float && self.dr.kind == PrimitiveKind.float
            {
                self._value = newValue
                return
            }
            if newValue is Double && self.dr.kind == PrimitiveKind.double
            {
                self._value = newValue
                return
            }
            if newValue is String && self.dr.kind == PrimitiveKind.string
            {
                self._value = newValue
                return
            }
            if newValue is String && self.dr.kind == PrimitiveKind.string
            {
                self._value = newValue
                return
            }
            if newValue is String && self.dr.kind == PrimitiveKind.date
            {
                self._value = newValue
                return
            }

            print( "Error !" )
        }
        
    }
}