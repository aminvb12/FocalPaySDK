

<!-- PROJECT LOGO -->
<br />
<div align="left">
  <a href="https://github.com/FocalpaySDK">
    <img src="img/focalpay-logo.png" alt="Logo" width="120">
  </a>

  <h3 align="left">FocalpaySDK</h3>


<!-- ABOUT THE PROJECT -->
## About The Project


`FocalpaySDK` is a standalone package that integrates with applications which developed with `SWIFT` language.


### Built With


* [![Swift][Swift]][Swift-url]
* [![React][React.js]][React-url]



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Installation

Add this Swift package in Xcode using its Github repository url.
  
  * SPM
  ```
  Add https://github.com/aminvb12/FocalpaySDK in the Xcode "Swift Package Dependencies" tab in the project configuration.
  The suggested version range is "Up to Next Minor Version" to prevent auto-updating
  to a breaking version before Ionic Portals iOS reaches version 1.0
  ```
<!-- USAGE EXAMPLES -->
## Basic Usage
You should import `FocalpaySDK` and then init the SDK with these parameters:
* currentState : Enum{case scan,receipt,none} as StateType 
* userId : String
* qrcodeData : String  
* callBackURL : String
* storeId : String
* orderId : String
* handler : Callback Function
  
## Examples

Here's an example on how to integrate the `FocalpaySDK`:

```swift
import SwiftUI
import CodeScanner
import FCUUID
import FocalpaySDK

struct ExampleView: View {
    
    @State private var isPresentingScanner = false
    @State private var userID: String = FCUUID.uuidForDevice() // user unique id  
    @State private var callbackURL: String = "" // callbackURL is called after the payment is finished. It should be URL- encoded and can be for example an app URL or a web URL
    @State private var showSDK = false
    @State private var scannedCode = ""
    
    @State private var store_id: String = ""
    @State private var order_id: String = ""
    
    @State private var currentState: StateType = .none // currentState is the running state of SDK 
    
    func handler(topic: String, value: Any?)  -> Void{
        // callback function for the purpose of fetching Swish payment token, orderId and storeId
        
        switch topic {
        case "payment_parameter":
              
            let dictionery = (value as! [String:String])
            let token = dictionery["token"]!
            let storeId = dictionery["storeId"]!
            let orderId = dictionery["orderId"]!
            
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
                
                if currentState != .none {
                // create a new instance of FocalPaySDK
                    
                    NavigationLink("FocalPaySDK", destination:
                                    MainSDK(currenctState: $currentState , userID: $userID, qrcodeData: $scannedCode, callbackURL: $callbackURL, storeId: $store_id, orderId: $order_id, paymentCallbackHandler: handler),isActive: $showSDK).hidden().navigationBarTitle("",displayMode: .inline)
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
                        currentState = .scan // change the state of running SDK to the scan mode
                    }
                }
            }
            .onOpenURL { url in
                currentState = .receipt // change the state of running SDK to the receipt mode
            }

        }
    }
    
}
```  

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)





<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)





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
