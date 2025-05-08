// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:app2/data/models/register_model.dart';
//
// class RegisterService{
//   final String baseUrl='https://fakestoreapi.com/users';
//
//   Future<bool>registerUser(RegisterRequestModel model)async{
//     try{
//       final response=await http.post(
//         Uri.parse(baseUrl),
//         headers:{
//           'Content-Type':'application/json',
//         },
//         body:jsonEncode(model.toJson()),
//       );
//       if(response.statusCode==200 || response.statusCode==201){
//         print("Resgistration Successful");
//         return true;
//       }
//       else{
//         print("Registration failed");
//         return false;
//       }
//     }
//     catch(e){
//       print('Error during registration:$e');
//       return false;
//     }
//   }
// }
import 'dart:async';
import 'package:app2/data/models/register_model.dart';

class RegisterService {
  Future<bool> registerUser(RegisterRequestModel model) async {
    await Future.delayed(Duration(seconds: 3));
    print("Mock registration data: ${model.toJson()}");
    return true;
  }
}