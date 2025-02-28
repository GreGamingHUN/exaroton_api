class ServerStatus {
  static const int offline = 0;
  static const int online = 1;
  static const int starting = 2;
  static const int stopping = 3;
  static const int restarting = 4;
  static const int saving = 5;
  static const int loading = 6;
  static const int crashed = 7;
  static const int pending = 8;
  static const int transferring = 9;
  static const int preparing = 10;

  static String getServerStatusFromValue(int value) {
    switch (value) {
      case offline:
        return "Offline";
      case online:
        return "Online";
      case starting:
        return "Starting";
      case stopping:
        return "Stopping";
      case restarting:
        return "Restarting";
      case saving:
        return "Saving";
      case loading:
        return "Loading";
      case crashed:
        return "Crashed";
      case pending:
        return "Pending";
      case transferring:
        return "Transferring";
      case preparing:
        return "Preparing";
      default:
        return "Unknown";
    }
  }
}
