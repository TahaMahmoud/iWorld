//
//  URLUtility.swift
//
//
//  Created by Taha Mahmoud on 23/01/2024.
//

import UIKit

public struct URLUtility {
    public static func openURL(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
