class Stock {
  
  String? ticker;
  String? name;
  String? market;
  String? locale;
  String? primaryExchange;
  String? type;
  bool? active;
  String? currencyName;
  String? cik;
  String? compositeFigi;
  String? shareClassFigi;
  String? lastUpdatedUtc;

  Stock({
    this.ticker,
    this.name,
    this.market,
    this.locale,
    this.primaryExchange,
    this.type,
    this.active,
    this.currencyName,
    this.cik,
    this.compositeFigi,
    this.shareClassFigi,
    this.lastUpdatedUtc,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    name = json['name'];
    market = json['market'];
    locale = json['locale'];
    primaryExchange = json['primary_exchange'];
    type = json['type'];
    active = json['active'];
    currencyName = json['currency_name'];
    cik = json['cik'];
    compositeFigi = json['composite_figi'];
    shareClassFigi = json['share_class_figi'];
    lastUpdatedUtc = json['last_updated_utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this.ticker;
    data['name'] = this.name;
    data['market'] = this.market;
    data['locale'] = this.locale;
    data['primary_exchange'] = this.primaryExchange;
    data['type'] = this.type;
    data['active'] = this.active;
    data['currency_name'] = this.currencyName;
    data['cik'] = this.cik;
    data['composite_figi'] = this.compositeFigi;
    data['share_class_figi'] = this.shareClassFigi;
    data['last_updated_utc'] = this.lastUpdatedUtc;
    return data;
  }
}