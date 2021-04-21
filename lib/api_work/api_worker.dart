import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:courier_prototype/home_widget.dart';
import 'package:courier_prototype/messages/message_widget.dart';
import 'package:courier_prototype/order/order.dart';
import 'package:courier_prototype/order/order_accepted_widget.dart';
import 'package:courier_prototype/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResultDto {
  LoginResultDto({required this.workerId, required this.authToken});

  factory LoginResultDto.fromJson(Map<String, dynamic> json) {
    return LoginResultDto(
        workerId: json['workerId'] as int,
        authToken: json['authToken'] as String);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'workerId': this.workerId, 'authToken': this.authToken};

  final int workerId;
  final String authToken;
}

@JsonSerializable()
class LoginDto {
  LoginDto({required this.Login, required this.Password});

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
        Login: json['Login'] as String, Password: json['Password'] as String);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'Login': this.Login, 'Password': this.Password};

  final String Login;
  final String Password;
}

@JsonSerializable()
class UnservedOrderDto {
  UnservedOrderDto(
      {required this.id,
      required this.content,
      required this.addressString,
      required this.addressAdditional});

  factory UnservedOrderDto.fromJson(Map<String, dynamic> json) {
    return UnservedOrderDto(
        id: json['id'] as int,
        content: json['content'] as String,
        addressString: json['addressString'] as String,
        addressAdditional: json['addressAdditional'] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'content': this.content,
        'addressString': this.addressString,
        'addressAdditional': this.addressAdditional
      };

  final int id;
  final String content;
  final String addressString;
  final String addressAdditional;
}

@JsonSerializable()
class CourierMessageDto {
  CourierMessageDto(
      {required this.CreationDateTime,
      required this.Content,
      required this.isFromCourier});

  factory CourierMessageDto.fromJson(Map<String, dynamic> json) {
    return CourierMessageDto(
        CreationDateTime: json['creationDateTime'] as String,
        Content: json['content'] as String,
        isFromCourier: json['isFromCourier'] as bool);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'creationDateTime': this.CreationDateTime,
        'content': this.Content,
        'isFromCourier': this.isFromCourier
      };

  final String CreationDateTime;
  final String Content;
  final bool isFromCourier;
}

@JsonSerializable()
class GetCourierMessagesResultDto {
  GetCourierMessagesResultDto({required this.Messages});

