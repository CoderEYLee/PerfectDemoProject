//
//  EYDataBaseManager+User.swift
//  PerfectDemoProject
//
//  Created by gujiabin on 2017/12/14.
//  user的相关操作

extension EYDataBaseManager {


    /// 用户注册账号
    func registerAccount() {
        
    }

    /// 查询t_user表中最大的user_id
    ///
    /// - Returns: 最大的user_id
    func mysqlSelectMaxUserId() -> Int {
        let selectResult = selectDataBase(tableName: table_t_user, selectKey: "user_id", otherSQLString: "ORDER BY user_id ASC;")
        guard let sqlResult = selectResult.result else {
            return -1
        }

        guard sqlResult.numRows() != 0 else {
            return -1
        }

        var user_id = -1
        selectResult.result?.forEachRow(callback: { (row) in
            user_id = Int(row[0]!) ?? -1
        })
        return user_id
    }
    
    //获取t_user表中所有数据
    func mysqlSelectAllUser() -> [Dictionary<String, String>]? {

        let selectResult = selectDataBase(tableName: table_t_user)
        var resultArray = [Dictionary<String, String>]()
        var dic = [String:String]()
        selectResult.result?.forEachRow(callback: { (row) in
            dic["user_id"] = row[0]
            dic["account"] = row[1]
            dic["password"] = row[2]
            resultArray.append(dic)
        })
        return resultArray

    }
}
