//
//  SwiftUIView 2.swift
//  
//
//  Created by amin on 8/28/22.
//

import SwiftUI


enum StateType {
    case scan, receipt
}



public struct MainSDK: View {

    @Binding var state: String

    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String


    @Binding var storeID: String
    @Binding var orderID: String
    
    var callback : (_ type: String, _ value:Any?) -> Void
    
    
    public init(state: Binding<String> , userID: Binding<String> , qrcodeData: Binding<String>, callbackURL: Binding<String>, storeId: Binding<String>, orderId: Binding<String> ,paymentCallbackHandler: @escaping (_ type:String,_ type: Any) -> Void) {
        
        
        
        _state = state
        _userID = userID
        _qrcodeData = qrcodeData
        _callbackURL = callbackURL
        _storeID = storeId
        _orderID = orderId
        
        callback = paymentCallbackHandler
        
    }
    
    public var body: some View {
        VStack {
            if state == "receipt" {
                ReceiptView(userID: $userID, storeID: $storeID, orderID: $orderID)
            } else if state == "scan" {
                SDKPackage(userID: $userID, callbackURL: $callbackURL, qrcodeData: $qrcodeData, paymentCallbackHandler: callback)
            }
        }
    }
}
