//
//  SwiftUIView 2.swift
//  
//
//  Created by amin on 8/24/22.
//

import SwiftUI

struct FinalView: ViewModifier {
    let isEmpty: Bool

        func body(content: Content) -> some View {
            Group {
                if isEmpty {
                    EmptyView()
                } else {
                    content
                }
            }
        }
}

//struct SwiftUIView_2_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalView()
//    }
//}
