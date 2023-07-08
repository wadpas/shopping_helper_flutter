import { Component } from '@angular/core';
import { Recipe } from '../models/recipe.model';

@Component({
  selector: 'app-recipe-list',
  template: `
    <div class="row">
      <div class="col-xs-12">
        <button class="btn btn-success">New Recipe</button>
      </div>
    </div>
    <hr />
    <div class="row">
      <div class="col-xs-12">
        <a
          *ngFor="let recipe of recipes"
          href="#"
          class="list-group-item clearfix"
        >
          <div class="pull-left">
            <h4 class="list-group-item-heading">{{ recipe.name }}</h4>
            <p class="list-group-item-text">{{ recipe.desciption }}</p>
          </div>
          <span class="pull-right">
            <img
              src="{{ recipe.imagePath }}"
              alt="{{ recipe.name }}"
              class="img-responsive"
              style="max-height: 50px"
            />
          </span>
        </a>
        <app-recipe-item />
      </div>
    </div>
  `,
})
export class RecipeListComponent {
  recipes: Recipe[] = [
    new Recipe(
      'Test',
      'Simple test',
      'https://weeatatlast.com/wp-content/uploads/2020/08/Sukuma-Wiki-Recipe-braised-collard-greens.jpg'
    ),
    new Recipe(
      'Test2',
      'Simple test2',
      'https://www.196flavors.com/wp-content/uploads/2013/07/Sukuma-Wiki-1-FP.jpg'
    ),
  ];
}
