//
//  Constants.swift
//  client
//
//  Created by Luke on 10/16/25.
//

import Foundation

struct Constants {
    struct Urls {
        static let register: URL = {
            guard let url = URL(string: "http://localhost:8080/api/auth/register") else {
                fatalError("Invalid register URL")
            }
            return url
        }()
    }
}
