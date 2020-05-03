// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..typeid = json['typeid'] as String
    ..typeid2 = json['typeid2'] as String
    ..ishidden = json['ishidden'] as String
    ..istop = json['istop'] as String
    ..click = json['click'] as String
    ..body = json['body'] as String
    ..content = json['content'] as String
    ..senddate = json['senddate'] as String;
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'typeid': instance.typeid,
      'typeid2': instance.typeid2,
      'ishidden': instance.ishidden,
      'istop': instance.istop,
      'click': instance.click,
      'body': instance.body,
      'content': instance.content,
      'senddate': instance.senddate
    };
