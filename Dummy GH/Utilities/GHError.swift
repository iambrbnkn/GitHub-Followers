//
//  GHError.swift
//  Dummy GH
//
//  Created by Vitaliy on 20.01.2024.
//

import Foundation

enum GHError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case unableFavorite = "Ops, we catch the error in favoriting this user. Please try again"
    case alreadyInFavorites = "Hey, this user is already in your favorite list. You can remove him and add again, if u want"
}
