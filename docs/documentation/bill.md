**账单查询**

智能 POS SDK 分别提供了最多30天的`账单列表查询`和`账单统计接口`接口,接口会根据 type 值确定返回`银行卡账单`或`扫码账单`。
交易成功还是失败最终以返回账单中应答码为准，见[应答码表](https://gongluis.github.io/Smart-POS/attached/sdkAnserCode/) 。


> 交互设计建议：交易中，具体来说，调用CILSDK.consumeQr()或是CILSDK.consume()方法时，当因为网络中断进入onError callback时，建议在交互中加入`查询账单列表`的逻辑，这样交易失败后可方便收银员通过账单来确认这笔订单的实际状态。
 
> 注意：对于 `09`（请求正在处理中）状态的交易账单数据，还需要看 `处理标志位` 才能判定此次交易成功与否，使用 `getProcessFlag()` 获取。
当 `processFlag 为 '0'` 时，此次交易成功；当 `processFlag 为非'0'` 时，此次交易失败，见[处理标志表](/user-guide/attachments/#_1)。
  
  
  
**根据外部订单号获取该笔订单信息（同步）**  
```
//outOrderNum为传入数据
CILSDK.getBillsAsync(outOrderNum, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable cilRequest, Exception e) {
                ...
            }
        })
```  
**根据凭证号获取当前批次号下该笔订单详情(异步)**    

```
/**
* 依据凭证号，获取当前批次下的订单详情 回调在主线程
* 异步操作
* @param traceNum 凭证号
* @param listener
*/
CILSDK.getBillByTraceNum(traceNum, new Callback<CILResponse>() {
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
**根据参考号获取当前批次下的订单详情（异步操作）**
```
/**
* @param refNum 参考号
* @param callBackIsOnMainThread 是否在主线程中回调
*/
CILSDK.getBillByRefNumAsync(refNum, callBackIsOnMainThread, new Callback<CILResponse>() {
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

**根据批次号获取当前批次下的订单详情（异步操作）**  
```

/**
* @param refNum 批次号
* @param callBackIsOnMainThread 是否在主线程中回调
*/
CILSDK.getBillByBatchNumAsync(batchNum, callBackIsOnMainThread, new Callback<CILResponse>() {
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




**获取账单列表**
```
 1. 默认获取三十天的账单列表
    /**
     * 获取账单列表 异步
     *
     * @param int page 从0开始
     * @param int size 每页返回的条数
     * @param int type 账单类型(TransConstants.CARD_BILL, TransConstants.QR_BILL, TransConstants.ALL_BILL)
     *
     */
    CILSDK.getBillsAsync(page, size, @BillType int type, new Callback<CILResponse>() {
        @Override
        public void onResult(final CILResponse response) {
            if (null != response && 0 == response.getStatus()) {
                //账单获取成功
                Trans[] trans = response.getTxn(); //账单数据,字段详情见 Trans
            }
        }

        @Override
        public void onError(Parcelable p, Exception ex) {
            //账单获取出错
        }
    });
    
    2. 获取指定区间的账单列表
        /**
     * 获取账单列表 异步
     *
     * @param page
     * @param size
     * @param startTime 查询订单开始时间，格式：yyyyMMdd
     * @param endTime 查询订单结束时间，格式：yyyyMMdd
     * @param type
     * @param callBackIsOnMainThread
     * @param listener
     * @return
     */
    CILSDK.getBillsAsync(page, size, startTime, endTime, type, true, new Callback<CILResponse>() {
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


**获取今日交易统计**      
```
    /**
     * 获取今日交易统计 异步
     * @param type 账单类型
     * <ul>
     *      <li>TransConstants.ALL_BILL:所有账单</li>
     *      <li>TransConstants.CARD_BILL:银行卡账单</li>
     *      <li>TransConstants.QR_BILL:扫码账单</li>
     * </ul>
     *
     */
    CILSDK.getBillStatAsync(@BillType int type, new Callback<CILResponse>() {
        @Override
        public void onResult(CILResponse response) {
            if (null != response && 0 == response.getStatus()) {
                //今日交易统计获取成功
            }

        }

        @Override
        public void onError(Parcelable p, Exception ex) {
            //今日交易统计获取出错
        }
    });
    
```

> SDK 的网络部分使用的是第三方库 `okhttp`,以上账单接口分别还提供了相对应的同步接口 `getBills` 和 `getBillStat` 。
对于异步接口来说,都会返回一个 `Call` 对象,你可以在应用出错的时候调用 `call.cancel()` 取消这次请求,以免造成内存泄露。