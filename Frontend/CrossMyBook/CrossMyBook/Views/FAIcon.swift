//
//  FAIcon.swift
//  CrossMyBook
//
//  Created by Caifei H on 11/5/22.
//

import SwiftUI

struct FAIcon: View {
    var name: String = ""
    var size: Int = 28
    var color: Color = Color.theme
    var style: String = "solid"
    var body: some View {
        if (style == "solid") {
            Text(name).font(.custom("FontAwesome5Free-Solid", size: CGFloat(size))).foregroundColor(color)
        } else {
            // regular
            Text(name).font(.custom("FontAwesome5Free-Regular", size: CGFloat(size))).foregroundColor(color)
        }
        
    }
}

struct FAIcon_Previews: PreviewProvider {
    static var previews: some View {
        FAIcon()
    }
}
