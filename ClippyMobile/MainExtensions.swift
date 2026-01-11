//
//  MainExtensions.swift
//  ClippyMobile
//
//  Created by Alan Maia on 11/01/2026.
//

import Foundation
import SwiftUI

extension VStack {
    func defaultStyle() -> some View{
        self
            .padding()
            .lineSpacing(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
