//
//  AdventureViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//


import Foundation
import SwiftUI

class AdventureViewModel : ObservableObject{
    
    @Published var adventures: [Adventure] = []
    @Published var selectedItem: Adventure? = nil
    
    
    
    
    //backend API call for fetch adventures
    func fetchAdventure(){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/adventures") else {return}
        
        
        //crate  request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        //send request async way
        URLSession.shared.dataTask(with: request){
            data, responce,error in
            if let data = data {
                do{
                    let responce = try JSONDecoder().decode([Adventure].self, from: data)
                    DispatchQueue.main.async{
                        self.adventures = responce
                    }
                } catch {
                    print("Decoding error")
                }
                
            }
            
            
            
        }.resume()
    }
    
    func selectAdventure(_ adventure: Adventure){
        selectedItem = adventure
    }
    
}









