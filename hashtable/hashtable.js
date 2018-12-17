'use strict';

const fs = require('fs');

class HashList {
  constructor(bucketSize) {
    this.bucketSize = bucketSize;
    this.buckets = [];
    for (let i = 0; i < this.bucketSize; i++) {
      this.buckets.push(new LinkedList());
    }

  }

  findHash(key) {
    let hash = 0;
    for (let char of key) {
      hash += char.charCodeAt(0);
    }
    return hash;
  }

  getBucket(key) {
    let index = this.findHash(key) % this.bucketSize;
    return this.buckets[index];
  }

  set(key, val) {
    let obj = { key, val };
    this.getBucket(key).add(obj);
    return true;
  }

  get(key) {
    let obj = { val: null };
    this.getBucket(key).traverse( n => { if (n.value.key == key) obj = n.value });
    return obj;
  }
}

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

let dictionary = fs.readFileSync('/usr/share/dict/words').toString();
let array_of_words = dictionary.split("\n");

let h = new HashList(2000);
console.time("set");
array_of_words.forEach( (word) => {
  h.set(word, word.length);
});
console.timeEnd("set");

console.time("get");
array_of_words.forEach( (word) => {
  h.get(word);
});
console.timeEnd("get");
