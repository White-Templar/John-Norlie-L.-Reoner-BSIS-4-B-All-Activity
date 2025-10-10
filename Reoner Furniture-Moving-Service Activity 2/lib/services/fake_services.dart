import '../models/service.dart';

class MovingServicesRepository {
  const MovingServicesRepository();

  List<MovingServiceItem> fetchAll() {
    return demoServices;
  }
}

