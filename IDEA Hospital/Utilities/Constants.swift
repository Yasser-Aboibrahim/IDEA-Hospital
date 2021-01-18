//
//  Constants.swift
//  IDEA Hospital
//
//  Created by yasser on 12/7/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

// Storyboards
struct Storyboards {
    static let main = "Main"
    static let home = "Home"
    static let myFavorites = "MyFavorites"
    static let myAppointments = "MyAppointments"
    static let homeNurse = "HomeNurse"
    static let searchResult = "SearchResult"
    static let settings = "Settings"
    static let aboutUsAndTerms = "AboutUsAndTerms"
    static let resetPassword = "ResetPassword"
    static let login = "Login"
    static let signUp = "SignUp"
    static let doctorProfile = "DoctorProfile"
    static let review = "Review"
    static let successfullyBooked = "SuccessfullyBooked"
    static let popUpAppoinmentCancellation = "appointmentCancellation"
    static let popUpVoucher = "Voucher"
    static let popUpAppointmentConfirmation = "AppoitmentConfirmation"
    static let editProfile = "EditProfile"
}

// View Controllers
struct ViewControllers {
    static let homeVC = "HomeVC"
    static let searchServicesVC = "searchServicesVC"
    static let myFavoritesVC = "MyFavoritesVC"
    static let myAppointmentsVC = "MyAppointmentsVC"
    static let searchResultVC = "SearchResultVC"
    static let homeNurseVC = "HomeNurseVC"
    static let settingsVC = "SettingsVC"
    static let aboutUsAndTermsVC = "AboutUsAndTermsVC"
    static let resetPasswordVC = "ResetPasswordVC"
    static let loginVC = "LoginVC"
    static let signUpVC = "SignUpVC"
    static let doctorProfileVC = "DoctorProfileVC"
    static let reviewVC = "ReviewVC"
    static let successfullyBookedVC = "SuccessfullyBookedVC"
    static let AppointmentCancellationVC = "appointmentCancellationVC"
    static let voucherVC = "VoucherVC"
    static let AppointmentConfirmationVC = "AppointmentConfirmationVC"
    static let editProfileVC = "EditProfileVC"
}

// Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api"
    static let mainCategories = "/main_categories"
    static let mainCategoriesParamData = "/main_categories"
    static let contactUsRequest = "/contact_us_requests"
    static let nursingRequest = "/nursing_requests"
    static let favorites = "/favorites/doctors"
    static let appointments = "/user_appointments"
    static let aboutUs = "/about_us"
    static let termsAndConditions = "/terms_and_conditions"
    static let forgetPassword = "/forget_password"
    static let login = "/login"
    static let register = "/register"
    static let logout = "/logout"
    static let doctorData = "/doctors"
    static let voucher = "/vouchers"
    static let userAppoinments = "/user_appointments"
    static let bookForNewUsers = "/user_appointments/with_register"
    static let bookingAfterLogin = "/user_appointments/with_login"
    static let user = "/user"
}

// Header Key
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let accept = "accept"
    static let authorization  = "Authorization"
    static let acceptLanguage = "Accept-Language"
}

// Parameters Key
struct ParameterKeys {
    static let name = "name"
    static let email = "email"
    static let mobile = "mobile"
    static let message = "message"
    static let fees = "fees"
    static let rate = "rating"
    static let orderBy = "order_by"
    static let page = "page"
    static let perPage = "per_page"
    static let specialtyId = "specialty_id"
    static let cityId = "city_id"
    static let regionId = "region_id"
    static let companyId = "company_id"
    static let password = "password"
    static let comment = "comment"
    static let id = "doctor_id"
    static let appointment = "appointment"
    static let voucher = "voucher"
    static let bookforanother = "book_for_another"
    static let patientName = "patient_name"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "AccessToken"
    static let isLoggedIn = "IsLoggedIn"
    static let userData = "UserData"
    
}

// Cells Key
struct Cells{
    static let homeCell = "HomeCell"
    static let myFavoritesCell = "MyFavoritesCell"
    static let myAppointmentsCell = "MyAppointmentsCell"
    static let searchResultCell = "TableViewCell"
    static let settingsCell = "SettingsCell"
    static let DoctorProfileCollectionViewCell = "doctorProfileCollectionViewCell"
    static let doctorReviewsTabelViewCell = "DoctorReviewsTabelViewCell"
}

// Settings
struct Settings {
    static let editProfile = "Edit Profile"
    static let favorite = "Favorites"
    static let bookedAppointments = "Booked Appointments"
    static let aboutUs = "About Us"
    static let contactUs = "Contact Us"
    static let share = "Share"
    static let termsAndConditions = "Terms & Conditions"
    static let logout = "Logouts"
    static let Login = "Login"
}

// Settings Icons
struct SettingsPhotoIcons {
    static let editProfile = "user"
    static let favorite = "heart2"
    static let bookedAppointments = "calendar3"
    static let aboutUs = "about"
    static let contactUs = "contact"
    static let share = "share"
    static let termsAndConditions = "sheet"
    static let logout = "logout"
    static let Login = "login"
}

struct ScreensTitle{
    static let homeNurse = "Home Nurse"
    static let contactUs = "Contact Us"
    static let aboutUs = "About Us"
    static let termsAndConditions = "Terms & Conditions"
}
