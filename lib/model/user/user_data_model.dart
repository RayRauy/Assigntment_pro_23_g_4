
class UserDataModel {
  UserDataModel({
      this.status, 
      this.title, 
      this.timestamp, 
      this.pagination, 
      this.data,});

  UserDataModel.fromJson(dynamic json) {
    status = json['status'];
    title = json['title'];
    timestamp = json['timestamp'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(userData.fromJson(v));
      });
    }
  }
  int? status;
  String? title;
  int? timestamp;
  Pagination? pagination;
  List<userData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['title'] = title;
    map['timestamp'] = timestamp;
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Pagination {
  Pagination({
    this.page,
    this.size,
    this.total,
    this.totalPages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    size = json['size'];
    total = json['total'];
    totalPages = json['totalPages'];
  }
  int? page;
  int? size;
  int? total;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['size'] = size;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }
}

class userData {
  userData({
    this.id,
    this.username,
    this.nickName,
    this.enabled,
    this.imageName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,});

  userData.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    nickName = json['nickName'];
    enabled = json['enabled'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  int? id;
  String? username;
  String? nickName;
  bool? enabled;
  String? imageName;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['nickName'] = nickName;
    map['enabled'] = enabled;
    map['imageName'] = imageName;
    map['imageUrl'] = imageUrl;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}