//
//  AdventuePlaceViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import Foundation
import SwiftUI

class AdventuePlaceViewModel : ObservableObject{
    
    @Published var places: [AdventurePlace] = []
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //load status
    @Published var isLoad = false
    
    func fetchPlacesByCategory(for categoryId: String, completion: @escaping ([AdventurePlace]) -> Void = { _ in }){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/places/\(categoryId)") else {return}
        
        isLoad = true
        
        //crate  request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //send request async way
        URLSession.shared.dataTask(with: request){
            data, responce,error in DispatchQueue.main.async{
                
                //for nerwork error alert
                if let error = error{
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                    
                }
                
                guard let httpResponce = responce as? HTTPURLResponse else {return}
                
                if httpResponce.statusCode == 200 {
                    
                    if let data = data{
                        
                        //decode JSON Data
                        do{
                            let decoded = try JSONDecoder().decode([AdventurePlace].self, from: data)
                            self.places = decoded
                            completion(decoded)
                            
                        } catch{
                            self.alertTitle = "Decoding Error"
                            if let jsonStr = String(data: data, encoding: .utf8){
                                self.alertMessage = "Data could not be read. JSON:\n\(jsonStr)"
                            } else {
                                self.alertMessage = error.localizedDescription
                            }
                            self.showAlert = true
                        }
                    }
                    
                }else{
                    let responseMessage = "Something went wrong"
                    self.alertTitle = "Error"
                    self.alertMessage = responseMessage
                    self.showAlert = true
                    
                }
            }
        }.resume()
    }
    
    // fetch places by id
    func fetchPlacesByID(for id: String){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/places/details\(id)") else {return}
        
        isLoad = true
        
        //crate  request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //send request async way
        URLSession.shared.dataTask(with: request){
            data, responce,error in DispatchQueue.main.async{
                
                //for nerwork error alert
                if let error = error{
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                    
                }
                
                guard let httpResponce = responce as? HTTPURLResponse else {return}
                
                if httpResponce.statusCode == 200 {
                    
                    if let data = data{
                        
                        //decode JSON Data
                        do{
                            let decoded = try JSONDecoder().decode([AdventurePlace].self, from: data)
                            self.places = decoded
                            
                            
                        } catch{
                            self.alertTitle = "Decoding Error"
                            if let jsonStr = String(data: data, encoding: .utf8){
                                self.alertMessage = "Data could not be read. JSON:\n\(jsonStr)"
                            } else {
                                self.alertMessage = error.localizedDescription
                            }
                            self.showAlert = true
                        }
                    }
                    
                }else{
                    let responseMessage = "Something went wrong"
                    self.alertTitle = "Error"
                    self.alertMessage = responseMessage
                    self.showAlert = true
                    
                }
            }
        }.resume()
    }
    
    
    
    
}
