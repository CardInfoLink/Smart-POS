**a、银行卡交易**

由于银行卡交易逻辑有点复杂,讯联提供了一个 `BaseCardActivity` 基础类,你只需要继承这个类便可以做银行卡类的交易了。具体使用方法可以见 demo 
里的 `CommonCardHandlerActivity` 类。下面给个大概说明:

```java
    public class CommonCardHandlerActivity extends BaseCardActivity {
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            
            //...
            
        }
        
        /**
         * 必须传入金额
         *
         * @return
         */
        public String getAmount() {
            //在这里传入金额
        }
		
		
		/**
		 * 此方法为控制sdk内部是否开启DCC交易逻辑（sdk2.4.1版本及以上支持该方法）
		 * 
		 *@return 需要进行DCC交易时，返回true，否则返回false
		 */
		public boolean isOpenDcc() {
			//只有刷卡消费和刷卡预授权才支持DCC交易
			//如果接入方无需支持DCC，则此方法返回false即可
			return false;
		}
		
    
        /**
         * 读卡的结果（sdk2.4.1版本及以上新增RateInfo参数，返回DCC读卡流程中进行汇率查询的结果）
         *
         * @param isSuccess 是否成功
         * @param cardType  卡片种类(-1(unknow) 1(msc) 2(ic) 3(nfc) 4(scancode) 5(other))
         * @param cardInfo  读取卡片信息
		 * @param rateInfo  汇率信息
         */
        public void cardReaderHandler(boolean isSuccess, @CardType.Type int cardType, CardInfo cardInfo, RateInfo rateInfo){    
            //读卡成功后才发起交易
            if (!isSuccess || cardInfo == null) {
                Toast.makeText(getApplicationContext(), "读卡失败",  Toast.LENGTH_SHORT).show();
                initCardEvent();
                return;
            }
        
            //1. 根据银联85号文规定，智能终端需上送经度，纬度，坐标系信息到卡组织
			CILRequest request = new CILRequest();
			
			request.setLongitude(121.600228);//设置经度
			request.setLatitude(31.180606);//设置纬度
			request.setCoordinates("GCJ02");//设置坐标系
			//关于坐标系，国内一些常用第三方取值：百度（BD09），高德、腾讯（GCJ02），GPS（WGS84）。
			//一般第三方定位SDK都能从定位后返回的位置信息类中取到，详细可查看各第三方接入文档。
			
			
			//2.如果接入方需要进行DCC交易，需将汇率信息填入request中，否则无需处理
			CILRequest request = new CILRequest();
			...
			if (rateInfo != null) {
			    request.setBillingAmt(rateInfo.getBillingAmt());//设置扣账金额
			    request.setBillingCurr(rateInfo.getBillingCurr());//设置扣账币种
			    request.setTransRate(rateInfo.getTransRate());//设置交易汇率
			    request.setBatchNum(rateInfo.getBatchNum());//设置汇率请求批次号
			    request.setTraceNum(rateInfo.getTraceNum());//设置汇率请求流水号
			}
			
			//3. 在这里面发送银行卡相关的交易(如消费、消费撤销、退货、预授权、预授权撤销、预授权完成、预授权完成撤销、余额查询)
            //CILSDK.consume(request, cardType, new Callback<CILResponse>() //消费
		}
   
        /**
         * 显示读卡时的缓冲页面
         */
        public void waitLoadingShow(){
        
        }
    
        /**
         * 取消读卡时的缓冲页面
         */
        public void waitLoadingDismiss(){
        
        }
    
        /**
         * 读卡失败
         */
        public void cardHandlerError(Exception e){
        
        }
            
    }
```
<span id="base_request" style="font-size:20px;color:red" >注意:</span><br/>
>调用银行卡类交易接口时，需要传入CILRequest以及CardType，且所有接口中CILRequest均需要传入以下信息：
```
   /**
    * @param: request:请求信息
    * @param: cardType:卡片类型
    */
    request.setAmount(amount);//消费金额
    /**
    * 刷卡获取的cardInfo信息
    */
    request.setCardNumb(cardInfo.getCardNumber());//卡号
    request.setCardExpirationDate(cardInfo.getCardExpirationDate());//卡片有效期
    request.setPinEmv(cardInfo.getPinBins());//卡bin
    request.setCardSequenceNumber(cardInfo.getSequenceSerialNum());//卡片序列号
    request.setField55(cardInfo.getField55());//55域信息
    request.setSecondTrack(cardInfo.getTrack2());//二磁道信息
    request.setOrderId(orderId);//可选参数。（消费、退货、预授权、预授权完成、扫码下单、扫码退货）
    request.setLocation(location)//有终端具备获取位置信息能力时必选上送（ 用于消费 预授权）
```

**1、消费**

