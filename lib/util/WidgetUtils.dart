import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

enum WidgetType { input, toggle, date, sex, slider }

enum InputType { number, text, date }

class WidgetUtils {
  static showProbDialog(String title, String keyName, Function callback,
      Map<String, double> otherWeight, double defaultValue) async {
    //最大权重
    double maxweight = 10000;
    var probValue = 0.0.obs;
    var weightValue = 0.0.obs;
    weightValue.value = defaultValue;
    //除了自身的权重
    double allWeight = 0;
    if (otherWeight.isEmpty || otherWeight.length == 0) {
      allWeight = 0;
    } else {
      otherWeight.forEach((key, value) {
        allWeight += value;
      });
    }
    //计算自己的概率
    probValue.value = double.parse(
        (weightValue.value / (allWeight + weightValue.value))
            .toStringAsFixed(6));
    //计算自己最大概率
    double maxProb =
        double.parse((maxweight / (maxweight + allWeight)).toStringAsFixed(6));
    RxMap<String, double> otherProb = RxMap<String, double>({});
    //计算其他的概率
    otherWeight.forEach((key, value) {
      otherProb[key] = double.parse(
          ((value / (allWeight + weightValue.value)) * 100).toStringAsFixed(6));
    });
    TextEditingController _controller = TextEditingController();
    _controller.text = weightValue.value.toString();
    Get.defaultDialog(
      title: title,
      content: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Obx(() {
              return Text(
                "当前概率${(probValue.value * 100).toStringAsFixed(6)}%(权重最大10000)",
                style: const TextStyle(fontSize: 12),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Container(child: Obx(() {
              return SfSlider(
                min: 0.0,
                max: maxProb,
                value: probValue.value,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  probValue.value = value;

                  //根据概率计算权重
                  weightValue.value = double.parse(
                      ((value / maxProb) * maxweight).toStringAsFixed(6));
                  _controller.text = weightValue.value.toString();
                  //计算其他的概率
                  otherWeight.forEach((key, value) {
                    otherProb[key] = double.parse(
                        ((value / (allWeight + weightValue.value)) * 100)
                            .toStringAsFixed(6));
                  });
                },
              );
            })),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                child: TextField(
                  maxLines: null,
                  minLines: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "请输入",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    // 设置输入框可编辑时的边框样式
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    // 用来配置输入框获取焦点时的颜色
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    try {
                      weightValue.value = double.parse(value);
                    } catch (e) {
                      weightValue.value = 0.0;
                    }
                    if (weightValue.value > maxweight) {
                      weightValue.value = maxweight;
                    }
                    //计算其他的概率
                    otherWeight.forEach((key, value) {
                      otherProb[key] = double.parse(
                          ((value / (allWeight + weightValue.value)) * 100)
                              .toStringAsFixed(6));
                    });
                    //计算自己的概率
                    probValue.value = double.parse(
                        (weightValue.value / (allWeight + weightValue.value))
                            .toStringAsFixed(6));
                  },
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Obx(() {
                return Column(
                    children: otherWeight.keys.map((e) {
                  return Text(
                      "${e}   权重:${otherWeight[e]}  概率：${otherProb.value[e]}");
                }).toList());
              }),
            )
          ])),
      confirm: Container(
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(
                  color: Colors.blueAccent,
                ),
                minimumSize: const Size(100, 40)),
            onPressed: () {
              Get.back();
              callback({"weight": weightValue.value, "prob": probValue.value});
            },
            child: const Text(
              "确定",
              style: TextStyle(color: Colors.blueAccent),
            )),
      ),
      //取消按钮
      cancel: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: const BorderSide(
              color: Colors.redAccent,
            ),
            minimumSize: const Size(100, 40)),
        onPressed: () {
          Get.back();
        },
        child: const Text("取消",
            style: TextStyle(
              color: Colors.redAccent,
            )),
      ),
      barrierDismissible: true,
      // backgroundColor: Colors.white,
      radius: 0,
    );
  }

  static showDialog(String title, String keyName, Function callback,
      {defaultValue = "",
      BuildContext? context,
      String subTitle = "",
      WidgetType type = WidgetType.input,
      InputType inputType = InputType.text}) async {
    if (type == WidgetType.input) {
      var dateStr = "".obs;

      TextEditingController _controller = TextEditingController();
      if (defaultValue.isNotEmpty) {
        _controller.text = defaultValue;
        dateStr.value = defaultValue;
      } else {
        dateStr.value = "0";
        _controller.text = "";
      }

      Get.defaultDialog(
        title: title,
        content: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                child: inputType == InputType.date
                    ? Container(
                        child: dateStr.value == "-1"
                            ? Container(
                                child: Text("永久"),
                              )
                            : Text(
                                "(毫秒时间戳)修改后的时间为：${formatDate(DateTime.fromMillisecondsSinceEpoch(int.parse(dateStr.value)), [
                                    yyyy,
                                    '-',
                                    mm,
                                    '-',
                                    dd,
                                    ' ',
                                    HH,
                                    ':',
                                    nn,
                                    ':',
                                    ss
                                  ])}"),
                      )
                    : Text(
                        "请输入新的${title}",
                        style: const TextStyle(fontSize: 12),
                      ),
              ),
              subTitle.isNotEmpty ? Text(subTitle) : Container(),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: null,
                minLines: 1,
                controller: _controller,
                inputFormatters: (inputType == InputType.text ||
                        inputType == InputType.date)
                    ? [LengthLimitingTextInputFormatter(100)]
                    //改为允许正负整数
                    : [FilteringTextInputFormatter.allow(RegExp(r'^-|[0-9]'))],
                onChanged: (value) {
                  if (inputType == InputType.date) {
                    if (value.isEmpty) {
                      dateStr.value = "-1";
                      _controller.text = "-1";
                    } else {
                      dateStr.value = value;
                    }
                  }
                },
                decoration: const InputDecoration(
                  hintText: "请输入",
                  // hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  // 设置输入框可编辑时的边框样式
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  // 用来配置输入框获取焦点时的颜色
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              )
            ])),
        confirm: Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  minimumSize: const Size(100, 40)),
              onPressed: () {
                callback(_controller.text);
                Get.back();
              },
              child: const Text(
                "确定",
                style: TextStyle(color: Colors.blueAccent),
              )),
        ),
        //取消按钮
        cancel: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(
                color: Colors.redAccent,
              ),
              minimumSize: const Size(100, 40)),
          onPressed: () {
            Get.back();
          },
          child: const Text("取消",
              style: TextStyle(
                color: Colors.redAccent,
              )),
        ),
        barrierDismissible: true,
        // backgroundColor: Colors.white,
        radius: 0,
      );
    } else if (type == WidgetType.toggle) {
      bool selevtValue = false;
      if (defaultValue.isNotEmpty) {
        //true和1是 真 其他是0 和 false 是假 其他则 都为假
        selevtValue = defaultValue == "true" || defaultValue == "1";
      }
      Get.defaultDialog(
        title: title,
        content: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text(
                "请输入新的${title}",
                style: const TextStyle(fontSize: 12),
              ),
              subTitle.isNotEmpty ? Text(subTitle) : Container(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: selevtValue?0:1,
                  cornerRadius: 20.0,
                  totalSwitches: 2,
                  labels: ["开/是", '关/否'],
                  icons: [Symbols.check, Symbols.close],
                  activeBgColors: [
                    [Colors.blue],
                    [Colors.pink]
                  ],
                  onToggle: (index) {
                    selevtValue = index == 0 ? true : false;
                    print('switched to: $index');
                  },
                ),
              ),
              SizedBox(
                height: 20,
              )
            ])),
        confirm: Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  minimumSize: const Size(100, 40)),
              onPressed: () {
                callback(selevtValue);
                Get.back();
              },
              child: const Text(
                "确定",
                style: TextStyle(color: Colors.blueAccent),
              )),
        ),
        //取消按钮
        cancel: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(
                color: Colors.redAccent,
              ),
              minimumSize: const Size(100, 40)),
          onPressed: () {
            Get.back();
          },
          child: const Text("取消",
              style: TextStyle(
                color: Colors.redAccent,
              )),
        ),
        barrierDismissible: true,
        // backgroundColor: Colors.white,
        radius: 0,
      );
    } else if (type == WidgetType.date) {
      DateTime initDateTime = DateTime.now();
      if (defaultValue.isNotEmpty) {
        DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
        initDateTime = formatter.parse(defaultValue);
      }
      DateTime? dateTime = await showOmniDateTimePicker(
        context: context!,
        is24HourMode: true,
        initialDate: initDateTime,
      );
      if (dateTime == null) {
        return;
      }
      var selectTime = formatDate(
          dateTime, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
      callback(selectTime);
    } else if (type == WidgetType.sex) {
      int index = 0;
      List<String> list = ["男", "女", "通用"];
      if (defaultValue.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          var element = list[i];
          if (element == defaultValue) {
            index = i;
            break;
          }
        }
      }
      Get.defaultDialog(
        title: title,
        content: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text(
                "请输入新的${title}",
                style: const TextStyle(fontSize: 12),
              ),
              subTitle.isNotEmpty ? Text(subTitle) : Container(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 90.0,
                  fontSize: 16.0,
                  initialLabelIndex: index,
                  activeBgColor: [Colors.green],
                  activeFgColor: Colors.white,
                  inactiveFgColor: Colors.grey[900],
                  totalSwitches: list.length,
                  icons: const [
                    Symbols.female_rounded,
                    Symbols.male_rounded,
                    Symbols.transgender
                  ],
                  labels: [...list],
                  onToggle: (index) {
                    index = index!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              )
            ])),
        confirm: Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  minimumSize: const Size(100, 40)),
              onPressed: () {
                callback(list[index]);
                Get.back();
              },
              child: const Text(
                "确定",
                style: TextStyle(color: Colors.blueAccent),
              )),
        ),
        //取消按钮
        cancel: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(
                color: Colors.redAccent,
              ),
              minimumSize: const Size(100, 40)),
          onPressed: () {
            Get.back();
          },
          child: const Text("取消",
              style: TextStyle(
                color: Colors.redAccent,
              )),
        ),
        barrierDismissible: true,
        // backgroundColor: Colors.white,
        radius: 0,
      );
    } else if (type == WidgetType.slider) {
      var valeu = 0.0.obs;
      try {
        if (defaultValue.isNotEmpty) {
          valeu.value = double.parse(defaultValue);
        }
      } catch (e) {
        valeu.value = double.parse(defaultValue.toString());
      }
      Get.defaultDialog(
        title: title,
        content: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text(
                "请输入新的${title}",
                style: const TextStyle(fontSize: 12),
              ),
              Obx(() {
                return Text("当前概率为：${valeu.value.toStringAsFixed(4)}%");
              }),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return SfSlider(
                  min: 0.0,
                  max: 100.0,
                  value: valeu.value,
                  interval: 20,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    valeu.value = value;
                  },
                );
              }),
              SizedBox(
                height: 20,
              )
            ])),
        confirm: Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  minimumSize: const Size(100, 40)),
              onPressed: () {
                callback(valeu.value.toStringAsFixed(4));
                Get.back();
              },
              child: const Text(
                "确定",
                style: TextStyle(color: Colors.blueAccent),
              )),
        ),
        //取消按钮
        cancel: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(
                color: Colors.redAccent,
              ),
              minimumSize: const Size(100, 40)),
          onPressed: () {
            Get.back();
          },
          child: const Text("取消",
              style: TextStyle(
                color: Colors.redAccent,
              )),
        ),
        barrierDismissible: true,
        // backgroundColor: Colors.white,
        radius: 0,
      );
    }
  }
}
