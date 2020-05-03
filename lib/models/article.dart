import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
    Article();

    String id;
    String title;
    String typeid;
    String typeid2;
    String ishidden;
    String istop;
    String click;
    String body;
    String content;
    String senddate;
    
    factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);
    Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
