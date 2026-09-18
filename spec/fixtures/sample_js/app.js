import React from "react";
import { helper } from "./helpers";

function topLevel(a, b) {
  if (a > b) {
    return a;
  }
  return b;
}

class MyClass {
  method1(x) {
    if (x > 0) {
      return x;
    }
    return -x;
  }

  method2(y) {
    for (let i = 0; i < y; i++) {
      console.log(i);
    }
  }
}

export { topLevel, MyClass };
