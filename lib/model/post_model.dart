class Post{
  String userId;
  String fullname;
  String lastname;
  String date;
  String content;
  String img_url;

  Post(this.userId, this.fullname, this.lastname, this.date, this.content, this.img_url);

Post.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
      fullname = json['fullname'],
      lastname = json['lastname'],
      date = json['date'],
      content = json['content'],
      img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'fullname' : fullname,
    'lastname' : lastname,
    'date' : date,
    'content' : content,
    'img_url' : img_url,

  };
  }