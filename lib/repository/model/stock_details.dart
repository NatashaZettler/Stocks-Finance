class StockDetails {
  String? logo;
  String? country;
  String? industry;
  String? sector;
  String? phone;
  String? ceo;
  String? url;
  String? name;
  String? symbol;
  String? hqAddress;
  String? hqState;
  String? exchangeSymbol;

  StockDetails({
    this.logo,
    this.country,
    this.industry,
    this.sector,
    this.phone,
    this.ceo,
    this.url,
    this.name,
    this.symbol,
    this.exchangeSymbol,
    this.hqAddress,
    this.hqState,
  });

  StockDetails.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    country = json['country'];
    industry = json['industry'];
    sector = json['sector'];
    phone = json['phone'];
    ceo = json['ceo'];
    url = json['url'];
    name = json['name'];
    symbol = json['symbol'];
    exchangeSymbol = json['exchangeSymbol'];
    hqAddress = json['hq_address'];
    hqState = json['hq_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['country'] = this.country;
    data['industry'] = this.industry;
    data['sector'] = this.sector;
    data['phone'] = this.phone;
    data['ceo'] = this.ceo;
    data['url'] = this.url;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['exchangeSymbol'] = this.exchangeSymbol;
    data['hq_address'] = this.hqAddress;
    data['hq_state'] = this.hqState;
    return data;
  }

  @override
  String toString() {
    return 'StockDetails{logo: $logo, country: $country, industry: $industry, sector: $sector, phone: $phone, ceo: $ceo, url: $url, name: $name, symbol: $symbol, hqAddress: $hqAddress, hqState: $hqState, exchangeSymbol: $exchangeSymbol}';
  }
}
