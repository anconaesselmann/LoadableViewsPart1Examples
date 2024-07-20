//  Created by Axel Ancona Esselmann on 7/19/24.
//

import SwiftUI
import Combine

class Networking {

    var requestsMade = 0

    var cancellable: AnyCancellable?

    func search(_ query: String) async throws -> String {
        let task = Task {
            requestsMade += 1
            let currentRequest = requestsMade
            try await Task.sleep(for: .seconds(Double.random(in: 0.01...5)))
            try Task.checkCancellation()
            return "Query: \"\(query)\", Request#: \(currentRequest)"
        }
        cancellable = AnyCancellable(task.cancel)
        return try await task.value
    }
}
