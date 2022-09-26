
class Forums {
  String? type;
  String? message;
  List<Forum>? forum=[];

  Forums({this.type, this.message, this.forum});

  Forums.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      forum = <Forum>[];
      json['data'].forEach((v) {
        forum!.add(Forum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (forum != null) {
      data['data'] = forum!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forum {
  String? forumId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  List<ForumLikes>? forumLikes;
  List<ForumComments>? forumComments;
  bool fav=false;

  Forum(
      {this.forumId,
      this.title,
      this.description,
      this.imageUrl,
      this.userId,
      this.forumLikes,
      this.forumComments});

  Forum.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    if (json['ForumLikes'] != null) {
      forumLikes = <ForumLikes>[];
      json['ForumLikes'].forEach((v) {
        forumLikes!.add(ForumLikes.fromJson(v));
      });
    }
    if (json['ForumComments'] != null) {
      forumComments = <ForumComments>[];
      json['ForumComments'].forEach((v) {
        forumComments!.add(ForumComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumId'] = forumId;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['userId'] = userId;
    if (forumLikes != null) {
      data['ForumLikes'] = forumLikes!.map((v) => v.toJson()).toList();
    }
    if (forumComments != null) {
      data['ForumComments'] =
          forumComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ForumLikes {
  String? forumId;
  String? userId;

  ForumLikes({this.forumId, this.userId});

  ForumLikes.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumId'] = forumId;
    data['userId'] = userId;
    return data;
  }
}

class ForumComments {
  String? forumCommentId;
  String? forumId;
  String? userId;
  String? comment;
  String? createdAt;

  ForumComments(
      {this.forumCommentId,
      this.forumId,
      this.userId,
      this.comment,
      this.createdAt});

  ForumComments.fromJson(Map<String, dynamic> json) {
    forumCommentId = json['forumCommentId'];
    forumId = json['forumId'];
    userId = json['userId'];
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forumCommentId'] = forumCommentId;
    data['forumId'] = forumId;
    data['userId'] = userId;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    return data;
  }
}