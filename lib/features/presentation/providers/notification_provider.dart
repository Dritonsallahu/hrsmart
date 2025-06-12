import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/notifications_controller.dart';
import 'package:business_menagament/features/models/notification_model.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notificationList = [];
  int unreadMessages = 0;

  List<NotificationModel> getNotifications() => _notificationList;
  int getUnreadNotifications() => unreadMessages;

  getNotificationsDB(BuildContext context) async {
    NotificationsController notificationsController = NotificationsController();
    var data = await notificationsController.getNotifications(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      _notificationList = result;
      for (var element in _notificationList) {
        if(element.read! == false){
          unreadMessages++;
        }
      }
      notifyListeners();
    });
  }

  readNotificationDB(BuildContext context, String nId) async {
    NotificationsController notificationsController = NotificationsController();
    var data = await notificationsController.readNotification(context,nId);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      for(int i=0;i<_notificationList.length;i++){
        if(_notificationList[i].id == result.id){
          _notificationList[i].read = true;
          unreadMessages -=unreadMessages;
          print(unreadMessages);
        }
      }
      notifyListeners();
    });
  }

  readMessage(messageId){
    for (var element in _notificationList) {
      if(element.id == messageId){
        element.read = true;
      }
    }
    notifyListeners();
  }

  mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props;
      case OfflineFailure:
        return failure.props;
      case DuplicateDataFailure:
        return failure.props;
      case EmptyDataFailure:
        return failure.props;
      case WrongFailure:
        return failure.props;
    }
  }
}
