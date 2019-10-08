#智能终端应用需求【sdk】完成版 

标签（空格分隔）： 智能pos

---
##智能终端业务文档
### 一、管理类
管理类sdk作为基础服务包，内容包括了激活、初始化、下载参数和签到；
#####序列图
```seq
Title:  管理类
应用->支付插件: 调用管理功能
支付插件->>系统: 1.【激活】激活商户终端；激活->参数下载->初始化->签到；
支付插件->>系统: 2.【参数下载】下载终端配置参数；
支付插件->>系统: 3.【初始化】更新密钥；
支付插件->>系统: 4.【签到】每日签到；
```

#### 激活
激活界面，输入商户号终端号，点击【激活】，实现终端与支付server交互，确认身份信息。支付server后续将密钥等信息反馈给终端。 
*只需要在初次使用终端时操作一次。激活操作直接完成激活、参数下载、初始化、签到等流程。*

#####调用方法

` CILSDK.active(merCode, termCode, new Callback<CILResponse>() `

| 参数        | 参数名称      | 样例 | 备注 |
| ------------- |-------------|  -----|---|
| merCode  | 商户代码     |  021290050110001 | 15位数字，激活时必填 |
| termCode | 终端代码     |  00000001 | 8位数字，激活时必填 |

` new Callback<CILResponse> ` 是回调函数


#### 参数下载
参数下载在主要应用在以下两种情况：
1. 激活时下载参数 
2. 参数修改后下载参数

#####调用方法
`  CILSDK.downloadParams(merCode, termCode, new com.cardinfolink.pos.listener.Callback<CILResponse>() `
其中，`new com.cardinfolink.pos.listener.Callback<CILResponse>() `是回调函数

#### 初始化
初始化主要是终端密钥下载，包含了主密钥下载和工作密钥下载。其主要应用在以下两种情况：
1.激活时初始化密钥 
2.需要更新密钥时初始化

#####调用方法
` CILSDK.downloadParamsWithProgress(new ProgressCallback<CILResponse>()`

#### 签到
签到其实就是一个更新密钥的过程，激活时已经覆盖了每日一次签到的操作。

#####调用方法
`CILSDK.signIn(new Callback<CILResponse>()`

### 二、配置

#####可配置参数
**1. 批次号、流水号** 
批次号用于结算，流水号（凭证号）定位本批每一笔交易唯一索引；

#####调用方法
设置批次号
`boolean isSuccess = CILSDK.setBatchNum(int batchNum);`
获取批次号
`int batchNum = CILSDK.getBatchNum();`
设置流水号
`boolean isSuccess = CILSDK.setSerialNum(int serialNum);`
获取流水号
`int serialNum = CILSDK.getSerialNum();`

**2. 主色调** 
为融合app颜色风格，提供一个调整支付demo颜色的方法，可调整主色调（输入颜色值即可，提供几个参数供参考），图标不可调；

**3. 语言**
为方便适应境内外app使用场景，提供一个输入语言控制的方法，可调整支付demo的语言。

#####序列图
```seq
Title: 配置
应用->支付插件: 设置批次号、流水号、颜色、语言、币种
```


### 三、打印
交易成功后，需要打印签购单，一般打印两联：商户联和客户联。商户联在持卡人签名后由商户保存。交易成功后，会自动打印商户联。
*需要补打小票时，可以早交易明细中找到补打功能，打印商户联。*

#####序列图
```seq
Title: 打印（SDK-打印api)
APP->SDK: 发送打印商户联请求
SDK-->APP: 返回商户联打印结果
APP->SDK: 发送客户联打印请求
SDK-->APP: 返回客户联打印结果
```
#####调用方法
######打印银行类／扫码交易小票
`CILSDK.printKindsReceipts(trans,lineBreak,formatTransCode, kind, isForeignTrans,  new Callback<PrinterResult>()`

| 参数        | 参数名称      |
| ------------- |---------------|
| trans  | 交易信息     |
| lineBreak | 小票结尾需要走纸换行的行数    |
|formatTransCode|小票的交易类型（String类型）|
|kind|小票的子标题，判断是商户联或者是客户联(int)|
|isForeignTrans|是否是外卡类交易|
| Callback|回调|

######打印结算小票
`CILSDK.printSettleReceipts(transSettles, transDatetime,batchNum, lineBreak, formatTransCode, new Callback<PrinterResult>()`

| 参数        | 参数名称      |
| ------------- |---------------|
| transSettles |  结算信息List    |
|transDatetime|结算时间|
|batchNum|批次号|
|lineBreak|打印结尾换行数|
|formatTransCode|结算类型|
| Callback|回调|

