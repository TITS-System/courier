class SingletonDS {
  static final SingletonDS _appData = new SingletonDS._internal();
    
  late String token;
  late int courierId;

  factory SingletonDS() {
    return _appData;
  }

  SingletonDS._internal(){
    token='nullToken';
    courierId=-1;
  }
}

final appData = SingletonDS();
