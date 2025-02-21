//
//  ShareUtility.swift
//
//
//  Created by Taha Mahmoud on 23/01/2024.
//

import Foundation
import UIKit

public struct ShareUtility {
    public static func shareSheet(items: [Any]) {
        let activityViewController = UIActivityViewController(
            activityItems: items, applicationActivities: nil)

        UIApplication.shared.currentUIWindow()?.rootViewController?.present(
            activityViewController, animated: true, completion: nil)
    }
}
