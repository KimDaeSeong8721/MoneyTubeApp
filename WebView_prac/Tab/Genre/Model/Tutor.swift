//
//  Tutor.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//



import Foundation

class Tutor: Identifiable {
    
    
    var id = UUID()
    @objc dynamic var sort : String = ""
    @objc dynamic var imageName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var headline: String = ""
   

   init(sort : String , imageName : String , name: String,headline: String ) {
        self.sort = sort
        self.imageName = imageName
        self.name = name
        self.headline = headline
    }
   
}

 

//class TutorData : Object {
//    var economicData = RealmSwift.List<Tutor>()
//    var psychologyData = RealmSwift.List<Tutor>()
//    var programmingData = RealmSwift.List<Tutor>()
//    var englishData = RealmSwift.List<Tutor>()
//
//
//
//
//}

#if DEBUG
let econmicData = [
    Tutor(sort: "경제유튜버 ",imageName: "lifehacker",name: "자청", headline: "연봉10억, 자수성가 청년"),
    Tutor(sort: "경제유튜버 ",imageName:"sinsaimdang",name: "신사임당", headline: "구독자 126만명 경제유튜버")
   
]

let psychologyData = [
    Tutor(sort: "심리유튜버 ",imageName: "jordan",name: "조던피터슨의 일기장", headline: "캐나다의 임상심리학자이자 토론토대학교의 심리학 교수"),
    Tutor(sort: "심리유튜버 ",imageName:"sinsaimdang",name: "생각에관한 생각", headline: "구독자 126만명 경제유튜버")
   
]

let programmingData = [
    Tutor(sort: "프밍유튜버 ",imageName: "nomadcoder",name: "노마드코더", headline: "콜롬비아인 니꼴라스의 프로젝트 노마드 코더" ),
    Tutor(sort: "프밍유튜버 ",imageName:"jocoding",name: "조코딩", headline: "누구나 배울 수 있는 쉬운 코딩채널")
   
]

let englishData = [
    Tutor(sort: "영어유튜버 ",imageName: "lifehacker",name: "노마드코더", headline: "연봉10억, 자수성가 청년"),
    Tutor(sort: "영어유튜버 ",imageName:"sinsaimdang",name: "영어학자", headline: "구독자 126만명 경제유튜버")
   
]


let totalData = [econmicData, psychologyData, programmingData, englishData]

#endif

