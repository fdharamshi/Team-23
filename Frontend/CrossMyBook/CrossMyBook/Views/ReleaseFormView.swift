//
//  ReleaseFormView.swift
//  CrossMyBook
//
//  Created by Chenjun Zhou on 11/7/22.
//
import SwiftUI
import SDWebImageSwiftUI
import Combine

struct ReleaseFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var vc: ReleaseController
    @ObservedObject var bookViewModel: BookViewModel = BookViewModel()
    // MARK: might delete zip
    @State var zip: String = ""
    @State var userID: String = UserDefaults.standard.string(forKey: "user_id") ?? "1"
    @State var jump = false
    @State private var showingAlert = false
    @State private var resultAlert = false
    @State private var res = false
    @State private var alertMsg = ""
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button (action: {
                        self.presentationMode.wrappedValue.dismiss() 
                    }) {
                        FAIcon(name: "chevron-left")
                    }
                    Text("Create New Release").font(.custom("NotoSerif", size: 24)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                }.padding(10)
                
                ScrollView {
                    NavigationLink(
                        destination: LandingView()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true), isActive: $jump){EmptyView()}
                    ReleaseCardView(book: vc.book)
                    VStack {
                        TextField("Leave a note", text: $vc.release.note, axis: .vertical)
                            .lineLimit(10...)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 15, trailing: 20))
                            .multilineTextAlignment(.leading)
                            .background(RoundedRectangle(cornerRadius:10).fill(Color.white))
                        
                        Button(action: {
                            self.vc.loc.getCurrentLocation()
                            self.showingAlert = true
                        }) {
                            Text("Get my location")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height:48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                        
                        Text("Your location is: (\(self.vc.loc.latitude,  specifier: "%.2f"), \(self.vc.loc.longitude, specifier: "%.2f"))")
                            .font(.custom("NotoSerif", size: 16)).bold().frame(maxWidth: .infinity).foregroundColor(.fontBlack)
                        
                        //                    TextField("Street Address", text: $vc.release.distance)
                        //                        .frame(height: 48)
                        //                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        //                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                        //                    TextField("Zip Code", text: $zip)
                        //                        .frame(height: 48)
                        //                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        //                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        //                        .keyboardType(.numberPad)
                        //                        .onReceive(Just(zip)) { newValue in
                        //                            let filtered = newValue.filter { "0123456789".contains($0) }
                        //                            if filtered != newValue {
                        //                                zip = ""
                        //                            }else{
                        //                                vc.inputZipCode(zip:zip)
                        //                            }
                        //                        }
                        HStack{
                            CustomText(s: "Shipping Option", size: 14).bold()
                            Spacer()
                            Picker("Shipping Option", selection: $vc.release.shipping) {
                                Text("Pay by Requester").tag("Pay by the Requester")
                                Text("Pay by Sender").tag("Pay by the Sender")
                                Text("Split by Both Parties").tag("Split by Both Parties")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        HStack{
                            CustomText(s: "Travel Distance", size: 14).bold()
                            Spacer()
                            Picker("Travel Distance", selection: $vc.release.distance) {
                                Text("Same City").tag("Same City")
                                Text("Same State").tag("Same State")
                                Text("Same Country").tag("Same Country")
                                Text("Worldwide").tag("Worldwide")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        HStack{
                            CustomText(s: "Book Condition", size: 14).bold()
                            Spacer()
                            Picker("Book Condition", selection: $vc.release.condition) {
                                Text("Excellent").tag("Excellent")
                                Text("Good").tag("Good")
                                Text("Fair").tag("Fair")
                            }.pickerStyle(.menu)
                        }.frame(height: 48)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Location"), message: Text(vc.generateTitle()))
                }
                
                Button(action: {
                    res = vc.createRelease(userID: Int(userID) ?? 1)
                    if (res){
                        alertMsg = "Release Sucess!"
                    }else{
                        alertMsg = "Release Failed!\nPlease try again."
                    }
                    resultAlert = true
                }) {
                    Text("Release Book").font(.custom("NotoSerif", size: 15))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 128 / 255, green: 71 / 255, blue: 28 / 255)))
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal)
            }.background(Color(red: 245/255, green: 245 / 255, blue: 245 / 255))
            
        }.alert(isPresented: $resultAlert) {
            Alert(
                title: Text(alertMsg),
                dismissButton: .default(Text("Got it")) {
                    if (res) {
                        jump = true
                    }
                }
            )
        }
        
    }
    
}

//struct ReleaseFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReleaseFormView()
//    }
//}
