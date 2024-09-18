import 'package:http/http.dart' as http;
import 'dart:convert'; 

class aiResponse {
  final String text;

  const aiResponse({
    required this.text,

  });

  factory aiResponse.fromJson(Map<String, dynamic> json) {
    return aiResponse(
      text: json['data'] as String,
    );
  }
}

Future<aiResponse> fetchAiResponse(String query) async {
  final response = await http
      .post(Uri.parse('https://aitrailsbackend.azurewebsites.net/gpt4_rag_prompt/no_url'),
        body: jsonEncode(<String, String>{"question":query}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return aiResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load aiResponse');
  }
}