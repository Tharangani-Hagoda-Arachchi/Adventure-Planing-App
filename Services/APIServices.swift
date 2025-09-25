//
//  APIServices.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 23/09/2025.
//

import Foundation

// ennum for show errors
enum APIError: Error, LocalizedError{
    case invalidURL
    case noData
    case networkError(Error)
    case decordingError(Error, String?)
    case serverError(String)
    case httpError(Int)
    
    //error descriptions
    var errorDescription: String?{
        switch self {
        case.invalidURL:
            return "Invalid URL"
        case.noData:
            return "Data not recived"
        case.networkError(let error):
            return error.localizedDescription
        case.decordingError(let error, let jsonString):
            if let jsonString = jsonString{
                return "Data could not be read. JSON:\n\(jsonString)"
            }
            return "responce decodin failed : \(error.localizedDescription)"
        case.serverError(let message):
            return message
        case.httpError(let code):
            return "HTTP error: \(code)"
        }
    }
}
    
    // enum for HTTP methods
    enum HTTPMethod: String{
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    // responce model for login
    struct LoginResponce: Codable{
        let success : Bool?
        let message: String
        let accessToken: String?
    }
    
    // responce model for login
    struct RegistrationResponce: Codable{
        let message: String
        let accessToken: String?
    }



    class APIServices{
        static let shared = APIServices()
        
        //base url
        private let baseURL = "http://13.60.76.232/api"
        
        private init() {}
        
        // function for  requests
        func performRequest<Model: Codable>( endpoint: String, method: HTTPMethod = .GET, body: [String: Any]? = nil, responceType: Model.Type, completion: @escaping (Result<Model, APIError>) -> Void){
            
            // create URL
            guard let url = createURL(for: endpoint) else{
                completion(.failure(.invalidURL))
                return
            }
            
            // create request
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            //if it is post request add content type for it
            if method == .POST || method == .PUT{
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            //if it is have  token attached tokens
            if let token = TokenManager.shared.getAcessToken(){
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }


            
            // if have body attaced it to request
            if let body = body{
                do{
                    request.httpBody = try JSONSerialization.data(withJSONObject: body)
                } catch{
                    completion(.failure(.decordingError(error, nil)))
                    return
                }
            }
            
            //perform asy request with backend
            URLSession.shared.dataTask(with: request){ data, responce, error in
                DispatchQueue.main.async{
                    if let error = error{
                        completion(.failure(.networkError(error)))
                        return
                    }
                    
                    //check responces
                    guard let httpResponse = responce as? HTTPURLResponse else{
                        completion(.failure(.serverError("Invalid responce")))
                        return
                    }
                    
                    //handle responce
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201{
                        guard let data = data else{
                            completion(.failure(.noData))
                            return
                        }
                        
                        //decode json response data
                        do{
                            let decoded = try JSONDecoder().decode(responceType, from: data)
                            completion(.success(decoded))
                        } catch{
                            let jsonString = String(data: data, encoding: .utf8)
                            completion(.failure(.decordingError(error, jsonString)))
                            
                        }
                    }else if httpResponse.statusCode == 401{
                        completion(.failure(.httpError(401))) // Session expired
                        
                    }else if httpResponse.statusCode == 404{
                        
                        if Model.self == [Packages].self || Model.self == [AdventurePlace].self{
                            let msg = self.extractErrorMessage(from: data) ?? "Not found"
                            completion(.failure(.serverError(msg)))
                            
                        }
                        
                    }else{
                        let errorMessage = self.extractErrorMessage(from: data) ?? "Something went wrong"
                        completion(.failure(.serverError(errorMessage)))
                    }
                }
                
            }.resume()
            

        }
        
        //function for registration
        func registerUser(name: String, email: String, phone: String, password: String, completion: @escaping (Result<RegistrationResponce, APIError>) -> Void){
            let body: [String: Any] = [
                "name": name,
                "email": email,
                "phone": phone,
                "password": password
            ]
            
            performRequest(
                endpoint: "auths/signup",
                method: .POST,
                body: body,
                responceType: RegistrationResponce.self,
                completion: completion
            )
        }
        
        //function for login
        func loginUser(email: String, password: String, completion: @escaping (Result<LoginResponce, APIError>) -> Void){
            let body: [String: Any] = [
                "email": email,
                "password": password
            ]
            
            performRequest(
                endpoint: "auths/signin",
                method: .POST,
                body: body,
                responceType: LoginResponce.self,
                completion: completion
            )
        }
        
        //function for fetch all adventures
        func fetchAdventures(completion: @escaping (Result<[Adventure], APIError>) -> Void){
            
            performRequest(
                endpoint: "adventures",
                method: .GET,
                responceType: [Adventure].self,
                completion: completion
            )
        }
        
        //function for fetch all adventure places by category
        func fetchAdventurePlaces( by categoryId: String, completion: @escaping (Result<[AdventurePlace], APIError>) -> Void){
            
            performRequest(
                endpoint: "places/\(categoryId)",
                method: .GET,
                responceType: [AdventurePlace].self,
                completion: completion
            )
        }
        
        
        //function for fetch  adventure place by ID
        func fetchAdventurePlace( by id:  String, completion: @escaping (Result<AdventurePlace, APIError>) -> Void){
            
            performRequest(
                endpoint: "places/details/\(id)",
                method: .GET,
                responceType: AdventurePlace.self,
                completion: completion
            )
        }
        
        //function for fetch all guides according to places
        func fetchGuides( by placeName: String, completion: @escaping (Result<[Guide], APIError>) -> Void){
            
            //encode url
            guard let encodedPlace = placeName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                completion(.failure(.invalidURL))
                return
            }
            
            performRequest(
                endpoint: "guides/\(encodedPlace)",
                method: .GET,
                responceType: [Guide].self,
                completion: completion
            )
        }
        
        //function for fetch  guide  by ID
        func fetchGuide( by id:  String, completion: @escaping (Result<Guide, APIError>) -> Void){
            
            performRequest(
                endpoint: "guides/details/\(id)",
                method: .GET,
                responceType: Guide.self,
                completion: completion
            )
        }
        
        //function for fetch  all packages
        func fetchPackages( completion: @escaping (Result<[Packages], APIError>) -> Void){
            
            performRequest(
                endpoint: "packages",
                method: .GET,
                responceType: [Packages].self,
                completion: completion
            )
        }
        
        //function for fetch all packages  by category
        func fetchPackagesByCategory( by categoryId: String, completion: @escaping (Result<[Packages], APIError>) -> Void){
            
            performRequest(
                endpoint: "packages/\(categoryId)",
                method: .GET,
                responceType: [Packages].self,
                completion: completion
            )
        }
        
        
        //function for serch all adventure places by name
        func SearchAdventurePlaces( query: String, completion: @escaping (Result<[AdventurePlace], APIError>) -> Void){
            
            //encode url
            guard let encodedPlace = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                completion(.failure(.invalidURL))
                return
            }
            
            performRequest(
                endpoint: "search/adventures?query=\(encodedPlace)",
                method: .GET,
                responceType: [AdventurePlace].self,
                completion: completion
            )
        }
        
        
        //function for serch all packages by name
        func SearchPackages( query: String, completion: @escaping (Result<[Packages], APIError>) -> Void){
            
            //encode url
            guard let encodedPlace = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                completion(.failure(.invalidURL))
                return
            }
            
            performRequest(
                endpoint: "search/packages?query=\(encodedPlace)",
                method: .GET,
                responceType: [Packages].self,
                completion: completion
            )
        }
        
        //create url function
        private func createURL(for endpoint: String) -> URL?{
            return URL(string: "\(baseURL)/\(endpoint)")
        }
        
        // function to extract error message by responce
        private func extractErrorMessage(from data: Data?) -> String?{
            guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else{
                return nil
            }
            return json["message"] as? String
        }
        
    
    

    
}
