import 'dart:convert';
import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BusinessAdminController {
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, EmployeeModel>> addNewEmployee(employee) async {
    var token = await BusinessAdminStorage().getToken();
    headers['Authorization'] = "Bearer $token";
   try{
     var response = await http.post(Uri.parse(EMPLOYEE_URL),
         body: employee, headers: headers);
     print(response.statusCode);
     print(response.body);
     if (response.statusCode == 201) {
       var resBody = jsonDecode(response.body);
       EmployeeModel employeeModel = EmployeeModel.fromJson(resBody['employee']);
       return Right(employeeModel);
     } else {
       if (response.statusCode == 409) {
         return Left(DuplicateDataFailure());
       }
       return Left(ServerFailure());
     }
   }
   catch(e){
     print(e);
     return Left(ServerFailure());
   }
  }

  Future<Either<Failure, List<EmployeeModel>>> getEmployees(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var business = userProvider.getBusinessAdmin()!.business!.id;
    var token = await BusinessAdminStorage().getToken();
    headers['Authorization'] = "Bearer $token";

     try{
       var response = await http.get(
           Uri.parse("$EMPLOYEES_LIST_URL?business=$business"),
           headers: headers).timeout(const Duration(seconds: 15));
        print(response.statusCode);
        print(response.body);
       var resBody = jsonDecode(response.body);
        if(response.statusCode == 200){
          List<EmployeeModel> employeeModel = resBody
              .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
              .toList();
          return Right(employeeModel);
        }
        else{
          return Left(ServerFailure());
        }

     }
     catch(e){
       return Left(ServerFailure());
     }

  }

  Future<Either<Failure, List<EmployeeModel>>> getEmployeeDetails(
      context, employeeID) async {
    try{
      var response = await http
          .get(Uri.parse("$EMPLOYEE_DETAILS_URL/$employeeID"), headers: headers);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List<EmployeeModel> employeeModel = resBody
            .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
            .toList();
        return Right(employeeModel);
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, EmployeeModel>> updateEmployeeProfile(context, body) async {
    var token = await BusinessAdminStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response = await http.put(
          Uri.parse(EDIT_EMP_DETAILS_URL),
          body: body ,
          headers: headers);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("Conflict")) {

          return Left(DuplicateDataFailure(message: "Tashme ekziston nje perdorues me kete adrese elektronike, ose emer te perdoruesit"));
        }
        else if (resBody.toString().contains("employee")) {
          EmployeeModel employeeModel =
          EmployeeModel.fromJson(resBody['employee']);
          return Right(employeeModel);
        }
        return Left(ServerFailure());
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
    Future<Either<Failure, EmployeeModel>> deleteEmployee(context, id) async {

    var token = await BusinessAdminStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response = await http.delete(
          Uri.parse("$DELETE_EMP_URL/$id"),
          headers: headers);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("employee")) {
          EmployeeModel employeeModel =
          EmployeeModel.fromJson(resBody['employee']);
          return Right(employeeModel);
        }
        return Left(ServerFailure());
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<BusinessModel>>> getAllBusinesses() async {
    try {
      var response = await http.get(Uri.parse(GET_ALL_BUSINESSES_URL));

      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List<BusinessModel> businessModel = resBody
            .map<BusinessModel>((json) => BusinessModel.fromJson(json))
            .toList();
        return Right(businessModel);
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }


}
