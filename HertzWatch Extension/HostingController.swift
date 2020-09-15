import Foundation
import SwiftUI
import WatchKit

class HostingController: WKHostingController<ContentView> {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override var body: ContentView {
        return ContentView()
    }
}

struct HostingController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
