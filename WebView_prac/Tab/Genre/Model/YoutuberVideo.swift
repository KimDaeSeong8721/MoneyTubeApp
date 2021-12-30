
import Foundation
import UIKit


struct YoutuberVideo: Identifiable {
    var id = UUID()
    var title : String
    var video_id : String
    
    
}

let lh_video = [YoutuberVideo(title: "자청 마지막편, 경제적 자유를 얻는 법(라이프해킹 최종편)", video_id: "AUCKb5b5UNs"),
             YoutuberVideo(title: "클루지, 나만 알았다면 더 부자가 됐을텐데....", video_id: "v_ESC-96BKs"),
             YoutuberVideo(title: "연봉 10억을 만들어준 심리학 5개, 4편 뇌욕망의 비밀을 풀다", video_id: "DFbVV-rQxak")
             
]

let si_video = [YoutuberVideo(title: "월 순익 1000만원 올리는 생각법, 한국에는 직업에 귀천이 있습니다.", video_id: "HBt5TqZSuq8"),
             YoutuberVideo(title: "월 순익 1000만원 올리는 구조, 사기꾼이라고 해도 할말 없습니다.", video_id: "hya3YerrEOU"),
             YoutuberVideo(title: "가난에서 빠르게 벗어나는 방법", video_id: "7sEyLvAGbls")
             
]

let jordan_video = [YoutuberVideo(title: "이 강의를 본 순간 당신의 인생이 통째로 바뀔 겁니다", video_id: "2gFLaGislp4"),
             YoutuberVideo(title: "인생에 목표가 없을 때 해야 하는 것 (ft. 인생강의)", video_id: "9txKfEb8o8A"),
             YoutuberVideo(title: "왜 우리는 집중력이 없는가(ft 무의식)", video_id: "8V081wPlCbM")
             
]

let nomad_video = [YoutuberVideo(title: "누구나 코딩을 할 수 있다? 5가지 팩폭 드림.", video_id: "ThGbP9wgkz8"),
             YoutuberVideo(title: "프로그래밍 독학할때 자주 하는 실수 5가지", video_id: "FF6CF8TZIhE"),
             YoutuberVideo(title: "머신러닝 vs 딥러닝 vs 인공지능? A.I. 개념정리!", video_id: "arbbhHyRP90")
             
]

let jocoding_video = [YoutuberVideo(title: "코딩 배워서 앱, 웹 만들고 싶으신가요? 코딩 공부 순서 정리해드립니다.", video_id: "wpUiN5hBnyc"),
             YoutuberVideo(title: "누구나 5분만에 스마트폰 앱 만들기! 웹으로 웹뷰앱을 만들어보자", video_id: "GyXLa-0R_S0"),
             YoutuberVideo(title: "우리가 코딩을 배워야하는 이유는?", video_id: "2yGMgLZQhIY")
]
var dict = ["lifehacker" : lh_video,
            "sinsaimdang" : si_video,
            "jordan" : jordan_video,
            "nomadcoder" : nomad_video,
            "jocoding" : jocoding_video]













