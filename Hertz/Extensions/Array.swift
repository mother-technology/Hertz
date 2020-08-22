import Foundation
import Swift

extension Array {
    subscript(circular index: Int) -> Element {
        if index < 0 {
            let i = abs(index) % count
            if i == 0 {
                return self[i]
            }
            
            return self[count - i]
        } else if index >= count {
            return self[index % count]
        } else {
            return self[index]
        }
    }
}
