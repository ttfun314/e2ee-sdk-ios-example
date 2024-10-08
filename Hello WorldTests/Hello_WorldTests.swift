//
//  Hello_WorldTests.swift
//  Hello WorldTests
//
//  Created by Thien Nguyen on 6/10/24.
//

import Testing
import XCTest
import Foundation;
@testable import Hello_World

struct Hello_WorldTests {

    @Test func example() async throws {
        let cryptoManager = CryptoSDK()

                // Specify a key size for key generation
                let keySize: UInt32 = 2048

                // Generate keys
                let (privateKey, publicKey) = cryptoManager.generateKeys(keySize: keySize)
                // Ensure keys are not nil
                XCTAssertNotNil(privateKey, "Private key should not be nil")
                XCTAssertNotNil(publicKey, "Public key should not be nil")

                // Test encryption
                let message = "Hello, World!"
                let encryptedMessage = cryptoManager.encryptMessage(msg: message, publicKey: publicKey!)
                let foo = encryptedMessage!
                print("encrypted", foo)

                XCTAssertNotNil(encryptedMessage, "Encrypted message should not be nil")

                // Test decryption
                let decryptedMessage = cryptoManager.decryptMessage(cipher: encryptedMessage!, privateKey: privateKey!)
                let foo2 = decryptedMessage!


                XCTAssertEqual(decryptedMessage, message, "Decrypted message should match the original message")
    }

}

class CryptoSDK {
    // Encrypt a message using the provided public key
    func encryptMessage(msg: String, publicKey: String) -> String? {
        let cMsg = msg.cString(using: .utf8)
        let cPublicKey = publicKey.cString(using: .utf8)

        if let encryptedCStr = encrypt_ffi(cMsg, cPublicKey) {
            let encryptedMessage = String(cString: encryptedCStr)
            free_c_string(UnsafeMutablePointer(mutating: encryptedCStr)) // Free the C string memory
            return encryptedMessage
        }
        return nil
    }
    
    // Decrypt a message using the provided private key
    func decryptMessage(cipher: String, privateKey: String) -> String? {
        // Convert Swift strings to C strings
        let cCipher = cipher.cString(using: .utf8)
        let cPrivateKey = privateKey.cString(using: .utf8)

        // Call the C function
        if let decryptedCStr = decrypt_ffi(cCipher, cPrivateKey) {
            let decryptedMessage = String(cString: decryptedCStr)
            free_c_string(UnsafeMutablePointer(mutating: decryptedCStr)) // Free the C string memory
            return decryptedMessage
        }
        return nil
    }
    
    // Generate a pair of RSA keys, passing the key size as a parameter
    func generateKeys(keySize: UInt32) -> (privateKey: String?, publicKey: String?) {
        // Call the FFI function to generate keys with the specified key size
        let keyPair = generate_keys_ffi(keySize)

        // Convert C strings to Swift strings
        if let privateKeyCStr = keyPair.private_key, let publicKeyCStr = keyPair.public_key {
            let privateKey = String(cString: privateKeyCStr)
            let publicKey = String(cString: publicKeyCStr)
            return (privateKey, publicKey)
        }
        return (nil, nil)
    }
}
