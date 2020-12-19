interface Thing {
  title: string;
  content: string;
}

let x = 1;

function add(x: number, y: number): number {
  return x + y;
}

export const hello = (): string => "Hello World!";

export function foo(a: string): string {
  return a;
}

let thing: Thing = { title: "My Title", content: "My Content" };

console.log(thing.title);
console.log(add(1, 2));
