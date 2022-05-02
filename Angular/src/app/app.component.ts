import { NgForOf } from '@angular/common';
import { Component } from '@angular/core';
import { DependencyInjectionService } from './dependency-injection.service';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [DependencyInjectionService]
})
export class AppComponent {
  title = 'sac_dha_app';
  question_list: string[] = [];

  // Include the dependency injection service into the costructor
  constructor(private dep_service: DependencyInjectionService) { }

  // Demo javascript alert
  popup_message()
  {
    const element = document.getElementById("ctl00_ctl58_csr_sbox");
    alert("Congratulations, you used an Angular click event. \nThe id of this element is: " + element?.id + ". \nIts title is: " + element?.title + ". \nIts type is: " + element?.tagName + ". \nIts class name is: " + element?.className);
  }

  // Call a custom service, which I have named "dependency-injection, and pass a string array to the HTML"
  getQuestions()
  {
    this.question_list = this.dep_service.getQuestionArray();
  }





  
}
