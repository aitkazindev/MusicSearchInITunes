//
//  ITunesmusic.swift
//  MusicSearchInITunes
//
//  Created by Ibrahim Aitkazin on 08.06.2022.
//

import UIKit
import SwiftyJSON
class ITunesmusic {
    
    var TrackName = ""
    var ArtistName = ""
    var ArtWork = ""
    var PreviewUrl = ""
    
    init(){
        
    }
    
    init(json: JSON){
        if let temp = json["artistName"].string {
            ArtistName = temp
        }
        if let temp = json["trackName"].string {
            TrackName = temp
        }
        if let temp = json["artworkUrl100"].string {
            ArtWork = temp
        }
        if let temp = json["previewUrl"].string {
            PreviewUrl = temp
        }
    }

}
