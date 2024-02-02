/// currentPrice : 2276.94
/// comment : null
/// digits : 2
/// login : 2088888
/// openPrice : 4732.58
/// openTime : "2021-11-08T06:35:33"
/// profit : -24.56
/// sl : 0
/// swaps : 0
/// symbol : "#Ethereum"
/// tp : 0
/// ticket : 1386773321
/// type : 0
/// volume : 0.01

class TradesModel {
  late double currentPrice;
  dynamic comment;
  late int digits;
  late int login;
  late double openPrice;
  late String openTime;
  late double profit;
  late int sl;
  late int swaps;
  late String symbol;
  late int tp;
  late int ticket;
  late int type;
  late double volume;

  static TradesModel? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TradesModel tradesModelBean = TradesModel();
    tradesModelBean.currentPrice = map['currentPrice'];
    tradesModelBean.comment = map['comment'];
    tradesModelBean.digits = map['digits'];
    tradesModelBean.login = map['login'];
    tradesModelBean.openPrice = map['openPrice'];
    tradesModelBean.openTime = map['openTime'];
    tradesModelBean.profit = map['profit'];
    tradesModelBean.sl = map['sl'];
    tradesModelBean.swaps = map['swaps'];
    tradesModelBean.symbol = map['symbol'];
    tradesModelBean.tp = map['tp'];
    tradesModelBean.ticket = map['ticket'];
    tradesModelBean.type = map['type'];
    tradesModelBean.volume = map['volume'];
    return tradesModelBean;
  }

  Map toJson() => {
    "currentPrice": currentPrice,
    "comment": comment,
    "digits": digits,
    "login": login,
    "openPrice": openPrice,
    "openTime": openTime,
    "profit": profit,
    "sl": sl,
    "swaps": swaps,
    "symbol": symbol,
    "tp": tp,
    "ticket": ticket,
    "type": type,
    "volume": volume,
  };
}