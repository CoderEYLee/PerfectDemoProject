# PerfectDemoProject
利用Perfectk(Swift语言)框架 在MAC电脑上搭建服务器

因为Perfect框架的限制,想要提交.build/下的所有三方框架,需要修改每个三方框架中的.gitignore 所以没有将 .build/下的文件提交 实际上实际开发中也不建议提交

本Demo实用步骤:                    
### 1> 下载本工程
```
git clone https://github.com/lieryang/PerfectDemoProject.git
```
### 2> 终端中执行以下指令 
```
cd PerfectDemoProject
swift build (过程可能有点长,时间长短就看你的网速啦!!!) 
```

### 3> 修改EYConstant.swift 文件中数据库信息和表信息
```
// MARK: ----------------------数据库信息----------------------
let mysql_host = "127.0.0.1"        //访问的ip地址
let mysql_user = "root"             //数据库的用户名称
let mysql_password = "123456"       //用户的密码
let mysql_database = "testDataBase" //要访问的数据库名称

// MARK: ------------------------表信息------------------------
/// 用户表
let table_t_user = "t_user"
```
