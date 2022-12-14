//
//  DashboardView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/8/22.
//

import SwiftUI
import SDWebImageSwiftUI
import WrappingHStack

struct DashboardView: View {
  
  @ObservedObject var profileController: ProfileController = ProfileController()
  @ObservedObject var dashboardController: DashboardController = DashboardController()
  @ObservedObject var reviewsController: ReviewsController = ReviewsController()
  
  @AppStorage("user_id") var userID: Int = -1
  
  @State private var enableCurrentButton = true
  @State private var enableHistoryButton = false
  
  var body: some View {
    VStack {
      HStack {
        WebImage(url: URL(string: profileController.profile?.profileUrl ?? ""))
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100, alignment: .center)
          .cornerRadius(50)
          .padding(.trailing, 20.0)
        VStack {
          Text(profileController.profile?.firstName ?? "")
            .font(Font.custom("NotoSerif", size: 30))
            .bold()
            .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
        }
      }.padding(.top, 20.0)
      
      HStack {
        Spacer()
        NavigationLink(destination: ReviewsView(reviews: reviewsController.myReviews ?? [], myReviewFlag: true).navigationBarBackButtonHidden(true)) {
          VStack {
            Text(String(reviewsController.myReviews?.count ?? 0))
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
            Text("Reviews")
              .font(Font.custom("NotoSerif", size: 15))
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          }
        }
        Spacer()
        NavigationLink(destination: ReviewsView(reviews: reviewsController.faveReviews ?? [], myReviewFlag: false).navigationBarBackButtonHidden(true)) {
          VStack {
            Text(String(reviewsController.faveReviews?.count ?? 0))
              .font(Font.custom("NotoSerif", size: 30))
              .bold()
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
            Text("Favorites")
              .font(Font.custom("NotoSerif", size: 15))
              .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
          }
        }
        Spacer()
      }
      HStack {
          // TODO: button actions
          Button(action: {
            self.dashboardController.changeDisplayBooks("current")
            self.enableCurrentButton = true
            self.enableHistoryButton = false
          }) {
            CustomText(s: "Current Books", size: 16, color: enableCurrentButton ? Color.white : Color.fontBlack).bold()
          }.frame(minWidth: 170, minHeight: 43)
          .background(enableCurrentButton ? Color.theme : Color.white)
          .cornerRadius(10)
          .disabled(enableCurrentButton)
        
          Button(action: {
            self.dashboardController.changeDisplayBooks("history")
            self.enableCurrentButton = false
            self.enableHistoryButton = true
          }) {
            CustomText(s: "Previous Books", size: 16, color: enableHistoryButton ? Color.white : Color.fontBlack).bold()
          }.frame(minWidth: 170, minHeight: 43)
          .background(enableHistoryButton ? Color.theme : Color.white)
          .cornerRadius(10)
          .disabled(enableHistoryButton)
      }.padding(.top, 10)
      
      ScrollView {
        WrappingHStack(dashboardController.displayBooks ?? []) { book in
          NavigationLink(destination: CopyDetailsView(book.copyId).navigationBarHidden(true)) {
            VStack {
              WebImage(url: URL(string: book.coverUrl))
                .resizable()
                .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
                .scaledToFit().cornerRadius(5)
                .frame(width: 100, height: 150, alignment: .center)
                .shadow(color: .gray, radius: 3, x: 0, y: 3)
              Text(book.title)
                .font(Font.custom("NotoSerif", size: 12)).bold()
                .frame(width: 100).foregroundColor(Color.black).lineLimit(1)
              Text(book.author)
                .font(Font.custom("NotoSerif", size: 10))
                .frame(width: 100).foregroundColor(Color.black).lineLimit(1).padding(.bottom, 15)
            }.padding(5)
          }
        }
      }.padding(20.0)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
      .onAppear(perform: {
        profileController.fetchProfile(userID)
        dashboardController.fetchUserBooks(userID)
        reviewsController.fetchReviews(userID)
        self.enableCurrentButton = true
        self.enableHistoryButton = false
      })
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
  }
}
