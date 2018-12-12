'use strict';

class Node {
  constructor(value, next) {
    this.value = value;
    this.next = next;
  }
}

class LinkedList {
  constructor() {
    this.head = null;
  }

  add(value) {
    let newNode = new Node(value);
    newNode.next = this.head;
    this.head = newNode;
  }

  traverse(proc) {
    let current = this.head;
    while (current) {
      proc(current);
      current = current.next;
    }
  }

  killWithFire(value) {
    let current = this.head;
    if (current.value === value) {
      this.head = current.next;
      if (!this.head) return;
    }
    //does not check past value
    while(current.next.next) {
      if (value === current.next.value) {
        current.next = current.next.next;
      }
      current = current.next;
    }
  }

  nthFromEnd(n, listLength) {
    if (listLength <= n) return "offset is bigger than the list";
    let current = this.head;
    let offset = this.head;
    for(let i = 0; i <= n; i++) {
      offset = offset.next;
    }
    while(offset) {
      offset = offset.next;
      current = current.next;
    }
    return current.value;
  }

  partitionEvenOdd() {
    if (!this.head) return;
    if (isOdd(this.head.value)) {
      var func = isOdd;
    } else { var func = isEven; }
    this.partition(func);
  }

  partition(func) {
    let current = this.head;
    let others = []
    if (func(current.value)) {
      let temp = current;
      while (current.next && temp.next) {
        if (func(temp.next.value)) {
          current.next = temp.next;
          current = current.next;
        } else {
          others.push(temp.next)
        }
        temp = temp.next;
      }
      others.forEach( entry => {
        entry.next = null;
        current.next = entry
        current = current.next;
      });
    }
  }

  reverse() {
    let current = this.head, previous = null;
    while (current) {
      let tempNext = current.next;
      current.next = previous;
      previous = current;
      current = tempNext;
    }
    this.head = previous;
  }
}

function isEven(num) {
  return num % 2 === 0;
}

function isOdd(num) {
  return !isEven(num);
}

// let list = new LinkedList;
// list.add(1);
// list.add(2);
// list.add(3);
// list.add(4);
// list.add(6);

// console.log(list);

// list.reverse();

// list.partitionEvenOdd();
// console.log(list);
//
// let listTwo = new LinkedList;
// listTwo.add(1);
// listTwo.add(2);
// listTwo.add(3);
// listTwo.add(4);
// listTwo.add(5);
//
// listTwo.partitionEvenOdd();
// console.log(listTwo);
//
// var listLength = 0
// list.traverse(v => listLength += 1);
// var nthValue = list.nthFromEnd(2, listLength);
// console.log("nthValue: ", nthValue);
