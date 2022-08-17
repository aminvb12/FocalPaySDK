////
////  File.swift
////
////
////  Created by amin on 8/17/22.
////
//
//import Foundation
//import IonicPortals
//import SwiftUI
//
//
//
//public struct SwiftUIView : View {
//    public init() {
//        PortalsRegistrationManager.shared.register(key: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIzMjI1OTAifQ.WjIrG3xRG9HnRbCQHd7xTINq4pWIkMHt-exeTuFEYFD7RzW1qQo1RahyxP_DdDJU5EsgsESCm6vUPKpHLnkkjLogQp_wiG6HqkcKj6odqt-P4Xe-38oKihXC4PScilAfwOgS9AKTh1LQ7EA5n2wmXLfip7DnjI3xPUkWt1Wo4B_vUWo571bDgdi6He_Kpztt8q1B_TBJDBilEXOBXdxWFAgftSZM4Yrn-u3Kb92-Itu2FpcIqR6w2k_kovRXd3g0RJHB5k_tzC1om9E2k1aUw76yaO30noCQnv4qx1ISugjeXEXFDML10W8uAY4lTreENXFiBdL6ux8_UoF077RFgw")
//      }
//    public var body: some View {
//         VStack {
//           // Using ExpressibleByStringLiteral conformance
//
//           PortalView(portal: .init(name: "PWA", startDir: "PWA"))
//         }
//     }
//}

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct SwiftUIView: View {
    public init() {}
    public var body: some View {
        Text("THIS IS THE SWIFTUIVIEW FROM THE PACKAGE")
    }
}
