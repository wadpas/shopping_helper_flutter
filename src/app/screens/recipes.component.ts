import { Component } from '@angular/core';
import { Recipe } from '../models/recipe.model';

@Component({
  selector: 'app-recipes',
  template: `
    <div class="row">
      <div class="col-md-5">
        <app-recipe-list (selectedRecipe)="selectedRecipe = $event" />
      </div>
      <div class="col-md-7">
        <app-recipe-details
          *ngIf="selectedRecipe; else infoText"
          [recipe]="selectedRecipe"
        />
        <ng-template #infoText>
          <p>Please select a Recipe!</p>
        </ng-template>
      </div>
    </div>
  `,
})
export class RecipesComponent {
  selectedRecipe: Recipe;
}
