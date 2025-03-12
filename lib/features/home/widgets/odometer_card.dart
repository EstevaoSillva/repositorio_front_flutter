import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../shared/styles/app_styles.dart';

class OdometerCard extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController odometerController = TextEditingController();
  final RxBool showOdometerInput = false.obs;

  OdometerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hodômetro Atual", style: AppStyles.title),
          SizedBox(height: 8),
          Obx(() => showOdometerInput.value
              ? Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: odometerController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Novo valor",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um valor';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor, insira um número válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        int newOdometer = int.tryParse(odometerController.text) ?? homeController.odometer.value;
                        homeController.updateOdometer(newOdometer);
                        showOdometerInput.value = false;
                        Get.snackbar("Sucesso", "Hodômetro atualizado", backgroundColor: Colors.green, colorText: Colors.white);
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${homeController.odometer.value} km", style: AppStyles.odometerText),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        odometerController.text = homeController.odometer.value.toString();
                        showOdometerInput.value = true;
                      },
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}