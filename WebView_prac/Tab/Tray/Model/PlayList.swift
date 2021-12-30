//
//  PlayList.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/09.
//

import Foundation
import RealmSwift

class PlayList : Object {
    
    @objc dynamic var name = ""
    
    var items = List<Item>()
}
