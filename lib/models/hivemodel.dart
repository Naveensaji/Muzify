import 'package:hive/hive.dart';
part 'hivemodel.g.dart';


@HiveType(typeId: 0)
class Localsongs extends HiveObject{


  @HiveField(0)
  String? title;

   @HiveField(1)
  String? artist;

   @HiveField(2)
  int? id;

   @HiveField(3)
  String? uri;

   @HiveField(4)
  int? duration;

  Localsongs({
     required this.title,
    required this.artist,
    required this.id,
    required this.uri,
    required this.duration,
  });




}