import 'package:internship_project/models/leaders.dart';

final dummyLeaders = [
  Leaders(
    name: 'Alice Johnson',
    phone: String.fromCharCode('+1234567890'.codeUnits as int),
    email: 'alice@gmail.com',

    status: Status.Contacted,
  ),
  Leaders(
    phone: String.fromCharCode('+0987654321'.codeUnits as int),
    name: 'Bob Smith',
    email: 'bob@gmail.com',
    status: Status.Converted,
  ),
  Leaders(
    name: 'Catherine Lee',
    phone: String.fromCharCode('+1122334455'.codeUnits as int),
    email: 'le@gmail.com',
    status: Status.New,
  ),
  Leaders(
    name: 'David Brown',
    phone: String.fromCharCode('+5566778899'.codeUnits as int),
    email: 'david@gmail.com',
    status: Status.New,
  ),
  Leaders(
    name: 'Eva Green',
    phone: String.fromCharCode('+6677889900'.codeUnits as int),
    email: 'eva@gmail.com',
    status: Status.New,
  ),
];
