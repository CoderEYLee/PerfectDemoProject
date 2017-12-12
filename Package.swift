//软件包管理
import PackageDescription

let versions = Version(0,0,0)..<Version(10,0,0)
let urls = [
    "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",      //HTTP服务
    "https://github.com/PerfectlySoft/Perfect-MySQL.git",           //MySQL服务
    "https://github.com/PerfectlySoft/Perfect-Mustache.git"         //Mustache
]

let package = Package(
    name: "PerfectDemoProject",
    targets: [],
    dependencies: urls.map { .Package(url: $0, versions: versions) }
)

// 作者：LuisX
// 链接：http://www.jianshu.com/p/2ce98b556e89
// 來源：简书
// 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

