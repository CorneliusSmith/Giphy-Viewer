//
//  giphyAPI.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit
//import SwiftUI

/**
 A class to query the GiphyApi
 
 # Available Structs
 - trendingResponse: A struct that holds an array of Trending Data
 - trendingData: A struct to hold the JSON response from the Giphy API
 
 # Available Functions
 - getTrendingGifs: A function that sends a request to the Giphy API to get the latest trending gifs
 - getSearchedGifs: A function to get all gifs related to a users search 
  
 */


class GiphyApi : ObservableObject{
    
    @Published var trendingResponse = TrendingResponse(data: [TrendingData(type: "", url: "", title: "")])
    @Published var isFinished: Bool = false
    @Published var doneSearching: Bool = false
    
    /**
    A function that sends a request to the Giphy API to get the latest trending gifs and parses the response
    
    # Variables:
     - data: An array of TrendingData structs
     
    */
    struct TrendingResponse:Decodable{
        var data: [TrendingData]
    }
    
    /**
    A function that sends a request to the Giphy API to get the latest trending gifs and parses the response
    
    # Variables:
     - type: A string that says the type of media returned from Giphy (almost always a .gif)
     - url: The Giphy url liking to the specific gif
     - title: The title of the returned gif
     
    */
    struct TrendingData:Decodable, Hashable{
        var type: String?
        var url: String?
        var title:String?
        var id: String?
    }
    
//    struct  Images:Decodable{
//        var fixed_width : [FixedWidth]
//    }
//
//    struct FixedWidth:Decodable {
//        var mp4:String
//    }
    
    /**
     A function that sends a request to the Giphy API to get the latest trending gifs and parses the response
     
     - parameters:
        - None
     - throws:
     An error when the JSON fails to be decoded on line 72
     */
    
    func getTrendingGifs(){
        self.isFinished = false
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&limit=2&rating=pg-13")! // force unwraps url because we know its a valid unchanging string as an input
    
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode){} else{
                print("Server Error")
                return
            }

            guard let data = data else{
                print("Error Getting Returned Data")
                return
            }
            
            DispatchQueue.main.async{
                do{
                    self.trendingResponse = try JSONDecoder().decode(TrendingResponse.self, from: data)
                    //print(self.trendingResponse)
                    self.isFinished = true
                    //self.trendingResponse.id = self.trendingResponse.data.count
                }
                catch{
                    print(error)
                    return
                }
            }

        }
        task.resume()
    }
    
    /**
         A function that sends a request to the Giphy API to get the all gifs related to a users search and parses the response
         
         - parameters:
            - query: A string to search the giphy api with
         - throws:
         An error when the JSON fails to be decoded on line 72
         */
        
    func getSearchedGifs(query: String){
        
        self.isFinished = false
        self.doneSearching = false
        
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&q=\(query)&limit=2&offset=0&rating=g&lang=en")! // force unwraps url because we know its a valid unchanging string as an input
    
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode){} else{
                print("Server Error")
                return
            }

            guard let data = data else{
                print("Error Getting Returned Data")
                return
            }
            
            DispatchQueue.main.async{
                do{
                    self.trendingResponse = try JSONDecoder().decode(TrendingResponse.self, from: data)
                    //print(self.trendingResponse)
                    self.doneSearching = true
                    self.isFinished = true
                    //self.trendingResponse.id = self.trendingResponse.data.count
                }
                catch{
                    print(error)
                    return
                }
            }
        }
        task.resume()
    }
    
}

