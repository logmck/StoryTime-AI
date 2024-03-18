//
//  AdViewRepresentable.swift
//  AI Storytime
//
//  Created by Log on 8/10/23.
//

import Foundation
import SwiftUI

struct AdViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AdViewController {
        return AdViewController()
    }
    
    func updateUIViewController(_ uiViewController: AdViewController, context: Context) {
        // Update logic (if needed)
    }
}
