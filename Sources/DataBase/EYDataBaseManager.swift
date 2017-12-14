//
//  DataBaseManager.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/12.
//

import PerfectMySQL

//MARK: 数据库信息
let mysql_host = "127.0.0.1"                    //访问的ip地址
let mysql_user = "root"                         //数据库的用户名称
let mysql_password = "LIeryang0811013!@#"       //用户的密码
let mysql_database = "east_soft"                //要访问的数据库名称

//MARK: 表信息
/// 用户表
let table_t_user = "t_user"        //表名称

open class EYDataBaseManager {

    static let shared: EYDataBaseManager = EYDataBaseManager()

    fileprivate var mysql: MySQL
    internal init() {
        mysql = MySQL.init()                           //创建MySQL对象
        guard connectDataBase() else {                 //开启MySQL连接
            return
        }
    }

    //MARK: 开启连接
    private func connectDataBase() -> Bool {

        let connected = mysql.connect(host: mysql_host, user: mysql_user, password: mysql_password, db: mysql_database)
        guard connected else {
            EYLog("MySQL连接失败" + mysql.errorMessage())
            return false
        }
        return true

    }

    //获取t_user表中所有数据
    func mysqlSelectAllUser() -> [Dictionary<String, String>]? {

        let result = selectDataBase(tableName: table_t_user)
        var resultArray = [Dictionary<String, String>]()
        var dic = [String:String]()
        result.mysqlResult?.forEachRow(callback: { (row) in
            dic["user_id"] = row[0]
            dic["account"] = row[1]
            dic["password"] = row[2]
            resultArray.append(dic)
        })
        return resultArray

    }

    /// 查询t_user表中最大的user_id
    ///
    /// - Returns: 最大的user_id
    func mysqlSelectMaxUserId() -> Int {
        let result = selectDataBase(tableName: table_t_user, selectKey: "user_id", otherSQLString: "ORDER BY user_id ASC;")
        guard let sqlResult = result.mysqlResult else {
            return -1
        }

        guard sqlResult.numRows() != 0 else {
            return -1
        }

        var user_id = -1
        result.mysqlResult?.forEachRow(callback: { (row) in
            user_id = Int(row[0]!) ?? -1
        })
        return user_id
    }

    //MARK: 执行SQL语句
    /// 执行SQL语句
    ///
    /// - Parameter sql: sql语句
    /// - Returns: 返回元组(success:是否成功 result:结果)
    @discardableResult
    private func mysqlStatement(sql: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {

        guard mysql.selectDatabase(named: mysql_database) else {         //指定database
            return (false, nil, "未找到\(mysql_database)数据库")
        }

        guard mysql.query(statement: sql) else {
            return (false, nil, "SQL失败: \(sql)")
        }
        let msg = "SQL成功: \(sql)"
        return (true, mysql.storeResults(), msg)                            //sql执行成功

    }

    /// 增
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键  （键，键，键）
    ///   - value: 值  ('值', '值', '值')
    func insertDataBase(tableName: String, key: String, value: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String){

        let SQL = "INSERT INTO \(tableName) (\(key)) VALUES (\(value))"
        return mysqlStatement(sql: SQL)

    }

    /// 删
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    ///   - value: 值
    func deleteDataBase(tableName: String, key: String, value: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {

        let SQL = "DELETE FROM \(tableName) WHERE \(key) = '\(value)'"
        return mysqlStatement(sql: SQL)

    }

    /// 改
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对的字符串 ( 键='值', 键='值', 键='值' )
    ///   - whereKey: 查找key
    ///   - whereValue: 查找value
    func updateDataBase(tableName: String, keyValue: String, whereKey: String, whereValue: String) -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {

        let SQL = "UPDATE \(tableName) SET \(keyValue) WHERE \(whereKey) = '\(whereValue)'"
        return mysqlStatement(sql: SQL)

    }

    /// 查
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键

    /// 查
    ///
    /// - Parameters:
    ///   - tableName: 表名
    ///   - selectKey: 需要查询的字段字符串 "(id, XXX, XXX)" 默认为 "*"
    ///   - otherSQLString: 其他SQL语句 "where XXX AND XXX ORDER BY XXX"
    /// - Returns: 返回信息

    func selectDataBase(tableName: String, selectKey: String = "*", otherSQLString: String = "") -> (success: Bool, mysqlResult: MySQL.Results?, errorMsg: String) {

        let SQL = "SELECT \(selectKey) FROM \(tableName) \(otherSQLString)"
        return mysqlStatement(sql: SQL)

    }
}