######自定义打印
`CILSDK.printBufferReceipt(buffer, lineBreak,new Callback<PrinterResult>()`

| 参数        | 参数名称      |
| ------------- |---------------|
| buffer |  打印内容   |
|linebreak|打印结尾换行数|
| Callback|回调|

######打印二维码
`CILSDK.printQRCode(qrCode,position,width,lineBreak,new Callback<PrinterResult>() `

| 参数        | 参数名称      |
| ------------- |---------------|
|qrCode|  二维码   |
|position|二维码位置|
|width|二维码大小|
|lineBreak|打印结尾换行数|
|Callback|回调|

######打印条形码
`CILSDK.printBarCode(String barCode, int position, int lineBreak, new Callback<PrinterResult>()`

| 参数        | 参数名称      |
| ------------- |---------------|
| barCode |  条形码数字   |
|position| 条形码位置|
|lineBreak|打印结尾换行数|
| Callback|回调|

######打印图片
`CILSDK.printImage(bitmap, lineBreak, offset, new Callback<PrinterResult>() `

| 参数        | 参数名称      |
| ------------- |---------------|
|bitmap |   图片Bitmap|
|lineBreak | 换行数|
| offset  |偏移量|
|callback | 回调|

### 四、消费
####  1. 消费【插卡、刷卡、挥卡、手机NFC】
支持开发者调用接口实现商家银行卡收款需求。
主要类型包括刷卡、插卡、挥卡以及手机NFC支付。

#####序列图
```seq
Title: 消费－银行卡（SDK-银行卡消费api)
APP->SDK: 发送消费请求
SDK-->APP: 返回消费结果
APP->SDK: （消费成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面输入消费金额，选择银行卡支付，发起银行卡付款请求
2. SDK处理交易，返回应答码
3. APP翻译应答码，输出结果
4. 如果消费成功，APP发送打印请求
5. SDK返回打印结果



####2. 消费【扫码】
支持开发者调用接口实现商家扫码收款需求。
主要类型包括微信扫码和支付宝扫码。

##### 序列图
```seq
Title: 消费－扫码（SDK-扫码消费api)
APP->SDK: 发送消费请求
SDK-->APP: 返回消费结果
APP->SDK: （消费成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面输入消费金额，扫描二维码获取付款码信息，发起扫码付款请求
2. SDK处理消费请求，返回应答码
3. APP翻译应答码，输出结果
4. 如果消费成功，APP发送打印请求
5. SDK返回打印结果



### 五、撤销
支持开发者调用接口实现商家撤销当日交易需求。
包括银行卡撤销和扫码撤销。

##### 序列图
```seq
Title: 撤销（SDK-撤销api)
APP->SDK: 发送撤销请求
SDK-->APP: 返回撤销结果
APP->SDK: （撤销成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面输入原交易凭证号，核对该笔交易，发起撤销请求
2. SDK处理撤销请求，返回应答码
3. APP翻译应答码，输出结果
4. 撤销成功时，APP发送打印请求
5. SDK返回打印结果


### 六、退货
支持开发者调用接口实现商家非当日交易的退货需求。
包括银行卡退货和扫码退货。

##### 序列图
```seq
Title: 退货（SDK-退货api)
APP->SDK: 发送退货请求
SDK-->APP: 返回退货结果
APP->SDK: （退货成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面输入订单相关信息（参考号／交易日期／退货金额），核对该笔交易，发起退货请求
2. SDK处理退货请求，返回应答码
3. APP翻译应答码，输出结果
4. 退货成功时，APP发送打印请求
5. SDK返回打印结果

### 七、预授权类
支持开发者调用接口实现部分商家（如酒店、租车）的预授权类需求。
主要针对银行卡业务。
#### 1. 预授权
支持开发者调用接口实现部分商家（如酒店、租车）的预授权需求。
*持卡人在宾馆、酒店或出租公司消费，消费与结算不在同一时间完成，特约单位通过POS预先向发卡机构索要授权的行为。*
#####序列图
```seq
Title: 预授权类－预授权（SDK-预授权api)
APP->SDK: 发送预授权请求
SDK-->APP: 返回预授权结果
APP->SDK: （预授权成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面输入消费金额，发起预授权请求
2. SDK处理预授权请求，返回应答码
3. APP翻译应答码，输出结果
4. 如果预授权成功，APP发送打印请求
5. SDK返回打印结果

#### 2. 预授权撤销
支持开发者调用接口实现部分商家（如酒店、租车）的预授权撤销需求。
*预授权撤销用来撤销之前的预授权交易，不限制当日。*

#####序列图
```seq
Title: 预授权撤销（SDK-预授权撤销api)
APP->SDK: 发送预授权撤销请求
SDK-->APP: 返回预授权撤销结果
APP->SDK: （预授权撤销成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面：输入原预授权信息（金额\原交易日期\授权码），核对该笔交易，发起预授权撤销请求
2. SDK处理撤销请求，返回应答码
3. APP翻译应答码，输出结果页面
4. 预授权撤销成功时，APP发送打印请求
5. SDK返回打印结果

