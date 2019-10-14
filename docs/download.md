# Download

<!--Version | Support | File Size | Md5 | Download-->
<!--:--|:--|:--|:--|:---->
<!--V1.0.0|N900|1.3M|856ade9a80c68f6edeab34543cc4f889|[POS-demo-master.zip](https://codeload.github.com/Candy0322/POS-demo/zip/master)-->

Version | Support | Download
:--|:--|:--
V2.0.0|N900|[POS-demo-2.0.0.zip](https://git.cardinfolink.net/Cardinfolink/pos-demo/repository/v2.0.0/archive.zip)
V1.0.4|N900|[POS-demo-1.0.4.zip](https://git.cardinfolink.net/Cardinfolink/pos-demo/repository/v1.0.4/archive.zip)
V1.0.2|N900|[POS-demo-1.0.2.zip](https://git.cardinfolink.net/Cardinfolink/pos-demo/repository/v1.0.2/archive.zip)
V1.0.1|N900|[POS-demo-1.0.1.zip](https://git.cardinfolink.net/Cardinfolink/pos-demo/repository/v1.0.1/archive.zip)
V1.0.0|N900|[POS-demo-1.0.0.zip](https://git.cardinfolink.net/Cardinfolink/pos-demo/repository/v1.0.0/archive.zip)

> 注意：v2.1.3以及后续sdk版本使用Jcenter管理（`最新版本:2.2.4`）

```gradle
compile 'com.cardinfolink.smart.pos:PosSDK:"latestVersion"'
```
or

```maven
<dependency>
  <groupId>com.cardinfolink.smart.pos</groupId>
  <artifactId>PosSDK</artifactId>
  <version>"latestVersion"</version>
  <type>pom</type>
</dependency>
```


# Change Log

* V2.2.4

 1、优化了双应用的主控占用体验<br>
 2、更改https证书<br>

* V2.2.3

 1、适配新大陆N910设备<br>
 2、订单查询、交易统计、交易结算接口优化升级<br>
 3、打印交易结果时，打印成功、失败条件优化<br>
 4、部分bug修改<br>

* V2.2.1

 1、银联21号问改造，要求银联卡的消费、预授权交易类型上送硬件序列号，硬件序列号密文等信息用于监管


* V2.2.0

 1、A8 读取 9F27 TAG 失败优化<br>
 2、AID 支持部分匹配<br>
 3、aid和ic公钥添加在asset目录中<br>
 4、response请求信息优化<br>
 5、激活流程修改：<br>
    （1）getMerchantInfo，获取终端号、商户号信息<br>
    （2）activeWithCode，使用终端信息+激活码激活设备<br>
    （3）downloadParams，下载终端参数<br>
    （4）downloadKeys，下载交易相关key<br>
    （5）notifyActived，激活完成<br>
   >CFCardSDK提供的activateDevice方法已完成对上述过程的封装，直接使用即可
  
* V2.1.8

 1、移除下载参数N900通讯APN设置<br>
 2、实现联迪A8的支持<br>
 3、增加Stetho调试工具<br>
 4、网络相关API优化<br>
 5、Bugfix<br>

* V2.1.7

 1、结算时，打印小票改为只打印合计小票<br>
 2、历史结算，可选择打印详情小票或者合计小票<br>
 3、结算打印后，批次号不能自动加1问题修改<br>
 4、结算数据库优化<br>

* V2.1.3

 1、添加CILPayUtil添加工具类方法。<br>
 2、CFCardSDK中cancelOfBank -> revokeOfBank、<br>
 3、Trans方法类添加55域、cardType类型<br>
 4、N900加入POS-收银机蓝牙通信功能<br>

* V2.0.0

 1、增加基于安卓智能手机的纯扫码交易支持。<br>
 2、打印回调结果PrinterResult移动到com.cardinfolink.pos.bean包下。<br>
 3、按照银联合规信息设计小票。<br>

* V1.0.4

 修复部分bug，提高稳定性。

* V1.0.2

 增加 `setTestAddr` 和 `setProAddr` 方法。可以方便更改测试环境和正式环境地址。
 
* V1.0.1

 增加外部订单号。

* V1.0.0

 第一版讯联 POS SDK , 支持银行卡( IC 卡、磁条卡、非接卡)和扫码(支付宝、微信)交易。

