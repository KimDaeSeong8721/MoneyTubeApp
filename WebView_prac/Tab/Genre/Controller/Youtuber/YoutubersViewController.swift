//
//  YoutubersViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//

import UIKit



class YoutubersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var tableView2: UITableView!
    
    var youtubersKindIndex : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView2.register(nibName, forCellReuseIdentifier: "YoutuberCell")
       
        tableView2.delegate = self
        tableView2.dataSource = self
    }
    func custominit(youtubersKindIndex : Int){
        self.youtubersKindIndex = youtubersKindIndex
        self.title = totalData[youtubersKindIndex][0].sort
    }
    // MARK: - Table view data source

 
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return totalData[youtubersKindIndex].count
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberCell", for: indexPath) as! TableViewCell

        // Configure the cell...
        let tutor = totalData[youtubersKindIndex]
        cell.imageview.image = UIImage(named: tutor[indexPath.row].imageName)
        cell.mainText.text = tutor[indexPath.row].name
        cell.subText.text = tutor[indexPath.row].headline
        return cell
    }


   
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let videoView = VideoViewController()
//        let tutor = totalData[youtubersKindIndex]
//        videoView.custominit(selectedYoutuer: tutor[indexPath.row].imageName, youtuberName: tutor[indexPath.row].name)
//
//        self.navigationController?.pushViewController(videoView, animated: true)
//
        performSegue(withIdentifier: "show2", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show2"{
            
            let vc = segue.destination as? VideoViewController
            let index = sender as! Int
            let tutor = totalData[youtubersKindIndex]
            vc?.custominit(selectedYoutuer: tutor[index].imageName, youtuberName: tutor[index].name)
        }
    }




}



//
