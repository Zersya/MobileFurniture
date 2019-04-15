class Response {
  final bool success;
  final String type;
  final String message;
  final String token;

  Response(this.success, this.type, this.message, this.token);

  factory Response.fromJson(Map<String, dynamic> json){
    return Response(json['success'], json['type'], json['message'], json['token']);
  }

}
