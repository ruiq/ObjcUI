//
//  UIViewController_Preview.swift
//  ObjcUI_Example
//
//  Created by ruiq on 2021/1/18.
//  Copyright © 2021 liruiqin. All rights reserved.
//

import Foundation
import UIKit


#if canImport(SwiftUI)

import SwiftUI
@available(iOS 13.0, *)
struct UIViewController_Preview: PreviewProvider, UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    static var previews: some View {
        UIViewController_Preview()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<UIViewController_Preview>) -> UIViewController {
        let vc = PXXViewController3()
        return vc;
        vc.title = "Preview"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<UIViewController_Preview>) {
        
    }
}
#endif
