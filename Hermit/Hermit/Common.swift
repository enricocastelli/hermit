

import Foundation

class Values {

    static let maxForce = 6.666666666666667
    static let maxTimeFrame = 0.03

}

struct CollisionType {
    static let hermit : UInt32 = 0x1 << 1
    static let floor : UInt32 = 0x1 << 2
}
