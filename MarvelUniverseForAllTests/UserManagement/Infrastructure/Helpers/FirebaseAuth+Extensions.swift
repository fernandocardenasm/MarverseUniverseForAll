//
//  FirebaseAuthHelpers.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 06.05.21.
//

import Firebase
import XCTest

extension Auth {
    
    static func deleteAccountsArtifacts() {
        let semaphore = DispatchSemaphore(value: 0)
        let projectId = FirebaseApp.app()!.options.projectID!
        let url = URL(string: "http://localhost:9099/emulator/v1/projects/\(projectId)/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                fatalError("❌ \(#function) completed with Error: \(error). Make sure the emulator is running")
            }
            print("✅ Accounts were deleted successfully")
            semaphore.signal()
        }
        task.resume()
        let result = semaphore.wait(timeout: .now() + 2)
        
        switch result {
        case .success:
            break
        case .timedOut:
            fatalError("❌ \(#function) 🕒 Timedout. Make sure the emulator is running")
        }
    }
}
