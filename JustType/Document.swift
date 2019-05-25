//
//  Document.swift
//  JustType
//
//  Created by Prudhvi Gadiraju on 5/25/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

enum FileError: Error {
    case invalidData
}

class Document: UIDocument {
    var text: String = ""
    
    override func contents(forType typeName: String) throws -> Any {
        return Data(text.utf8)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let contents = contents as? Data else { throw FileError.invalidData }
        text = String(decoding: contents, as: UTF8.self)
    }
}

