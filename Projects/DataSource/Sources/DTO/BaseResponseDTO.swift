//
//  BaseResponseDTO.swift
//  DataSource
//
//  Created by 최정인 on 6/23/25.
//

struct BaseResponseDTO<T: Decodable>: Decodable {
    let code: String
    let data: T?
    let message: String
}
