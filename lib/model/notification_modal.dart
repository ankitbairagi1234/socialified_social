import 'package:foap/model/post_model.dart';
import 'package:foap/model/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../helper/enum.dart';
import 'club_model.dart';
import 'competition_model.dart';

class NotificationModel {
  int id;

  // int type;
  String title;
  String message;

  DateTime date;
  UserModel? actionBy;
  ClubModel? club;
  CompetitionModel? competition;
  PostModel? post;
  NotificationType type;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.message,
      required this.date,
      required this.type,
      this.actionBy,
      this.competition,
      this.post,
      this.club});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        date: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000)
            .toUtc(),
        type: getType(json["type"]),
        actionBy: json["createdByUser"] == null
            ? null
            : UserModel.fromJson(json["createdByUser"]),
        competition: json["type"] == 4
            ? CompetitionModel.fromJson(json["refrenceDetails"])
            : null,
        post: json["type"] == 2 || json["type"] == 3 || json["type"] == 7
            ? PostModel.fromJson(json["refrenceDetails"])
            : null,
        // club: json["type"] == 11 ? ClubModel.fromJson(json["reference"]) : null,
      );

  String notificationTime() {
    return timeago.format(date);
  }

  static NotificationType getType(int type) {
    if (type == 1) {
      return NotificationType.follow;
    }
    if (type == 2) {
      return NotificationType.comment;
    }
    if (type == 3) {
      return NotificationType.like;
    }
    if (type == 4) {
      return NotificationType.competitionAdded;
    }
    if (type == 8) {
      return NotificationType.gift;
    }
    if (type == 11) {
      return NotificationType.clubInvitation;
    }
    if (type == 13) {
      return NotificationType.relationInvite;
    }
    return NotificationType.none;
  }
}
