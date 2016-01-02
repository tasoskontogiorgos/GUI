//
//  Stack.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/17/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Foundation




struct Frame
{
    let dr: DRIfc
    var ir: IRIfc
    var index: Int
    
    init( dr: DRIfc, index: Int )
    {
        self.dr = dr
        self.ir = dr.produceIR()
        self.index = index
    }
    
    init( dr: DRIfc, ir:IRIfc, index: Int )
    {
        self.dr = dr
        self.ir = ir
        self.index = index
    }
    
    
}

struct Stack<Element> {
    
    var items = [Element]()
    
    mutating func push(item: Element)
    {
        items.append(item)
    }
    
    mutating func pop() -> Element
    {
        return items.removeLast()
    }
    
    func top() -> Element
    {
        return items.last!
    }
    
    func size() -> Int
    {
        return items.count
    }
}


class MDDStack
{
    var stack:Stack< Frame > = Stack()
    
    
    init( dr: DRIfc )
    {
        let frame = Frame( dr:dr, index:-1)
        stack.push( frame )
    }
    
    init( ir: IRIfc )
    {
        let frame = Frame( dr:ir.getDR(), ir:ir, index:-1)
        stack.push( frame )
    }

    
    func pushByIndex( index:Int )
    {
        let top = stack.top()
        let dr = top.dr.getDR( index )
        let ir = top.ir.getIR(index )
        
        let newFrame = Frame( dr: dr, ir: ir, index: index )
        stack.push( newFrame )
    }
    
    
    func pushByName( name:String )
    {
        let top = stack.top()
        let dr = top.dr
        let index = dr.indexOfName( name )
        pushByIndex( index )
        
    }
    
    func pop() -> Frame
    {
        let oldTop = stack.pop()
        let newTop = stack.top()
        let ir = newTop.ir
        
        ir.setIR( oldTop.index, ir: oldTop.ir )
        return oldTop
        
    }
    
    func size() -> Int
    {
        return stack.size()
    }
    
    
    func top() -> Frame
    {
        let t = stack.top()
        
        return t
        
    }

}

