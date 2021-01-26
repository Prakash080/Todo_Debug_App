import 'package:get/get.dart';
import 'GetX_Helper/FirebaseController.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseController>(() => FirebaseController());
  }
}