  factory GetCourierMessagesResultDto.fromJson(Map<String, dynamic> json) {
    return GetCourierMessagesResultDto(
        Messages: (json['messages'] as List<dynamic>)
            .map((e) => CourierMessageDto.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'messages': this.Messages};

  final List<CourierMessageDto> Messages;
}

@JsonSerializable()
class GetUnservedOrdersResultDto {
  GetUnservedOrdersResultDto({required this.Orders});

  factory GetUnservedOrdersResultDto.fromJson(Map<String, dynamic> json) {
    return GetUnservedOrdersResultDto(
        Orders: (json['orders'] as List<dynamic>)
            .map((e) => UnservedOrderDto.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'orders': this.Orders};

  final List<UnservedOrderDto> Orders;
}

@JsonSerializable()
class SendCourierMessageDto {
  SendCourierMessageDto({required this.content, required this.courierId});

  factory SendCourierMessageDto.fromJson(Map<String, dynamic> json) {
    return SendCourierMessageDto(
        content: json['content'] as String,
        courierId: json['courierId'] as int);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'content': this.content, 'courierId': this.courierId};

  final String content;
  final int courierId;
}

@JsonSerializable()
class BeginDeliveryDto {
  BeginDeliveryDto({required this.courierId, required this.orderId});

  factory BeginDeliveryDto.fromJson(Map<String, dynamic> json) {
    return BeginDeliveryDto(
        courierId: json['courierId'] as int, orderId: json['orderId'] as int);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'courierId': this.courierId, 'orderId': this.orderId};

  final int courierId;
  final int orderId;
}

@JsonSerializable()
class DeliveryDto {
  DeliveryDto({required this.orderId, required this.courierId});

  factory DeliveryDto.fromJson(Map<String, dynamic> json) {
    return DeliveryDto(
        orderId: json['orderId'] as int, courierId: json['courierId'] as int);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'orderId': this.orderId, 'courierId': this.courierId};

  final int orderId;
  final int courierId;
}

@JsonSerializable()
class DeliveriesDto {
  DeliveriesDto({required this.deliveries});

  factory DeliveriesDto.fromJson(Map<String, dynamic> json) {
    return DeliveriesDto(
        deliveries: (json['deliveries'] as List<dynamic>)
            .map((e) => DeliveryDto.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'deliveries': this.deliveries};

  final List<DeliveryDto> deliveries;
}

@JsonSerializable()
class LatLngDto {
  LatLngDto({required this.lat, required this.lng});

  factory LatLngDto.fromJson(Map<String, dynamic> json) {
    return LatLngDto(
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble());
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'lat': this.lat, 'lng': this.lng};

  final double lat;
  final double lng;
}

@JsonSerializable()
class OrderDto {
  OrderDto(
      {required this.content,
      required this.addressString,
      required this.addressAdditional,
      required this.destination});

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
        content: json['content'] as String,
        addressString: json['addressString'] as String,
        addressAdditional: json['addressAdditional'] as String,
        destination: null);
    //LatLngDto.fromJson(json['destination'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': this.content,
        'addressString': this.addressString,
        'addressAdditional': this.addressAdditional,
        'destination': this.destination
      };

  final String content;
  final String addressString;
  final String addressAdditional;
  final LatLngDto? destination;
}

String baseUrl = "https://192.168.21.104:8443/api";

Future<void> login(LoginDto LoginDto, BuildContext context) async {
  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print('object');
  print(baseUrl + '/courier/login');

  final response = await ioClient.post(Uri.parse(baseUrl + '/courier/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(LoginDto));

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    SingletonDS inst = SingletonDS();
    inst.token = LoginResultDto.fromJson(json.decode(response.body)).authToken;
    inst.courierId =
        LoginResultDto.fromJson(json.decode(response.body)).workerId;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeWidget()));
  }
}

Future<Set<Order>> getNewOrders(int restId) async {
  Set<Order> orders = {};
  SingletonDS db = SingletonDS();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(baseUrl + '/order/getunserved?restaurantId=' + restId.toString());

  final response = await ioClient.get(
    Uri.parse(baseUrl + '/order/getunserved?restaurantId=' + restId.toString()),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(response.statusCode);
  print(response.body);

  GetUnservedOrdersResultDto dd =
      GetUnservedOrdersResultDto.fromJson(json.decode(response.body));

  orders.addAll(dd.Orders.map(
      (e) => Order(e.id, e.content, e.addressString, e.addressAdditional)));

  if (response.statusCode == 200) {}

  return orders;
}

sendSos() async {
  SingletonDS db = SingletonDS();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(baseUrl + '/sos/requestsos?courierId=' + db.courierId.toString());

  final response = await ioClient.post(
    Uri.parse(baseUrl + '/sos/requestsos?courierId=' + db.courierId.toString()),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {}
}

Future<List<MessageW>> getMessages() async {
  List<MessageW> strL = [];

  SingletonDS db = SingletonDS();
  String courId = db.courierId.toString();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(baseUrl + '/messaging/cgethistory?courierId=$courId');

  final response = await ioClient.get(
    Uri.parse(baseUrl + '/messaging/cgethistory?courierId=$courId'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(response.statusCode);
  print(response.body);

  GetCourierMessagesResultDto msgs =
      GetCourierMessagesResultDto.fromJson(json.decode(response.body));

  strL.addAll(msgs.Messages.map((e) => MessageW(
        text: e.Content,
        time: e.CreationDateTime,
        isFromCourier: e.isFromCourier,
      )));

  return strL;
}

Future<void> sendMessage(String str) async {
  return Future<void>(() async {
    SingletonDS db = SingletonDS();

    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

    print(baseUrl + '/messaging/csend');

    print(str);

    final response = await ioClient.post(
        Uri.parse(baseUrl + '/messaging/csend'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'auth-token': db.token
        },
        body: json.encode(
            SendCourierMessageDto(content: str, courierId: db.courierId)));

    print(response.statusCode);
    print(response.body);
  });
}

acceptOrder(int orderId) async {
  SingletonDS db = SingletonDS();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(baseUrl + '/sos/requestsos?courierId=' + db.courierId.toString());

  final response = await ioClient.post(Uri.parse(baseUrl + '/delivery/begin'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'auth-token': db.token
      },
      body: json
          .encode(BeginDeliveryDto(courierId: db.courierId, orderId: orderId)));

  print(response.statusCode);
  print(response.body);
}

Future<Set<AcceptedOrder>> getActiveOrders(int restId) async {
  Set<AcceptedOrder> orders = {};
  SingletonDS db = SingletonDS();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(Uri.parse(baseUrl +
      '/delivery/getinprogressbycourier?courierId=' +
      db.courierId.toString()));

  final response = await ioClient.get(
    Uri.parse(baseUrl +
        '/delivery/getinprogressbycourier?courierId=' +
        db.courierId.toString()),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(response.statusCode);
  print(response.body);

  DeliveriesDto dd = DeliveriesDto.fromJson(json.decode(response.body));

  print('deliv');

  late OrderDto ordTem;

  final resp = await ioClient.get(
    Uri.parse(baseUrl +
        '/order/GetInfo?orderId=' +
        dd.deliveries.first.orderId.toString()),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(json.decode(resp.body));
  ordTem = OrderDto.fromJson(json.decode(response.body));

  print('yolo');

  Future.forEach(dd.deliveries, (DeliveryDto e) async {
    final response = await ioClient.get(
      Uri.parse(baseUrl + '/order/GetInfo?orderId=' + e.orderId.toString()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'auth-token': db.token
      },
    );

    ordTem = OrderDto.fromJson(json.decode(response.body));

    orders.add(Order(e.orderId, ordTem.content, ordTem.addressString,
        ordTem.addressAdditional));
  });

  return orders;
}

finishOrder(int orderId) async {
  SingletonDS db = SingletonDS();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);

  print(baseUrl + '/delivery/Finish');

  final response = await ioClient.get(
    Uri.parse(baseUrl + '/delivery/Finish?deliveryId'+orderId),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'auth-token': db.token
    },
  );

  print(response.statusCode);
  print(response.body);
}
