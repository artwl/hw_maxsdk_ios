# HWSDK IOS 

本文档是IOS版变现SDK，当前版本 `V7.0`

## 下载地址

SDK 下载地址：[v7.0](https://github.com/artwl/hwsdk_ios/releases/tag/V7.0)

对于unity 2019开发的游戏，接入sdk，可以参考
[示例文档](https://github.com/artwl/hwsdk_ios/blob/master/doc/Unity%202019%E6%8E%A5%E5%85%A5iOS%20SDK%E6%AD%A5%E9%AA%A4.docx)

## 接入文档

接入请参考：[SDK接入文档](https://github.com/artwl/hwsdk_ios/wiki/HwSDK-V7.0%E6%8E%A5%E5%85%A5%E6%96%87%E6%A1%A3)

## 需要帮助？

请先查看接入文档和常见问题，还有问题可联系对接人寻求技术支持

## 本版特性 (7.0 - 2020年9月)

详细内容请查看更新记录，有完整的更新内容列表。
- **7.0 新特性（2020年9月18号）**
 - 1.删除AppsFlyerTracker
 - 2.删除Mintegral广告商和对应的adapter
 - 3.添加LTV2.0打点方法
 
- **6.2 新特性（2020年9月2号）**
 - 1.针对unity 2019上传遇到嵌套动态库的问题，升级sdk，解决这个问题
 
- **6.1 新特性（2020年5月20号）**
 - 1.修复调用插屏有偶现的bug
 
- **6.0 新特性（2020年5月18号）**
 - 1.彻底解决UIWebView的问题
 
- **5.1 新特性（2020年5月13号）**
 - 1.优化内部计算模型
 - 2.修改在系统为9.0时的一个bug
 
- **5.0 新特性（2020年5月7号）**
 - 1.支持一家bidding
 - 2.支持国内本地化渠道

- **4.2 新特性（2020年4月23号）**
 - 1.为了减轻服务端压力，做了小优化；核心代码逻辑没动

- **4.1 新特性（2020年4月5号）**
 - 1.升级vungle到6.5.4 解决UIWebView的问题
   2.为了加快服务端拉取数据的速度，将事件分流处理
 
- **4.0 新特性（2020年3月29号）**
 - 删除苹果4月即将禁用的UIWebView，升级对应广告渠道SDK，解决这个问题
 
- **3.2 新特性（2020年3月25号）**
 - 新增加一家追踪平台
  
- **3.1 新特性（2020年3月17号）**
  - 添加banner是否加载的接口，添加banner加载成功的回调；当激励视频播放失败，抛这个回调 hwAdsRewardedVideoPlayFail，不给奖励恢复游戏逻辑
  
- **3.0 新特性（2020年3月12号）**
  - 添加插屏，激励回调；当广告缓存时间过长，播放该广告会触发播放失败当回调

- **2.7 新特性（2020年3月5号）**
  - 添加激励显示接口；添加推广人员需要打点的api；优化sdk内部变现打点

- **2.6 新特性（2020年1月19号）**
  - 添加插屏回调的接口，目前暴露了显示，关闭的回调

- **2.5 新特性**
  - 支持banner的接口，有banner的最好用这个版本

- **2.4 新特性**
  - 升级sdk，修复无网络进入时，卡主的bug

- **2.3 新特性**
  - 升级sdk，修改了2个接口，初始接口，仅仅需要传项目id的数字就行了

- **2.2 新特性**
  - 升级一家sdk，修复内部打点方式的bug

- **2.1 新特性**
  - 修复插屏控制逻辑的bug

- **2.0 新特性**
  - 支持广点通，穿山甲，Sigmob
