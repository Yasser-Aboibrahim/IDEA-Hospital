//
//  APIManager.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    //Get main Categories
    class func getMainCategories(completion: @escaping (Result<MainCategoryResponse,Error>) -> Void){
        request(APIRouter.getMainCategories) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- getquerypParametersData
    class func getquerypParametersData(with categoriesID : Int , completion: @escaping (Result<CategoryDataResponse, Error>) -> Void){
        request(APIRouter.getQueryParametersData(id: categoriesID)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- homeNursing
    class func homeNursing(body: RequestBodyData, completion: @escaping (Result<NursingRequest,Error>)-> Void){
        request(APIRouter.nursingRequest(body)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- getDoctorDataFilterdWithFiltersWithPagination
    class func  getDoctorDataFilterdWithFiltersWithPagination(body: categoryDataBodyRequest,  completion: @escaping (Result<DoctorDataWithFilterItemsResponse , Error>)-> ()){
        request(APIRouter.getDoctorDataWithFiltersWithPagination(body: body) ) { (response) in
            completion(response)
        }
    }
    
    //MARK:- getFavoritesDataWithPagination
    class func getFavoritesDataWithPagination(page: Int, perPage: Int, completion: @escaping (Result<FavoritesResponse, Error>) -> Void){
        request(APIRouter.getUserFavoritesWithPagination(pega: page, perPage: perPage)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- getUserAppointmentsDataWithPagination
    class func getUserAppointmentsDataWithPagination(page: Int, perPage: Int, completion: @escaping (Result<AppointmentsResponse, Error>) -> Void){
        request(APIRouter.getUserAppointmentsWithPagination(pega: page, perPage: perPage)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- addAndRemoveFavorite
    class func addAndRemoveFavorite(id: Int, completion: @escaping (Result<addAndRemoveResponse, Error>) -> Void){
        request(APIRouter.addAndRemoveFavorite(id: id)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- deleteAppointment
    class func deleteAppointment(id: Int, completion: @escaping (Result<deleteAppointment, Error>) -> Void){
        request(APIRouter.deleteAppointment(id: id)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- aboutUsContent
    class func aboutUsContent(completion: @escaping (Result<AboutUsResponse, Error>) -> Void){
        request(APIRouter.aboutUsContent) { (response) in
            completion(response)
        }
    }
    
    //MARK:- termsAndConditionsContent
    class func termsAndConditionsContent(completion: @escaping (Result<TermsAndConditionsResponse, Error>) -> Void){
        request(APIRouter.termsAndConditionsContent) { (response) in
            completion(response)
        }
    }
    
    //MARK:- contactUsRequest
    class func contactUsRequest(body: RequestBodyData, completion: @escaping (Result<ContactUsRequest,Error>)-> Void){
        request(APIRouter.contactUsRequest(body)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- forgotPassword
    class func forgotPassword(email: String, completion: @escaping (Result<ForgetPasswordResponse, Error>) -> Void){
        request(APIRouter.forgetPassword(email: email)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- Login
    class func  login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>)-> ()){
        request(APIRouter.login(email, password)){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Register
    class func register(body: UserBodyData, completion: @escaping (Result<AuthResponse, Error>)-> Void){
        request(APIRouter.register(body)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Logout
    class func logout( completion: @escaping (Result<AuthResponse, Error>)-> Void){
        request(APIRouter.logout) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Get DoctorData
    class func getDoctorData(doctorId:Int, completion: @escaping (Result<DoctorDataByIDResponse, Error>)-> Void){
        request(APIRouter.getDoctorData(doctorId)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Get Doctor Appointments
    class func getDoctorAppointments(doctorId:Int, completion: @escaping (Result<DocotorAppointmentsResponse, Error>)-> Void){
        request(APIRouter.getDoctorAppontments(doctorId)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Get Doctor Reviews
    class func getDoctorReviewsWithPagination(pega: Int, perPage: Int, doctorId: Int, completion: @escaping (Result<DocotorReviewsResponse, Error>)-> Void){
        request(APIRouter.getDoctorReviewsWithPagination(pega: pega, perPage: perPage, doctorId: doctorId)) { (response) in
            completion(response)
        }
    }
    
    //Mark:- Review
    class func review(id: Int,rating: Int, comment: String,  completion: @escaping (Result<ReviewResponse, Error>)-> Void){
        request(APIRouter.reviewDoctors(id, rating, comment)) { (response) in
            completion(response)
        }
    }
    
    //Mark:- BookingDoctor
    class func bookDoctor(body: UserDoctorAppointment, completion: @escaping (Result<UserDoctorAppointmentResponse, Error>)-> Void){
        request(APIRouter.bookAppointmentWithDoctor(body)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- RegisterAndBookForNewUsers
    class func registerAndBookForNewUsers(body: NewUserBodyData, completion: @escaping (Result<AuthResponse, Error>)-> Void){
        request(APIRouter.bookAppointmensForNewUsers(body)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- LoginAndBook
    class func  loginAndBook(body: UserloginBodyData, completion: @escaping (Result<AuthResponse, Error>)-> ()){
        request(APIRouter.bookAppointmetAfterLogin(body)){ (response) in
            completion(response)
        }
    }
    
    //Mark:- Edit Profile
    class func editProfile(body: EditProfileBodyData, completion: @escaping (Result<EditProfileResponse, Error>)-> Void){
        request(APIRouter.editProfile(body)) { (response) in
            completion(response)
        }
    }
    
    //Mark:- Grt User Data
    class func getUserData(completion: @escaping (Result<UserDataResponse, Error>)-> Void){
        request(APIRouter.getUserData) { (response) in
            completion(response)
        }
    }

}
    


extension APIManager{
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
            }
            .responseJSON { response in
                print(response)
        }
    }
}
