//
//  AthleanX_TableViewController.swift
//  youtube_Data_API
//
//  Created by Calvin Lee on 2023/4/7.
//

import UIKit

class AthleanX_TableViewController: UITableViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var allVideos = [Video]()
    var favoriteVideos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        tableView.rowHeight = 300
        
    }
    
    
    // MARK: - Fetch function
    
    func fetchItems() {
        _ = "[YOUR_API_KEY]" //let apikey = "[YOUR_API_KEY]"
        let urlString = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=UUe0TLA0EsQbE-MjuHXevj2A&key=A[YOUR_API_KEY]"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                        var newVideos: [Video] = []
                        for item in searchResponse.items{
                            let video = Video(title: item.snippet.title,
                                              videoId: item.snippet.resourceId.videoId,
                                              thumbnailUrl: item.snippet.thumbnails.standard.url)
                            
                            newVideos += [video]
                        }
                        self.allVideos = newVideos
                        DispatchQueue.main.sync {
                            self.tableView.reloadData()
                        }
                        print("get Data")
                    } catch {
                        print("error")
                    }
                }
            }.resume()
            print("function dataTask執行完會先回傳task，然後呼叫task的resume啟動它")
        }
    }
    
    
    
    
    // MARK: - Button & Segmented control
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        allVideos[sender.tag].favorite = !allVideos[sender.tag].favorite
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    
    @IBAction func changeSegmentControl(_ sender: UISegmentedControl) {
        segmentedControl.selectedSegmentIndex = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view Cell
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return allVideos.count
        } else {
            favoriteVideos = allVideos.filter({$0.favorite})
            return favoriteVideos.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleanXTableViewCell", for: indexPath) as! AthleanX_TableViewCell
        var video: Video
        if segmentedControl.selectedSegmentIndex == 0  {
            video = allVideos[indexPath.row]
        } else {
            video = favoriteVideos[indexPath.row]
        }
        
        cell.videoTitle.text = video.title
        cell.likeButton.imageView?.image = video.favorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.likeButton.tag = indexPath.row
        cell.videoImage.image = UIImage(systemName: "video.circle.fill")
        URLSession.shared.dataTask(with:
                                    video.thumbnailUrl) { data, response, error in
            if let data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.videoImage.image = image
                }
            }
        }.resume()
     return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let videoVC = segue.destination as? Video_ViewController {
            let selectedRow = tableView.indexPathForSelectedRow
            if let passIndex = selectedRow?.row {
                videoVC.index = passIndex
                videoVC.data = allVideos
            }
        }
    }
    
    

}
