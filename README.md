

<!-- PROJECT LOGO -->
<br />
<div align="left">
  <a href="https://github.com/FocalpaySDK">
    <img src="img/focalpay-logo.png" alt="Logo" width="160">
  </a>

  <h3 align="left">FocalpaySDK</h3>


<!-- ABOUT THE PROJECT -->
## About The Project


`FocalpaySDK` is a standalone package that can be integrated with applications developed in Swift language.


### Built With


* [![Swift][Swift]][Swift-url]



<!-- GETTING STARTED -->
## Getting Started

Below you have the instructions on how to setup your project locally and intregrate the SDK into your application.
To get a local copy follow the steps below.

### Installation
  
Using SPM, add https://github.com/Focalpay/FocalpaySDK in the Xcode "Swift Package Dependencies" tab in the project configuration.
In order to setup the access to private repository in Github, please refer to this [[link]](https://stackoverflow.com/questions/47842479/how-to-use-swift-package-manager-with-private-repos)

<!-- USAGE EXAMPLES -->
## Basic Usage
You should import `FocalpaySDK` into your program and then initiate the SDK with these parameters:
* currentState : Enum{`case SelfScanning, PaymentResult, Init`} as StateType 
* userId : String
* qrcodeData : String  
* appUniversalLink : String
* storeId : String
* orderId : String
* paymentCallbackHandler : Callback Function
 
## Examples

Here is a sample code of a very simple Swift application integrating `FocalpaySDK`:

```swift

import SwiftUI
import CodeScanner
import FCUUID
import FocalPaySDK



struct QRCodeScannerView: View {
    
    @State private var isPresentingScanner = false
    @State private var userID: String = FCUUID.uuidForDevice()
    @State private var callbackURL: String = ""
    @State private var showSDK = false
    @State private var showReceipt = false
    @State private var scannedCode = ""
    
    @State private var store_id: String = ""
    @State private var order_id: String = ""
    
    @State private var currentState: StateType = .Init
    
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
            
            
            let swishURL = URL(string: "swish://paymentrequest?token=\(token)&callbackurl=sdk-integeration://\(storeId)-\(orderId)")!
            
            
            
            if UIApplication.shared.canOpenURL(swishURL)
            {
                
                UIApplication.shared.open(swishURL)
            }
            
            break
        default:
            print("default")
        }
        
        
    }
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 2) {
                
                if currentState != .Init {
                    
                    
                    NavigationLink("FocalPaySDK", destination:
                                    FocalpayAppSDK(currenctState: $currentState , userID: $userID, qrcodeData: $scannedCode, appUniversalLink: $callbackURL, storeId: $store_id, orderId: $order_id, paymentCallbackHandler: handler),isActive: $showSDK).hidden().navigationBarTitle("",displayMode: .inline)
                        .navigationBarHidden(true)
                }
                
                
                Button("Check-in to store") {
                    showSDK = false
                    isPresentingScanner = true
                }
                
                Text("Scan the QR-Code to check-in to store.")
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        scannedCode = result.string
                        showSDK = true
                        isPresentingScanner = false
                        currentState = .SelfScanning
                    }
                }
            }
            .onOpenURL { url in
                currentState = .PaymentResult
            }
            
            
            
        }
    }
    
}



```  

<!-- LICENSE -->
## License
This program is only distributed to Focalpay partners only and any redistribution of it is strictly prohibited.



<!-- CONTACT -->
## Contact
  contact@focalpay.se

Project Link: [[https://github.com/Focalpay/FocalpaySDK]](https://github.com/Focalpay/FocalpaySDK)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
[Swift]: https://img.shields.io/badge/swift-20232A?style=for-the-badge&logo=swift&logoColor=61DAFB
[Swift-url]: https://Swift.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/

