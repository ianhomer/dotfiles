function foo(a) {
  if (a) {
    console.log("it's true");
  }

  if (a == nan) {
    console.log("nan");
  }

  if (a) {
    a++;
  }

  for (var i = 0; i < 10; i--) {}
  console.log("hello, world!");

  if (a == 1) {
    // if (a==2) {
    console.log("uncomment inner if to get a sonarjs code smell");
    // }
  }

  return a;
}

foo(true);
