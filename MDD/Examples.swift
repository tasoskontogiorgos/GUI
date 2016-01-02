//
//  Examples.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/28/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation


struct FormalArg
{
    let name:String
    let type:String
    
    init( type:String, name:String )
    {
        self.type = type
        self.name = name
    }
}


struct FuncDecl
{
    let function : DRFunc
    
    init( resultType:String, name:String, formals:[ FormalArg ])
    {
        
        function = DRFunc( name: name, resultType: resultType )
        for arg in formals
        {
            function.add( Member( name: arg.name, type: arg.type ))
        }
        function.promote()
    }
}

struct StructMem
{
    let name:String
    let type:String
    
    init( type:String, name:String )
    {
        self.type = type
        self.name = name
    }
}

struct Structure
{
    let structure:DRStruct
    
    init( name:String, members:[StructMem])
    {
        structure = DRStruct( name: name )
        for m in members
        {
            structure.add( Member( name: m.name, type: m.type ))
        }
        structure.promote()
        
    }
}




class CalcImpl : IfcImpl
{
    let add:DRFunc
    let mult:DRFunc
    let ifc:DRInterface
    
    let origin_x:IntAcc
    let origin_y:IntAcc
    let corner_x:IntAcc
    let corner_y:IntAcc
    let scalar:DoubleAcc
    
    init( rectName:String)
    {
        let _ = Structure( name:"Point", members:[
            StructMem( type: "int", name: "x"),
            StructMem( type: "int", name: "y"),
            ])
        let _ = Structure( name:rectName, members:[
            StructMem( type: "Point", name: "origin"),
            StructMem( type: "Point", name: "corner"),
            ])

        
        add = FuncDecl( resultType: rectName, name: "add", formals: [
            FormalArg( type: rectName, name: "left"),
            FormalArg( type: rectName, name: "right"),
        ]).function
        mult = FuncDecl( resultType: rectName, name: "mult", formals: [
                FormalArg( type: rectName, name: "rect"),
                FormalArg( type: "double", name: "scalar"),
        ]).function
        
        ifc = DRInterface( name: "Calc" )
        
        ifc.add( add )
        ifc.add( mult )
        
        let rectDR = Types.GetType(rectName)
        
        origin_x = IntAcc( dr: rectDR, acc: "origin.x")
        origin_y = IntAcc( dr: rectDR, acc: "origin.y")
        corner_x = IntAcc( dr: rectDR, acc: "corner.x")
        corner_y = IntAcc( dr: rectDR, acc: "corner.y")
        
        scalar = DoubleAcc( dr:mult, acc: "scalar" )
        
        ifc.impl = self

        
        
    }
    
    
    func getDR() -> DRInterface
    {
        return ifc
    }
    
    func Call( obj:IRFunc)
    {
        switch obj.getDR().getName()
        {
        case "add":
            
            let left = obj.getIR("left" )
            let right = obj.getIR("right" )
            
            let res = left.getDR().produceIR()
            
            
            origin_x.set(res, v: origin_x.get( left) + origin_x.get( right ))
            origin_y.set(res, v: origin_y.get( left) + origin_y.get( right ))
            corner_x.set(res, v: corner_x.get( left) + corner_x.get( right ))
            corner_y.set(res, v: corner_y.get( left) + corner_y.get( right ))
            
            
            obj.result = res
            
            
            return
            
         
            
            
        default:
            
            let rect = obj.getIR("rect" )
            let res = rect.getDR().produceIR()
            let x = Int( scalar.get( obj ))
            
            
            origin_x.set(res, v: origin_x.get( rect) * x )
            origin_y.set(res, v: origin_y.get( rect) * x )
            corner_x.set(res, v: corner_x.get( rect) * x )
            corner_y.set(res, v: corner_y.get( rect) * x )

            obj.result = res
            return 
            
        }
    }
}



class Calc : CalcImpl
{
    init() {
        super.init(rectName: "Rect")
    }
}

class Calc2 : CalcImpl
{
    init() {
        super.init(rectName: "Rect2")
    }
}




