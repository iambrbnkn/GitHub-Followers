//
//  File.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let placeHolderImg = UIImage(named: "avatar-placeholder")
    static let emptyStateImg  = UIImage(named: "empty-state-logo")
}


enum ScreenSize {
    static let screenWidth        = UIScreen.main.bounds.size.width
    static let screenHeight       = UIScreen.main.bounds.size.height
    static let screenMaxLength    = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let screenMinLength    = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

enum DeviceType {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isIphoneSE               = idiom == .phone && ScreenSize.screenMaxLength <= 568.0
    static let isIphone8                = idiom == .phone && ScreenSize.screenMaxLength == 667.0 && nativeScale == scale
    static let isIphone8Zoom            = idiom == .phone && ScreenSize.screenMaxLength == 667.0 && nativeScale > scale
    static let isIphone8Plus            = idiom == .phone && ScreenSize.screenMaxLength == 736.0
    static let isIphone8PlusZoom        = idiom == .phone && ScreenSize.screenMaxLength == 736.0 && nativeScale < scale
    static let isIphoneX                = idiom == .phone && ScreenSize.screenMaxLength == 812.0
    static let isIphoneXMaxAndXr        = idiom == .phone && ScreenSize.screenMaxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.screenMaxLength >= 1024.0
    
    static func isIphoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXMaxAndXr
    }
}
