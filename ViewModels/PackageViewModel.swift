//
//  PackageViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation
import SwiftUI

class PackageViewModel : ObservableObject{
    
    @Published var packages: [Packages] = []
    @Published var packagesDetail: Packages? = nil// for single responce
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //load status
    @Published var isLoad = false
    
    //backend API call for fetch adventures
    func fetchPackages(){
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
                    let responce = try JSONDecoder().decode([Packages].self, from: data)
                    DispatchQueue.main.async{
                        self.packages = responce
                    }
                } catch {
                    print("Decoding error")
                }
                
            }
            
        }.resume()
    }
    


    
    func fetchPackageByCategory(for categoryId: String, completion: @escaping ([Packages]) -> Void = { _ in }){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/packages/\(categoryId)") else {return}
        
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
                            let decoded = try JSONDecoder().decode([Packages].self, from: data)
                            self.packages = decoded
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
    
    // fetch package by id
    func fetchPackageByID(for id: String, completion: @escaping (Packages?) -> Void = { _ in }){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/packages/details/\(id)") else {return}
        
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
                            let decoded = try JSONDecoder().decode(Packages.self, from: data)
                            self.packagesDetail = decoded
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
    
    
    
    
}

