// import 'dart:developer';

// import 'package:babi_connexions/data/model/list_place_model.dart';
// import 'package:babi_connexions/data/provider/auth_provider.dart';
// import 'package:babi_connexions/data/provider/google_map_data_provider.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;
// part 'place_state.dart';

// class PlaceCubit extends Cubit<PlaceState> {
//   PlaceCubit() : super(PlaceInitial());
//   Future getPlaceList() async {
//     GoogleMapDataProvider apiRepository = GoogleMapDataProvider();
//     emit(PlaceStateLoading());
//     try {
//       var checkUrl = 'http://www.google.com';
//       var checkResponse = await http.get(Uri.parse(checkUrl));
//       if (checkResponse.statusCode == 200) {
//         // if (!await AuthProvider().isTokenValid()) {
//         //   // token est expiré, appelez refreshToken()
//         //   await AuthProvider().refreshToken();
//         // }
//         var result = await apiRepository.getPlaceList();
//         log('place$result');
//         result != null
//             ? emit(PlaceStateLoaded(result))
//             : emit(PlaceStateError('oups'));
//       } else {
//         emit(PlaceStateError('oups'));
//       }
//     } catch (e) {
//       log(e.toString());
//       emit(PlaceStateError(e.toString()));
//     }
//   }
// }
