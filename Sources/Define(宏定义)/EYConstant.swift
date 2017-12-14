import Foundation
// MARK:--------- 自定义打印方法
func EYLog<T>( _ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {

    #if DEBUG

        let fileName = (file as NSString).lastPathComponent

        print("\(fileName):\(funcName):\(lineNum)行:\(message)")

    #endif
}

/// base uri
let EYBaseURIString = "/user"

//用户注册
let EYRegisterString = "/register"
