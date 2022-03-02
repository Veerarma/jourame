class JModel{
  int id;
  String title;
  String body;
  DateTime date;

  JModel({ this.id, this.title, this.body,this.date});


  Map<String, dynamic> toMap(){
    return({
      "id":id,
      "title":title,
      "body":body,
      "date":date.toString()
    });
  }
}