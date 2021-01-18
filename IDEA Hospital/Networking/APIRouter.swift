//
//  APIRouter.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case getMainCategories
    case getQueryParametersData(id: Int)
    case getUserFavoritesWithPagination(pega: Int, perPage: Int)
    case getUserAppointmentsWithPagination(pega: Int, perPage: Int)
    case addAndRemoveFavorite(id: Int)
    case deleteAppointment(id: Int)
    case nursingRequest(_ requestBody: RequestBodyData)
    case getDoctorDataWithFiltersWithPagination(body: categoryDataBodyRequest)
    case aboutUsContent
    case termsAndConditionsContent
    case contactUsRequest(_ requestBody: RequestBodyData)
    case forgetPassword(email : String)
    case login(_ email: String, _ password: String)
    case register(_ requestBody: UserBodyData)
    case logout
    case getDoctorData(_ doctorId: Int)
    case getDoctorAppontments(_ doctorId: Int)
    case getDoctorReviewsWithPagination(pega: Int, perPage: Int,doctorId: Int)
    case reviewDoctors(_ id: Int, _ rating: Int , _ comment: String)
    case bookAppointmentWithDoctor(_ requestBody: UserDoctorAppointment)
    case bookAppointmensForNewUsers(_ requestBody: NewUserBodyData)
    case bookAppointmetAfterLogin(_ requestBody : UserloginBodyData)
    case editProfile(_ body: EditProfileBodyData)
    case getUserData
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getMainCategories , .getQueryParametersData, .getUserFavoritesWithPagination , .getUserAppointmentsWithPagination , .getDoctorDataWithFiltersWithPagination, .aboutUsContent, .termsAndConditionsContent, .getDoctorData , .getDoctorAppontments , .getDoctorReviewsWithPagination, .getUserData:
            return .get
        case .addAndRemoveFavorite , .nursingRequest, .contactUsRequest, .forgetPassword , .login , .register, .logout, .reviewDoctors, .bookAppointmentWithDoctor, .bookAppointmensForNewUsers, .bookAppointmetAfterLogin :
            return .post
        case .deleteAppointment:
            return .delete
        case .editProfile:
            return .patch
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
        case .forgetPassword(let email):
            return [ParameterKeys.email : email]
        case .getUserAppointmentsWithPagination(let page, let perPage):
            return [ParameterKeys.page: page, ParameterKeys.perPage: perPage]
        case .getUserFavoritesWithPagination(let page, let perPage):
            return [ParameterKeys.page: page, ParameterKeys.perPage: perPage]
        case .getDoctorDataWithFiltersWithPagination(let body):
            return [ParameterKeys.page: body.page, ParameterKeys.perPage: body.perPage,ParameterKeys.orderBy: body.orderBy ?? "", ParameterKeys.specialtyId: body.specialtyId ?? "", ParameterKeys.cityId: body.cityId ?? "", ParameterKeys.regionId: body.regionId ?? "", ParameterKeys.companyId: body.companyId ?? "", ParameterKeys.name: body.name ?? ""]
        case .getDoctorReviewsWithPagination(let page, let perPage,_):
            return [ParameterKeys.page: page, ParameterKeys.perPage: perPage]
        case .reviewDoctors (let id, let rating, let comment):
            return[ParameterKeys.id: id, ParameterKeys.rate: rating, ParameterKeys.comment: comment]
        default:
            return nil
            }
        }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getMainCategories:
            return URLs.mainCategories
        case .getQueryParametersData(let id):
            return "/main_categories" + "/\(id)" + "/doctors_query_parameters"
        case .getUserFavoritesWithPagination:
            return URLs.favorites
        case .getUserAppointmentsWithPagination:
            return URLs.appointments
        case .addAndRemoveFavorite(let id):
            return URLs.favorites + "/\(id)" + "/add_remove"
        case .deleteAppointment(let id):
            return URLs.appointments + "/\(id)"
        case .getDoctorDataWithFiltersWithPagination(let body):
            return URLs.mainCategories + "/\(body.mainCategoryId ?? 0)" + "/doctors"
        case .nursingRequest:
            return URLs.nursingRequest
        case .contactUsRequest:
            return URLs.contactUsRequest
        case .aboutUsContent:
            return URLs.aboutUs
        case .termsAndConditionsContent:
            return URLs.termsAndConditions
        case .forgetPassword:
            return URLs.forgetPassword
        case .login:
            return URLs.login
        case .register:
            return URLs.register
        case .logout:
            return URLs.logout
        case .getDoctorData(let doctorId):
            return URLs.doctorData + "/\(doctorId)"
        case .getDoctorAppontments(let doctorId):
            return URLs.doctorData + "/\(doctorId)/appointments"
        case .getDoctorReviewsWithPagination(_, _, let doctorId):
            return URLs.doctorData + "/\(doctorId)/reviews"
        case .reviewDoctors(let id, _, _) :
            return "/doctors" + "/\(id)" + "/reviews"
        case .bookAppointmentWithDoctor:
            return URLs.userAppoinments
        case .bookAppointmensForNewUsers:
            return URLs.bookForNewUsers
        case .bookAppointmetAfterLogin:
            return URLs.bookingAfterLogin
        case .editProfile:
            return URLs.user
        case .getUserData:
            return URLs.user
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        default:
            break
        }
        if UserDefaultsManager.shared().token != nil{
        let token = UserDefaultsManager.shared().token
        urlRequest.setValue("\(token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        }
        urlRequest.setValue("en", forHTTPHeaderField: HeaderKeys.acceptLanguage)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .nursingRequest(let body), .contactUsRequest(let body):
                return encodeToJSON(body)
            case .register(let body):
                return encodeToJSON(body)
            case .bookAppointmensForNewUsers(let body):
                return encodeToJSON(body)
            case .bookAppointmetAfterLogin(let body):
                return encodeToJSON(body)
            case .editProfile(let body):
                return encodeToJSON(body)
            case .bookAppointmentWithDoctor(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
