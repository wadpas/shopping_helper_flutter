import { Component, Input } from '@angular/core';
import { Recipe } from '../models/recipe.model';

@Component({
  selector: 'app-recipe-details',
  template: `
    <div class="row">
      <div class="col-xs-12">
        <img
          [src]="recipe.imagePath"
          alt="{{ recipe.name }}"
          class="img-responsive"
          style="max-height: 400px"
        />
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <h1>{{ recipe.name }}</h1>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="btn-group">
          <button type="button" class="btn btn-primary dropdown-toggle">
            Manage Recipe
            <span class="caret"></span>
          </button>
          <ul class="dropdown-menu">
            <li><a href="#">To Shopping List</a></li>
            <li><a href="#">Edit Recipe</a></li>
            <li><a href="#">Delete Recipe</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">{{ recipe.desciption }}</div>
    </div>
    <div class="row">
      <div class="col-xs-12">Ingredients</div>
    </div>
  `,
})
export class RecipeDetailsComponent {
  @Input() recipe: Recipe;
}
