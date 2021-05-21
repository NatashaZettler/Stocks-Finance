class Stock {
  
  String? ticker;
  String? name;
  int? favorite;

  Stock({
    this.ticker,
    this.name,
    this.favorite,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    name = json['name'];
    favorite = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this.ticker;
    data['name'] = this.name;
    data['favorite'] = this.favorite;
    return data;
  }

  @override
  String toString() {
    return 'Stock{ticker: $ticker, name: $name, favorite: $favorite}';
  }

  void setFavorite(int favorite){
    this.favorite = favorite;
  }
}