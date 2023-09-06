class FavouriteNewsModel {
  final int? id;
  final String? newsTitle;
  final String? newsPicture;
  final String? newsPublishedAt;
  final String? newsSourceName;
  final String? newsDetails;
  final String? newsUrl;

  FavouriteNewsModel({
    this.id,
    this.newsTitle,
    this.newsPicture,
    this.newsPublishedAt,
    this.newsSourceName,
    this.newsDetails,
    this.newsUrl,
  });

  factory FavouriteNewsModel.fromJson(Map<String, dynamic> json) => FavouriteNewsModel(
    id: json['id'],
    newsTitle: json['newsTitle'],
    newsPicture: json['newsPicture'],
    newsPublishedAt: json['newsPublishedAt'],
    newsSourceName: json['newsSourceName'],
    newsDetails: json['newsDetails'],
    newsUrl: json['newsUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'newsTitle': newsTitle,
    'newsPicture': newsPicture,
    'newsPublishedAt': newsPublishedAt,
    'newsSourceName': newsSourceName,
    'newsDetails': newsDetails,
    'newsUrl': newsUrl,
  };
}