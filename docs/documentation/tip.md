**小费**  
> 注意:
通过对一笔交易收取小费。  
小费最多收取交易金额的20%  
小费只能成功收取一次
消费撤销后不能再次收取  


```  

        CILRequest request = new CILRequest();
        request.setCardNum(cardNumber);
        request.setReferenceNumber(trans.getRefNum());
        request.setBatchNum(trans.getBatchNum());
        request.setTraceNum(trans.getTraceNum());
        request.setTransDatetime(trans.getTransDatetime());
        request.setRevAuthCode(trans.getRevAuthCode());
        
        request.setAmount(amount);//小费金额

        CILSDK.takeTip(request, new     Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable parcelable, Exception e) {
                ...
            }
        });
```
**小费撤销**  

```
        CILRequest request = new CILRequest();
        request.setCardNum(cardNo);
        request.setAmount(trans.getTransAmt());
        request.setReferenceNumber(trans.getRefNum());
        request.setRevAuthCode(trans.getRevAuthCode());
        request.setBatchNum(trans.getBatchNum());
        request.setTraceNum(trans.getTraceNum());
        request.setTransDatetime(trans.getTransDatetime());  
        
        CILSDK.revokeTip(request, new Callback<CILResponse>() {
            @Override
            public void onResult(CILResponse cilResponse) {
                ...
            }

            @Override
            public void onError(Parcelable parcelable, Exception e) {
                ...
            }
        });
```

