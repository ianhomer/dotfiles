function foo(a) {
  if (true) {
    console.log("It's true");
  }

  if (a == NaN) {
    console.log("NaN");
  }

  if (a) {
    a++;
  }

  for (var i = 0; i < 10; i--) {}
  console.log("Hello, World!");
  return a;
}

foo(true);
