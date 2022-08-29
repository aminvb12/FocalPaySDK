//
//  SwiftUIView 2.swift
//  
//
//  Created by amin on 8/28/22.
//

import SwiftUI


public enum StateType {
    case SelfScanning, PaymentResult, Init
}

//public enum callbackType {}



public struct FocalpayAppSDK: View {

    @Binding var state: StateType

    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String


    @Binding var storeID: String
    @Binding var orderID: String
    
    var callback : (_ type: String, _ value:Any?) -> Void
    
    
    public init(currenctState: Binding<StateType> = .constant(.Init
    ) , userID: Binding<String> , qrcodeData: Binding<String>, appUniversalLink: Binding<String>, storeId: Binding<String>, orderId: Binding<String> ,paymentCallbackHandler: @escaping (_ type:String,_ type: Any) -> Void) {
        
        
        
        _state = currenctState
        _userID = userID
        _qrcodeData = qrcodeData
        _callbackURL = appUniversalLink
        _storeID = storeId
        _orderID = orderId
        callback = paymentCallbackHandler
        
    }
    
    public var body: some View {
        VStack {
            if state == .PaymentResult {
                ReceiptView(userID: $userID, storeID: $storeID, orderID: $orderID)
            } else if state == .SelfScanning{
                SDKPackage(userID: $userID, callbackURL: $callbackURL, qrcodeData: $qrcodeData, paymentCallbackHandler: callback)
            }
        }
    }
}
