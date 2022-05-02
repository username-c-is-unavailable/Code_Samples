import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class DependencyInjectionService {
  question_array: string [] = ["Where is the DHA office located?", 
  "What is the relationship between the DHA and the Department of Technology?", 
  "This has been an example of Angular dependency injection in which I am calling an object from a service."];

  constructor() { }

  // Method to call the questions
  getQuestionArray(): string[]
  {
    return this.question_array;
  }
}
