import 'package:objd/basic/widget.dart';
import 'package:objd/basic/command.dart';
import 'package:objd/basic/widgets.dart';
import 'package:objd/build/build.dart';
import 'package:meta/meta.dart';

class File extends Widget {
  Widget child;
  String path;
  String pack;
  bool execute;
  bool create;
  bool isRecursive;
  /// The file class simply generates a new mcfunction file with content and a path.
  /// 
  /// The File class can be used as often as you want and where you want, so you can also define a new file in a For container for example.
  /// ```dart
  /// File(
	/// 	path:"main",
	/// 	child: File.execute( // same as execute: true
	/// 		path: 'new'
	/// 		child: Command(...)
	/// 	)
	/// )
  /// ```
  File(this.path,{this.child, this.execute = false,this.pack,this.create = true}){
    this.path.replaceAll('.mcfunction', '');
    if(this.path.substring(0,1) == '/') this.path = this.path.substring(1);
  }
  /// the execute subconstructor adds an execution statement forwarding to the new file into the original
  File.execute(this.path,{this.child,this.pack,this.create = true}){
    this.path.replaceAll('.mcfunction', '');
    if(this.path.substring(0,1) == '/') this.path = this.path.substring(1);
    execute = true;
  }
  File.recursive(){
    isRecursive = true;
    execute = true;
    create = false;
  }

  /**
   * File.strait generates the child strait through a method you give using a StraitWidget. You need a StraitWidget on around every strait content
   * ```dart
   * File.strait(path, child: (List<Widget> cont) {
   *  ...
   * });
   * ```
   */
  File.strait(String path,{@required Function(List<Widget>) child,bool execute = false,String pack,bool create = true}): this(path, child: StraitWidget(child),execute: execute,pack: pack, create: create);

  File.executeStrait(String path,{@required Function(List<Widget>) child,String pack, bool create = true}): this.strait(path,child: child, execute: true,pack: pack, create: create);

  @override
  Widget generate(Context context) {
    if(this.isRecursive != null && isRecursive) path = context.file;

    if(pack == null) pack = context.packId;
      return Command('function ${pack}:' + path);
  }

  @override
  Map toMap(){
    return {'File':{'path':path,'child':child.toMap(),'execute':execute}};
  }
}
