//
//  VideoViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//
import Combine
import UIKit
import youtube_ios_player_helper
class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView3: UITableView!

    var data = Data()
    var selectedYoutuer: String!
    var youtuberName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName = UINib(nibName: "VideoViewCell", bundle: nil)
        tableView3.register(nibName, forCellReuseIdentifier: "VideoCell")
        
        tableView3.delegate = self
        tableView3.dataSource = self
    }
    
    func custominit(selectedYoutuer : String, youtuberName : String){
        self.selectedYoutuer = selectedYoutuer
        self.youtuberName = youtuberName
        self.title = youtuberName
    }
    
    // MARK: - Table view data source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return dict[selectedYoutuer]!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
            as! VideoViewCell
        cell.videoTitle.text = dict[selectedYoutuer]![indexPath.row].title
        cell.thumbNail.image = UIImage(systemName: "photo")
        let url = URL(string: "https://img.youtube.com/vi/\(dict[selectedYoutuer]![indexPath.row].video_id)/0.jpg")
           
      //  cell.thumbNail.image =  remoteImage(url: url )
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.thumbNail.image = UIImage(data: data!)
            }

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "show3", sender: indexPath.row)
        
        //        let Storyboard = UIStoryboard(name: "Player", bundle: nil)
        //
        //        let youtubeplayer = Storyboard.instantiateViewController(withIdentifier: "Player")
        
        //as! VideoPlayer
        
        //  youtubeplayer.custominit(youtubeId: dict[selectedYoutuer]![indexPath.row].video_id)
        
        
        //  present(youtubeplayer, animated: true, completion: nil)
        //self.navigationController?.pushViewController(youtubeplayer, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show3" {
            let vc = segue.destination as? VideoPlayer
            let index = sender as! Int
            vc?.videoID = dict[selectedYoutuer]![index].video_id
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
    
}

