interface Thing {
  title: string;
  content: string;
}

const myGlobal = [];

function add(x: number, y: number): number {
  return x + y;
}

export const hello = (): string => "Hello World!";

export function foo(a: string): string {
  if (a) {
    console.log("branch 1");
  } else if (a == "x") {
    console.log("branch 2");
  }

  if (a != "2") {
    console.log("sonarjs smell");
  }
  return a;
}

const thing: Thing = { title: "My Title", content: "My Content" };

console.log(myGlobal);
console.log(thing.title);
console.log(add(1, 2));
