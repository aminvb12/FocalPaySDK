//
//  SwiftUIView 2.swift
//  
//
//  Created by amin on 8/28/22.
//

import SwiftUI


public enum StateType {
    case scan, receipt, none
}



public struct MainSDK: View {

    @Binding var state: StateType

    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String


    @Binding var storeID: String
    @Binding var orderID: String
    
    var callback : (_ type: String, _ value:Any?) -> Void
    
    
    public init(currenctState: Binding<StateType> = .constant(.none
    ) , userID: Binding<String> , qrcodeData: Binding<String>, callbackURL: Binding<String>, storeId: Binding<String>, orderId: Binding<String> ,paymentCallbackHandler: @escaping (_ type:String,_ type: Any) -> Void) {
        
        
        
        _state = currenctState
        _userID = userID
        _qrcodeData = qrcodeData
        _callbackURL = callbackURL
        _storeID = storeId
        _orderID = orderId
        callback = paymentCallbackHandler
        
    }
    
    public var body: some View {
        VStack {
            if state == .scan {
                ReceiptView(userID: $userID, storeID: $storeID, orderID: $orderID)
            } else if state == .receipt{
                SDKPackage(userID: $userID, callbackURL: $callbackURL, qrcodeData: $qrcodeData, paymentCallbackHandler: callback)
            }
        }
    }
}
