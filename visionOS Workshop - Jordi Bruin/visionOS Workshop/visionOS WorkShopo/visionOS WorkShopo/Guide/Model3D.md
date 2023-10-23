//
//  Model3D.swift
//  visionOS WorkShopo
//
//  Created by Jordi Bruin on 01/09/2023.
//

import Foundation

Model3D(url: beer.modelURL) { model in
    model
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 200, height: 200)
} placeholder: {
    ProgressView()
}
