//
//  EYDataBaseManager+User.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/14.
//  user的相关操作

extension EYDataBaseManager {

    /// 用户注册账号
    func registerAccount(account: String, password: String) ->(isSuccess: Bool, data: [String : String], errorCode: Int) {

        let selectResult = selectDataBase(tableName: table_t_user, otherSQLString: "WHERE account = '\(account)'")
        guard selectResult.result?.numRows() == 0 else {
            EYLog("该用户名已经存在")
            return (false, ["account" : account, "password" : password], EYErrorCodeAccountExists)
        }

        let user_id = mysqlSelectMaxUserId() + 1
        let name = account
        let insertResult = insertDataBase(tableName: table_t_user, key: "(user_id, account, password, name)", value: "(\(user_id), '\(account)', '\(password)', '\(name)')")
        return (insertResult.isSuccess, ["account" : account, "password" : password], insertResult.isSuccess ? EYErrorCodeNull : EYErrorCodeRegister)
    }

    /// 用户登录账号
    func loginAccount(account: String, password: String) ->(isSuccess: Bool, data: [String : String], errorCode: Int) {
        let selectResult = selectDataBase(tableName: table_t_user, selectKey: "(password)", otherSQLString: "WHERE account = '\(account)'")
        if selectResult.result?.numRows() == 0 {
            EYLog("该用户名不存在")
            return (selectResult.isSuccess, ["account" : account, "password" : password], EYErrorCodeAccountNotExists)
        } else {
            var errorCode = EYErrorCodeAccountPassword
            selectResult.result?.forEachRow(callback: { (row) in
                if password.elementsEqual(row[0]!) {
                    errorCode = EYErrorCodeNull
                }
            })

            return (selectResult.isSuccess, ["account" : account, "password" : password], errorCode)
        }
    }

    /// 查询t_user表中最大的user_id
    ///
    /// - Returns: 最大的user_id
    private func mysqlSelectMaxUserId() -> Int {
        let selectResult = selectDataBase(tableName: table_t_user, selectKey: "user_id", otherSQLString: "ORDER BY user_id ASC;")
        guard let sqlResult = selectResult.result else {
            return 0
        }

        guard sqlResult.numRows() != 0 else {
            return 0
        }

        var user_id = 0
        selectResult.result?.forEachRow(callback: { (row) in
            user_id = Int(row[0]!) ?? 0
        })
        return user_id
    }
}
