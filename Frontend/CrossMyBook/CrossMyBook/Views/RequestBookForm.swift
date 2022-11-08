//
//  CopyDetailsView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 11/3/22.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct RequestBookForm: View {
  
  @State var streetAddress: String = ""
  @State var zipCode: String = ""
  @State var note: String = ""
  
  var body: some View {
    
    VStack {
      HStack {
        Text("Cross My Book")
          .font(.custom("NotoSerif", size: 25)).bold()
      }
      ScrollView {
        
        HStack (alignment: .top) {
          Spacer()
          
          WebImage(url: URL(string: "https://covers.openlibrary.org/b/id/10447670-L.jpg")).resizable().scaledToFit().frame(height: 180).cornerRadius(5)
          
          Spacer()
          
          VStack {
            VStack (alignment: .leading, spacing: 5) {
              Text("Cracking the Coding Interview")
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("NotoSerif", size: 20))
                .bold()
              
              Text("James Clear")
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
              
            }
          }
          Spacer()
        }
        VStack {

          
           RoundedTextField(text: .constant("Femin Dharamshi"), placeholder: "name", height: 48)
          
          Button("Fetch Current Location", action: {})
          Text("Lat: 123.123 Lon: -79.123")
          
           RoundedTextField(text: $note, placeholder: "leave a note", height: 250)
          
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
      }
      Button(action: {
        print("Request submitted")
      }) {
        Text("Submit Request").font(.custom("NotoSerif", size: 15).bold())
          .padding()
          .frame(maxWidth: .infinity)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
          .foregroundColor(Color.white)
      }
      .padding(.horizontal)
    }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
    
  }
}

struct RequestBookForm_Previews: PreviewProvider {
  static var previews: some View {
    RequestBookForm()
  }
}
