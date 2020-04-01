
**其他设置**

考虑到使用 SDK 的时候可能还会有其他需求,比如`获取 POS 机的 SN 号`、`设置密钥索引`等,在这里,我们也提供了一部分接口。

* 获取 SDK 版本

```
    //版本名
    String versionName = CILSDK.VERSION_NAME;
    //版本号
    int versionCode = CILSDK.VERSION_CODE;
```

* 获取 SN 号

```
    //SN号
    String snCode = CILSDK.getDeviceSN();
```

* 设置流水号

```
    //serialNum范围：1~999999
    boolean isSuccess = CILSDK.setSerialNum(int serialNum);
```

* 获取流水号

```
    //序列号
    int serialNum = CILSDK.getSerialNum();
```

* 设置批次号

```
    //batchNum范围：1~999999
    boolean isSuccess = CILSDK.setBatchNum(int batchNum);
```

* 获取批次号

```
    //批次号
    int batchNum = CILSDK.getBatchNum();
```

<!--* 设置密钥索引-->

* 设置联迪密钥区
```
    //1-15的设值范围
    CILSDK.setTingA8KeyIndex(2);
```
* 设置密钥索引  
```
    //分别对应MAIN MAC PIN MES
    //1-255的设值范围
    //可以使用下方提供数值,也可以根据自身程序设值
     CILSDK.setTingKeyIndex(4,101,10,150);
```
以上两个方法请在连接刷卡器(CILSDK.connect)之前使用  

**工具类**

* CILPayUtil

```

    /**
     * 将respCode翻译成对应中文解释
     */
    CILPayUtil.translate(context, respCode));

    /**
     * 将Trans类中的transCode翻译成打印所需的对象
     */
    CILPayUtil.getFormatTransCode(transCode);

    /**
     * 根据billingCurr判断交易是否为外卡类的DCC交易
     */
    CILPayUtil.isDCCPay(billingCurr);
    /**
     * 判断交易是否成功
     */
    CILPayUtil.isTransSuccess(trans);
    /**
     * 根据Trans类中的transCode判断交易是否属于扫码类交易
     */
    CILPayUtil.isQrPay(transCode);

```

* ReceiptFormatUtils

```
    /**
     * 根据Trans类中的TransCode翻译成对应的中文解释
     */
    ReceiptFormatUtils.getTransType(transCode);
    /**
     * 将明文的卡号修改为"前六后四中间为四个*"的样式
     */
    ReceiptFormatUtils.handleCardNum(cardNum);

```

**许可证**

Copyright (c) 2016 cardinfolink.com

**JAVADOC**

java document 详情见 [javadoc](sdkapi/javadoc/)