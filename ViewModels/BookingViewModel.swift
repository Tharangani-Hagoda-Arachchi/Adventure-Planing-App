//
//  BookingViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 28/09/2025.
//

import SwiftUI
import Foundation

class BookingViewModel: ObservableObject{
    
    
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var address = ""
    
    let bookingType: BookingType
    let date: Date
    let travellers: Int
    var selectedGuide: Guide?
    var selectedPackage: Packages?
    
    //error masseges
    @Published var errorName : String?
    @Published var errorEmail : String?
    @Published var errorPhone : String?
    @Published var errorAddress : String?

    
    //validation status
    @Published var isValid = false
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published var isLoading = false
    @Published var navigateToPayment = false
    
    private let apiService = APIServices.shared
    
    var pricePerPerson: Double {
        selectedPackage?.price ?? bookingType.price
    }
    var totalPrice: Double {
        pricePerPerson * Double(travellers)
    }
    var guideDetails: String {
        selectedGuide?.guideName ?? bookingType.displaySubtitle
    }
    var packageDetails: String {
        selectedPackage?.name ?? bookingType.title
    }
    
    // initialize data according to package or guide
    init(bookingType: BookingType, date: Date, travellers: Int, selectedGuide: Guide? = nil, selectedPackage: Packages? = nil) {
        self.bookingType = bookingType
        self.date = date
        self.travellers = travellers
        self.selectedGuide = selectedGuide
        self.selectedPackage = selectedPackage
    }


    
    // validation check function
    func validateBookings(){
        
        //assign errors to nill
        errorName = nil
        errorEmail = nil
        errorPhone = nil
        errorAddress = nil

        //name validation
        if name.isEmpty{
            errorName = "Enter Your Name"
        }
        //email validation
        if email.isEmpty{
            errorEmail = "Enter Your Email"
        }else if !isValidEmail(email){
            errorEmail = "Invalid Email"
        }
        //phone validation
        if phone.isEmpty{
            errorPhone = "Enter Your Phone No"
        }else if !isValidPhone(phone){
            errorPhone = "Invalid Phone No"
        }
        //address validation
        if address.isEmpty{
            errorName = "Enter Your Address"
        }
        
        
        isValid = (errorName == nil && errorEmail == nil && errorPhone == nil && errorAddress == nil)
             
        
    }
    
    // validate emai using regex
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    // validate phone no using regex (use country code)
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegEx = "^\\+?[0-9]{1,3}?[0-9]{9,10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegEx).evaluate(with: phone)
    }
    

    //backend API call for registration
    func saveBookings(){
        
        validateBookings()
        guard isValid else {
            return
        }
        isLoading = true

        
        apiService.saveBooking(
            name: name,
            email: email,
            phone: phone,
            address: address,
            date: date,
            travellers: travellers,
            bookingTypeId: selectedPackage?.id ?? bookingType.title,
            pricePerPerson: pricePerPerson,
            totalPrice: totalPrice,
            guideId: selectedGuide?.id,
            packageId: selectedPackage?.id,
            
            
        )
        
        { [weak self] (result: Result<BookingResponse, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                
                switch result {
                case .success(let response):
                    if response.success{
                        self.handleSuccessfulBooking()
                    } else{
                        self.showErrorAlert(title: "Error", message: "Booking Failed")
                    }
                 case .failure(let error):
                    self.showErrorAlert(title: "Error", message: error.localizedDescription)
                    
                }
            }
            

        }
    }
    
    // function for handle successfull registration
    private func handleSuccessfulBooking(){
        showSuccessAlert()
        clearFormField()
        addBookongNotification()
    }
        
      
    
    
    //clear fom fields
    private func clearFormField(){
        name = ""
        email = ""
        phone = ""
        address = ""
        
    }
    
    // function for show success alerts
    private func showSuccessAlert(){
        alertTitle = "Success"
        alertMessage = "Booking successfuly"
        showAlert = true
    }
    
    // function for show error alerts
    private func showErrorAlert(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // function for booking notifications
    private func addBookongNotification(){
        var message = ""
        
        if let package = selectedPackage{
            message = "Your booking for the package \"\(package.name)\" on \(formattedDate(date)) has been confirmed."
        }
        else if let guide = selectedGuide{
            message = "Your booking for the guide \"\(guide.guideName)\" on \(formattedDate(date)) has been confirmed."
            
        }
        else{
            message = "Your booking for the  \"\(bookingType.title)\" on \(formattedDate(date)) has been confirmed."
        }
        
        NotificationManager.shared.addNotification(title: "Booking Successful", message: message)
        
        
        
    }

    
    

    
    
}
