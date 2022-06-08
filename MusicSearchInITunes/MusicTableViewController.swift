//
//  MusicTableViewController.swift
//  MusicSearchInITunes
//
//  Created by Ibrahim Aitkazin on 08.06.2022.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import SDWebImage

class MusicTableViewController: UITableViewController, UISearchBarDelegate {

    var musicArray: [ITunesmusic] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchArtist = "eminem"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for artist"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        downloadData()

    }
    
    func downloadData(){
        let url = "https://itunes.apple.com/search?term=\(searchArtist.replacingOccurrences(of: " ", with: "+"))&limit=25."
        print(url)
        SVProgressHUD.show()
        
        AF.request(url,method: .get).responseJSON{
            response in
            //print("\(String(describing: response.response))") //HTTP URL response
            //print("\(String(describing: response.data))")
            //print("\(response.result)")
            //print("\(String(describing: response.value))")
            
            if response.response?.statusCode == 200 {
                //print("response.value - \(response.value)")
                
                let json = JSON(response.value!)
                
                if let results = json["results"].array {
                    
                    for track in results {
                        self.musicArray.append(ITunesmusic(json: track))
                    }
                }
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }else{
                SVProgressHUD.dismiss()
            }
        }
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MusicTableViewCell
        
        cell.artistNameLabel.text = musicArray[indexPath.row].ArtistName
        cell.trackNameLabel.text = musicArray[indexPath.row].TrackName
        cell.posterImageView!.sd_setImage(with: URL(string:musicArray[indexPath.row].ArtWork),completed: nil)
        //
        
        //viewcontroller.PreviewUrl =
        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "playerStoryBoard") as! ViewController
        
        viewcontroller.previewurl = musicArray[indexPath.row].PreviewUrl
        
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        searchArtist = searchBar.text!
        musicArray.removeAll()
        tableView.reloadData()
        downloadData()
    }

  

}
