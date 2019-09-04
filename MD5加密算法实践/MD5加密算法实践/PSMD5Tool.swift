//
//  PSMD5Tool.swift
//  MD5加密算法实践
//
//  Created by 廖佩志 on 2019/3/4.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import CommonCrypto
class PSMD5Tool: NSObject {
    class func md5(str: String) -> String {
        let cStrl = str.cString(using: .utf8)
        let strLen = CUnsignedInt(str.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStrl, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        free(result)
        return String(hash as String)
    }
}
