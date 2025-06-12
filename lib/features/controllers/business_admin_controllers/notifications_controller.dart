import 'dart:convert';
import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/local_storage.dart';
import 'package:business_menagament/features/models/checkout_model.dart';
import 'package:business_menagament/features/models/notification_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationsController {
  static var headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<NotificationModel>>> getNotifications(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response =
        await http.get(Uri.parse("$NOTIFICATIONS_URL/${userProvider.getUser()!.id}"), headers: headers);
    print(userProvider.getUser()!.id);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains("errors")) return Left(WrongFailure());

      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("notifications")) {
        List<NotificationModel> transactions= resBody['notifications']
            .map<NotificationModel>((json) => NotificationModel.fromJson(json))
            .toList();
        return Right(transactions);
      }
      return Left(ServerFailure());
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NotificationModel>> readNotification(context,nId) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response =
        await http.put(Uri.parse("$READ_NOTIFICATIONS_URL/$nId"), headers: headers);

    if (response.statusCode == 200) {
      if (response.body.contains("errors")) return Left(WrongFailure());

      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("Not Found")) {
        return Left(EmptyDataFailure(message: "Ky njoftim nuk ekziston!"));
      }
      else if (resBody.toString().contains("notifications")) {
        NotificationModel  transactionModel = NotificationModel.fromJson(resBody['notifications']);
        return Right(transactionModel);
      }
      return Left(ServerFailure());
    } else {
      return Left(ServerFailure());
    }
  }
}
