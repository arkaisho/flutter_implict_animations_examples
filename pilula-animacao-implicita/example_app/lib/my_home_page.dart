import 'package:example_app/hero_test_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool animated = false;

  Future timedAnimate() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("button clicked!"),
    ));
    setState(() => animated = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => animated = false);
  }

  TextStyle animatedTextStyle1 = const TextStyle(
    fontSize: 20,
    color: Colors.blue,
  );
  TextStyle animatedTextStyle2 = const TextStyle(
    fontSize: 30,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  ColorTween? _colorTween;
  AnimationController? _animationController;
  Animation<Color?>? _colorAnimation;

  @override
  void initState() {
    _colorTween = ColorTween(
      begin: const Color.fromARGB(200, 155, 120, 155),
      end: const Color.fromARGB(100, 127, 127, 127),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    if (_animationController != null && _colorTween != null) {
      _colorAnimation = _colorTween!.animate(
        _animationController!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Text("AnimatedAlign")),
              Tab(icon: Text("AnimatedContainer")),
              Tab(icon: Text("AnimatedCrossFade")),
              Tab(icon: Text("AnimatedDefaultTextStyle")),
              Tab(icon: Text("AnimatedModalBarrier")),
              Tab(icon: Text("AnimatedOpacity")),
              Tab(icon: Text("AnimatedPhysicalModel")),
              Tab(icon: Text("AnimatedPositioned")),
              Tab(icon: Text("AnimatedSize")),
              Tab(icon: Text("Hero")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AnimatedAlign(
              alignment: animated ? Alignment.center : Alignment.topCenter,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: const FlutterLogo(size: 50.0),
            ),
            Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: animated ? 80 : 100,
                padding: animated
                    ? const EdgeInsets.all(20)
                    : const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    animated ? 0 : 15,
                  ),
                  color: animated ? Colors.red : Colors.blue,
                  border: Border.all(
                    width: animated ? 5 : 0,
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  "AnimatedContainer",
                ),
              ),
            ),
            Center(
              child: AnimatedCrossFade(
                duration: const Duration(seconds: 1),
                crossFadeState: animated
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: const Text(
                  "not AnimatedWidget",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                secondChild: const Text(
                  "AnimatedWidget",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(seconds: 1),
                style: animated ? animatedTextStyle1 : animatedTextStyle2,
                child: const Text(
                  "AnimatedWidget",
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () => timedAnimate(),
                    child: const Text("test"),
                  ),
                ),
                if (_colorAnimation != null && animated)
                  AnimatedModalBarrier(
                    color: _colorAnimation!,
                    dismissible: true,
                  )
              ],
            ),
            Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: animated ? 0 : 1,
                child: Text(
                  "AnimatedWidget",
                  style: animatedTextStyle2,
                ),
              ),
            ),
            Center(
              child: AnimatedPhysicalModel(
                duration: const Duration(seconds: 1),
                color: Colors.grey,
                elevation: animated ? 0 : 10,
                shadowColor: animated ? Colors.blue : Colors.purple,
                shape: BoxShape.rectangle,
                child: Text(
                  "AnimatedWidget",
                  style: animatedTextStyle2,
                ),
              ),
            ),
            Stack(
              //Only works if it's the child of a Stack.
              children: [
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  top: animated ? 20 : 200,
                  left: animated ? 200.0 : 50.0,
                  right: animated ? 50.0 : 200.0,
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      "AnimatedWidget",
                      style: animatedTextStyle2.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: AnimatedSize(
                duration: const Duration(seconds: 1),
                reverseDuration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Container(
                  color: Colors.blue,
                  child: FlutterLogo(size: animated ? 200 : 50),
                ),
              ),
            ),
            Stack(
              children: [
                const Center(
                  child: Hero(
                    tag: "hero test tag",
                    child: FlutterLogo(size: 50),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    child: const Text("test hero"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HeroTestPage(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              animated = !animated;
            });
          },
          tooltip: 'Increment',
          child: Icon(
            animated ? Icons.arrow_right : Icons.arrow_left,
            size: 50,
          ),
        ),
      ),
    );
  }
}

//https://medium.com/flutter-community/mastering-hero-animations-in-flutter-bc07e1bea327