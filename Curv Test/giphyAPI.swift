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
 - getMoreTrendingGifs: A function to add to the current Trending gifs
 - getMoreSearchedGifs: A function to add to the current amount of Searched gifs
  
 */


class GiphyApi : ObservableObject{
    
    @Published var trendingResponse = TrendingResponse(data: [TrendingData(type: "", url: "", title: "")])
    @Published var isFinished: Bool = false
    @Published var doneSearching: Bool = false
    @Published var localURL: URL =  URL(string:"nothing")!
    @Published var lastTrendingGif: Int = 25
    @Published var lastSearchedGif: Int = 25
    
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
    
    
    /**
     A function that sends a request to the Giphy API to get the latest trending gifs and parses the response
     
     - throws:
        An error when the JSON fails to be decoded
     */
    
    func getTrendingGifs(){
        self.isFinished = false
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&limit=25&rating=pg-13")! // force unwraps url because we know its a valid unchanging string as an input
    
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
         An error when the JSON fails to be decoded
         */
        
    func getSearchedGifs(query: String){
        
        self.isFinished = false
        self.doneSearching = false
        
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&limit=25&offset=0&rating=g&lang=en")! /// force unwraps url because we know its a valid string. Also percent encoding allows for searching strings with spaces like "Dance Dance Revolution"
    
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
                    self.doneSearching = true
                    self.isFinished = true
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
     A function that sends a request to the Giphy API to get more gifs afteers a certain offset and adds it to the Trending Response
     
     - parameters:
     - throws:
     An error when the JSON fails to be decoded
     */
    func getMoreTrendingGifs(){
        
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&limit=25&rating=pg-13&offset=\(self.lastTrendingGif)")! /// force unwraps url because we know its a valid unchanging string as an input
    
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
                    let moreTrendingResponses = try JSONDecoder().decode(TrendingResponse.self, from: data)
                    self.trendingResponse.data.append(contentsOf: moreTrendingResponses.data)
                    self.lastTrendingGif += 25
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
    A function that sends a request to the Giphy API to get more gifs related to a users search after a certain offset and adds it to the Trending Response
    
    - parameters:
       - query: A string to search the giphy api with
    - throws:
    An error when the JSON fails to be decoded
    */
    
    func getMoreSearchedGifs(query: String){
        
        /// force unwraps url because we know its a valid unchanging string as an input
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=pAV7WsmKVwCuuLZPS0d3X3180xqW0rma&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))&limit=25&offset=\(self.lastSearchedGif)&rating=g&lang=en")!
    
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
                    let moreTrendingResponses = try JSONDecoder().decode(TrendingResponse.self, from: data)
                    self.trendingResponse.data.append(contentsOf: moreTrendingResponses.data)
                    self.lastSearchedGif += 25
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

extension URL {
    
    
    /// A function that downloads a gif and saves it to the application to persist after the app closes
    /// - Parameters:
    ///   - directory: A directory to save a gif
    ///   - fileName: The name to save the gif as
    ///   - completion: A completion handler that return the destination the gif was saved in, or an error
    /// - Throws: An Error if the task is unable to be downloaded/removed from the directory its saved in
    
    func download(to directory: FileManager.SearchPathDirectory, fileName: String? = nil, completion: @escaping (URL?, Error?) -> Void) throws {
        let directory = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        var destination: URL
        
        /// Creates the destination path for each favourited gif
        if let fileName = fileName {
            print("File Name: \(fileName)")
            destination = directory
                .appendingPathComponent(fileName)
            print(destination.lastPathComponent, self.pathExtension)
        } else {
            destination = directory
            .appendingPathComponent(lastPathComponent)
        }
        
        /// If file exists i.e is already in favourites delete it
        if (FileManager.default.fileExists(atPath: destination.path)) { completion(destination, nil)
            if FileManager.default.fileExists(atPath: destination.path) {
                try FileManager.default.removeItem(at: destination)
            }
            return
        }
        
        ///Downloads the gif and moves it to the destination directory
        URLSession.shared.downloadTask(with: self) { location, _, error in
            guard let location = location else {
                completion(nil, error)
                return
            }
            do{
                destination.appendPathExtension(self.pathExtension)
                try FileManager.default.moveItem(at: location, to: destination)
                print("Destination: \(destination)")
                completion(destination, nil)
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
