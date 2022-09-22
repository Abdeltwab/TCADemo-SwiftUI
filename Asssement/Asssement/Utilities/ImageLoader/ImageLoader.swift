///  ** Credits **
/// Created by Vadim Bulavin
/// Github https://github.com/V8tr/AsyncImage

import Combine
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
                   .map { UIImage(data: $0.data) }
                   .replaceError(with: nil)
                   .receive(on: DispatchQueue.main)
                   .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
