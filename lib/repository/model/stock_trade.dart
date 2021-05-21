class StockTrade {
  String? date;
  String? high;
  String? open;
  String? low;
  String? close;
  String? volume;

  StockTrade(
      {this.date, this.open, this.high, this.low, this.close, this.volume});

  StockTrade.fromJson(String key, Map<String, dynamic> json) {
    date = key;
    open = json['1. open'];
    high = json['2. high'];
    low = json['3. low'];
    close = json['4. close'];
    volume = json['5. volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1. open'] = this.open;
    data['2. high'] = this.high;
    data['3. low'] = this.low;
    data['4. close'] = this.close;
    data['5. volume'] = this.volume;
    return data;
  }
}
