//
//  TrayViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/07.
//


//
//  VideoViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//
import Combine
import UIKit
import youtube_ios_player_helper
import RealmSwift
import SwipeCellKit
import Alamofire
class TrayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate  {
    
    static var video_title = ""
    let realm = try! Realm()
    let key = "AIzaSyBTvYDjxyJ2fEpKlInopW2Dde4kpruB6PI"

    @IBOutlet weak var trayTableView: UITableView!
    
    
    var likeThem_count = 0
    
    
    @IBAction func plusPressed(_ sender: Any) {
        performSegue(withIdentifier: "webShow", sender: nil)
    }
   
    var data = Data()
    var selectedYoutuer: String!
    var youtuberName : String!
    
    // 이부분이 중요함. 배울 점 이 잇네
    var selectedPlayList: PlayList? {
        didSet {
           loadItems()
           // trayTableView.reloadData()
        }
    }
    var toLikeItems: Results<Item>?
   
    func loadItems() {
        if let items = selectedPlayList?.items{
            toLikeItems = items.sorted(byKeyPath: "video_id")//??
       // trayTableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        likeThem_count = toLikeItems?.count ?? 0
        let nibName = UINib(nibName: "ItemViewCell", bundle: nil)
        trayTableView.register(nibName, forCellReuseIdentifier: "itemViewCell")
        
        trayTableView.delegate = self
        trayTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (likeThem_count != toLikeItems?.count){
            trayTableView.reloadData()
            likeThem_count = toLikeItems!.count
            print("추가됨")
        }
        else{
            print("추가안됨")
        }
    }
    
    func custominit(selectedYoutuer : String, youtuberName : String){
        self.selectedYoutuer = selectedYoutuer
        self.youtuberName = youtuberName
      //  self.title = youtuberName
    }
    
    // MARK: - Table view data source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return selectedPlayList?.items.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemViewCell", for: indexPath)
            as! ItemViewCell
        
        if let item = toLikeItems?[indexPath.row] {
            print(item)
            cell.itemTitle.text = item.video_title
           
        cell.itemThumbNail.image = UIImage(systemName: "photo")
            let url = URL(string: "https://img.youtube.com/vi/\(item.video_id)/0.jpg")
           
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
         //   self.getVideoTitle(id: item.video_id)
            
            DispatchQueue.main.async {
                cell.itemThumbNail.image = UIImage(data: data!)
                
            }

        }
            }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        
//        let cell_forSwipe = cell as! SwipeTableViewCell
//        cell_forSwipe.delegate = self
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toLikeItems?[indexPath.row] {
            
        performSegue(withIdentifier: "trayShow", sender: indexPath.row)
        
        //        let Storyboard = UIStoryboard(name: "Player", bundle: nil)
        //
        //        let youtubeplayer = Storyboard.instantiateViewController(withIdentifier: "Player")
        
        //as! VideoPlayer
        
        //  youtubeplayer.custominit(youtubeId: dict[selectedYoutuer]![indexPath.row].video_id)
        
        
        //  present(youtubeplayer, animated: true, completion: nil)
        //self.navigationController?.pushViewController(youtubeplayer, animated: true)
        }
            tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //스와이프를 위한 테이블 뷰메소드
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                if let itemForDeletion = self.selectedPlayList?.items[indexPath.row]{
                    do{
              
                        try! self.realm.write{
                           
                            print(itemForDeletion)
                            self.realm.delete(itemForDeletion)
                        }
                    }catch{
                        print("Error deleting item,\(error)")
                    }
                    tableView.reloadData()
                  
               
                }
            }

            // customize the action appearance
            deleteAction.image = UIImage(systemName: "trash.fill")

            return [deleteAction]
    }
    // 끝까지 스와이프하는 메소드
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        //options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trayShow" {
            let vc = segue.destination as? VideoPlayer
            let index = sender as! Int
            vc?.videoID = toLikeItems?[index].video_id
        }
        if segue.identifier == "webShow" {
            let vc2 = segue.destination as? WebViewController
            vc2?.selectedPlayList = self.selectedPlayList
        }
    }
    
    func remoteImage(url : String)->UIImage?{
        var imagea : UIImage?
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }
        
        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            DispatchQueue.global().async { [weak self] in
                if let data = try? data {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imagea = image
                            
                        }
                    }
                }
            }
            
            
            
        }.resume()
            return imagea
        }
    
    
//    func getVideoTitle(id : String){
//        
//        AF.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: ["part":"snippet","id":id,"key": key], encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
//            if let err = dataResponse.error {
//                print("Failed to contact server", err)
//                return
//            }
//            guard let data = dataResponse.data else {return}
//            do {
//
//
//                   let decoded = try JSONDecoder().decode(Result.self, from: data)
//                  
//
//
//                  
//                   //since the items is array we take first for now
//                   if  let firstItem = decoded.items.first {
//                       //to print the first one
//                       print(firstItem.snippet.title) // "fouseyTUBE"
//                    self.videotitle = firstItem.snippet.title
//                       //same for URL
//            
//                   }
//
//
//               } catch {
//                   debugPrint("\(error.localizedDescription)")
//               }
//            
//        }
  // }
    
}

struct PageInfo: Decodable {
    var totalResults = 0
    var resultsPerPage = 0
}


struct Snippet: Decodable {
    var channelId = ""
    var title = ""
    var description = ""
    var channelTitle = ""
    var thumbnails: Thumbnail
}


struct ChannelURL: Decodable {
    var url = ""
}

struct Thumbnail: Decodable {
    var medium: ChannelURL
    var high: ChannelURL
}

struct Item1: Decodable {
    var kind = ""
    var etag = ""
    var snippet: Snippet

}


struct Result: Decodable {
    var kind = ""
    var etag = ""
    var pageInfo: PageInfo
    var items: [Item1]
}
