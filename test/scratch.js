function foo(a) {
  if (a) {
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

  if (a == 1) {
    // if (a==2) {
    console.log("uncomment inner if to get a sonarjs code smell");
    // }
  }

  return a;
}

foo(true);
