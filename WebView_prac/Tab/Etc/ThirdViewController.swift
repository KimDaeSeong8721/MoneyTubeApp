//
//  ViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/01/31.
//

import UIKit
import WebKit
import youtube_ios_player_helper
import Alamofire
class ThirdViewController: UIViewController, YTPlayerViewDelegate{

@IBOutlet weak var ytp: YTPlayerView!
    let key = "AIzaSyBTvYDjxyJ2fEpKlInopW2Dde4kpruB6PI"
    var title2 : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getVideoTitle(id: "eFEMqPnhY7o")

       // ytp.load(withVideoId: "2gFLaGislp4")
    }
    func getVideoTitle(id : String){
        
        AF.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: ["part":"snippet","id":id,"key": key], encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact server", err)
                return
            }
            guard let data = dataResponse.data else {return}
            do {


                   let decoded = try JSONDecoder().decode(Result.self, from: data)
                   debugPrint(decoded)


                  
                   //since the items is array we take first for now
                   if  let firstItem = decoded.items.first {
               
                
                    self.title2 = firstItem.snippet.title
                    print(self.title2)

              
                   }


               } catch {
                   debugPrint("\(error.localizedDescription)")
               }
            
        }
    }
}

