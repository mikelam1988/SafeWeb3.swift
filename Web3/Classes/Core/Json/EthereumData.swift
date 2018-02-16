//
//  EthereumData.swift
//  Web3
//
//  Created by Koray Koska on 11.02.18.
//

import Foundation
import VaporBytes

public struct EthereumData: BytesConvertible {

    public let bytes: Bytes

    public init(bytes: Bytes) {
        self.bytes = bytes
    }

    public func makeBytes() -> Bytes {
        return bytes
    }

    public func hex() -> String {
        return bytes.hexString(prefix: true)
    }
}

extension EthereumData: EthereumValueConvertible {

    public static func string(_ string: String) throws -> EthereumData {
        return try self.init(ethereumValue: .string(string))
    }

    public init(ethereumValue: EthereumValue) throws {
        guard let str = ethereumValue.string else {
            throw EthereumValueInitializableError.notInitializable
        }

        try self.init(bytes: str.hexBytes())
    }

    public func ethereumValue() -> EthereumValue {
        return EthereumValue(stringLiteral: bytes.hexString(prefix: true))
    }
}

public extension EthereumValue {

    public var ethereumData: EthereumData? {
        return try? EthereumData(ethereumValue: self)
    }
}