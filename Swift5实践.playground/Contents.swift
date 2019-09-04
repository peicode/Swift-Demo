import UIKit

let nums: [Int] = []

!nums.isEmpty && nums[4] > 0

false && 10 > 11

true && false

false && false


///系统提示：@dynamicCallable attribute requires 'Person' to have either a valid 'dynamicallyCall(withArguments:)' method or 'dynamicallyCall(withKeywordArguments:)' method
@dynamicCallable
struct Person {
    func dynamicallyCall(withArguments names: [Int]) -> [Int] { return names.sorted(by: { (a, b) -> Bool in
        return a>b
    })
    }
    func dynamicallyCall(withKeywordArguments scores: KeyValuePairs <String, Any>) {}
}
//动态调用
let p = Person()
p(1,2,3)
p(label: 1, ss: 2, sdd: 3)
//p.label

///系统提示：@dynamicMemberLookup attribute requires 'People' to have a 'subscript(dynamicMember:)' method with an 'ExpressibleByStringLiteral' parameter
@dynamicMemberLookup
struct People {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Liao", "city": "HuBei"]
        return properties[member, default: "hhhh"]
    }
}
//
let people = People()
people.name
people.city
people.age
people.a


@dynamicCallable @dynamicMemberLookup
struct RubyObject{
    func dynamicallyCall(withArguments names: [Int]) { }
    func dynamicallyCall(withKeywordArguments scores: KeyValuePairs <String, String>) {}

    subscript(dynamicMember name: String) -> String {
        return "liao"
    }
    subscript(dynamicMember address: String) -> [String] {
        return ["huber"]
    }
    subscript(dynamicMember member: String) -> Int {
        return 22
    }
}


let r = RubyObject()

r(1,2,3)
r(name:"lpz",age:"23",address:"hubei")

//这里必须要指定类型, 只有这样才能找到对应的动态类型，名字随便取
//let l: Int = r.a
var s: String = r.name
var s1: [String] = r.wusuowei
var h: Int = r.age
var h1: Int = r.wusuowei

var address: [String] = r.addres


/*
 KeyValuePairs在5.0之前,有点令人困惑地称为DictionaryLiteral是一种有用的数据类型, 它提供了类似字典的功能, 具有以下几个优点:
 1.您的密钥不需要符合Hashable.
 2.您可以使用重复的键添加项。(不会覆盖自定中添加的值)
 3.添加项的顺序将保留。(是DictionAry变有序)
 */

//raw String
let str = ##"//d##"#d"d//"##
let str1 = #"//s\"s"s//"#
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes:"""
"""#