#### 3. 预授权完成
支持开发者调用接口实现部分商家（如酒店、租车）的预授权完成需求。
*预授权完成是持卡人消费完成并确定消费金额时，已取得预授权的特约商户在预授权金额或超出预授权金额一定比例的范围内，根据持卡人实际消费金额通过POS终端或手工方式完成持卡人付款的过程。*
#####序列图
```seq
Title: 预授权类－预授权完成（SDK-预授权完成api)
APP->SDK: 发送预授权完成请求
SDK-->APP: 返回预授权完成结果
APP->SDK: （预授权完成成功）发送打印请求
SDK-->APP: 返回打印结果
```
1.  APP界面：输入预授权完成金额和原预授权信息（原交易日期\授权码），核对该笔交易，发起预授权完成请求
2. SDK处理预授权完成请求，返回应答码
3. APP翻译应答码，输出结果
4. 如果预授权完成成功，APP发送打印请求
5. SDK返回打印结果

#### 4. 预授权完成撤销
支持开发者调用接口实现部分商家（如酒店、租车）的预授权完成撤销需求。
*用来撤销已经成功的预授权完成交易。不限当日。要解冻相应的预授权交易金额，需要完成撤销预授权.*
##### 序列图
```seq
Title: 预授权完成撤销（SDK-预授权完成撤销api)
APP->SDK: 发送预授权完成撤销请求
SDK-->APP: 返回预授权完成撤销结果
APP->SDK: （预授权完成撤销成功）发送打印请求
SDK-->APP: 返回打印结果
```
1. APP界面：输入原凭证号，找到该笔预授权完成，发起预授权完成撤销请求
2. SDK处理预授权完成撤销请求，返回应答码
3. APP翻译应答码，输出结果
4. 预授权完成撤销成功时，APP发送打印请求
5. SDK返回打印结果



###八、交易明细
支持开发者调用接口实现商家查看交易订单需求，同时可以补打、撤销订单。

##### 序列图
```seq
Title: 交易明细（SDK-交易明细api)
APP->SDK: 发送查看交易明细请求
SDK-->APP: 返回交易明细结果
APP->SDK: （某一笔交易）发送打印请求
SDK-->APP: 返回打印结果
APP->SDK: （某一笔交易）发送撤销请求
SDK-->APP: 返回撤销结果
```
1. APP界面：发起查看交易明细请求
2. SDK处理请求，返回应答码
3. APP翻译应答码，输出交易明细结果
4. 对某一笔订单，APP发送打印商户联请求
5. SDK返回打印商户联结果
6. 对某一笔订单，APP发送撤销请求
5. SDK返回撤销结果

#####调用方法
`CILSDK.getBillsAsync(page, size,@BillType int txnType, new Callback<CILResponse>() `

| 参数        | 参数名称      |
| ------------- |---------------|
|  page | 从0开始|
|  size |每页返回的条数|
|  type |账单类型|
|  callback |回调|

###九、结算
支持开发者调用接口实现商家结算需求。
结算需求主要用于每日交易结束时或收银员交接班时，对某段时间内的账款核对。

##### 序列图
```seq
Title: 结算（SDK-结算api)
APP->SDK: 发送结算请求
SDK-->APP: 返回结算结果
APP->SDK: （结算成功）发送打印结算单请求
SDK-->APP: 返回打印结算单结果
```
1. APP界面：点击【去结算】，核对交易明细无误后【结算】，发起结算请求
2. SDK处理结算请求，返回应答码
3. APP翻译应答码，输出结果
4. 结算成功时，APP发送打印结算单请求
5. SDK返回打印结算单结果

#####调用方法
` CILSDK.transSettleAsync(batchNum, new Callback<CILResponse>()`

| 参数        | 参数名称      |
| ------------- |---------------|
| batchNum |批次号|
| Callback|回调函数|






