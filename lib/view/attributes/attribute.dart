import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
 

class SizeColorManager extends StatefulWidget {
  @override
  _SizeColorManagerState createState() => _SizeColorManagerState();
}

class _SizeColorManagerState extends State<SizeColorManager>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> sizes = [];
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add listener to the TabController to track tab changes
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {}); // Call setState to update the FAB label
      }
    });
  }

  // Show bottom modal sheet for adding/editing size
  void showSizeModal({String? initialSize, int? index}) {
    final TextEditingController sizeController =
        TextEditingController(text: initialSize);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Size", style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              TextField(
                controller: sizeController,
                decoration: InputDecoration(
                  labelText: 'Enter Size',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    String newSize = sizeController.text;
                    if (newSize.isNotEmpty) {
                      setState(() {
                        if (index != null) {
                          sizes[index] = newSize; // Update existing size
                        } else {
                          sizes.add(newSize); // Add new size
                        }
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a size')),
                      );
                    }
                  },
                  child: Text(index != null ? 'Update Size' : 'Add Size'),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        );
      },
    );
  }

  // Show bottom modal sheet for adding/editing color
  void showColorModal({Color? initialColor, int? index}) {
    Color selectedColor = initialColor ?? Colors.transparent;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pick a Color'),
              const SizedBox(height: 10),
              BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (Color color) {
                  selectedColor = color;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (selectedColor != Colors.transparent) {
                    setState(() {
                      if (index != null) {
                        colors[index] = selectedColor; // Update existing color
                      } else {
                        colors.add(selectedColor); // Add new color
                      }
                    });
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please pick a color')),
                    );
                  }
                },
                child: Text(index != null ? 'Update Color' : 'Add Color'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Edit size
  void editSize(int index) {
    showSizeModal(initialSize: sizes[index], index: index);
  }

  // Edit color
  void editColor(int index) {
    showColorModal(initialColor: colors[index], index: index);
  }

  // Delete size
  void deleteSize(int index) {
    setState(() {
      sizes.removeAt(index);
    });
  }

  // Delete color
  void deleteColor(int index) {
    setState(() {
      colors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Size and Color Attribute'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Size'),
            Tab(text: 'Color'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Size Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Display list of sizes
                Expanded(
                  child: ListView.builder(
                    itemCount: sizes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Size: ${sizes[index]}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.2),
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue,),
                                  onPressed: () => editSize(index),
                                ),
                              ),
                              SizedBox(width: 8,),
                              CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.2),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red,),
                                  onPressed: () => deleteSize(index),
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Color Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Display list of colors
                Expanded(
                  child: ListView.builder(
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: colors[index],
                          ),
                          title: Text('Color'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.2),
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue,),
                                  onPressed: () => editColor(index),
                                ),
                              ),
                              SizedBox(width: 8,),
                              CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.2),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red,),
                                  onPressed: () => deleteColor(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // FloatingActionButton based on selected tab
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController!.index == 0) {
            // Show size modal when on the Size tab
            showSizeModal();
          } else if (_tabController!.index == 1) {
            // Show color modal when on the Color tab
            showColorModal();
          }
        },
        icon: Icon(Icons.add),
        label: Text(_tabController!.index == 0 ? 'Add Size' : 'Add Color'),
      ),
    );
  }
}
