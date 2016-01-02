//
//  Model.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/10/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation


let Result = "@result"


enum PrimitiveKind
{
    case int
    case double
    case float
    case string
    case date
    
    func nameOf() -> String
    {
        switch self
        {
            
        case .int: return "int"
        case .double: return "double"
        case .date: return "date"
        case .float: return "float"
        case .string: return "string"
            
        }
    }
    
    static let allValues:[PrimitiveKind] = [.int, .double, .float, .string, .date ]
}

enum Kind
{
    case PrimitiveDR, PrimitiveIR
    case StructDR, StructIR
    case FuncDR, FuncIR
    case SeqDR, SeqIR
    case DictDR, DictIR
    case IfcDR, IfcIR
    
}

struct TypedName
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

struct Member
{
    
    let typedName:TypedName
    let dr:DRIfc
    
    init( name:String, type: String )
    {
        self.typedName = TypedName( name: name, type: type)
        self.dr = Types.GetType(type)
    }
    
    init( name:String, type: String, dr:DRIfc )
    {
        self.typedName = TypedName( name: name, type: type)
        self.dr = dr
    }
    
    init( name:String, dr:DRIfc )
    {
        self.typedName = TypedName( name: name, type: dr.getName() )
        self.dr = dr
    }
    
    
    var desc: String
    {
            return "(\(self.typedName.desc)";
    }
}


struct Members
{
    var seq: [ Member ] = []
    var map: [ String: Member ] = [:]
    var n2i: [ String: Int ] = [:]
    
    mutating func add( member:Member )
    {
        let name = member.typedName.name
        if( hasMemberAt( name ))
        {
            print( "duplicate definition: \( member.typedName.name )" )
            return
        }
        let i = seq.count
        seq.append( member )
        map[ name ] = member
        n2i[ name ] = i        
    }
    
    func indexOfName( name : String ) -> Int
    {
        let x = n2i[ name ]
        if let y = x
        {
            return y
        }
        print( "unkown name : \( name )" )
        return -1
    }
    
    func hasMemberAt( name: String ) -> Bool
    {
        return !( map[ name ] == nil )
    }
    
    func getNameAt( index: Int ) -> String
    {
        return seq[ index ].typedName.name;
    }

    func getTypeNameAt( index: Int ) -> String
    {
        return seq[ index ].typedName.type;
    }
    
 
    
    func memberAt( index: Int ) -> Member
    {
        return seq[ index ]
    }
    
    func memberAt( name: String ) -> Member
    {
        if map[ name ] == nil
        {
            print( "unknown member : \"\( name )\"")
        }
        return map[ name  ]!
    }
    
    var count : Int
    {
        return seq.count
    }
    
    var desc: String
    {
        var r = ""
        
        for m in seq
        {
            r += "\( m.desc );"
        }
        return r
    }
}

protocol MDDObject
{
    func Kind() -> MDD.Kind
    func desc() -> String
}


protocol DRIfc
{
    func kindName() -> String
    func shortDesc() -> String
    func size() -> Int
    func isType() -> Bool
    func isPrimitive() -> Bool
    func produceIR() -> IRIfc
    func getName() -> String
    func getNameAt( index:Int ) -> String
    func format( depth:Int) -> String
    func getDR( index:Int )-> DRIfc
    func getDR( name:String )-> DRIfc
    func indexOfName( name: String ) -> Int
    var desc: String { get }
}


protocol IRIfc
{
    func kindName() -> String
    func shortDesc() -> String
    func size() -> Int
    func getDR() -> DRIfc
    var desc: String { get }
    func format( depth:Int) -> String
    func getIR( index:Int )-> IRIfc
    func getIR( name:String )-> IRIfc
    func setIR( index:Int, ir:IRIfc )
    func setIR( name:String, ir:IRIfc )
}

protocol IfcImpl
{
    func Call( obj:IRFunc ) 
    func getDR() -> DRInterface
}



 