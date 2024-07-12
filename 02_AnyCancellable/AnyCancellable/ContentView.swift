//  Created by Axel Ancona Esselmann on 7/12/24.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {

    var cancellable: AnyCancellable?

    @Published
    var count = 0

    @Published
    var status = "Timer not started"

    func createTimer() {
        count = 0
        status = "Timer started"
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.update()
        }
        cancellable = AnyCancellable({ [weak self] in
            timer.invalidate()
            self?.status = "Timer canceled"
        })
    }

    private func update() {
        count += 1
        status = "Timer running"
    }

    func cancelTimer() {
        cancellable = nil
    }
}

struct ContentView: View {

    @StateObject
    var vm = ViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("start timer") {
                    vm.createTimer()
                }
                Button("cancel") {
                    vm.cancelTimer()
                }.disabled(vm.cancellable == nil)
            }.padding()
            Text("Count: \(vm.count)")
            Text(vm.status)
        }
        .frame(width: 300, height: 200)
    }
}
