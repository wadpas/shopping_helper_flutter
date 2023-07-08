import { Component } from '@angular/core';
import { Ingredient } from '../models/ingredient.model';

@Component({
  selector: 'app-shopping-list',
  template: `
    <div class="row">
      <div class="col-xs-10">
        <app-shopping-edit />
        <hr />
        <ul class="list-group">
          <a
            *ngFor="let ingredient of ingredients"
            class="list-group-item"
            style="cursor: pointer"
          >
            {{ ingredient.name }} ({{ ingredient.amount }})
          </a>
        </ul>
      </div>
    </div>
  `,
})
export class ShoppingListComponent {
  ingredients: Ingredient[] = [
    new Ingredient('Apples', 10),
    new Ingredient('Tomatos', 5),
  ];
}
