import UIKit

let nums1 = [1,2,3,4,5,6,7]
let nums2 = [1,3,4,5,6,7]
var set1 = Set(nums1)
var set2 = Set(nums2)
//并集
set1.union(set2)
//交集
set1.subtracting(set2)

var set3 = set1.intersection(set2)
var nums3 = set3.map { (i) -> Int in
    return i
}

