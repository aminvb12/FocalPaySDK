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



@available(macOS 10.15, *)
public struct ReceiptView : View {
    
    @Binding var storeID: String
    @Binding var orderID: String
    @Binding var qrcodeData: String
    
    
    
    public init(storeID: Binding<String> , orderID: Binding<String> , qrcodeData: Binding<String> ) {
        
        _storeID = storeID
        _orderID = orderID
        _qrcodeData = qrcodeData
        
        PortalsRegistrationManager.shared.register(key: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIzMjI1OTAifQ.WjIrG3xRG9HnRbCQHd7xTINq4pWIkMHt-exeTuFEYFD7RzW1qQo1RahyxP_DdDJU5EsgsESCm6vUPKpHLnkkjLogQp_wiG6HqkcKj6odqt-P4Xe-38oKihXC4PScilAfwOgS9AKTh1LQ7EA5n2wmXLfip7DnjI3xPUkWt1Wo4B_vUWo571bDgdi6He_Kpztt8q1B_TBJDBilEXOBXdxWFAgftSZM4Yrn-u3Kb92-Itu2FpcIqR6w2k_kovRXd3g0RJHB5k_tzC1om9E2k1aUw76yaO30noCQnv4qx1ISugjeXEXFDML10W8uAY4lTreENXFiBdL6ux8_UoF077RFgw")
        
    }
    
    
    
    public static func broadcastQRData (topic:String, data: Any) -> Void{
        IonicPortals.IONPortalsPubSub.publish(message: data, topic: topic)
    }
    
    
    
    public var body: some View {
        
        VStack{
            PortalView(portal: .init(name: "webapp", startDir: "focalpayPortal",bundle: .module, initialContext:  [ "storeId": storeID , "orderId": orderID, "url": qrcodeData ]))
        }
        
    }
    
    
}
