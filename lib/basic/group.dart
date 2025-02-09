import 'package:objd/basic/rest_action.dart';
import 'package:objd/basic/widget.dart';
import 'package:objd/basic/for_list.dart';
import 'package:objd/basic/file.dart';
import 'package:objd/build/build.dart';
import 'package:meta/meta.dart';
import 'package:objd/wrappers/comment.dart';

class Group extends RestActionAble {
  static int fileId = 1;
  bool _isFile = false;
  String prefix;
  String suffix;
  String filename;
  String path;
  List<Widget> children;
  int groupMin;
  /// The group groups actions similar to for but has an option to prefix each action and encapsulate the content in a new file.
  /// 
  /// If the children length is larger or equal groupMin a new file is created in `/objD/`(the working directory for objectiveD) and executed.
/// ```dart
/// Group(
/// 	prefix: "execute as @e run "
/// 	children: List<Widget>[
/// 		Command('say 1'),
/// 		Command('say 2'),
/// 		Command('say 3')
/// 	],
/// 	filename: "asgroup",
/// 	groupMin: 2
/// ),
/// ``` 
  Group(
      {this.prefix,
      @required this.children,
      this.suffix,
      this.path = "objd",
      this.groupMin = 3,
      this.filename = "group",bool generateIDs=true}) {
    assert(children != null);
    if (groupMin > -1 && children.length > 0 && children.length >= groupMin) {
      if(generateIDs){
        filename += fileId.toString();
        fileId++;
      }
      _isFile = true;
    }
  }

  String getPath(){
    return path + '/' + filename;
  }

  @override
  Widget generate(Context context) {
    
    if (_isFile) {
      children.insert(0, Comment("Generated ${filename} Group Widget from ${context.file}"));
      return File(
        getPath(),
        execute: true,
        child: For.of(children),
      );
    }
    return For.of(children);
  }
}
