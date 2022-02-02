
class GetUserContact {
  String? id;
  String? authId;
  List? contacts;
  String? contactName;
  String? updatedAt;


  GetUserContact({ this.id,  this.authId, this.contacts,this.contactName,this.updatedAt});

  GetUserContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authId = json['authId'];
    contacts = json['contacts'];
    contactName = json['contactName'];
    updatedAt = json['updatedAt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authId'] = this.authId;
    data['contacts'] = this.contacts;
    data['contactName'] = this.contactName;
    data['updatedAt'] = this.updatedAt;

    return data;
  }
}