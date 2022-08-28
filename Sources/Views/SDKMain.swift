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

    @Binding var state: StateType

    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String


    @Binding var storeID: String
    @Binding var orderID: String
    
    var callback : (_ type: String, _ value:Any?) -> Void
    
    public var body: some View {
        VStack {
            if state == .receipt {
                ReceiptView(userID: $userID, storeID: $storeID, orderID: $orderID)
            } else if state == .scan {
                SDKPackage(userID: $userID, callbackURL: $callbackURL, qrcodeData: $qrcodeData, paymentCallbackHandler: callback)
            }
        }
    }
}
