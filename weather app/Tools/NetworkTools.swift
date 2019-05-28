//
//  NetworkTools.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

// MARK:- Network helpers
enum Result<T> {
    case success(_ value: T)
    case err(_ err: Error)
}

typealias completion<T> = (Result<T>)->Void
