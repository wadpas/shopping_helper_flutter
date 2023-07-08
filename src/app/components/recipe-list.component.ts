import { Component, EventEmitter, Output } from '@angular/core';
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
        <app-recipe-item
          *ngFor="let rec of recipes"
          [recipe]="rec"
          (recipeSelected)="onRecipeSelected(rec)"
        />
      </div>
    </div>
  `,
})
export class RecipeListComponent {
  @Output() selectedRecipe = new EventEmitter<Recipe>();

  onRecipeSelected(recipe: Recipe) {
    this.selectedRecipe.emit(recipe);
  }

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
