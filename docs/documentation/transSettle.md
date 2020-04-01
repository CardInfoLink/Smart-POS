**结算**

结算需求主要用于每日交易结束时或收银员交接班时,对某段时间内的账款核对。商户每日交易结束后,收银员需要统计并核对所有的交易,核对交易统计准确后结算，打印出结算单。
结算会涉及到一个概念--`批次号`,我们在前面的交易都会传入一个批次号给 request ,调用结算之后,后续的交易需要将这个批次号加1,因为此批次已经打包结算掉了。

```
    //batchNum 批次号
    CILSDK.transSettleAsync(batchNum, new Callback<CILResponse>() {
        @Override
        public void onResult(final CILResponse response) {
            //打印结算单
        }

        @Override
        public void onError(Parcelable cilRequest, Exception e) {
            //结算出错
        }
    });
```

如果使用讯联样式结算UI、逻辑直接使用

>注意,使用SettleDaoUtil工具类是必须先初始化，SettleDaoUtil.getInstance().init();

```

    SettleDaoUtil.getInstance().gotoLiquidation(context)
```