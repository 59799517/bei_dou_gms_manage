import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/alert/gf_alert.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'logic.dart';

class SearchMaterialComponent extends StatelessWidget {
  SearchMaterialComponent({Key? key}) : super(key: key);

  final SearchMaterialLogic logic = Get.put(SearchMaterialLogic());

  @override
  Widget build(BuildContext context) {
    Color dialogBackgroundColor = Theme.of(context).dialogBackgroundColor;

    return Container(
      child: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border:
                    new Border.all(color: Colors.black87, width: 0.5), // border
                borderRadius: BorderRadius.circular((100)), // 圆角
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: GetBuilder<SearchMaterialLogic>(
                        id: logic.V_select_Name,
                        builder: (logic) {
                          return Container(
                            margin: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              // width: 100,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Text(
                                    '请选择',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: logic.selectList.map((item) {
                                    return DropdownMenuItem(
                                      value: item.search_name,
                                      //disable default onTap to avoid closing menu when selecting an item
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) {
                                          final isSelected = logic.selectedItems
                                              .contains(item);
                                          return InkWell(
                                            onTap: () {
                                              isSelected
                                                  ? logic.selectedItems
                                                      .remove(item)
                                                  : logic.selectedItems
                                                      .add(item);
                                              //This rebuilds the StatefulWidget to update the button's text
                                              // setState(() {});
                                              logic.changeSelectValue();
                                              //This rebuilds the dropdownMenu Widget to update the check mark
                                              menuSetState(() {});
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  if (isSelected)
                                                    const Icon(Icons
                                                        .check_box_outlined)
                                                  else
                                                    const Icon(Icons
                                                        .check_box_outline_blank),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Text(
                                                      item.search_name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                  value: logic.selectedItems.isEmpty
                                      ? null
                                      : logic.selectedItems.last.search_name,
                                  onChanged: (value) {},
                                  selectedItemBuilder: (context) {
                                    return logic.selectList.map(
                                      (item) {
                                        return Container(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text(
                                            logic.selectedItems
                                                .map((e) => e.search_name)
                                                .join(', '),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 8),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    flex: 10,
                    child: TextField(
                      controller: logic.search_controller,
                      onSubmitted: (value) {
                        logic.onSearch();
                      },
                      decoration: InputDecoration(
                        hintText: "请输入搜索内容", //取消底部边框
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {
                              logic.onSearch();
                            },
                            icon: Icon(Symbols.search)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: GetBuilder<SearchMaterialLogic>(
                id: logic.V_search_searchResult_Name,
                builder: (logic) {
                  return Container(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return SQListTile(
                              titleText: logic.searchResult[index].name,
                              title: Text(logic.searchResult[index].name,
                                  overflow: TextOverflow.ellipsis),
                              //长度溢出后显示省略号),
                              subTitleText: logic
                                  .getTypeDesc(logic.searchResult[index].type),
                              avatar: Image(
                                  image: NetworkImage(MSImageUtils.getIconUrl(
                                    category: "item",
                                    itemId: logic.searchResult[index].id,
                                  )),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                        Symbols.error_circle_rounded);
                                  }),
                              icon: Icon(Icons.keyboard_arrow_right,
                                size: 30.0),
                              onTap: () {
                                Dialogs.materialDialog(
                                  color: dialogBackgroundColor,
                                  title: "${logic.searchResult[index].name} ",
                                  customView: Container(
                                      padding: EdgeInsets.all(8),
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Image(
                                                image: NetworkImage(
                                                    MSImageUtils.getIconUrl(
                                                  category: "item",
                                                  itemId: logic
                                                      .searchResult[index].id,
                                                )),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(Symbols
                                                      .error_circle_rounded);
                                                }),
                                            Text(logic.searchResult[index].desc
                                                    .trim()
                                                    .isEmpty
                                                ? "暂无描述"
                                                : logic
                                                    .searchResult[index].desc),
                                          ],
                                        ),
                                      )),
                                  customViewPosition:
                                      CustomViewPosition.BEFORE_ACTION,
                                  context: context,
                                );
                              },
                            );
                          },
                          itemCount: logic.searchResult.length));
                }),
          )
        ],
      )),
    );
  }
}
