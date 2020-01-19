
**签购单规范**

* 小票（签购单）样例，银行卡类小票和扫码类小票：

![](../img/slip.png)![](../img/slipqr.png)

* 其他说明

> 签购单中，可以有空行

> 交易金额显示，如为退货或撤销，均在金额前显示负号

> 卡号后面的一位字母，刷卡方式，取值：S（刷卡）、I(插卡)、M（无卡）、C（非接）

> 卡号后面的3位字母，卡品牌CUP

> 原凭证号：只有撤销或退货时显示

> TAG：8583规范中的子域名，必须打印

> 各项内容必须完备，排版可以略有不同

> 标点符号全部为半角

* 银联卡消费打印的签购单中，必须要显示的内容：

| 内容 | 字段取值 | 备注 |
|:--|:--|:--|
| 商户/持卡人/银行存根 | 固定文本 | |
| 客户ID | 0000000000 | 目前为10个0 |
| 商户名称 | Config.IsoMsg.MERCHANT_NAME | |
| 商户号 | response.getTrans().getCompInfoA2() | |
| 终端号 | response.getTrans().getCompInfoA3() | |
| 卡号 | response.getTrans().getCardNo() + response.getTrans().getCardType() + response.getTrans().getCardBrand() | 卡号 + 刷卡方式(1S 2I 3C) + 卡品牌 |
| 有效期 | response.getTrans().getCompExpirationDate() | 需格式转换 MM/YY （为空不打印） |
| 收单行 | response.getTrans().compInfoA1() | |
| 发卡行 | response.getTrans().getAdditionalResData() | |
| 交易类型 | response.getTrans().getTransCode() | 需转换，见下文'交易类型码表' |
| 授权码 | response.getTrans().getRevAuthCode() | |
| 批次号 | response.getTrans().getBatchNum() | |
| 凭证号 | response.getTrans().getTraceNum() | |
| 日期时间 | response.getTrans().getTransDate() + response.getTrans().getTransDatetime() | 需格式转换 |
| 参考号 | response.getTrans().getRefNum() | |
| 交易金额 | response.getTrans().getTransAmt() | |
| 小费（Tips）| | |
| 签名 | | |
| 备注 | | |
| 版本 | | |
| TAG | | |

**新大陆-打印规范**

如果你想要自定义小票的样式，可以参考`新大陆`提供的打印文档，点击[新大陆-打印规范.doc](http://download.cardinfolink.net/doc/新大陆-打印规范.doc)可以下载。

### 终端相应合规信息取值

按照银联最新规范，终端展示/打印信息需要根据8583报文中57域信息。因此，SDK中Trans新增部分字段


|字段名|意义|
|:--|:--|
| compInfoA1 | 签购单收单行 |
| compInfoA2 |签购单商户号 |
| compInfoA3 |签购单终端号|
| compInfoA4 |markup|
| compInfoA6 |借贷记标识|
| compInfoA7 |营销信息|
| compInfoA8 |二维码信息|

详细字段信息可查看[javadoc](../documentation/sdkapi/javadoc/)中com.cardinfolink.pos.sdk.model.Trans信息


