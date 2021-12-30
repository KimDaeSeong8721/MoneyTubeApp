//
//  PlayListViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/09.
//

import Foundation
import UIKit
import RealmSwift
class PlayListViewController : UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var playListTableView: UITableView!
    
    var playLists : Results<PlayList>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
      
        print(Realm.Configuration.defaultConfiguration.fileURL)
        super.viewDidLoad()
        loadplayLists()
        playListTableView.delegate  = self
        playListTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nibName = UINib(nibName: "GenreViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "GenreCell")
        return playLists?.count ?? 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreViewCell
        
        cell.textLabel?.text = playLists?[indexPath.row].name ?? "새로운 플레이 리스트를 추가하세요"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showTray", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTray"{
            
            let vc = segue.destination as? TrayViewController
            
            let index = sender as! Int
            print(index)
            vc?.selectedPlayList = playLists?[index]
        }
    }
    
    
    @IBAction func listPlusPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "새로운 플레이리스트", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "추가", style: .default) { (action) in
            let playlist = PlayList()
            playlist.name = textField.text!
          //  newCategory.colour = UIColor.randomFlat().hexValue()
            self.save(playList: playlist)
            
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
   
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "플레이리스트 이름"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func loadplayLists() {
        
        playLists = realm.objects(PlayList.self)
        playListTableView.reloadData()
    }
    
    func save(playList : PlayList){
        do{
            try! realm.write(){
                realm.add(playList)
                
                playListTableView.reloadData()
            }
            
        }catch{
            print("Error saving category \(error)")
        }
        
    
    }
}
