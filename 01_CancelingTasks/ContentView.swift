//  Created by Axel Ancona Esselmann on 7/19/24.
//

import SwiftUI

struct ContentView: View {

    @State
    var status: String = ""

    @State
    var task: Task<(), any Error>?

    var body: some View {
        VStack {
            HStack {
                Button("run") {
                    runTask()
                }.disabled(task != nil)
                Button("cancel") {
                    task?.cancel()
                    status = "Task cancelled"
                }.disabled(task == nil)
            }
            Text(status)
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 200)
    }

    private func runTask() {
        task = Task {
            defer {
                task = nil
            }
            status = "Task has started"
            try await Task.sleep(for: .seconds(3))
            try Task.checkCancellation()
            status = "Middle of task"
            try await Task.sleep(for: .seconds(3))
            try Task.checkCancellation()
            status = "Task has completed"
        }
    }
}
