//
//  News.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 22/04/22.
//

import Foundation

struct News: Codable {
    let status: String
    let sources: [NewsSource]
}

struct NewsSource: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}
