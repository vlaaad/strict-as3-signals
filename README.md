strict-as3-signals
==================

Signals inspired by Robert Penner's as3-signals and Jackson Dunstan's turbo-signals
This library offers strictly typed signals with compile time checking.
How it's achieved? By signals generation with freemarker templates.
How to use it?
1. Go to downloads section
2. Download strict-as3-signals.zip
3. Unpack it to your project root. now there should be signals.yml and templates folder.
4. Edit "signals.yml" to describe signals that your need. 
For more info about what yml is and how to work with it, visit http://yaml.org/spec/1.1/
By default there is three sample signals ("BlankTestSignal", "ArgsTestSignal" and "CustomClassesTestSignal") described in signals.yaml. What it means:
- "~" in "BlankTestSignal" means signal requires no arguments to dispatch (this is null in yaml specification)
- other signals descriptions contain key-value pairs like "string: String" or "attribute: com.example.Attribute", where keys are arguments names, values are class names in dispatch\handle methods.
5. in your command line interface change current directory to your project root 
6. run:

    java -jar strict-as3-signals-generation.jar "signals.yml" "src/" "templates/"
    
first arg is path to yaml file, second is target source root and third is path to templates root (do not delete that templates, by the way!)
7. that's all! Signals and their interfaces are generated!

How to work with generated signals? Here is example:

    public const onMyObjectAddedToContainer:MyObjectAddedToContainer = new MyObjectAddedToContainer();
    public const onMyObjectRemovedFromContainer:MyObjectRemovedFromContainer = new MyObjectRemovedFromContainer();
    
    ...
    
    public function add(myObject:MyObject):void {
        onMyObjectAddedToContainer.dispatch(myObject);
    }
    
In other place:

    public class SomeClass implements IMyObjectAddedToContainerHandler, IMyObjectRemovedFromContainerHandler {
    
    ...
    
    myObjectContainer.onMyObjectAddedToContainer.add(this);
    myObjectContainer.onMyObjectRemovedFromContainer.add(this);
    
    public function handleMyObjectAddedToContainer(obj:MyObject):void {
        //do stuff
    }
    
    public function handleMyObjectRemovedFromContainer(obj:MyObject):void {
        //do stuff
    }
    
Current repository contains behaviour tests of generated signals and performance comparison with Robert Penner's as3-signals (lower is better), on my PC i have following results:

All tests passed OK

as3 signals add once performance: 416
strict as3 signals add once performance: 183

as3 signals dispatch performance: 60
strict as3 signals dispatch performance: 32

as3 signals add 10000 listeners performance: 12250
strict as3 signals add 10000 listeners performance: 5494

as3 signals dispatch to 10000 listeners performance: 6
strict as3 signals dispatch to 10000 listeners performance: 3

as3 signals remove performance: 42
strict as3 signals remove performance: 31

as3 signals type check performance: 92 //as3-signals validates dispatched types in runtime
strict as3 signal "type cast" performance: 40 //with strict-as3-signal you can't compile app with wrong dispatched types, so tehnically there is no typecast, just dispatching
    