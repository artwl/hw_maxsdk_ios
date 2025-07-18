# HWSDK iOS 

本文档是iOS版变现SDK，当前版本 `V9.8.21`

## 下载地址

SDK 下载地址：[v9.8.21](https://github.com/artwl/hw_maxsdk_ios/releases/tag/V9.8.21)


## 接入文档

接入请参考：[SDK接入文档,飞书文档](https://hellowd.feishu.cn/docs/doccnM0dCN19JMcNyOLTruK80Ud#)

## 需要帮助？

请先查看接入文档和常见问题，还有问题可联系对接人寻求技术支持

## 本版特性 (9.8.21 - 2025年7月)

详细内容请查看更新记录，有完整的更新内容列表。
- **9.8.21 新特性（2025年7月7号）**
  - 1.更新第三方库版本，支持谷歌ICM
  - 2.添加SKA值

- **9.8.18 新特性（2025年4月22号）**
  - 1.更新第三方库版本
  - 2.添加完全境外用户判断逻辑

- **9.8.17 新特性（2025年4月14号）**
  - 1.更新第三方库版本
  - 2.添加针对GA4的用户意见征求设置

- **9.8.15 新特性（2025年3月10号）**
  - 1.更新第三方库版本
  - 2.添加SDK内打点
    
- **9.8.13 新特性（2024年12月23号）**
  - 1.更新第三方库版本
    
- **9.8.11 新特性（2024年10月22号）**
  - 1.新增打点
    
- **9.8.8 新特性（2024年9月14号）**
  - 1.更新第三方库
  - 2.adjust更新至V5版本

- **9.8.7 新特性（2024年7月12号）**
  - 1.优化SDK
        
- **9.8.6 新特性（2024年6月5号）**
  - 1.优化SDK
  - 2.新增SDK打点
    
- **9.8.3 新特性（2024年5月16号）**
  - 1.新增adjust SDK签名功能

- **9.8.2 新特性（2024年4月29号）**
  - 1.更新第三方库版本
  - 2.支持苹果隐私政策的SDK签名

- **9.8.0 新特性（2024年4月7号）**
  - 1.更新第三方库版本
  - 2.支持Privacy Manifest
    
- **9.7.9 新特性（2024年2月19号）**
  - 1.更新第三方库版本
  - 2.支持Google DMA
    
- **9.7.8 新特性（2024年1月24号）**
  - 1.更新AppLovin版本至12.1.0，更新其他第三方库版本
  - 2.支持Google CMP

- **9.7.0 新特性（2022年10月11号）**
  - 1.更新AppLovin版本至11.5.0，更新其他第三方库版本
  - 2.修复 iOS 15.7 -[ALStoreKitProductViewController sceneDisconnected:] 崩溃。 请注意，此崩溃仅在用户退出应用程序时发生，因此用户体验不受影响。
  - 3.新增V1LTV打点，删掉旧的LTV打点
  
- **9.5.1 新特性（2022年9月7号）**
  - 1.添加广告展示时的Firebase打点
  - 2.修改广告打点时机，和Android端保持一致
  - 3.修改广告渠道名称，和Android端保持一致
  
- **9.5.0 新特性（2022年8月24号）**
  - 1.更新第三方SDK版本
  - 2.初始化接口添加isFirebase字段，如需要接入Firebase传YES，否则传NO 
  
- **9.4.0 新特性（2022年7月27号）**
  - 1.更新第三方SDK版本
  - 2.添加Firebase Crashlytics 
  - 3.添加内购是否打点的逻辑判断

- **9.3.3 新特性（2022年7月12号）**
  - 1.修改内购接口ProductId商品ID需传入苹果后台创建的商品编号（是一串数字）
  
- **9.3.2 新特性（2022年7月7号）**
  - 1.更新AppLovin至11.4.3版本，Mintegral至7.1.7版本
  
- **9.3.1 新特性（2022年6月27号）**
  - 1.优化判断本地缓存的逻辑。

- **9.3.0 新特性（2022年6月15号）**
  - 1.新用户请求服务端失败后SDK会读取本地hw-services.plist配置加载广告。
  - 2.更新AppLovin-SDK至11.4.1版本。
  - 3.请求间隔时间调整为15秒。
  - 4.服务端参数解析失败时SDK打点hwServiceErrorToken事件到Adjust。

- **9.2.0 新特性（2022年4月24号）**
  - 1.内购LTV加上SDK和应用版本号
  - 2.更新第三方广告SDK和Adjust SDK至新版本
  - 3.优化SDK代码逻辑，添加日志TAG：HWLog
  - 4.添加监控网络状态，恢复网络时立即重新加载广告

- **9.1 新特性（2022年3月28号）**
  - 1.内购LTV，加上版本号；
  - 2.去掉和服务端的二次验证的逻辑；先打点，后验证

- **9.0.1 新特性（2022年3月10号）**
  - 1.广告LTV细化，增加时间戳等相关信息；用于更精准的计算LTV

- **8.2 新特性（2022年2月17号）**
  - 1.目前发现内购的LTV不准确，增加了3个参数，保留旧的打点方式，同时用新的方式均打点；校正内购的LTV打点
  
  /// 内购完成打点方法，二次验证也在这个方法内包含不需要再进行二次验证
  
  /// @param number 转换成美元的价格
  
  /// @param myProductId 商品ID
  
  /// @param myPurchaseType 商品类型，1是订阅，0是普通商品
  
  /// @param myOrderId 订单ID
  
  (void)hwAnalyticsPurchaseByNumberOfDollars:(NSString *)number
  
                                   productId:(NSString *)myProductId
                                   
                                   purchaseType:(NSString *)myPurchaseType
                                   
                                   orderId:(NSString *)myOrderId;
  

- **8.1.5 新特性（2021年12月23号）**
  - 1.更新SDK，添加smatto渠道
  
- **8.1.4 新特性（2021年12月23号）**
  - 1.更新SDK应对iOS15上线广告平台可能做的修改
  
- **8.1.4 新特性（2021年11月10号）**
  - 1.升级MaxSDK，保持CSJ和FacebookSDK最新
  
- **8.1.2 新特性（2021年9月2号）**
  - 1.升级MaxSDK，保持CSJ和FacebookSDK最新

- **8.1.1 新特性（2021年8月20号）**
  - 1.升级MaxSDK，保持CSJ等SDK最新

- **8.1.0 新特性（2021年7月6号）**
  - 1.升级MaxSDK，保持Facebook等SDK最新
  - 2.把内购金额打入adjust后台

- **8.0.2 新特性（2021年7月1号）**
  - 1.移除Facebook分析相关代码

- **8.0.1 新特性（2021年6月8号）**
  - 1.添加iOS14.5以上ATT打点
  - 2.Google开屏广告，添加代理方法，用于开发人员开屏打点

- **8.0.0 新特性（2021年6月8号）**
  - 1.1.升级MaxSDK至最新，使用Max同意流

- **7.9.3 新特性（2021年5月17号）**
  - 1.ATT弹窗逻辑修改，iOS14.5以后才会弹出

- **7.9.2 新特性（2021年4月26号）**
  - 1.添加Adjust弹窗

- **7.9.1 新特性（2021年4月19号）**
  - 1.移除关于iOS14的自定义弹窗
  - 2.添加分析广告用户行为的打点事件
  - 3.添加Google开屏广告弹出的控制时间

- **7.9.0 新特性（2021年4月15号）**
  - 1.升级Max版本至最新
  - 2.升级自定义弹出框的打点逻辑，添加新的打点点位
 
- **7.8.3 新特性（2021年4月10号）**
  - 1.升级Adjust
 
- **7.8.2 新特性（2021年4月2号）**
  - 1.开屏广告合并入SDK，并添加控制开关和LTV打点
 
- **7.8.1 新特性（2021年3月18号）**
  - 1.添加次留的打点方法
 
- **7.8.0 新特性（2021年3月11号）**
  - 1.升级SDK至最新版本
  - 2.Facebook6.3.0，Google8.1.0，FB打点9.0.1
 
- **7.7.1 新特性（2021年3月4号）**
  - 1.更新Facebook至6.2.1
  - 2.添加Google的开屏广告
 
- **7.7.0 新特性（2021年2月2号）**
  - 1.更新最新版本SDK（紧急更新FB到6.2.1）
  - 2.把IDFA权限请求从SDK中挪出来，解决提包时候报找不到权限请求代码的问题
 
- **7.6.1 新特性（2021年1月18号）**
  - 1.修改Facebook设置setAdvertiserTrackingEnabled的逻辑
 
- **7.6.0 新特性（2021年1月13号）**
  - 1.升级Max到6.14.11其他广告渠道升级到最新
  - 2.主要应对Facebook6.2.1和unity3.5.1和穿山甲3.3.6.2关于iOS14的支持
  - 3.加入GDT，并解决GDT导致的拔掉线无法启动的问题
 
- **7.5.1 新特性（2020年1月6号）**
  - 1.内购打点方法修改，隐藏原来的打点方法，移除原来不相关的系统方法

- **7.5.0 新特性（2020年12月28号）**
  - 1.升级adjust
  - 2.升级Max最新版本，广告渠道也都进行了最新的升级。
  - 3.新加Fyber和Mintegral两家渠道商
  - 4.添加ATT自定义弹窗，应对iOS14IDFA权限问题
  - 5.隐藏sdk广告的Load方法
  - 6.修复加载成功的时间打点异常问题

- **7.4.4 新特性（2020年12月22号）**
  - 1.移除广点通SDK，解决部分设备把应用杀进程之后无法启动的问题。
  - 2.修复Facebook打点方法导致的播放完广告不能连续加载的问题。

- **7.4.3 新特性（2020年11月23号）**
  - 1.新增isFaceBookInter接口
  - 2.在关闭插屏广告回调中新增一个参数：用来判断是否为Facebook或者Admob广告商

- **7.4.2 新特性（2020年11月20号）**
  - 1.升级SDK到6.14.6版本
  - 2.添加三家广告商
  - 3.修复max激励广告回调不及时的问题

- **7.2.1 新特性（2020年10月15号）**
  - 1.把两个内购打点拆分
 
- **7.2 新特性（2020年9月30号）**
  - 1.针对推广AEO投放，增加功能支持，需要开发打对应的5个事件，调用方法见文档

- **7.1 新特性（2020年9月28号）**
  - 1.使用Facebook 5.10.1.1最新版本SDK替换5.9.0版本SDK，用于解决新APP无法展示Facebook广告问题。
 
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
  - 2.为了加快服务端拉取数据的速度，将事件分流处理
 
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
