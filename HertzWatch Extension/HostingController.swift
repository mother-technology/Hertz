import Foundation
import SwiftUI
import WatchKit

class HostingController: WKHostingController<AnyView> {
    var model: HertzViewModel!
    var hrvModel: WorkoutManager!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.model = (WKExtension.shared().delegate as! ExtensionDelegate).model
        self.hrvModel = (WKExtension.shared().delegate as! ExtensionDelegate).hrvModel
    }
    
    override var body: AnyView {
        return AnyView(ContentView().environmentObject(model).environmentObject(hrvModel))
    }
}

struct HostingController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
