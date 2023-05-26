//
//  Video_ViewController.swift
//  youtube_Data_API
//
//  Created by Calvin Lee on 2023/4/7.
//

import UIKit
import WebKit

class Video_ViewController: UIViewController {

    
    @IBOutlet weak var AthleanWebView: WKWebView!
    
    //前一頁select到的tableview的row的位置
    var index: Int!
    
    //宣告儲存前一頁解析完成的API資料
    var data = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://www.youtube.com/watch?v=\(data[index].videoId)") {
            let request = URLRequest(url: url)
            AthleanWebView.load(request)
        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
