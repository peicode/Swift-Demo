import UIKit

var str = "Hello, playground"

/// 类型协议
protocol TypeWrapperProtocol2{
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

/// 类型协议
protocol TypeWrapperProtocol{
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}
//
struct NamespaceWrapper<T>: TypeWrapperProtocol {
    let wrappedValue: T
    init(value: T) {
        self.wrappedValue = value
    }
}

protocol NamespaceProtocol {
    associatedtype type
    var lpz: type {get}
    static var lpz: type.Type {get}
}

extension NamespaceProtocol {
    var lpz: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    static var lpz: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }

}

//具体实现
extension UIColor: NamespaceProtocol {}

extension TypeWrapperProtocol where WrappedType == UIColor {
    //在这里可以写自己的方法
}



//struct NamespaceWrapper<T>: TypeWrapperProtocol {
//    let warpValue: T
//    init(value: T) {
//        self.warpValue = value
//    }
//}

//extension NamespaceWrappale {
//    var lpz: MyNameSpace<Self> {
//        return May
//    }
//}

//extension NamespaceWrappale {
//    var lpz: NamespaceWrappale   <Self> {
//        return NamespaceWrappale(value: self)
//    }
//}
