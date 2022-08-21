//
//  File.swift
//  
//
//  Created by amin on 8/17/22.
//

import Foundation
import IonicPortals
import SwiftUI
import FCUUID


class MonitorChanges: ObservableObject {
    @Published var listener : String = ""
    
    func fetchData() {
        _ = PortalsPubSub.subscribe(to: "authState") { result in
            
            self.listener = result.data as! String
            print("inner: ",result.data as! String)
   
        }
    }
}


public struct SDKPackage : View {
    
    
    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String

//    @State var qrcodeData: String = ""
//    @State var authToken: String = ""
    
    @ObservedObject var listen =  MonitorChanges()

    public init(userID: Binding<String> ,callbackURL: Binding<String>, qrcodeData: Binding<String>) {
        
        _userID = userID
        _callbackURL = callbackURL
        _qrcodeData = qrcodeData
        
        
        //login set token after API call
        
        PortalsRegistrationManager.shared.register(key: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIzMjI1OTAifQ.WjIrG3xRG9HnRbCQHd7xTINq4pWIkMHt-exeTuFEYFD7RzW1qQo1RahyxP_DdDJU5EsgsESCm6vUPKpHLnkkjLogQp_wiG6HqkcKj6odqt-P4Xe-38oKihXC4PScilAfwOgS9AKTh1LQ7EA5n2wmXLfip7DnjI3xPUkWt1Wo4B_vUWo571bDgdi6He_Kpztt8q1B_TBJDBilEXOBXdxWFAgftSZM4Yrn-u3Kb92-Itu2FpcIqR6w2k_kovRXd3g0RJHB5k_tzC1om9E2k1aUw76yaO30noCQnv4qx1ISugjeXEXFDML10W8uAY4lTreENXFiBdL6ux8_UoF077RFgw")
        
    }
    
    
    
    public static func broadcastQRData (topic:String, data: Any) -> Void{
        IonicPortals.IONPortalsPubSub.publish(message: data, topic: topic)
    }
    
    
//    public func actOnQR(QR:String) {
//        //start pwa
//        self.qrcodeData = QR
//
//    }
    
    
    public var body: some View {

//        if qrcodeData.count > 0 && authToken.count > 0 {
        
        VStack{
            PortalView(portal: .init(name: "webapp", startDir: "focalpayPortal",bundle: .module, initialContext:  ["url": qrcodeData, "deviceID": userID , "callbackURL": callbackURL]))
                
                //token
            }
        .onReceive(
                PortalsPubSub.publisher(for: "authState")
                    .data().print()
            ) { _ in
                
            }

        
        .onAppear {
            Task{
                let eventStream = PortalsPubSub.subscribe(to: "authState")
                    .compactMap { $0.data as? String }
                
     

                for await event in eventStream
                    where event == "cancel" || event == "success" {
                        print(event)
                    }
                }
            }

        }
        
    

}