消费接口[request必须包含参数:](#base_request)
```
    CILSDK.consume(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });

```

**2、撤销**
撤销接口[request必须包含参数:](#base_request)
```

    /**
     *  撤销接口除基础信息外，
     *  还需要原交易信息
     */
    request.setReferenceNumber(transaction.getRefNum());//原交易参考号
    request.setRevAuthCode(transaction.getRevAuthCode());//原交易授权码
    request.setBatchNum(transaction.getBatchNum());//原交易批次号
    request.setTraceNum(transaction.getTraceNum());//原交易凭证号

    CILSDK.revokeConsume(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });

```

**3、退货**
退货接口[request必须包含参数:](#base_request)
```

    /**
     *  退货接口除基础信息外
     *  还需要原交易信息
     */
    request.setReferenceNumber(referenceNumber);
    request.setTransDatetime(tradeDate);
    CILSDK.returnConsume(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });

```
**4、余额查询**
余额查询接口[request必须包含参数:](#base_request)
```
    CILSDK.checkBalance(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });

```

**5、卡预授权**
预授权接口[request必须包含参数:](#base_request)
```
    request.setLocation(location)//有终端具备获取位置信息能力时必选上送（ 用于消费 预授权）
    CILSDK.preAuth(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
               ...
            }
        });

```

**6、卡预授权撤销**
预授权撤销接口[request必须包含参数:](#base_request)
```
    /**
     *  预授权撤销接口除基础信息外
     *  还需要原预授权交易信息
     */
    request.setRevAuthCode(authCode);//原预授权交易授权码
    request.setTransDatetime(originalTradeDate);//原预授权交易日期
    CILSDK.revokePreAuth(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });

```

**7、卡预授权完成**
预授权完成接口[request必须包含参数:](#base_request)
```
    /**
     *  预授权完成接口除基础信息外
     *  还需要原预授权交易信息
     */
    request.setRevAuthCode(authCode);//原预授权交易授权码
    request.setTransDatetime(originalTradeDate);//原预授权交易日期
    CILSDK.preAuthComplete(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
               ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });
```

**8、卡预授权完成撤销**
预授权完成撤销接口[request必须包含参数:](#base_request)
```
    /**
     *  预授权完成撤销接口除基础信息外
     *  还需要原预授权完成交易信息
     */
    request.setReferenceNumber(refNum);//原预授权完成交易参考号
    request.setRevAuthCode(authCode);//原预授权完成交易授权码
    request.setTraceNum(traceNum);//原预授权完成交易凭证号
    request.setBatchNum(batchNum);//原预授权完成交易批次号
    request.setTransDatetime(originalTradeDate);//原预授权完成交易日期

    CILSDK.revokePreAuthComplete(request, cardType, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        });
```

**9、DCC转EDC**  

当交易卡片为外卡时，消费类（消费、预授权完成）交易可选择进行DCC转EDC。

```
    CILRequest request = new CILRequest();
    request.setCardNum(cardNum);//卡号
    request.setTransDatetime(datetime);//原交易时间
    request.setAmount(amount);//原交易金额
    request.setBillingAmt(biilingAmt);//原扣币金额
    request.setReferenceNumber(refNum);//原交易参考号
    request.setRevAuthCode(revAuthCode);//原交易授权码
    request.setBatchNum(batchNum);//原交易批次号
    request.setTraceNum(traceNum);//原交易凭证号
    request.setTransCurr(transCurr);//原交易币种
    request.setBillingCurr(billingCurr);//原交易扣款币种
    CILSDK.dccToEdc(request, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse cilResponse) {
            ...
        }

        @Override
        public void onError(Parcelable p, Exception e) {
            ...
        }
    });

```  

**交易结果字段说明**  
  
   字段 | 类型 | 含义 | 备注 | 备注
---|---|---|---|---
additionalResData  |String |受理方标识码 |无|
afterTransCode  |String |原交易类型 |无|
batchNum   |String |批次号 |无|
billingAmt   |String |持卡人扣帐金额 |无|
billingCurr   |String |持卡人扣帐货币代码符号，三位字母 |例如USD|
billingCurrNum   |String |持卡人扣帐货币代码,三位数字 |无|
cardBrand   |String |国际信用卡公司代码 |无|
cardNo   |String |银行卡号 |无|
cardType |String |刷卡方式 |无|
cashierName |String |收银员 |无|
cashierNum |String |收银员号 |无|
clearingDate |String |清算日期 |无|
compInfoA1 |String |签购单收单行 |无|
compInfoA2 |String |签购单商户号 |无|
compInfoA3 |String |签购单终端号 |无|
compInfoA4 |String |markup |无|
compInfoA6 |String |借贷记标识 |无|
compInfoA7 |String |营销信息 |无|
compInfoA8 |String |二维码信息 |无|
coupon |String |支付宝/微信优惠金额 |无|
field55 |String |IC卡交易的TAG信息 |无|
insCode |String |受理方标识码 |无|
localTransDate |String |受卡方所在地日期 |无|
localTransTime |String |受卡方所在地时间 |无|
merCode |String |受卡方标识码（商户号） |无|
merDiscount |String |商家优惠金额 |无|
originTraceNum |String |原交易凭证号 |无|
outOrderNum |String |外部订单号 |无|
posInputStyle |String |服务点输入方式码 |无|
processflag |String |扫码支付09状态的交易是否成功 |附件表1|
refNum |String |检索参考号 |无|
respCode |String |应答码 |"00"表示成功|
revAuthCode |String |授权标识应答码 |无|
revInsCode |String |附加响应数据 |无|
revOrderNum |String |自定义域，用于扫码支付业务。 |无|
scanCodeId |String |扫码号 |无|
termCode |String |终端号 |无|
traceNum |String |受卡方系统跟踪号 |合作方交易流水|
transAmt |String |交易金额 |无|
transCode |String |交易类型码 |无|
transCurr |String |交易货币代码 |无|
transDate |String |原交易日期 |无|
transDatetime |String |受卡方所在地日期＋受卡方所在地时 |无|
transRate |String |持卡人扣帐汇率 |无|