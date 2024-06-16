import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<double> _imageAnimation;
  bool _isImageAnimated = false;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_imageController);
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  void _animateImage() {
    if (_isImageAnimated) {
      _imageController.reverse();
    } else {
      _imageController.forward();
    }
    _isImageAnimated = !_isImageAnimated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the forest'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero).animate(
                  CurvedAnimation(
                    parent: _imageController,
                    curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
                  ),
                ),
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Conserving the environment, specifically the forest, is crucial for saving our world.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SlideTransition(
                position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(
                  CurvedAnimation(
                    parent: _imageController,
                    curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
                  ),
                ),
                child: Text(
                  'Forests are critical ecosystems covering 31% of Earth\'s land. They provide habitats for diverse wildlife, regulate climate, maintain biodiversity, and aid in global oxygen production and carbon absorption, combating climate change. Additionally, forests are vital for human needs, offering timber, medicinal plants, and livelihoods worldwide. Sustainable forest management is crucial for the well-being of both nature and humanity.',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: _animateImage,
                child: AnimatedBuilder(
                  animation: _imageController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _imageAnimation.value,
                      child: Image.asset(
                        'assets/for.jpeg', 
                        width: 300.0, 
                        height: 300.0, 
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _animateImage,
                child: Text(_isImageAnimated ? 'Reverse Image Animation' : 'Animate me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
