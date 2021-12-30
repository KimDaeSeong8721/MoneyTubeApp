

import UIKit
import WebKit
import Alamofire
import RealmSwift

class WebViewController: UIViewController {
    
    var selectedPlayList : PlayList?
    let realm = try! Realm()

    var data = Data()
    let key = "AIzaSyBTvYDjxyJ2fEpKlInopW2Dde4kpruB6PI"
    var link  : String? = ""
    // 비디오 주소얻기
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[.newKey] as? Int, let oldValue = change?[.oldKey] as? Int, newValue != oldValue {
            //Value Changed
            print("dsadas\(change?[.oldKey] as! NSObject)")
            
        }else{
            //Value not Changed
            //print(change?[.newKey])
            print("뉴벨류")
            let newValue = change?[.newKey] as? URL
                     
            link = newValue?.absoluteString
            self.searchBar.text = link

          
            
            
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.request(url: "https://m.youtube.com")
        searchBar.text = "https://m.youtube.com"
        webView.configuration.allowsInlineMediaPlayback = true
        webView.allowsBackForwardNavigationGestures = true
       // loadYoutube()//
       
        


    }
    
    

    

    
    
    // 이전 페이지로 이동
    @IBAction func back(_ sender: UIBarButtonItem) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    // 다음 페이지로 이동
    @IBAction func forward() {
        if self.webView.canGoForward {
            self.webView.goForward()
        }
    }

    // 현재 webView에서 받아온 URL 페이지를 로드한다.
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
        self.webView.navigationDelegate = self
        
    }
    
    
    @IBAction func likeIt(_ sender: Any) {
        
        if let currentCategory = self.selectedPlayList {
            do {
                try self.realm.write {
         
                    
                    // 코드 refactor필요함
                    let newItem = Item()
                    if let youtubeId = link?.youTubeId{
                    newItem.video_id = youtubeId
            
                        DispatchQueue.global(qos: .userInitiated).async{
                        self.getVideoTitle(id: youtubeId)
                        }
                    
                        
                        var reduplicationCount = 0
                        
                        
                        for  item in currentCategory.items{
                            
                            if(item.video_id == newItem.video_id){
                                reduplicationCount += 1
                            }
                        }
                        if(reduplicationCount == 0){
                   
                           // newItem.video_title = video_title
                            currentCategory.items.append(newItem)
                        }
                           
                        
               
                    }
                }
                let vc = UIAlertController(title: "추가", message: "찜목록에 추가되었습니다.", preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                present(vc,animated: true)
            
            } catch {
                let vc = UIAlertController(title: "실패", message: "찜목록 실패하였습니다.", preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                present(vc,animated: true)
                print("Error saving new items, \(error)")
            }
        }
      
        
        
        
    }
        
        
        
//        if !(likeThem.contains((link?.youTubeId)!)){
//
//        likeThem.append((link?.youTubeId)!)
//        }
//
//        print(likeThem)
//
//    }
    
    func getVideoTitle(id : String){
        print("타이틀생성중")
        var vdtitle = "ㅗ"
        AF.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: ["part":"snippet","id":id,"key": key], encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact server", err)
                return
            }
            guard let data = dataResponse.data else {return}
            do {


                   let decoded = try JSONDecoder().decode(Result.self, from: data)
                  


                  
                   //since the items is array we take first for now
                   if  let firstItem = decoded.items.first {
                    print("아이템선택됨")
                     
                   vdtitle =  firstItem.snippet.title
                       //same for URL
            
                   }


               } catch {
                   debugPrint("\(error.localizedDescription)")
               }
            
            if let currentCategory = self.selectedPlayList {
                do {
                    try self.realm.write {
                        currentCategory.items.last?.video_title = vdtitle
                    }
                } catch{}
            
            
            }
           
        }
    }
    
}

// searchBar에서 검색하면 searchBar에 입력된 주소를 요청한다.
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색")
        self.request(url: searchBar.text!)

        //다른곳을 터치하면 키보드가 내려갈 수 있도록 한다.
        self.view.endEditing(true)
    }
}

// 현재 웹페이지의 URL을 searchBar에 띄워준다.
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       // self.searchBar.text = webView.url?.absoluteString
     
        webView.addObserver(self, forKeyPath: "URL", options: [.new, .old], context: nil)
       // self.searchBar.text = link
      //  getVideoId()
                }
    
}

extension String {
    var youTubeId: String? {
        let typePattern = "(?:(?:\\.be\\/|embed\\/|v\\/|\\?v=|\\&v=|\\/videos\\/)|(?:[\\w+]+#\\w\\/\\w(?:\\/[\\w]+)?\\/\\w\\/))([\\w-_]+)"
        let regex = try? NSRegularExpression(pattern: typePattern, options: .caseInsensitive)
        return regex
            .flatMap { $0.firstMatch(in: self, range: NSMakeRange(0, self.count)) }
            .flatMap { Range($0.range(at: 1), in: self) }
            .map { String(self[$0]) }
    }
}


