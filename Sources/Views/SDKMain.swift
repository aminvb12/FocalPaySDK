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



@available(macOS 10.15, *)
public struct FocalpayAppSDK: View {

    @Binding var state: StateType

    @Binding var userID: String
    @Binding var qrcodeData: String
    @Binding var callbackURL: String

    @Binding var paymentFlowType : PaymentFlowType
    
    var callback : (_ type: String, _ value:Any?) -> Void
    
    
    @State var store_id: String = ""
    @State var order_id: String = ""
    
    
    func handler(topic: String, value: Any?)  -> Void{
        
        switch topic {
        case "payment_parameter":
            
            let dictionery = (value as! [String:String])
            
            let token = dictionery["token"]!
            let storeId = dictionery["storeId"]!
            let orderId = dictionery["orderId"]!
            //
            self.store_id = storeId
            self.order_id = orderId
            
            if(paymentFlowType == .ApplicationContext){
                self.callback(topic,token)
            }
          
            
            break
        default:
            print("default")
        }
        
    }
    
    
    public init(currenctState: Binding<StateType> = .constant(.Init
    ) , userID: Binding<String> , qrcodeData: Binding<String>, appUniversalLink: Binding<String>, paymentCallbackHandler: @escaping (_ type:String,_ type: Any) -> Void, paymentFlowType: Binding<PaymentFlowType> = .constant(.ApplicationContext
    )) {
        
        
        
        _state = currenctState
        _userID = userID
        _qrcodeData = qrcodeData
        _callbackURL = appUniversalLink

        callback = paymentCallbackHandler
        _paymentFlowType = paymentFlowType
        
    }
    
    public var body: some View {
        VStack {
            if state == .PaymentResult {
                ReceiptView( storeID: $store_id, orderID: $order_id, qrcodeData: $qrcodeData)
            } else if state == .SelfScanning{
                SDKPackage(paymentFlowType: $paymentFlowType ,userID: $userID, callbackURL: $callbackURL, qrcodeData: $qrcodeData, paymentCallbackHandler: handler)
 
            }
        }
    }
}
