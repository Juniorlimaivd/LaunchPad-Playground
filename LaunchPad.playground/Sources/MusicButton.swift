import Foundation
import UIKit

public class MusicButton: UIButton {
    var position = -1
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
