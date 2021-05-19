class StockDetails {
  String? logo;
  String? listdate;
  String? cik;
  String? bloomberg;
  String? lei;
  int? sic;
  String? country;
  String? industry;
  String? sector;
  int? marketcap;
  int? employees;
  String? phone;
  String? ceo;
  String? url;
  String? description;
  String? exchange;
  String? name;
  String? symbol;
  String? exchangeSymbol;
  String? hqAddress;
  String? hqState;
  String? hqCountry;
  String? type;
  String? updated;
  List<String>? tags;
  List<String>? similar;
  bool? active;

  StockDetails(
      {this.logo,
        this.listdate,
        this.cik,
        this.bloomberg,
        this.lei,
        this.sic,
        this.country,
        this.industry,
        this.sector,
        this.marketcap,
        this.employees,
        this.phone,
        this.ceo,
        this.url,
        this.description,
        this.exchange,
        this.name,
        this.symbol,
        this.exchangeSymbol,
        this.hqAddress,
        this.hqState,
        this.hqCountry,
        this.type,
        this.updated,
        this.tags,
        this.similar,
        this.active});

  StockDetails.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    listdate = json['listdate'];
    cik = json['cik'];
    bloomberg = json['bloomberg'];
    lei = json['lei'];
    sic = json['sic'];
    country = json['country'];
    industry = json['industry'];
    sector = json['sector'];
    marketcap = json['marketcap'];
    employees = json['employees'];
    phone = json['phone'];
    ceo = json['ceo'];
    url = json['url'];
    description = json['description'];
    exchange = json['exchange'];
    name = json['name'];
    symbol = json['symbol'];
    exchangeSymbol = json['exchangeSymbol'];
    hqAddress = json['hq_address'];
    hqState = json['hq_state'];
    hqCountry = json['hq_country'];
    type = json['type'];
    updated = json['updated'];
    tags = json['tags'].cast<String>();
    similar = json['similar'].cast<String>();
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['listdate'] = this.listdate;
    data['cik'] = this.cik;
    data['bloomberg'] = this.bloomberg;
    data['lei'] = this.lei;
    data['sic'] = this.sic;
    data['country'] = this.country;
    data['industry'] = this.industry;
    data['sector'] = this.sector;
    data['marketcap'] = this.marketcap;
    data['employees'] = this.employees;
    data['phone'] = this.phone;
    data['ceo'] = this.ceo;
    data['url'] = this.url;
    data['description'] = this.description;
    data['exchange'] = this.exchange;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['exchangeSymbol'] = this.exchangeSymbol;
    data['hq_address'] = this.hqAddress;
    data['hq_state'] = this.hqState;
    data['hq_country'] = this.hqCountry;
    data['type'] = this.type;
    data['updated'] = this.updated;
    data['tags'] = this.tags;
    data['similar'] = this.similar;
    data['active'] = this.active;
    return data;
  }

  @override
  String toString() {
    return 'StockDetails{logo: $logo, listdate: $listdate, cik: $cik, bloomberg: $bloomberg, lei: $lei, sic: $sic, country: $country, industry: $industry, sector: $sector, marketcap: $marketcap, employees: $employees, phone: $phone, ceo: $ceo, url: $url, description: $description, exchange: $exchange, name: $name, symbol: $symbol, exchangeSymbol: $exchangeSymbol, hqAddress: $hqAddress, hqState: $hqState, hqCountry: $hqCountry, type: $type, updated: $updated, tags: $tags, similar: $similar, active: $active}';
  }
}