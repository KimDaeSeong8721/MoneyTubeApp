//
//  Item.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/09.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var video_id = ""
    @objc dynamic var video_title = ""
    let parentPlayList = LinkingObjects(fromType: PlayList.self,property : "items")
}
