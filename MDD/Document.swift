//
//  Document.swift
//  MDD
//
//  Created by Tasos Kontogiorgos on 10/10/15.
//  Copyright © 2015 Tasos Kontogiorgos. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    @IBOutlet var arrC: NSArrayController!
    
    var ge: GenEditor?
    var te: TableEditor?
    @IBOutlet weak var Table: NSTableView!
    
    @IBAction func rowSelected(sender: AnyObject) {
        
         let name = apps[ Table.selectedRow].name
        
        
        let ifc = ( name == "Calc") ? Calc().ifc : Calc2().ifc
        let ir = ifc.produceIR()
        ge = GenEditor(windowNibName: "GenEditor")
        ge!.set(ir)
        
        te = TableEditor(windowNibName: "TableEditor")
        te!.set( ir )
        
        ge!.showWindow(self)
        te!.showWindow(self)
    }
    
    
    
    class App : NSObject
    {
        let name: String
        
        init( name: String )
        {
            self.name = name
        }
    }
    
    let apps:[App] = [
        App(name:"Calc" ),
        App(name:"Calc2" ),
    ]
   
    
    
       
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
        
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        
        arrC.content = apps

    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}
