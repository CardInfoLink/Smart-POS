** 扫码交易**

扫码相关的交易则是不依赖 POS 机器的读卡模块的,但是你需要将`微信`或者`支付宝`的二维码读出来传给扫码消费接口,扫码可以使用第三方库,如 `zxing`。
  
  **扫码消费**
```
    CILRequest request = new CILRequest();
    request.setAmount(amount);//交易金额
    request.setScanCodeId(result);//二维码code
    request.setOrderId(orderId);//外部订单号（可选参数）
    
    CILSDK.consumeQr(request, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse response) {
//        处理扫码消费结果，字段说明见底部
//        如果结果返回`09`，需要查询该订单获取最终结果，如下：
//        resultCode = response.getTrans().getRespCode();
//        if ("09".equals(resultCode)) {
//            CILSDK.queryQr(); // `queryQr` 方法见下文
//        }

        }

        @Override
        public void onError(Parcelable cilRequest, Exception e) {
            // 扫码消费出错
        }
    });  
```  

>注意,如果应答码返回09或98，需要调用讯联扫码查询接口，查询该笔订单的实际状态。

    
**扫码撤销**  
```
    CILRequest request = new CILRequest();
    request.setAmount(amount);//原交易金额
    request.setBatchNum(batchNum);//原交易批次号
    request.setTraceNum(traceNum);//原交易凭证(流水)号
    request.setReferenceNumber(refNum);  //原交易参考号

    CILSDK.revokeConsumeQr(request, new Callback<CILResponse>() {
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
    

**扫码退货**  

```   
    CILRequest request = new CILRequest();  
    request.setAmount(amount);//退款金额  
    request.setReferenceNumber(serialNum);//原交易参考号  
    request.setTransDatetime(tradeDate);//原交易时间

    CILSDK.returnConsumeQr(request, new Callback<CILResponse>() {
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

**扫码查询**
```
    CILRequest request = new CILRequest();
    request.setBatchNum(response.getTrans().getBatchNum());//批次号
    request.setTraceNum(response.getTrans().getTraceNum());//凭证号
    request.setPeriod(10000L);//10s
    request.setLimitTime(6);//6 次
    request.setReferenceNumber(response.getTrans().getRefNum());//参考号
    request.setPosInputStyle(response.getTrans().getPosInputStyle());//pos输入服务方式码
    request.setScanCodeId(response.getTrans().getScanCodeId());//扫码号
    request.setAmount(response.getTrans().getTransAmt());//交易金额
    
    CILSDK.queryQr(request, new Callback<CILResponse>() {
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

**扫码消费查询,只查询一次，不含取消接口**  
```
    CILRequest request = new CILRequest();
    request.setBatchNum(response.getTrans().getBatchNum());//批次号
    request.setTraceNum(response.getTrans().getTraceNum());//凭证号
    request.setReferenceNumber(response.getTrans().getRefNum());//参考号
    request.setPosInputStyle(response.getTrans().getPosInputStyle());//pos输入服务方式码
    request.setScanCodeId(response.getTrans().getScanCodeId());//扫码号  
    
    CILSDK.queryQrJustOnce(request, new Callback<CILResponse>() {
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
**扫码取消**  
```
    /**
     * 扫码取消
     * 对于09状态的消费订单，最终需要取消、关单
     * @param request
     * @param listener
     */  

    CILRequest cilRequest = new CILRequest();
    cilRequest.setOriginalTradeDate(response.getTrans().getTransDate());//原交易日期
    cilRequest.setAmount(response.getTrans().getTransAmt());//交易金额
    cilRequest.setBatchNum(response.getTrans().getBatchNum());//批次号
    cilRequest.setTraceNum(response.getTrans().getTraceNum());//凭证号
    cilRequest.setPosInputStyle(response.getTrans().getPosInputStyle());//pos输入服务方式码
    cilRequest.setReferenceNumber(response.getTrans().getRefNum());//参考号  
    
    CILSDK.voidQr(request, new Callback<CILResponse>() {
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
	

**扫码预授权**  
```
    CILRequest request = new CILRequest();
    request.setAmount(amount);
    request.setScanCodeId(result);//二维码code
    request.setOrderId(orderId);//外部订单号（可选参数）
	
	CILSDK.preAuthQr(request, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
            // 处理扫码预授权结果
            // 如果结果返回`09`，需要查询该订单获取最终结果，如下：
            /**
             *      resultCode = response.getTrans().getRespCode();
             *      if ("09".equals(resultCode)
             ) {
             *          CILSDK.queryQr(); // `queryQr` 方法见下文
             *      }
             */
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                //扫码预授权出错
            }
        });  
```		
	

**扫码预授权撤销**
```
	CILRequest request = new CILRequest();
    request.setAmount(transAmt);//原预授权交易金额
    request.setReferenceNumber(revAuthCode);//原预授权交易参考号
    request.setTransDatetime(transDate);//原预授权交易时间
    request.setBatchNum(curTrans.getBatchNum());//原预授权交易批次号
    request.setTraceNum(curTrans.getTraceNum());//原预授权交易凭证（流水）号
	
	CILSDK.revokePreAuthQr(request, new Callback<CILResponse>() {
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

**扫码预授权完成**
```
		CILRequest request = new CILRequest();
        request.setAmount(transAmt);//原预授权交易金额
        request.setReferenceNumber(revAuthCode);//原预授权交易参考号
        request.setTransDatetime(transDate);//原预授权交易时间
        CILSDK.preAuthCompleteQr(request, new Callback<CILResponse>() {
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

**扫码预授权完成撤销**
```
	CILRequest request = new CILRequest();
    request.setAmount(transaction.getTransAmt());//原预授权完成交易金额
    request.setBatchNum(transaction.getBatchNum());//原预授权完成交易批次号
    request.setTraceNum(transaction.getTraceNum());//原预授权完成交易凭证（流水）号
    request.setReferenceNumber(transaction.getRefNum());//原预授权完成交易参考号

    CILSDK.revokePreAuthCompleteQr(request, new Callback<CILResponse>() {
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




**单品券功能接入指引**   
> 注意：sdk v2.5.3及之后版本支持该功能
1. 扫码消费接口增加单品券核销功能，扫码消费接口增加入参两个参数，订单优惠标记（为配券时候的填的优惠标记）,商品列表；
```
    /**
     * 扫码消费
     */
    CILRequest request = new CILRequest();
    request.setAmount(amount);
    request.setScanCodeId(result);//二维码code
    request.setOrderId(orderId);//外部订单号（可选参数）
    
    request.setOrderPromotionMark(orderPromotionMark);//订单优惠标记（类型String可选参数）
    request.setGoodsList(goodsList);//商品列表（类型String可选参数）详见下新增字段说明

    CILSDK.consumeQr(request, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse response) {
            // 处理扫码消费结果
            // 如果结果返回`09`，需要查询该订单获取最终结果，如下：
            /**
             *      resultCode = response.getTrans().getRespCode();
             *      if ("09".equals(resultCode)
             ) {
             *          CILSDK.queryQr(); // `queryQr` 方法见下文
             *      }
             */

        }

        @Override
        public void onError(Parcelable cilRequest, Exception e) {
            // 扫码消费出错
        }
    });
```  
* 新增字段说明  

字段 | 类型 | 含义 | 是否可选 | 备注1 | 备注2
---|---|---|---|---|---
orderPromotionMark   |String |订单优惠标记 |Y|ans32|来源于配券时选填字段
goodsList |String |商品列表 |Y|最多9个商品|按照以下样例格式传输  

报文样例：
```
"orderPromotionMark":"1111",
"[
    {
        "goodsName":"小面包",
        "price":"1",
        "goodsNum":"1",
        "goodsId":"1111"
    },
    {
        "goodsName":"棒棒糖",
        "price":"1",
        "goodsNum":"1",
        "goodsId":"2222"
    },
    {
        "goodsName":"彩虹糖",
        "price":"1",
        "goodsNum":"1",
        "goodsId":"3333"
    },
    {
        "goodsName":"矿泉水",
        "price":"1",
        "goodsNum":"1",
        "goodsId":"4444"
    }
]"
```
* 响应报文新增一个CouponInfo的实例,内部包含属性字段有：

字段 | 类型 | 含义 | 是否可选 | 备注
---|---|---|---|---
couponId   |String |优惠券id |Y|
couponName   |String |优惠券名称 |Y|
channelContribution    |String |渠道出资 |Y| 
MerchantContribution    |String |商家出资 |Y| 
otherContribution    |String |其它出资 |Y| 
discountType    |String |优惠类型 |Y| 
discountRange    |String |优惠范围 |Y| 
discountbatchaId    |String |优惠活动批次ID |Y| 
goodsList |String |单品优惠商品列表 |Y|  


* 单品优惠列表商品字段  
 
字段 | 类型 | 含义 | 是否可选 | 备注
---|---|---|---|---
goodsBarCode   |String |商品条码号 |Y|
goodsDiscount   |String |单品优惠金 |Y| 

  
CouponInfo响应报文样例：
```
{
    "MerchantContribution":"000000000100",
    "couponId":"9026256969",
    "couponName":"讯联满1.1减1 tag",
    "discountRange":"SINGLE",
    "discountType":"DISCOUNT",
    "discountbatchaId":"9803978",
    "goodsList":"[{"goodsBarCode":"1111","goodsDiscount":"000000000034"}, {"goodsBarCode":"2222","goodsDiscount":"000000000034"}, {"goodsBarCode":"3333","goodsDiscount":"000000000032"}]",
    "otherContribution":"000000000000"
}
```  
附：最多支持传入9个商品  