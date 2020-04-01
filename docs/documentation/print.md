**打印**


本模块可用于根据交易信息打印所需的消费票据。接口不仅提供了一套固定格式的小票样式，而且还可以根据需要自定义打印样式。
主要功能包括小票打印、二维码打印、条形码打印以及图片打印。

<p style="color:red; font-size:18">特别注意: 中国人民银行和中国银联为了规范市场上的POS机终端，要求终端打印的签购单必须合乎规范，规范内容包括必须打印的字段与正确的字段内容。</p>

签购单规范详情见 [签购单规范](https://gongluis.github.io/Smart-POS/attached/ticket)


* 打印银行卡类交易、扫码类交易小票
```
    /** trans 交易信息,Trans类型
     *  lineBreak 小票结尾需要走纸换行的行数，int类型
     *  formatTransCode @FormatTransCode String类型，小票的交易类型
     *  kind @ReceiptSubtitle int类型，小票的子标题，判断是商户联或者是客户联
     *  isForeignTrans 是否是外卡类交易
     *  bitmap logo图标，没有直接传null
     */
    CILSDK.printKindsReceipts(trans,lineBreak,formatTransCode, kind, isForeignTrans,  bitmap, new Callback<PrinterResult>(){
         @Override
         public void onResult(PrinterResult response) {
             if (null ！= printerResult && !"打印成功".equals(printerResult.toString())) {
                 //打印成功
             }
         }
           
          @Override
          public void onError(Parcelable cilRequest, Exception e) {
                 //打印失败
          }
    }); 
```

* 打印结算小票

```
    /**
     * 打印结算小票
     *
     * transSettles    结算信息List
     * transDatetime   结算时间
     * lineBreak       打印结尾换行数
     * formatTransCode 结算类型；TransConstants.TRANS_SETTLE_DETAILS：结算详情小票；TransConstants.TRANS_SETTLE_TOTAL：结算统计小票
     * callback 回调
     */
     CILSDK.printSettleReceipts(transSettles, transDatetime,batchNum, lineBreak, formatTransCode, new Callback<PrinterResult>() {
          @Override
          public void onResult(PrinterResult result) {
              if (null != result && !"打印成功".equals(result.toString())){
                                           
               }
          }    
          @Override
          public void onError(Parcelable cilRequest, Exception e) {
                                       
          }
     });

```

* 自定义打印

> 注意：使用自定义打印方法时，若打印内容超过2000个字符，请使用分段打印方式，否则可能出现DeviceRTException

```
    /**
     * 根据二进制数据打印(根据打印规范用户自定义打印小票样式)
     *
     * buffer    打印内容
     * lineBreak 换行数
     * callback  回调
     */
   CILSDK.printBufferReceipt(buffer, lineBreak,new Callback<PrinterResult>() {
        @Override
        public void onResult(PrinterResult result) {
            if (null != result && !"打印成功".equals(result.toString())){
                                                                                                                                         
             }
        }    
        @Override
        public void onError(Parcelable cilRequest, Exception e) {
                                                                                                                                     
        }
    });

```

* 打印二维码

```
    /**
     * 打印二维码
     *
     * qrCode   二维码内容
     * position 打印位置  0:左对齐；1居中；2：右对齐
     * width    二维码宽度
     * callback 回调
     *
     */
    CILSDK.printQRCode(qrCode,position,width,lineBreak,new Callback<PrinterResult>() {
         @Override
         public void onResult(PrinterResult result) {
             if (null != result && !"打印成功".equals(result.toString())){
                                                                                                  
             }
         }    
         @Override
         public void onError(Parcelable cilRequest, Exception e) {
                                                                                              
         }
    });
```

* 打印条形码

```
    /**
     * 打印条形码
     *
     * barCode   条形码数字
     * position  条形码位置 0:左对齐；1居中；2：右对齐
     * lineBreak 换行数
     * callback  回调
     */
    CILSDK.printBarCode(String barCode, int position, int lineBreak, new Callback<PrinterResult>() {
         @Override
         public void onResult(PrinterResult result) {
             if (null != result && !"打印成功".equals(result.toString())){
                                                                                                                                                                                                                        
              }
         }    
         @Override
         public void onError(Parcelable cilRequest, Exception e) {
                                                                                                                                                                                                                    
         }
    });
```

* 打印图片

```
    /**
     * 打印图片
     *
     * bitmap    图片Bitmap
     * lineBreak 换行数
     * offset    偏移量
     * callback  回调
     *
     */
    CILSDK.printImage(bitmap, lineBreak, offset, new Callback<PrinterResult>() {
         @Override
         public void onResult(PrinterResult result) {
             if (null != result && !"打印成功".equals(result.toString())){
                                                                                                                                                   
             }
         }    
         @Override
         public void onError(Parcelable cilRequest, Exception e) {
                                                                                                                                               
         }
    });
```