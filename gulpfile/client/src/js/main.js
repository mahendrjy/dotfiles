import fire from './fire';

class Person {
  constructor(name) {
    this.name = name;
  }

  hello() {
    if (typeof this.name === 'string') return `Hello, I am ${this.name}!`;
    return 'Hello!';
  }
}

const mahendra = new Person('Mahendra Choudhary');
console.log(mahendra.hello());
console.log(fire());
