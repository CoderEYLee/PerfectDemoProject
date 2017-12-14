import Foundation
// MARK:--------- 自定义打印方法
func EYLog<T>( _ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {

    #if DEBUG

        let fileName = (file as NSString).lastPathComponent

        print("\(fileName):\(funcName):\(lineNum)行:\(message)")

    #endif
}

// MARK: ----------------------数据库信息----------------------
let mysql_host = "127.0.0.1"                    //访问的ip地址
let mysql_user = "root"                         //数据库的用户名称
let mysql_password = "LIeryang0811013!@#"       //用户的密码
let mysql_database = "east_soft"                //要访问的数据库名称

// MARK: ------------------------表信息------------------------
/// 用户表
let table_t_user = "t_user"

/// base uri
let EYBaseURIString = "/user"

/// 用户注册
let EYRegisterString = "/register"
