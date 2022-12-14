//
//  CopyDetails.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/7/22.
//

import Foundation

import Foundation

// MARK: - CopyDetailsModel
struct CopyDetailsModel: Codable {

  let success: Bool
  let msg: String
  let copyID: String?
  let bookID, status: Int
  let travelHistory: [TravelHistory]
  let coverURL: String?
  let title, author: String?
  let rating: Rating?
  let listing: Listing?
  
  enum CodingKeys: String, CodingKey {
    case success, msg
    case copyID = "copy_id"
    case bookID = "book_id"
    case status
    case travelHistory = "travel_history"
    case coverURL = "cover_url"
    case title, author, rating
    case listing = "Listing"
  }
}

// MARK: - Listing
struct Listing: Codable {
  let listingID: Int
  let shippingExpense, willingness, bookCondition, note: String
  
  enum CodingKeys: String, CodingKey {
    case listingID = "listing_id"
    case shippingExpense = "shipping_expense"
    case willingness
    case bookCondition = "book_condition"
    case note
  }
}

// MARK: - Rating
struct Rating: Codable {
  let starsAvg: Double
  
  enum CodingKeys: String, CodingKey {
    case starsAvg = "stars__avg"
  }
}

// MARK: - TravelHistory
struct TravelHistory: Codable, Identifiable, Equatable {
  var id = UUID()
  let date, user: String
  let userID: Int
  let userPicture: String
  let lat, lon: Double
  
  static func == (lhs: TravelHistory, rhs: TravelHistory) -> Bool {
          return
              lhs.id == rhs.id
}
  
  enum CodingKeys: String, CodingKey {
    case date, user
    case userID = "user_id"
    case userPicture = "user_picture"
    case lat, lon
  }
}
