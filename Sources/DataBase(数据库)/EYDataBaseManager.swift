//
//  DataBaseManager.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/12.
//

import PerfectMySQL

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

    // MARK: ----------------------Public Methods----------------------
    /// 增
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键  （键，键，键）
    ///   - value: 值  ('值', '值', '值')
    /// - Returns: 返回元组(isSuccess:是否成功 result:结果 error:错误原因)
    @discardableResult
    func insertDataBase(tableName: String, key: String, value: String) -> (isSuccess: Bool, result: MySQL.Results?, error: String?){

        let SQL = "INSERT INTO \(tableName) (\(key)) VALUES (\(value));"
        return mysqlStatement(sql: SQL)

    }

    /// 删
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - key: 键
    ///   - value: 值
    /// - Returns: 返回元组(isSuccess:是否成功 result:结果 error:错误原因)
    @discardableResult
    func deleteDataBase(tableName: String, key: String, value: String) -> (isSuccess: Bool, result: MySQL.Results?, error: String?) {

        let SQL = "DELETE FROM \(tableName) WHERE \(key) = '\(value)';"
        return mysqlStatement(sql: SQL)

    }

    /// 改
    ///
    /// - Parameters:
    ///   - tableName: 表
    ///   - keyValue: 键值对的字符串 ( 键='值', 键='值', 键='值' )
    ///   - whereKey: 查找key
    ///   - whereValue: 查找value
    /// - Returns: 返回元组(isSuccess:是否成功 result:结果 error:错误原因)
    @discardableResult
    func updateDataBase(tableName: String, keyValue: String, whereKey: String, whereValue: String) -> (isSuccess: Bool, result: MySQL.Results?, error: String?) {

        let SQL = "UPDATE \(tableName) SET \(keyValue) WHERE \(whereKey) = '\(whereValue)';"
        return mysqlStatement(sql: SQL)

    }

    /// 查
    ///
    /// - Parameters:
    ///   - tableName: 表名
    ///   - selectKey: 需要查询的字段字符串 "(id, XXX, XXX)" 默认为 "*"
    ///   - otherSQLString: 其他SQL语句 "WHERE XXX AND XXX ORDER BY XXX"
    /// - Returns: 返回元组(isSuccess:是否成功 result:结果 error:错误原因)
    @discardableResult
    func selectDataBase(tableName: String, selectKey: String = "*", otherSQLString: String = "") -> (isSuccess: Bool, result: MySQL.Results?, error: String?) {

        let SQL = "SELECT \(selectKey) FROM \(tableName) \(otherSQLString);"
        return mysqlStatement(sql: SQL)

    }

    // MARK: ----------------------Private Methods----------------------
    /// 执行SQL语句
    ///
    /// - Parameter sql: sql语句
    /// - Returns: 返回元组(isSuccess:是否成功 result:结果 error:错误原因)
    @discardableResult
    private func mysqlStatement(sql: String) -> (isSuccess: Bool, result: MySQL.Results?, error: String?) {

        guard mysql.selectDatabase(named: mysql_database) else {
            EYLog("未找到\(mysql_database)数据库")
            return (false, nil, "未找到\(mysql_database)数据库")
        }

        guard mysql.query(statement: sql) else {
            EYLog("执行SQL失败: \(sql)")
            return (false, nil, "SQL失败: \(sql)")
        }

        EYLog("执行SQL成功: \(sql)")
        return (true, mysql.storeResults(), nil)    //sql执行成功
    }
}
