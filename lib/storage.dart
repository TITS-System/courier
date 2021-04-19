class SingletonDS {
  static final SingletonDS _appData = new SingletonDS._internal();
    
  late String token;

  factory SingletonDS() {
    return _appData;
  }

  SingletonDS._internal(){
    token='nullToken';
  }
}

final appData = SingletonDS();
