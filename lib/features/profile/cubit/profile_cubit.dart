// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;
// import 'package:sunrise_hosting/data/model/apireponse.dart';
// import 'package:sunrise_hosting/data/provider/auth_provider.dart';
// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   ProfileCubit() : super(UpdateProfileInitial());

//   void resetState() {
//     emit(UpdateProfileInitial());
//   }

//   final AuthProvider profileProvider = AuthProvider();
//   Future UpdateUserInfo(String name, String email, String role,
//       String firstName, String phone, String id) async {
//     emit(UpdateProfileStateLoading());
//     try {
//       var checkUrl = 'http://www.google.com';
//       var checkResponse = await http.get(Uri.parse(checkUrl));
//       if (checkResponse.statusCode == 200) {
//         // if (!await AuthProvider().isTokenValid()) {
//         //   // token est expiré, appelez refreshToken()
//         //   await AuthProvider().refreshToken();
//         // }
//         var result =
//             await profileProvider.UpdateUserInfo(name, email, date, phone);
//         log('result${result.data}');
//         result.status != null && result.status == true
//             ? emit(UpdateProfileStateLoaded(result))
//             : emit(UpdateProfileStateError('oups'));
//       } else {
//         emit(UpdateProfileStateError('oups'));
//       }
//     } catch (e) {
//       log(e.toString());
//       emit(UpdateProfileStateError(e.toString()));
//     }
//   }

//   // Future updatePassword(String oldPassword, String password) async {
//   //   emit(UpdatePasswordStateLoading());
//   //   try {
//   //     var checkUrl = 'http://www.google.com';
//   //     var checkResponse = await http.get(Uri.parse(checkUrl));
//   //     if (checkResponse.statusCode == 200) {
//   //       if (!await AuthProvider().isTokenValid()) {
//   //         // token est expiré, appelez refreshToken()
//   //         await AuthProvider().refreshToken();
//   //       }
//   //       var result =
//   //           await profileProvider.updatePassword(oldPassword, password);
//   //       log('result${result.status}');
//   //       result.status != null && result.status == true
//   //           ? emit(UpdatePasswordStateLoaded(result))
//   //           : emit(UpdatePasswordStateError(result.error!));
//   //     } else {
//   //       emit(UpdatePasswordStateError('oups'));
//   //     }
//   //   } catch (e) {
//   //     log(e.toString());
//   //     emit(UpdatePasswordStateError(e.toString()));
//   //   }
//   // }

//   // Future getUserInfo(String id, bool isUpdate) async {
//   //   emit(GetUserInfoStateLoading());
//   //   try {
//   //     var checkUrl = 'http://www.google.com';
//   //     var checkResponse = await http.get(Uri.parse(checkUrl));
//   //     if (checkResponse.statusCode == 200) {
//   //       if (!await AuthProvider().isTokenValid()) {
//   //         // token est expiré, appelez refreshToken()
//   //         await AuthProvider().refreshToken();
//   //       }
//   //       var result = await profileProvider.getUserInfo(id, isUpdate);
//   //       log('result${result.data}');
//   //       result.data != null
//   //           ? emit(GetUserInfoStateLoaded(result))
//   //           : emit(GetUserInfoStateError(result.error.toString()));
//   //     }
//   //   } catch (e) {
//   //     log(e.toString());
//   //     emit(GetUserInfoStateError(e.toString()));
//   //   }
//   // }
// }
