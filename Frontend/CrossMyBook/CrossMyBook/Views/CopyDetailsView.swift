//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct CopyDetailsView: View {
  
  @ObservedObject var copyDetailsController: CopyDetailsController = CopyDetailsController()
  
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
  init() {
    copyDetailsController.fetchCopyDetails()
  }
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("Cross My Book")
            .font(.custom("NotoSerif", size: 25)).bold()
        }
        ScrollView {
          
          ZStack (alignment: .bottomLeading) {
            Map(coordinateRegion: $mapRegion, annotationItems: copyDetailsController.observedCopy?.travelHistory ?? []) { tH in
              MapMarker(coordinate: CLLocationCoordinate2D(
                latitude: tH.lat,
                longitude: tH.lon
              ))
            }
            .frame(height: 450)
            
            WebImage(url: URL(string: copyDetailsController.observedCopy?.coverURL ?? ""))
              .resizable()
              .placeholder(Image(uiImage: UIImage(named: "bookplaceholder")!)) // Placeholder Image
            // Supports ViewBuilder as well
              .scaledToFit()
              .frame(width: 100, height: 150, alignment: .center)
              .border(Color.black, width: 1)
              .background(Color.brown)
              .offset(x: 30, y: 75)
          }.onReceive(copyDetailsController.$observedCopy) { observedCopy in
            
            // TODO: Update center of the map to the last location
            
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: observedCopy?.travelHistory.last?.lat ?? 51.5, longitude: observedCopy?.travelHistory.last?.lon ?? -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
          }
          
          VStack {
            VStack (alignment: .leading) {
              Text(copyDetailsController.observedCopy?.title ?? "Loading...")
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("NotoSerif", size: 20))
                .bold()
              
              Text(copyDetailsController.observedCopy?.author ?? "Loading...")
                .font(.custom("NotoSerif", size: 15))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
              
              HStack (spacing: 1){
                ForEach (0..<5) {_ in
                  Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color.yellow)
                }
              }
              
            }.frame(maxWidth: UIScreen.main.bounds.size.width - 160, alignment: .leading)
              .offset(x: 150, y:0)
          }.frame(maxWidth: .infinity, alignment: .leading)
          
          VStack {
            Text("Travel History")
              .font(.custom("NotoSerif", size: 18))
              .bold()
              .multilineTextAlignment(.leading)
          }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
              
              ForEach(copyDetailsController.observedCopy?.travelHistory ?? []) { travelPoint in
                WebImage(url: URL(string: travelPoint.userPicture))
                                  .resizable()
                                  .scaledToFit()
                                  .frame(width: 70, height: 70, alignment: .center)
                                  .cornerRadius(35)
                
                if(travelPoint != copyDetailsController.observedCopy?.travelHistory.last) {
                  WebImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/3183/3183354.png"))
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 30, height: 30, alignment: .center)
                }
              }
//              ForEach(0..<(copyDetailsController.observedCopy?.travelHistory.count ?? 0)) {idx in
//                WebImage(url: URL(string: "https://randomuser.me/api/portraits/women/61.jpg"))
//                  .resizable()
//                  .scaledToFit()
//                  .frame(width: 70, height: 70, alignment: .center)
//                  .cornerRadius(35)
//
//                if(idx != ((copyDetailsController.observedCopy?.travelHistory.count ?? 1) - 1)) {
//                  WebImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/3183/3183354.png"))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 30, height: 30, alignment: .center)
//                }
                
//              }.id(copyDetailsController.observedCopy?.travelHistory.count ?? 0)
            }
          }.padding(.leading)
          
          if (copyDetailsController.observedCopy?.listing != nil) {
            
            // ##################################################
            // Listing Details only if there is an active listing
            // ##################################################
            
            VStack (alignment: .leading) {
              Text("Shipping Expense")
                .font(.custom("NotoSerif", size: 15))
                .bold()
                .padding([.top, .leading, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
              Text(copyDetailsController.observedCopy?.listing?.shippingExpense ?? "Loading...")
                .font(.custom("NotoSerif", size: 15))
                .padding([.leading, .bottom, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
              
            }.frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            ).background(Color.white).padding([.leading, .top, .trailing])
            
            VStack (alignment: .leading) {
              Text("Willingness to Ship")
                .font(.custom("NotoSerif", size: 15))
                .bold()
                .padding([.top, .leading, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
              Text(copyDetailsController.observedCopy?.listing?.willingness ?? "Loading...")
                .font(.custom("NotoSerif", size: 15))
                .padding([.leading, .bottom, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
              
            }.frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            ).background(Color.white).padding([.leading, .top, .trailing])
            
            VStack (alignment: .leading) {
              Text("Book Condition")
                .font(.custom("NotoSerif", size: 15))
                .bold()
                .padding([.top, .leading, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
              Text(copyDetailsController.observedCopy?.listing?.bookCondition ?? "Loading...")
                .font(.custom("NotoSerif", size: 15))
                .padding([.leading, .bottom, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
              
            }.frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            ).background(Color.white).padding([.leading, .top, .trailing])
            
            VStack (alignment: .leading) {
              Text("Note from Current Owner")
                .font(.custom("NotoSerif", size: 15))
                .bold()
                .padding([.top, .leading, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255))
              Text(copyDetailsController.observedCopy?.listing?.note ?? "-")
                .font(.custom("NotoSerif", size: 15))
                .padding([.leading, .bottom, .trailing])
                .frame(width: .infinity)
                .multilineTextAlignment(.leading)
              
            }.frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            ).background(Color.white).padding([.leading, .top, .trailing])
          }
        }
        
          Button(action: {
            print("Request Book")
          }) {
            Text("Request Book").font(.custom("NotoSerif", size: 15))
              .padding()
              .frame(maxWidth: .infinity)
              .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
              .foregroundColor(Color.white)
          }
          .padding(.horizontal)
        
      }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    }
  }
}

struct CopyDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    CopyDetailsView()
  }
}
