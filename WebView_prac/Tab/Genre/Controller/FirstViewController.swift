//
//  FirstViewController.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/01/31.
//
import UIKit
import Foundation

class FirstViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView0: UITableView!
    var GenreArray = [["경제유튜브","person"],["투자유튜브","list.bullet"],["심리유튜브","bookmark"],["프밍유튜브","bubble.left"]]
  
    

    override func viewDidLoad() {
       
        tableView0.delegate = self
        tableView0.dataSource = self
        


     

        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nibName = UINib(nibName: "GenreViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "GenreCell")
        return GenreArray.count
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreViewCell
        
        
       
//        let cell: TableViewCell = tableView.dequeueReusableCellWithReuseIdentifier(myCellIdentifier, forIndexPath: indexPath) as! TableViewCell
//        let nvc: UINavigationController = UIStoryboard(name: "myStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("myNavigationController") as! UINavigationController
//        cell.myViewController = nvc.childViewControllers.first as! MyViewController
//
//        
       
        cell.genreTitle.text = GenreArray[indexPath.row][0]
       
        
 
     

        
        
       
    
        
     
      
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

//        let youtubersView = YoutubersViewController()
//        youtubersView.custominit(youtubersKindIndex: indexPath.row)
//        self.navigationController?.pushViewController(youtubersView, animated: true)
//
        
        
        performSegue(withIdentifier: "show1", sender: indexPath.row)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show1"{
            
            let vc = segue.destination as? YoutubersViewController
            
            let index = sender as! Int
            vc?.custominit(youtubersKindIndex: index)
        }
    }
   
    
}



