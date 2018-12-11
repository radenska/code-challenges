dedup = function(array) {
  if (array.length < 2) return array;
  let uniquesArray = [array[0]];
  for (let x = 1; x < array.length; x++) {
    let isUniq = true;
    for (let y = 0; y < uniquesArray.length; y++) {
      if (array[x] === uniquesArray[y]) isUniq = false;
    }
    if (isUniq) uniquesArray.push(array[x]);
  }
  console.log(uniquesArray);
  return;
}

console.log(`expected: [], actual: ${dedup([])}`);
console.log("expected: [45], actual: " + dedup([45]));
console.log("expected: [234, 123, 45], actual: " + dedup([234, 123, 45]));
console.log("expected: [234, 123, 45, 4, 17, 12], actual: " + dedup([234, 123, 45, 4, 17, 234, 17, 12]));
console.log("expected: [42], actual: " + dedup([42, 42, 42, 42, 42, 42]));
