//  Created by Axel Ancona Esselmann on 7/19/24.
//

import SwiftUI

struct SearchView: View {

    private let networking = Networking()

    @State
    private var query: String = ""

    @State
    private var result: String = ""

    @State
    private var isLoading: Bool = false

    var body: some View {
        VStack {
            TextField("Search", text: $query)
                .padding()
            if isLoading {
                ProgressView()
            } else {
                if !result.isEmpty {
                    Text("Result: \(result)")
                }
            }
            Spacer()
        }
        .padding()
        .onChange(of: query) {
            Task {
                isLoading = true
                result = try await networking.search(query)
                isLoading = false
            }
        }
    }
}
